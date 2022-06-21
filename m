Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90711553EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346474AbiFUWwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354853AbiFUWv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:51:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1763E31DDB;
        Tue, 21 Jun 2022 15:51:53 -0700 (PDT)
X-UUID: c04db7f580fa40d2b9b608109c8c9ce5-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:d82d7fd8-68cf-49b0-9104-196a679d57cd,OB:10,L
        OB:0,IP:0,URL:5,TC:0,Content:3,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:59
X-CID-INFO: VERSION:1.1.6,REQID:d82d7fd8-68cf-49b0-9104-196a679d57cd,OB:10,LOB
        :0,IP:0,URL:5,TC:0,Content:3,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:59
X-CID-META: VersionHash:b14ad71,CLOUDID:db4ead2d-1756-4fa3-be7f-474a6e4be921,C
        OID:f9af49f95651,Recheck:0,SF:28|17|19|48,TC:nil,Content:3,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: c04db7f580fa40d2b9b608109c8c9ce5-20220622
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 372402516; Wed, 22 Jun 2022 06:51:47 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 22 Jun 2022 06:51:45 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jun 2022 06:51:45 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 22 Jun 2022 06:51:45 +0800
From:   <sean.wang@mediatek.com>
To:     <pmenzel@molgen.mpg.de>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>,
        <abhishekpandit@google.com>, <michaelfsun@google.com>,
        <mcchou@chromium.org>, <shawnku@google.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: btmtksdio: Add in-band wakeup support
Date:   Wed, 22 Jun 2022 06:51:44 +0800
Message-ID: <1655851904-15022-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1472eccd-429b-0a18-565c-7de2e5ed44f2@molgen.mpg.de--annotate>
References: <1472eccd-429b-0a18-565c-7de2e5ed44f2@molgen.mpg.de--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>Dear Sean,
>
>
>Thank you for the patch.
>
>Am 10.06.22 um 02:17 schrieb sean.wang@mediatek.com:
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> 'ce64b3e94919 ("Bluetooth: mt7921s: Support wake on bluetooth")'
>> have added the waken-on-bluetooth via dedicated GPIO.
>
>Maybe:
>
>Commit ce64b3e94919 ("Bluetooth: mt7921s: Support wake on bluetooth") adds the wake on bluethooth via a dedicated GPIO.

Thanks! Look good to me. I will add it in the next version.

>
>> The patch extends the function to the waken-on-bluetooth via SDIO DAT1
>> pin (inband wakeup) when the SDIO host driver is able to support.
>
>Maybe:
>
>Extend the wake-on-bluetooth to use the SDIO DAT1 pin (in-band wakeup), when supported by the SDIO host driver.
>

Thanks! Look good to me. I will add it in the next version.

>How did you test this? In what datasheet is it documented?

We tested it on the MT8186 platform with wakening up by the keyboard or mouse when the platform is in the suspend state.

We can see the details on SDIO DAT1 pin in SDIO specification ver 3.00 section 8.2 Asynchronous Interrupt:
During the asynchronous interrupt period, the host can stop providing an SD clock to the card and the card
can generate an interrupt via SDIO DATA1 without SD clock.

or you can check the patch ("mmc: mediatek: add support for SDIO eint wakup IRQ")
in https://patchwork.kernel.org/project/linux-arm-kernel/patch/20220523074017.12649-4-axe.yang@mediatek.com/
that is the actual patch btmtksdio was tested against on MT8186 platfrom.

>
>> Co-developed-by: Yake Yang <yake.yang@mediatek.com>
>> Signed-off-by: Yake Yang <yake.yang@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>>   drivers/bluetooth/btmtksdio.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btmtksdio.c
>> b/drivers/bluetooth/btmtksdio.c index d6700efcfe8c..9ed3af4ba51a
>> 100644
>> --- a/drivers/bluetooth/btmtksdio.c
>> +++ b/drivers/bluetooth/btmtksdio.c
>> @@ -118,6 +118,7 @@ MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
>>   #define BTMTKSDIO_FUNC_ENABLED		3
>>   #define BTMTKSDIO_PATCH_ENABLED		4
>>   #define BTMTKSDIO_HW_RESET_ACTIVE	5
>> +#define BTMTKSDIO_INBAND_WAKEUP		6
>>
>>   struct mtkbtsdio_hdr {
>>	__le16	len;
>> @@ -1294,6 +1295,9 @@ static bool btmtksdio_sdio_wakeup(struct hci_dev *hdev)
>>		.wakeup_delay = cpu_to_le16(0x20),
>>	};
>>
>> +	if (test_bit(BTMTKSDIO_INBAND_WAKEUP, &bdev->tx_state))
>> +		return may_wakeup;
>> +
>>	if (may_wakeup && bdev->data->chipid == 0x7921) {
>>		struct sk_buff *skb;
>>
>> @@ -1384,6 +1388,10 @@ static int btmtksdio_probe(struct sdio_func *func,
>>	 */
>>	pm_runtime_put_noidle(bdev->dev);
>>
>> +	/* Mark if the mmc host can support waken by SDIO */
>
>Maybe:
>
>Mark if MMC host supports wake on bluetooth by SDIO

Thanks! Look good to me. I will add it in the next version.

>
>> +	if (device_can_wakeup(func->card->host->parent))
>> +		set_bit(BTMTKSDIO_INBAND_WAKEUP, &bdev->tx_state);
>> +
>>	err = device_init_wakeup(bdev->dev, true);
>>	if (err)
>>		bt_dev_err(hdev, "failed to initialize device wakeup");
>
>
>Kind regards,
>
>Paul
>
>
