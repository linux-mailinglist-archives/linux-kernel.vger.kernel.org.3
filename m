Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2C451D6D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391413AbiEFLnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiEFLnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:43:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84965DE6B
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:39:32 -0700 (PDT)
X-UUID: 5cf4482705974597a43805780b255883-20220506
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:637941b4-cb86-4741-bcbd-b1ead3e81090,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:637941b4-cb86-4741-bcbd-b1ead3e81090,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:806b7816-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: 5cf4482705974597a43805780b255883-20220506
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1297254437; Fri, 06 May 2022 19:39:25 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 6 May 2022 19:39:24 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 May 2022 19:39:24 +0800
Message-ID: <ef0c621760d63c28ad97d4b7e8bef34660ea079c.camel@mediatek.com>
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
Date:   Fri, 6 May 2022 19:39:24 +0800
In-Reply-To: <YnQ9h6k0yFN8f+Ui@kroah.com>
References: <20220505053048.13804-1-tinghan.shen@mediatek.com>
         <20220505053048.13804-2-tinghan.shen@mediatek.com>
         <YnQ9h6k0yFN8f+Ui@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, 2022-05-05 at 23:11 +0200, Greg Kroah-Hartman wrote:
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
> > 
> > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > index d65964996e8d..c4d149b28944 100644
> > --- a/drivers/firmware/Kconfig
> > +++ b/drivers/firmware/Kconfig
> > @@ -300,6 +300,7 @@ source "drivers/firmware/cirrus/Kconfig"
> >  source "drivers/firmware/google/Kconfig"
> >  source "drivers/firmware/efi/Kconfig"
> >  source "drivers/firmware/imx/Kconfig"
> > +source "drivers/firmware/mediatek/Kconfig"
> >  source "drivers/firmware/meson/Kconfig"
> >  source "drivers/firmware/psci/Kconfig"
> >  source "drivers/firmware/smccc/Kconfig"
> > diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> > index 4e58cb474a68..88fbdc110100 100644
> > --- a/drivers/firmware/Makefile
> > +++ b/drivers/firmware/Makefile
> > @@ -34,6 +34,7 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
> >  obj-$(CONFIG_EFI)		+= efi/
> >  obj-$(CONFIG_UEFI_CPER)		+= efi/
> >  obj-y				+= imx/
> > +obj-y				+= mediatek/
> >  obj-y				+= psci/
> >  obj-y				+= smccc/
> >  obj-y				+= tegra/
> > diff --git a/drivers/firmware/mediatek/Kconfig b/drivers/firmware/mediatek/Kconfig
> > new file mode 100644
> > index 000000000000..6d1e580b967b
> > --- /dev/null
> > +++ b/drivers/firmware/mediatek/Kconfig
> > @@ -0,0 +1,9 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config MTK_ADSP_IPC
> > +	tristate "MTK ADSP IPC Protocol driver"
> > +	depends on MTK_ADSP_MBOX
> > +	help
> > +	  Say yes here to add support for the MediaTek ADSP IPC
> > +	  between host AP (Linux) and the firmware running on ADSP.
> > +	  ADSP exists on some mtk processors.
> > +	  Client might use shared memory to exchange information with ADSP side.
> > diff --git a/drivers/firmware/mediatek/Makefile b/drivers/firmware/mediatek/Makefile
> > new file mode 100644
> > index 000000000000..4e840b65650d
> > --- /dev/null
> > +++ b/drivers/firmware/mediatek/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +obj-$(CONFIG_MTK_ADSP_IPC)		+= mtk-adsp-ipc.o
> > diff --git a/drivers/firmware/mediatek/mtk-adsp-ipc.c b/drivers/firmware/mediatek/mtk-adsp-ipc.c
> > new file mode 100644
> > index 000000000000..87cee61dbf32
> > --- /dev/null
> > +++ b/drivers/firmware/mediatek/mtk-adsp-ipc.c
> > @@ -0,0 +1,161 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2022 MediaTek Corporation. All rights reserved.
> > + * Author: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > + */
> > +
> > +#include <linux/firmware/mediatek/mtk-adsp-ipc.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mailbox_client.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +/*
> > + * mtk_adsp_ipc_send - send ipc cmd to MTK ADSP
> > + *
> > + * @ipc: ADSP IPC handle
> > + * @idx: index of the mailbox channel
> > + * @msg: IPC cmd (reply or request)
> > + *
> > + * Returns zero for success from mbox_send_message
> > + * negative value for error
> > + */
> > +int mtk_adsp_ipc_send(struct mtk_adsp_ipc *ipc, unsigned int idx, uint32_t msg)
> > +{
> > +	struct mtk_adsp_chan *adsp_chan;
> > +	int ret;
> > +
> > +	if (idx >= MTK_ADSP_MBOX_NUM)
> > +		return -EINVAL;
> > +
> > +	adsp_chan = &ipc->chans[idx];
> > +	ret = mbox_send_message(adsp_chan->ch, &msg);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * mbox_send_message returns non-negative value on success,
> > +	 * return zero for success
> > +	 */
> > +	return 0;
> 
> You already said this up in the function comments, no need to duplicate
> it again.
> 
> > +}
> > +EXPORT_SYMBOL(mtk_adsp_ipc_send);
> 
> EXPORT_SYMBOL_GPL()?  I have to ask, sorry.
> 
> thanks,
> 
> greg k-h

I'll update these parts in next version.
Thank you!


Best regards,
TingHan

