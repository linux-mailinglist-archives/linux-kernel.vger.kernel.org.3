Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F91D588AE4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbiHCLIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 07:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbiHCLIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 07:08:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FD11B79F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 04:07:53 -0700 (PDT)
X-UUID: d7481b9851dd428693477088b0959532-20220803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=1SasbzoC2Ds5PFkGibtZDjGZyrgO09YD9RDB7LIzRHI=;
        b=hR0Uoo4pOWDq66jiSzIPBVKOdOSmewq1YzY/ql6gKDG47wQHE4w8Pbwd2atO/jFsXf1DK0JDjBoLd+d4ZPR8QUjJp7CUDiciE4dSjmoi7YFyERt03QVh9s56OpI1YgYqKXZ3d2CaoU/UqNtlZjXdVBaqBl/guXSLERItf6ovhd4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:e8819d5b-b7ba-4299-8bf4-3e29a88b5c72,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.8,REQID:e8819d5b-b7ba-4299-8bf4-3e29a88b5c72,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:0f94e32,CLOUDID:975d2fd0-a6cf-4fb6-be1b-c60094821ca2,C
        OID:4c28708342a1,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: d7481b9851dd428693477088b0959532-20220803
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 821057793; Wed, 03 Aug 2022 19:07:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 3 Aug 2022 19:07:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 3 Aug 2022 19:07:47 +0800
Message-ID: <238915dffb733adc5126a1605de0b2878be6ca6e.camel@mediatek.com>
Subject: Re: [PATCH] arm64: Fix comment typo
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chinwen Chang =?UTF-8?Q?=28=E5=BC=B5=E9=8C=A6=E6=96=87=29?= 
        <chinwen.chang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 3 Aug 2022 19:07:47 +0800
In-Reply-To: <20220721030531.21234-1-Kuan-Ying.Lee@mediatek.com>
References: <20220721030531.21234-1-Kuan-Ying.Lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-21 at 11:05 +0800, Kuan-Ying Lee wrote:

Kindly ping.

> Replace wrong 'FIQ EL1h' comment with 'FIQ EL1t'.
> 
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> ---
>  arch/arm64/kernel/entry.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 254fe31c03a0..2d73b3e793b2 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -502,7 +502,7 @@ tsk	.req	x28		// current
> thread_info
>  SYM_CODE_START(vectors)
>  	kernel_ventry	1, t, 64, sync		// Synchronous EL1t
>  	kernel_ventry	1, t, 64, irq		// IRQ EL1t
> -	kernel_ventry	1, t, 64, fiq		// FIQ EL1h
> +	kernel_ventry	1, t, 64, fiq		// FIQ EL1t
>  	kernel_ventry	1, t, 64, error		// Error EL1t
>  
>  	kernel_ventry	1, h, 64, sync		// Synchronous EL1h
> -- 
> 2.18.0
> 

