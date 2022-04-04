Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884BC4F12CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352770AbiDDKNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356523AbiDDKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:12:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1207D26106
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:11:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B274FB8121C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96679C34110;
        Mon,  4 Apr 2022 10:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649067059;
        bh=cL4ABkWor1En6L7CKLeFQLHbXrPdAQ7Q3BCSAY5hI3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRsZPZzGjAv6qr0NY8h/jIQ5qQSAlyQeX/SefmPNjpqpwCSfHzOfp+m3ouuHcr2tq
         JGBWBKICiMRjfE4fz2RQ+YJKkmH7S8EGj7een4Mt8w6U0h9ycYN+P/ymLACYE9vh15
         c9pvNFJJcCb8cq0BplxQNBtezNvmRGXy7/0BruDqKkIY2FPsn0caWgTwFkNSIYBgIz
         8aGtBUGinxgVODp4+8w1lUuB3Z2F5pbLW2XTJeCAfC3OqGwLBLp9Mcvh0Kbe3xw7I+
         njCAZ4Fkx8bPISf3/sjvmbHTj1tEUmJnt0oB9JePPfT2xmQ8ec0ZHB12f7aNUkigY/
         oixhN9i1Xpl/Q==
From:   Will Deacon <will@kernel.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: MARVELL_CN10K_DDR_PMU should depend on ARCH_THUNDER
Date:   Mon,  4 Apr 2022 11:10:46 +0100
Message-Id: <164906588116.27582.9026408119818877052.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <18bfd6e1bcf67db7ea656d684a8bbb68261eeb54.1648559364.git.geert+renesas@glider.be>
References: <18bfd6e1bcf67db7ea656d684a8bbb68261eeb54.1648559364.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 15:10:10 +0200, Geert Uytterhoeven wrote:
> The Marvell CN10K DRAM Subsystem (DSS) performance monitor is only
> present on Marvell CN10K SoCs.  Hence add a dependency on ARCH_THUNDER,
> to prevent asking the user about this driver when configuring a kernel
> without Cavium Thunder (incl. Marvell CN10K) SoC support,
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf: MARVELL_CN10K_DDR_PMU should depend on ARCH_THUNDER
      https://git.kernel.org/arm64/c/1d8e926a04b9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
