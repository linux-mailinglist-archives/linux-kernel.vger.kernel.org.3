Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B87050AE40
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443626AbiDVC4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443621AbiDVC4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:56:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E044D636
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:53:17 -0700 (PDT)
X-UUID: 272af0c95c334f2ab44e2ac5451820dc-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:e9307f85-12c3-4783-86c5-0857a376cb9c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:53,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:53
X-CID-INFO: VERSION:1.1.4,REQID:e9307f85-12c3-4783-86c5-0857a376cb9c,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:53,FILE:0,RULE:Release_UHam,ACTI
        ON:release,TS:53
X-CID-META: VersionHash:faefae9,CLOUDID:363b8cf0-da02-41b4-b6df-58f4ccd36682,C
        OID:3120d0ac20a5,Recheck:0,SF:13|15|28|16|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 272af0c95c334f2ab44e2ac5451820dc-20220422
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1478556448; Fri, 22 Apr 2022 10:53:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 22 Apr 2022 10:53:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 10:53:12 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <tiwai@suse.de>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <perex@perex.cz>,
        <rdunlap@infradead.org>, <tiwai@suse.com>
Subject: Re: [PATCH -next V2] sound/oss/dmasound: fix 'dmasound_setup' defined but not used
Date:   Fri, 22 Apr 2022 10:53:12 +0800
Message-ID: <20220422025312.7718-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <s5ha6cm4xy2.wl-tiwai@suse.de>
References: <s5ha6cm4xy2.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taksshi,

>> We observed: 'dmasound_setup' defined but not used error with
>> COMPILER=gcc ARCH=m68k DEFCONFIG=allmodconfig build.
>> 
>> Fix it by adding __maybe_unused to dmasound_setup.
>> 
>> Error(s):
>> sound/oss/dmasound/dmasound_core.c:1431:12: error: 'dmasound_setup' defined but not used [-Werror=unused-function]
>> 
>> Fixes: 9dd7c46346ca ("sound/oss/dmasound: fix build when drivers are mixed =y/=m")
>> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
>> Cc: Takashi Iwai <tiwai@suse.com>
>
>Thanks, applied.

This patch is needed in 5.18-rc3 [1] too, should I submit another patch or
you can pick it to the mainstream?

[1] https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2204190925230.302265@ramsan.of.borg/

thanks,
Miles
>
>
>Takashi

