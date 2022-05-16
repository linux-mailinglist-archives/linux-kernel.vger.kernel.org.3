Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CBE527B86
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 03:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbiEPBuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 21:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiEPBuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 21:50:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AD5389B;
        Sun, 15 May 2022 18:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9E04B80E81;
        Mon, 16 May 2022 01:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D6E7C34100;
        Mon, 16 May 2022 01:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652665812;
        bh=jKN9jck8Cg4KOGCMfWWvP4ssROBon9ITJfnmgvrhoso=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AWyTTFpfS8wz7J0MElpBgEKOdKrp6Yjd/crGpWxKcnne/5o7cMqYk5+LmiRJqKP+g
         P7JIgzdRl7e6hhPO0cmx9SMKp1UyLz6ZOhTgs0M2xX2YJvL5TP0wKSbq80UkJG4U8+
         XgimDq6ydh7d2Ha1yH7aQrzoX+7vRv2s+e1FJDOREevY+D62ZIHwyK0y+8grNAy+Qc
         gCb2PYXT+FeI1E4oFw3k9T4B3JUSDgNEjmWc0VXAQRV9/NEaC6hCTuS262258m8qO2
         Y5V0kD9lj9R06lsEhfM9IkinqKn2XRqqjKR4CWefkg53I2YdDnBXPT5Fi+jtM2J/WU
         BfT3ZA8vEKSJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13A7DF0383D;
        Mon, 16 May 2022 01:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v13] platform/chrome: Add ChromeOS ACPI device driver
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165266581207.6997.10229505003935532310.git-patchwork-notify@kernel.org>
Date:   Mon, 16 May 2022 01:50:12 +0000
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
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
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


