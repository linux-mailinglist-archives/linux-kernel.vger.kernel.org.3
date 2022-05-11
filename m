Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A87522AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 06:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiEKE2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 00:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiEKE2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 00:28:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA50750E28
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 21:28:08 -0700 (PDT)
X-UUID: 8c0d3c2b10594e0e8f157c4694b2939d-20220511
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:9129420d-3390-4f49-84e6-d309fde9f01c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:75
X-CID-INFO: VERSION:1.1.4,REQID:9129420d-3390-4f49-84e6-d309fde9f01c,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9,CLOUDID:91600ae6-38f2-431d-8de7-bf8fac490b0a,C
        OID:d91d75d33c30,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 8c0d3c2b10594e0e8f157c4694b2939d-20220511
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1156365683; Wed, 11 May 2022 12:28:03 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 11 May 2022 12:28:02 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 May 2022 12:28:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 11 May 2022 12:28:02 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        TingHan Shen <tinghan.shen@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        YC Hung <yc.hung@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
Subject: [PATCH v8 2/3] ASoC: SOF: mediatek: Add ipc support for mt8195
Date:   Wed, 11 May 2022 12:27:17 +0800
Message-ID: <20220511042718.4305-3-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220511042718.4305-1-tinghan.shen@mediatek.com>
References: <20220511042718.4305-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

This patch adds mt8195 IPC support by using mailbox.

On mt8195 resource, there are two mboxes used to handle ipc request
and reply. We create a mtk-adsp-ipc client device to request mbox
controllers.

Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
---
 sound/soc/sof/mediatek/Kconfig         |   1 +
 sound/soc/sof/mediatek/adsp_helper.h   |  12 +--
 sound/soc/sof/mediatek/mt8195/mt8195.c | 138 ++++++++++++++++++++++++-
 3 files changed, 140 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sof/mediatek/Kconfig b/sound/soc/sof/mediatek/Kconfig
index f79e76a6f3c6..c3c99a248302 100644
--- a/sound/soc/sof/mediatek/Kconfig
+++ b/sound/soc/sof/mediatek/Kconfig
@@ -17,6 +17,7 @@ config SND_SOC_SOF_MTK_COMMON
 	select SND_SOC_SOF
 	select SND_SOC_SOF_XTENSA
 	select SND_SOC_SOF_COMPRESS
+	depends on MTK_ADSP_IPC
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
diff --git a/sound/soc/sof/mediatek/adsp_helper.h b/sound/soc/sof/mediatek/adsp_helper.h
index f269a2b6c26a..4ab998756bbc 100644
--- a/sound/soc/sof/mediatek/adsp_helper.h
+++ b/sound/soc/sof/mediatek/adsp_helper.h
@@ -7,24 +7,22 @@
 #ifndef __MTK_ADSP_HELPER_H__
 #define __MTK_ADSP_HELPER_H__
 
+#include <linux/firmware/mediatek/mtk-adsp-ipc.h>
+
 /*
  * Global important adsp data structure.
  */
-#define DSP_MBOX_NUM	3
-
 struct mtk_adsp_chip_info {
 	phys_addr_t pa_sram;
 	phys_addr_t pa_dram; /* adsp dram physical base */
 	phys_addr_t pa_shared_dram; /* adsp dram physical base */
 	phys_addr_t pa_cfgreg;
-	phys_addr_t pa_mboxreg[DSP_MBOX_NUM];
 	u32 sramsize;
 	u32 dramsize;
 	u32 cfgregsize;
 	void __iomem *va_sram; /* corresponding to pa_sram */
 	void __iomem *va_dram; /* corresponding to pa_dram */
 	void __iomem *va_cfgreg;
-	void __iomem *va_mboxreg[DSP_MBOX_NUM];
 	void __iomem *shared_sram; /* part of  va_sram */
 	void __iomem *shared_dram; /* part of  va_dram */
 	phys_addr_t adsp_bootup_addr;
@@ -42,10 +40,8 @@ struct mtk_adsp_chip_info {
 struct adsp_priv {
 	struct device *dev;
 	struct snd_sof_dev *sdev;
-
-	/* DSP IPC handler */
-	struct mbox_controller *adsp_mbox;
-
+	struct mtk_adsp_ipc *dsp_ipc;
+	struct platform_device *ipc_dev;
 	struct mtk_adsp_chip_info *adsp;
 	struct clk **clk;
 	u32 (*ap2adsp_addr)(u32 addr, void *data);
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index ba13e4540f7a..f4b24afb6f75 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/io.h>
+#include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -27,6 +28,99 @@
 #include "mt8195.h"
 #include "mt8195-clk.h"
 
+static int mt8195_get_mailbox_offset(struct snd_sof_dev *sdev)
+{
+	return MBOX_OFFSET;
+}
+
+static int mt8195_get_window_offset(struct snd_sof_dev *sdev, u32 id)
+{
+	return MBOX_OFFSET;
+}
+
+static int mt8195_send_msg(struct snd_sof_dev *sdev,
+			   struct snd_sof_ipc_msg *msg)
+{
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+
+	sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
+			  msg->msg_size);
+
+	return mtk_adsp_ipc_send(priv->dsp_ipc, MTK_ADSP_IPC_REQ, MTK_ADSP_IPC_OP_REQ);
+}
+
+static void mt8195_get_reply(struct snd_sof_dev *sdev)
+{
+	struct snd_sof_ipc_msg *msg = sdev->msg;
+	struct sof_ipc_reply reply;
+	int ret = 0;
+
+	if (!msg) {
+		dev_warn(sdev->dev, "unexpected ipc interrupt\n");
+		return;
+	}
+
+	/* get reply */
+	sof_mailbox_read(sdev, sdev->host_box.offset, &reply, sizeof(reply));
+	if (reply.error < 0) {
+		memcpy(msg->reply_data, &reply, sizeof(reply));
+		ret = reply.error;
+	} else {
+		/* reply has correct size? */
+		if (reply.hdr.size != msg->reply_size) {
+			dev_err(sdev->dev, "error: reply expected %zu got %u bytes\n",
+				msg->reply_size, reply.hdr.size);
+			ret = -EINVAL;
+		}
+
+		/* read the message */
+		if (msg->reply_size > 0)
+			sof_mailbox_read(sdev, sdev->host_box.offset,
+					 msg->reply_data, msg->reply_size);
+	}
+
+	msg->reply_error = ret;
+}
+
+static void mt8195_dsp_handle_reply(struct mtk_adsp_ipc *ipc)
+{
+	struct adsp_priv *priv = mtk_adsp_ipc_get_data(ipc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->sdev->ipc_lock, flags);
+	mt8195_get_reply(priv->sdev);
+	snd_sof_ipc_reply(priv->sdev, 0);
+	spin_unlock_irqrestore(&priv->sdev->ipc_lock, flags);
+}
+
+static void mt8195_dsp_handle_request(struct mtk_adsp_ipc *ipc)
+{
+	struct adsp_priv *priv = mtk_adsp_ipc_get_data(ipc);
+	u32 p; /* panic code */
+	int ret;
+
+	/* Read the message from the debug box. */
+	sof_mailbox_read(priv->sdev, priv->sdev->debug_box.offset + 4,
+			 &p, sizeof(p));
+
+	/* Check to see if the message is a panic code 0x0dead*** */
+	if ((p & SOF_IPC_PANIC_MAGIC_MASK) == SOF_IPC_PANIC_MAGIC) {
+		snd_sof_dsp_panic(priv->sdev, p, true);
+	} else {
+		snd_sof_ipc_msgs_rx(priv->sdev);
+
+		/* tell DSP cmd is done */
+		ret = mtk_adsp_ipc_send(priv->dsp_ipc, MTK_ADSP_IPC_RSP, MTK_ADSP_IPC_OP_RSP);
+		if (ret)
+			dev_err(priv->dev, "request send ipc failed");
+	}
+}
+
+static struct mtk_adsp_ipc_ops dsp_ops = {
+	.handle_reply		= mt8195_dsp_handle_reply,
+	.handle_request		= mt8195_dsp_handle_request,
+};
+
 static int platform_parse_resource(struct platform_device *pdev, void *data)
 {
 	struct resource *mmio;
@@ -285,15 +379,36 @@ static int mt8195_dsp_probe(struct snd_sof_dev *sdev)
 	}
 
 	sdev->bar[DSP_REG_BAR] = priv->adsp->va_cfgreg;
-	sdev->bar[DSP_MBOX0_BAR] =  priv->adsp->va_mboxreg[0];
-	sdev->bar[DSP_MBOX1_BAR] =  priv->adsp->va_mboxreg[1];
-	sdev->bar[DSP_MBOX2_BAR] =  priv->adsp->va_mboxreg[2];
 
 	sdev->mmio_bar = SOF_FW_BLK_TYPE_SRAM;
 	sdev->mailbox_bar = SOF_FW_BLK_TYPE_SRAM;
 
+	/* set default mailbox offset for FW ready message */
+	sdev->dsp_box.offset = mt8195_get_mailbox_offset(sdev);
+
+	priv->ipc_dev = platform_device_register_data(&pdev->dev, "mtk-adsp-ipc",
+						      PLATFORM_DEVID_NONE,
+						      pdev, sizeof(*pdev));
+	if (IS_ERR(priv->ipc_dev)) {
+		ret = PTR_ERR(priv->ipc_dev);
+		dev_err(sdev->dev, "failed to register mtk-adsp-ipc device\n");
+		goto err_adsp_sram_power_off;
+	}
+
+	priv->dsp_ipc = dev_get_drvdata(&priv->ipc_dev->dev);
+	if (!priv->dsp_ipc) {
+		ret = -EPROBE_DEFER;
+		dev_err(sdev->dev, "failed to get drvdata\n");
+		goto exit_pdev_unregister;
+	}
+
+	mtk_adsp_ipc_set_data(priv->dsp_ipc, priv);
+	priv->dsp_ipc->ops = &dsp_ops;
+
 	return 0;
 
+exit_pdev_unregister:
+	platform_device_unregister(priv->ipc_dev);
 err_adsp_sram_power_off:
 	adsp_sram_power_on(&pdev->dev, false);
 exit_clk_disable:
@@ -310,7 +425,9 @@ static int mt8195_dsp_shutdown(struct snd_sof_dev *sdev)
 static int mt8195_dsp_remove(struct snd_sof_dev *sdev)
 {
 	struct platform_device *pdev = container_of(sdev->dev, struct platform_device, dev);
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
 
+	platform_device_unregister(priv->ipc_dev);
 	adsp_sram_power_on(&pdev->dev, false);
 	adsp_clock_off(sdev);
 
@@ -361,6 +478,14 @@ static int mt8195_get_bar_index(struct snd_sof_dev *sdev, u32 type)
 	return type;
 }
 
+static int mt8195_ipc_msg_data(struct snd_sof_dev *sdev,
+			       struct snd_pcm_substream *substream,
+			       void *p, size_t sz)
+{
+	sof_mailbox_read(sdev, sdev->dsp_box.offset, p, sz);
+	return 0;
+}
+
 static struct snd_soc_dai_driver mt8195_dai[] = {
 {
 	.name = "SOF_DL2",
@@ -412,6 +537,13 @@ static struct snd_sof_dsp_ops sof_mt8195_ops = {
 	.write64	= sof_io_write64,
 	.read64		= sof_io_read64,
 
+	/* ipc */
+	.send_msg		= mt8195_send_msg,
+	.get_mailbox_offset	= mt8195_get_mailbox_offset,
+	.get_window_offset	= mt8195_get_window_offset,
+	.ipc_msg_data		= mt8195_ipc_msg_data,
+	.set_stream_data_offset = sof_set_stream_data_offset,
+
 	/* misc */
 	.get_bar_index	= mt8195_get_bar_index,
 
-- 
2.18.0

