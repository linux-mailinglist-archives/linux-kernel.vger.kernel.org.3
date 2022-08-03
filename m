Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11E5588B03
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 13:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbiHCLSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 07:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiHCLSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 07:18:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D91D1DA79
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 04:18:38 -0700 (PDT)
X-UUID: e05811de7bca46208585186a31832815-20220803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=OZYlzLgyWu40ADizHKmCXW+EjVh2C0M+Azc1lhdIggI=;
        b=To4NqyX8U9MQPANUtu6vtc+lKS/P9Umqbh0I37UHeyeZPMfJ7MPXbqKo3xc7c62ZuWJRRPHf4hl1KOiAcsRrtaSNQ2jYLszMuE/n+omI7b/EfgUVNUY098/a3W98J1s13T2SwEfrhTgo7f3GcKq6/BWgrpDn9RD03a9i29GyCWU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:865561e0-6715-4395-8c3c-daf0637f60ea,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:a9352925-a982-4824-82d2-9da3b6056c2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: e05811de7bca46208585186a31832815-20220803
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1155117335; Wed, 03 Aug 2022 19:18:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 3 Aug 2022 19:18:30 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Aug 2022 19:18:30 +0800
Message-ID: <e64af337f5bc32ee90e4154642446126040432f9.camel@mediatek.com>
Subject: Re: [PATCH] scripts: Fix no space expression between sp and offset
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>, <masahiroy@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <wafgo01@gmail.com>
CC:     Chinwen Chang =?UTF-8?Q?=28=E5=BC=B5=E9=8C=A6=E6=96=87=29?= 
        <chinwen.chang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 3 Aug 2022 19:18:30 +0800
In-Reply-To: <20220722063529.7166-1-Kuan-Ying.Lee@mediatek.com>
References: <20220722063529.7166-1-Kuan-Ying.Lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-22 at 14:35 +0800, Kuan-Ying Lee wrote:

Cc maintainers.

> When I use older version aarch64 objdump (2.24) to disassemble
> aarch64 vmlinux, I get the result like below.
> There is no space between sp and offset.
> 
> ffff800008010000 <dw_apb_ictl_handle_irq>:
> ffff800008010000:       d503233f        hint    #0x19
> ffff800008010004:       a9bc7bfd        stp     x29, x30, [sp,#-64]!
> ffff800008010008:       90011e60        adrp    x0, ffff80000a3dc000
> <num_ictlrs>
> ffff80000801000c:       910003fd        mov     x29, sp
> ffff800008010010:       a9025bf5        stp     x21, x22, [sp,#32]
> 
> When I use newer version aarch64 objdump (2.35), I get
> the result like below.
> 
> ffff800008010000 <dw_apb_ictl_handle_irq>:
> ffff800008010000:       d503233f        paciasp
> ffff800008010004:       a9bc7bfd        stp     x29, x30, [sp, #-64]!
> ffff800008010008:       90011e60        adrp    x0, ffff80000a3dc000
> <num_ictlrs>
> ffff80000801000c:       910003fd        mov     x29, sp
> ffff800008010010:       a9025bf5        stp     x21, x22, [sp, #32]
> 
> Add no space support of regular expression for old version objdump.
> 
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> ---
>  scripts/checkstack.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
> index d2c38584ece6..e404b6b11295 100755
> --- a/scripts/checkstack.pl
> +++ b/scripts/checkstack.pl
> @@ -56,7 +56,7 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre,
> $min_stack);
>  	if ($arch =~ '^(aarch|arm)64$') {
>  		#ffffffc0006325cc:       a9bb7bfd        stp     x29,
> x30, [sp, #-80]!
>  		#a110:       d11643ff        sub     sp, sp, #0x590
> -		$re = qr/^.*stp.*sp, \#-([0-9]{1,8})\]\!/o;
> +		$re = qr/^.*stp.*sp, ?\#-([0-9]{1,8})\]\!/o;
>  		$dre = qr/^.*sub.*sp, sp, #(0x$x{1,8})/o;
>  	} elsif ($arch eq 'arm') {
>  		#c0008ffc:	e24dd064	sub	sp, sp, #100	
> ; 0x64
> -- 
> 2.18.0
> 

