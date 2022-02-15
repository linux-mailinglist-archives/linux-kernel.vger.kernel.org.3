Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A964B7B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbiBOXTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:19:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244779AbiBOXS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:18:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB1F8B9A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:18:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBEE8B81D52
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30531C340F1;
        Tue, 15 Feb 2022 23:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644967122;
        bh=XJpnHFLasMCrQgOvSoR57y4Fd4eVA+yk+IczENWXL1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPw+Q0OsDEfzdN/3+Mdn/XjUNpp/geNDmpAWHAXaXRCk1hvor+JerhC81zEA2XN/O
         We9arJ1ClqpSu9REmGrnUWbfOzEiQx3Skt/zxbtZis+Pt6Bj1i6k5ZTZEmtmZsUjoU
         5aySZtl+SY0FaG0llSWNMrny7km0Rdt3ZrXVUyACE5hk3jlbzVOOHo+m0rtQmmkLhU
         ESSa6cV06hU5yc9Ep3BAQB4lWBAFLARdvxDv7g5Z0gBSSvecVt24wr5WXaKVvHW8l6
         Vo98U1I9ItxFenVDEw71aN8xbyyVrKUygfUA+ceAkugl+RH2GNWz0xKPxfjPMStuFu
         9/FAGPQDmYyRw==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Consolidate TCR_EL1 fields
Date:   Tue, 15 Feb 2022 23:18:22 +0000
Message-Id: <164493926234.1196070.2991800251269464058.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1643121513-21854-1-git-send-email-anshuman.khandual@arm.com>
References: <1643121513-21854-1-git-send-email-anshuman.khandual@arm.com>
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

On Tue, 25 Jan 2022 20:08:33 +0530, Anshuman Khandual wrote:
> This renames and moves SYS_TCR_EL1_TCMA1 and SYS_TCR_EL1_TCMA0 definitions
> into pgtable-hwdef.h thus consolidating all TCR fields in a single header.
> This does not cause any functional change.
> 
> 

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Consolidate TCR_EL1 fields
      https://git.kernel.org/arm64/c/e921da6bc7ca

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
