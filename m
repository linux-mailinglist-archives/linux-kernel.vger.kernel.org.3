Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D48536B65
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 09:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiE1Hgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 03:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiE1Hgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 03:36:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EAB655E
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:36:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c19so9863880lfv.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rf7xTz6xWC+B69rXQW7WMdbA86zr+6aW1iCp94asITI=;
        b=I73nuEmg9d5oTCMliGcvwMAhodhF9ql1wQjjkgXz9yYxCYM2/VA1vUt4aK5ggcgxEf
         iDCdybD4JgdTm6lyPB1rKt8mk1e0YzzM+ZIN3hO7cdC5h3HDCpgXqmeHJrnNd065PraO
         yCkDXvKBe6A1k1Z3+TTeCkK6QKgzT/M1Ylgah9aXS25dGRXVPQfhdDaLwxBbnnl6l5Vg
         ain73E3cQWyQwEyUN2e17KcWri/WwBhuBTlF1+QbgOWTNIEiBTI9gJdzEv1byNFLRls/
         z1YsFqWQ8E9dlC5pxY4WvQYYzx0KIjK1PuNJwEDWM57LHnOMIbr9fC+G/PcLrAlqunEV
         B+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rf7xTz6xWC+B69rXQW7WMdbA86zr+6aW1iCp94asITI=;
        b=E8YyG8YTt3ZV4iAjtzQlFIV2qrUGcbDMcIe6qe5Q0kh8T7WzOwEs5MiaojSdMn43HC
         mbzQ592i67DLGZtDIbIjKqwAL9sN2rqew/CoYDHTzk2aKxNhenjT10+hdtAo0LLg4VFo
         lay3Mr1HJes65497I7kZZRYUEukLTXnjXJ6tR/utNbZ0tROnjhiMPCEZgDeIpA+MvqCM
         KCPkk3Ei3/WmF3sLgWGqVufpkH9JDkkIOgH5JOBkXuTEL6OVMxy7dddm/AfQ2nfiA1LT
         sEaJmk+i+8wXlvZWg5oqb7ehKTwrBOaGlzM+APZ0D8fdwedLF3MmJ6Mt7l/+rLakMc+a
         GQhQ==
X-Gm-Message-State: AOAM532slX9eB4626DVjYwxlfFnLxwkjI2ye2kZR9dzSRF7w2sA2rRqA
        1AIMZDJupec5TPKRUR0DG9epZw==
X-Google-Smtp-Source: ABdhPJySokKfbhJyhpL9WeQE7gSyMqDZAd1GY4Ipm3uFS8KTc8MuCrlK01mIouOibMXkNZ0e6Z5o0g==
X-Received: by 2002:a05:6512:10c4:b0:478:7392:a239 with SMTP id k4-20020a05651210c400b004787392a239mr19243667lfg.35.1653723404238;
        Sat, 28 May 2022 00:36:44 -0700 (PDT)
Received: from [192.168.16.143] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id a23-20020ac25057000000b00477ccad3dcfsm1201190lfm.287.2022.05.28.00.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 00:36:43 -0700 (PDT)
Message-ID: <dc6402d2-c492-8f4e-82c1-d0693320432a@kvaser.com>
Date:   Sat, 28 May 2022 09:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 04/12] can: kvaser_usb: Mark Mini PCIe 2xHS as supporting
 error counters
Content-Language: en-US
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <20220516134748.3724796-5-anssi.hannula@bitwise.fi>
From:   Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <20220516134748.3724796-5-anssi.hannula@bitwise.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 15:47, Anssi Hannula wrote:
> The 0bfd:0124 Kvaser Mini PCI Express 2xHS (FW 4.18.778) seems to support
> TX/RX error counters in exactly the same way (via unsolicited cmd 106 on
> bus errors and via cmd 20 when queried with cmd 19) as 0bfd:0017 Kvaser
> Memorator Professional HS/HS (FW 2.0.50), but only the latter has
> KVASER_USB_HAS_TXRX_ERRORS set to enable do_get_berr_counter().
> 
> Enable error counter retrieval for Kvaser Mini PCI Express 2xHS, too.
> 
> Fixes: 71873a9b38d1 ("can: kvaser_usb: Add support for more Kvaser Leaf v2 devices")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> 
> ---
> 
> I'm not really sure what KVASER_USB_HAS_TXRX_ERRORS means, exactly,
> w.r.t. device behavior, though, i.e. how does a device without it behave.

Devices without KVASER_USB_HAS_TXRX_ERRORS, firmware will always report
zero for the Rx and Tx error counters.

>   drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> index 47bff40c36b6..7388fdca9079 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> @@ -165,7 +165,8 @@ static const struct usb_device_id kvaser_usb_table[] = {
>   	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_HS_PRODUCT_ID) },
>   	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID) },
>   	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_LIGHT_2HS_PRODUCT_ID) },
> -	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_2HS_PRODUCT_ID) },
> +	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_2HS_PRODUCT_ID),
> +		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
>   	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_R_V2_PRODUCT_ID) },
>   	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_R_V2_PRODUCT_ID) },
>   	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID) },



It's possible to query the device for specific capabilities.
i.e. Kvaser Mini PCI Express 2xHS does also got support for silent mode.

I want to replace this patch with the one below:

 From fbf1c02e5f7860be9bdafd1c9b4f01c903dd9258 Mon Sep 17 00:00:00 2001
From: Jimmy Assarsson <extja@kvaser.com>
Date: Wed, 25 May 2022 20:21:19 +0200
Subject: [PATCH 04/13] can: kvaser_usb: kvaser_usb_leaf: Get 
capabilities from
  device

Use the CMD_GET_CAPABILITIES_REQ command to query the device for certain
capabilities. We are only interested in LISTENONLY mode and wither the
device reports CAN error counters.

And remove hard coded capabilities for all Leaf devices.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB 
devices")
Reported-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
  .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  61 ++------
  .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 146 +++++++++++++++++-
  2 files changed, 162 insertions(+), 45 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c 
b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 47bff40c36b6..247caf0982bc 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -116,51 +116,24 @@ static const struct usb_device_id 
kvaser_usb_table[] = {
  	/* Leaf USB product IDs */
  	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_DEVEL_PRODUCT_ID) },
  	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_LS_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_SWC_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_LIN_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_LS_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_SWC_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_DEVEL_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_HSHS_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_UPRO_HSHS_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_LS_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_SWC_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_LIN_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_LS_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_SWC_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_DEVEL_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_HSHS_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_UPRO_HSHS_PRODUCT_ID) },
  	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_GI_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_OBDII_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS |
-			       KVASER_USB_HAS_SILENT_MODE },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_HSLS_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_CH_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_BLACKBIRD_SPRO_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_OEM_MERCURY_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_OEM_LEAF_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_CAN_R_PRODUCT_ID),
-		.driver_info = KVASER_USB_HAS_TXRX_ERRORS },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_OBDII_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_HSLS_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_CH_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_BLACKBIRD_SPRO_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_OEM_MERCURY_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_OEM_LEAF_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_CAN_R_PRODUCT_ID) },
  	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_V2_PRODUCT_ID) },
  	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_HS_PRODUCT_ID) },
  	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID) },
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c 
b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 09ade66256b2..aee2dae67459 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -74,6 +74,8 @@
  #define CMD_TX_ACKNOWLEDGE		50
  #define CMD_CAN_ERROR_EVENT		51
  #define CMD_FLUSH_QUEUE_REPLY		68
+#define CMD_GET_CAPABILITIES_REQ	95
+#define CMD_GET_CAPABILITIES_RESP	96

  #define CMD_LEAF_LOG_MESSAGE		106

@@ -83,6 +85,8 @@
  #define KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK BIT(5)
  #define KVASER_USB_LEAF_SWOPTION_FREQ_24_MHZ_CLK BIT(6)

+#define KVASER_USB_LEAF_SWOPTION_EXT_CAP BIT(12)
+
  /* error factors */
  #define M16C_EF_ACKE			BIT(0)
  #define M16C_EF_CRCE			BIT(1)
@@ -288,6 +292,28 @@ struct leaf_cmd_log_message {
  	u8 data[8];
  } __packed;

+/* Sub commands for cap_req and cap_res */
+#define KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE 0x02
+#define KVASER_USB_LEAF_CAP_CMD_ERR_REPORT 0x05
+struct kvaser_cmd_cap_req {
+	__le16 padding0;
+	__le16 cap_cmd;
+	__le16 padding1;
+	__le16 channel;
+} __packed;
+
+/* Status codes for cap_res */
+#define KVASER_USB_LEAF_CAP_STAT_OK 0x00
+#define KVASER_USB_LEAF_CAP_STAT_NOT_IMPL 0x01
+#define KVASER_USB_LEAF_CAP_STAT_UNAVAIL 0x02
+struct kvaser_cmd_cap_res {
+	__le16 padding;
+	__le16 cap_cmd;
+	__le16 status;
+	__le32 mask;
+	__le32 value;
+} __packed;
+
  struct kvaser_cmd {
  	u8 len;
  	u8 id;
@@ -305,6 +331,8 @@ struct kvaser_cmd {
  			struct leaf_cmd_chip_state_event chip_state_event;
  			struct leaf_cmd_error_event error_event;
  			struct leaf_cmd_log_message log_message;
+			struct kvaser_cmd_cap_req cap_req;
+			struct kvaser_cmd_cap_res cap_res;
  		} __packed leaf;

  		union {
@@ -334,6 +362,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
  	[CMD_LEAF_LOG_MESSAGE]		= kvaser_fsize(u.leaf.log_message),
  	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.leaf.chip_state_event),
  	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.leaf.error_event),
+	[CMD_GET_CAPABILITIES_RESP]	= kvaser_fsize(u.leaf.cap_res),
  	/* ignored events: */
  	[CMD_FLUSH_QUEUE_REPLY]		= CMD_SIZE_ANY,
  };
@@ -596,6 +625,9 @@ static void 
kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
  	dev->fw_version = le32_to_cpu(softinfo->fw_version);
  	dev->max_tx_urbs = le16_to_cpu(softinfo->max_outstanding_tx);

+	if (sw_options & KVASER_USB_LEAF_SWOPTION_EXT_CAP)
+		dev->card_data.capabilities |= KVASER_USB_CAP_EXT_CAP;
+
  	switch (sw_options & KVASER_USB_LEAF_SWOPTION_FREQ_MASK) {
  	case KVASER_USB_LEAF_SWOPTION_FREQ_16_MHZ_CLK:
  		dev->cfg = &kvaser_usb_leaf_dev_cfg_16mhz;
@@ -676,6 +708,118 @@ static int kvaser_usb_leaf_get_card_info(struct 
kvaser_usb *dev)
  	return 0;
  }

+static int kvaser_usb_leaf_get_single_capability(struct kvaser_usb *dev,
+						 u16 cap_cmd_req, u16 *status)
+{
+	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
+	struct kvaser_cmd *cmd;
+	u32 value = 0;
+	u32 mask = 0;
+	u16 cap_cmd_res;
+	int err;
+	int i;
+
+	cmd = kcalloc(1, sizeof(struct kvaser_cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->id = CMD_GET_CAPABILITIES_REQ;
+	cmd->u.leaf.cap_req.cap_cmd = cpu_to_le16(cap_cmd_req);
+	cmd->len = CMD_HEADER_LEN + sizeof(struct kvaser_cmd_cap_req);
+
+	err = kvaser_usb_send_cmd(dev, cmd, cmd->len);
+	if (err)
+		goto end;
+
+	err = kvaser_usb_leaf_wait_cmd(dev, CMD_GET_CAPABILITIES_RESP, cmd);
+	if (err)
+		goto end;
+
+	*status = le16_to_cpu(cmd->u.leaf.cap_res.status);
+
+	if (*status != KVASER_USB_LEAF_CAP_STAT_OK)
+		goto end;
+
+	cap_cmd_res = le16_to_cpu(cmd->u.leaf.cap_res.cap_cmd);
+	switch (cap_cmd_res) {
+	case KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE:
+	case KVASER_USB_LEAF_CAP_CMD_ERR_REPORT:
+		value = le32_to_cpu(cmd->u.leaf.cap_res.value);
+		mask = le32_to_cpu(cmd->u.leaf.cap_res.mask);
+		break;
+	default:
+		dev_warn(&dev->intf->dev, "Unknown capability command %u\n",
+			 cap_cmd_res);
+		break;
+	}
+
+	for (i = 0; i < dev->nchannels; i++) {
+		if (BIT(i) & (value & mask)) {
+			switch (cap_cmd_res) {
+			case KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE:
+				card_data->ctrlmode_supported |=
+						CAN_CTRLMODE_LISTENONLY;
+				break;
+			case KVASER_USB_LEAF_CAP_CMD_ERR_REPORT:
+				card_data->capabilities |=
+						KVASER_USB_CAP_BERR_CAP;
+				break;
+			}
+		}
+	}
+
+end:
+	kfree(cmd);
+
+	return err;
+}
+
+static int kvaser_usb_leaf_get_capabilities_leaf(struct kvaser_usb *dev)
+{
+	int err;
+	u16 status;
+
+	if (!(dev->card_data.capabilities & KVASER_USB_CAP_EXT_CAP)) {
+		dev_info(&dev->intf->dev,
+			 "No extended capability support. Upgrade device firmware.\n");
+		return 0;
+	}
+
+	err = kvaser_usb_leaf_get_single_capability
+					(dev,
+					 KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE,
+					 &status);
+	if (err)
+		return err;
+	if (status)
+		dev_info(&dev->intf->dev,
+			 "KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE failed %u\n",
+			 status);
+
+	err = kvaser_usb_leaf_get_single_capability
+					(dev,
+					 KVASER_USB_LEAF_CAP_CMD_ERR_REPORT,
+					 &status);
+	if (err)
+		return err;
+	if (status)
+		dev_info(&dev->intf->dev,
+			 "KVASER_USB_LEAF_CAP_CMD_ERR_REPORT failed %u\n",
+			 status);
+
+	return 0;
+}
+
+static int kvaser_usb_leaf_get_capabilities(struct kvaser_usb *dev)
+{
+	int err = 0;
+
+	if (dev->card_data.leaf.family == KVASER_LEAF)
+		err = kvaser_usb_leaf_get_capabilities_leaf(dev);
+
+	return err;
+}
+
  static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
  					   const struct kvaser_cmd *cmd)
  {
@@ -1462,7 +1606,7 @@ const struct kvaser_usb_dev_ops 
kvaser_usb_leaf_dev_ops = {
  	.dev_get_software_info = kvaser_usb_leaf_get_software_info,
  	.dev_get_software_details = NULL,
  	.dev_get_card_info = kvaser_usb_leaf_get_card_info,
-	.dev_get_capabilities = NULL,
+	.dev_get_capabilities = kvaser_usb_leaf_get_capabilities,
  	.dev_set_opt_mode = kvaser_usb_leaf_set_opt_mode,
  	.dev_start_chip = kvaser_usb_leaf_start_chip,
  	.dev_stop_chip = kvaser_usb_leaf_stop_chip,
-- 
2.36.1

