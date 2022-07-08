Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A92B56BB44
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiGHN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbiGHN4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:56:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917282B1B1;
        Fri,  8 Jul 2022 06:56:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F0BA62817;
        Fri,  8 Jul 2022 13:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79104C341C0;
        Fri,  8 Jul 2022 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657288559;
        bh=vUnJeGk6PURBMTNQYZb3D8KGF3E0//wVCAiUeEdZQuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdhAUE1eiT10VVl+XThRV7BK1mqecq4Uht/fc+RdwjeWRRMg6KxJbVNAl11h7mzxC
         zsnC4OOlVXla3W/VTgWAvvHs6hp67eeRt8osWH8T0AjfhWUYsBu/iK8Doea25/XFTh
         Hj43AV8K1ZvZJN3ad/3mLLLWK552cOerDhyPMzRpmM9XOT/UKzUzMV38sIlQ7wT7Sf
         PECcKLvd1tkxzM4kQF/z3LcKkFXbDTo1FjT27g24OB3m2oon0MltBGSAq3rkL2Fp5P
         /U1G7yQoknPGTY2/+YeKe34fvKOaTaV99hBrykCjBWMVPsXSUpNi0yZtoSYO88VRSc
         sgRQYD4EaWk8A==
From:   Will Deacon <will@kernel.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] iommu/arm-smmu-qcom: Add debug support for TLB sync timeouts
Date:   Fri,  8 Jul 2022 14:55:53 +0100
Message-Id: <165728615303.683968.1528285807329632811.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220708094230.4349-1-quic_saipraka@quicinc.com>
References: <20220708094230.4349-1-quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2022 15:12:30 +0530, Sai Prakash Ranjan wrote:
> TLB sync timeouts can be due to various reasons such as TBU power down
> or pending TCU/TBU invalidation/sync and so on. Debugging these often
> require dumping of some implementation defined registers to know the
> status of TBU/TCU operations and some of these registers are not
> accessible in non-secure world such as from kernel and requires SMC
> calls to read them in the secure world. So, add this debug support
> to dump implementation defined registers for TLB sync timeout issues.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-qcom: Add debug support for TLB sync timeouts
      https://git.kernel.org/will/c/b9b721d117e9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
