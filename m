Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDB951D6CB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391396AbiEFLlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242314AbiEFLlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:41:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9AF5C77D
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:37:16 -0700 (PDT)
X-UUID: 5038d43519b74feca2815c150857bef6-20220506
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:616086b7-229f-4795-9c2d-512db55b2b67,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:470ad8b2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 5038d43519b74feca2815c150857bef6-20220506
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 987445387; Fri, 06 May 2022 19:37:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 6 May 2022 19:37:07 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 May 2022 19:37:07 +0800
Message-ID: <fc564f68194b5cc668bb9e7a88cc097d38c9b128.camel@mediatek.com>
Subject: Re: [RESEND PATCH v7 1/1] firmware: mediatek: add adsp ipc protocol
 interface
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        "Cristian Marussi" <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        "John Stultz" <john.stultz@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        YC Hung <yc.hung@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <alsa-devel@alsa-project.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 6 May 2022 19:37:07 +0800
In-Reply-To: <YnQ9UzeyMTkmyGgD@kroah.com>
References: <20220505053048.13804-1-tinghan.shen@mediatek.com>
         <20220505053048.13804-2-tinghan.shen@mediatek.com>
         <YnQ9UzeyMTkmyGgD@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for your review.

On Thu, 2022-05-05 at 23:10 +0200, Greg Kroah-Hartman wrote:
> On Thu, May 05, 2022 at 01:30:48PM +0800, Tinghan Shen wrote:
> > From: TingHan Shen <tinghan.shen@mediatek.com>
> > 
> > Some of mediatek processors contain
> > the Tensilica HiFix DSP for audio processing.
> > 
> > The communication between Host CPU and DSP firmware is
> > taking place using a shared memory area for message passing.
> > 
> > ADSP IPC protocol offers (send/recv) interfaces using
> > mediatek-mailbox APIs.
> > 
> > We use two mbox channels to implement a request-reply protocol.
> > 
> > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > Signed-off-by: TingHan Shen <tinghan.shen@mediatek.com>
> > Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
> > Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> > Reviewed-by: YC Hung <yc.hung@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> >  drivers/firmware/Kconfig                      |   1 +
> >  drivers/firmware/Makefile                     |   1 +
> >  drivers/firmware/mediatek/Kconfig             |   9 +
> >  drivers/firmware/mediatek/Makefile            |   2 +
> >  drivers/firmware/mediatek/mtk-adsp-ipc.c      | 161 ++++++++++++++++++
> >  .../linux/firmware/mediatek/mtk-adsp-ipc.h    |  65 +++++++
> >  6 files changed, 239 insertions(+)
> >  create mode 100644 drivers/firmware/mediatek/Kconfig
> >  create mode 100644 drivers/firmware/mediatek/Makefile
> >  create mode 100644 drivers/firmware/mediatek/mtk-adsp-ipc.c
> >  create mode 100644 include/linux/firmware/mediatek/mtk-adsp-ipc.h
> 
> Why do you have a .h file, and export symbols in your .c file, yet you
> have no user of these symbols or header file?
> 
> Without a user, we can not take this, sorry.

MediaTek have adsp client drivers on 2 chips that use symbols from this module.
We were planned to upstream them after Linux community accept this module.
I will add those client drivers in next version.

> 
> This should just be one single .c file.
> 
> Also, why a whole subdirectory for just one .c file?

Ok, I'll move the souce out and remove this subdirectory in next version.
Thank you very much.

Best regards,
TingHan

> 
> thanks,
> 
> greg k-h


