Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA675AA614
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 04:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiIBC4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 22:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiIBC4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 22:56:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40744055D;
        Thu,  1 Sep 2022 19:56:02 -0700 (PDT)
X-UUID: 2b3cadce884e4bcf8f16a137ebccec15-20220902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=oLNGlCRUkI7WrIyYgZdRutE3RCvGTE+Yyyht7nl8QoM=;
        b=Hl/27i9aiGprfachLfClDJVGEBaUfD/QmFmhOVsoGyT9VKsZkM56TGpbSioSn2Cs2kAMwqeLzZ9mi566OqO6BtiePOip0X/UlaTYIj3yMXGq+QmGlIRysQ6qr0Vf2ekNXnrAqsOZyECtm75gDXnbYpiSKjWKQDgoOya7VBKLg0Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:86a3920d-ea40-4d27-9909-185b469a346d,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:-5
X-CID-META: VersionHash:84eae18,CLOUDID:189a64d0-20bd-4e5e-ace8-00692b7ab380,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2b3cadce884e4bcf8f16a137ebccec15-20220902
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1541283790; Fri, 02 Sep 2022 10:55:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 2 Sep 2022 10:55:55 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 2 Sep 2022 10:55:55 +0800
Message-ID: <e213e9d8ef900db665fee08b484181e1d47c5171.camel@mediatek.com>
Subject: Re: linux-next: Tree for Sep 1 (Kconfig for VIDEO_MEDIATEK_VPU)
From:   moudy ho <moudy.ho@mediatek.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Date:   Fri, 2 Sep 2022 10:55:55 +0800
In-Reply-To: <f19684d4-9ef0-6308-8245-73c9a4511e67@infradead.org>
References: <20220901171832.78d88aed@canb.auug.org.au>
         <f19684d4-9ef0-6308-8245-73c9a4511e67@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thanks for your efforts on this matter, the warning is due to not
setting V4L_MEM2MEM_DRIVERS on defconfig which the VIDEO_MEDIATEK_VPU
depends.
Could I send a patch to add a V4L_MEM2MEM_DRIVERS selection in MDP3
Kconfig to avoid this warning?

Regards,
Moudy

On Thu, 2022-09-01 at 13:38 -0700, Randy Dunlap wrote:
> 
> On 9/1/22 00:18, Stephen Rothwell wrote:
> > Hi all,
> > 
> > News: there will be no linux-next releases tomorrow or on Monday.
> > 
> > Changes since 20220831:
> > 
> 
> on i386 or x86_64:
> 
> WARNING: unmet direct dependencies detected for VIDEO_MEDIATEK_VPU
>   Depends on [n]: MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y]
> && MEDIA_PLATFORM_DRIVERS [=y] && V4L_MEM2MEM_DRIVERS [=n] &&
> VIDEO_DEV [=y] && (ARCH_MEDIATEK || COMPILE_TEST [=y])
>   Selected by [y]:
>   - VIDEO_MEDIATEK_MDP3 [=y] && MEDIA_SUPPORT [=y] &&
> MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] &&
> (MTK_IOMMU [=n] || COMPILE_TEST [=y]) && VIDEO_DEV [=y] &&
> (ARCH_MEDIATEK || COMPILE_TEST [=y]) && HAS_DMA [=y] && REMOTEPROC
> [=y]
> 
> 
> 
> Full x86_64 randconfig file is attached.
> 

