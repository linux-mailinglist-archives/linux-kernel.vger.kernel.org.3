Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0243526160
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380069AbiEMLuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380044AbiEMLuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:50:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF44B1F8F0B;
        Fri, 13 May 2022 04:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67E0161E79;
        Fri, 13 May 2022 11:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C147EC3411E;
        Fri, 13 May 2022 11:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652442615;
        bh=UHq75syz1TwIK/R+8b105K6sf477mrGnpEYKE8UUBjg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OXOhqbvkVUCbn/mD9aQ/qla4Vx7uqJe+Klm49poBCtW6tS5QxiIXSB392vQJVnkGz
         rokxy3+le9vm/RuFySY/NNhrbSc7CDofLoq1CUZQsoMobPorNAaanH3nHccna7Wqpw
         yJZfb8qsi2fk7+9OYLqNy5BojL/L5k6hj3C70tFGumwK7FieK8QD7e7AxIkHxiZWge
         Rt7oteioNHESX0eqlvnMaawju/Q/ycjnvJ00GimdWcuV6MIzXN35NR8FYzH8qsKLKC
         Nzl/G0vMOsNwS5EFThuDIuA6mIwzgaFr9M03vbhOXtVSA70QK3dqMy7qkVZOpTbJn0
         bno8Q8FXLkA9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A857AF03935;
        Fri, 13 May 2022 11:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v13] platform/chrome: Add ChromeOS ACPI device driver
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165244261568.26306.10633068874919454705.git-patchwork-notify@kernel.org>
Date:   Fri, 13 May 2022 11:50:15 +0000
References: <Yn4OKYrtV35Dv+nd@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <Yn4OKYrtV35Dv+nd@debian-BULLSEYE-live-builder-AMD64>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     rafael@kernel.org, lenb@kernel.org, hdegoede@redhat.com,
        markgross@kernel.org, bleung@chromium.org, eballetbo@gmail.com,
        gregkh@linuxfoundation.org, kernel@collabora.com,
        groeck@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        vbendeb@chromium.org, andy@infradead.org, ayman.bagabas@gmail.com,
        benjamin.tissoires@redhat.com, blaz@mxxn.io, dvhart@infradead.org,
        dmitry.torokhov@gmail.com, jeremy@system76.com, 2pi@mok.nu,
        mchehab+samsung@kernel.org, rajatja@google.com,
        srinivas.pandruvada@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com,
        chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Fri, 13 May 2022 12:52:09 +0500 you wrote:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> The x86 Chromebooks have the ChromeOS ACPI device. This driver attaches
> to the ChromeOS ACPI device and exports the values reported by ACPI in a
> sysfs directory. This data isn't present in ACPI tables when read
> through ACPI tools, hence a driver is needed to do it. The driver gets
> data from firmware using the ACPI component of the kernel. The ACPI values
> are presented in string form (numbers as decimal values) or binary
> blobs, and can be accessed as the contents of the appropriate read only
> files in the standard ACPI device's sysfs directory tree. This data is
> consumed by the ChromeOS user space.
> 
> [...]

Here is the summary with links:
  - [v13] platform/chrome: Add ChromeOS ACPI device driver
    https://git.kernel.org/chrome-platform/c/0a4cad9c11ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


