Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248C04B7B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244774AbiBOXSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:18:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiBOXSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:18:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469B3C1C9E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:18:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED3DBB81D4D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C01AC340ED;
        Tue, 15 Feb 2022 23:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644967120;
        bh=cdKzAwRticnUntwrFd32lEmGs4a3gn08lFYQ5AOACG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fVu0XQoImgKqABDKNjt5Ullbx1FHA1dinGco4+Vl3OfBOESZnTyJUqRPcTmFX2+lY
         xhG4ara7Ckkec1yvkfPrQ6VoixjoSX5FUcskUs6NRKJpgwSEhFlWnxvie9Wg+OmahX
         gOuk9wXBk8vY1xRkli6YK8GiVFZ1/5BbvRdCtX3ELKzi0EitgmX+vWOTNUaMXuyfn1
         1k8KubhObn2VYsXK4WHb3dzLal52dXKixoEHsJ5wShlLaaGfa3bVRRZHdOsyVJ9c2A
         ELc4FXZgcIJKnhpikh9QH6C0l0F4UNsQ4iJ84yMpsTICZuYFrNQNeM7RGWvuGBg67q
         7yHlYNitXKzkA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v1 1/1] perf/smmuv3: Don't cast parameter in bit operations
Date:   Tue, 15 Feb 2022 23:18:21 +0000
Message-Id: <164494388717.3761559.1060651484914816360.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220209184758.56578-1-andriy.shevchenko@linux.intel.com>
References: <20220209184758.56578-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022 20:47:58 +0200, Andy Shevchenko wrote:
> While in this particular case it would not be a (critical) issue,
> the pattern itself is bad and error prone in case somebody blindly
> copies to their code.
> 
> Don't cast parameter to unsigned long pointer in the bit operations.
> Instead copy to a local variable on stack of a proper type and use.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] perf/smmuv3: Don't cast parameter in bit operations
      https://git.kernel.org/will/c/8ddf4eff71e1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
