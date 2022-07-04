Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20AC5651F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiGDKSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiGDKQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:16:48 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666F1DEB6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:16:47 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2645Z9NJ023931;
        Mon, 4 Jul 2022 05:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=eKPUZThOeVTIZnGIj8YxsTsMCnV73vohaSA5rmR9v4g=;
 b=F7tmh+JoX0h+qyYxqf8OgTj8F7pcvT/3b1kGu/0a+4khZsWXks+BJk/D6TSFYdfdFfgL
 qbLYXoDehdvQYpyXPGL6YQG1HNasK3ozwp2WK/1ble94nWXbXfaejAJDfdDujKbK3pxE
 OG/HIkz/kExR7HmpZRdDpbXbiwSjQSrLj5MJo7Fu4kVmIo6if8fXbILmgvdKHphGSztt
 Klex8eqhk5PQmqmLnQTVtfznPA8UQOS8jwqcJYOyGocQsaeQlVDVv7+wWkO9h2VjHSVc
 ygzg7pnvASboQpN3LuDTUuFCs5cGQbR0wbIYRcJBU+e14FvL5vB6F45+354PQuNf8JSr /A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3h2jeqhyad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 Jul 2022 05:15:40 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 4 Jul
 2022 11:15:39 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 4 Jul 2022 11:15:39 +0100
Received: from [198.90.202.50] (unknown [198.90.202.50])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D00B52A9;
        Mon,  4 Jul 2022 10:15:26 +0000 (UTC)
Message-ID: <f7876785-3895-7494-6d64-7ba64a5d290d@opensource.cirrus.com>
Date:   Mon, 4 Jul 2022 11:15:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ALSA: hda: add CSC3551 support for UM5302TA
Content-Language: en-US
To:     xhe <xw897002528@gmail.com>
CC:     Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tim Crawford <tcrawford@system76.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        "Andy Chi" <andy.chi@canonical.com>,
        Yong Wu <yong.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
References: <20220703053225.2203-1-xw897002528@gmail.com>
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <20220703053225.2203-1-xw897002528@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -Z0dxOpRqS1jDKGCKqRl7GMmV6o9zwHp
X-Proofpoint-ORIG-GUID: -Z0dxOpRqS1jDKGCKqRl7GMmV6o9zwHp
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/22 06:32, xhe wrote:
> From: He Wang <xw897002528@gmail.com>
>
> ASUS UM5302TA are using csc3551, or cs35l41, which is connected to the
> laptop by I2C bus. This patch adds quirk for the sound card, and avoid
> ACPI DSD things for i2c-multi-instantiate cases like CLSA0100.
>
> Patch is made by XiaoYan Li. It is tested by us on ASUS UM5302TA.
>
> Signed-off-by: He Wang <xw897002528@gmail.com>
> Signed-off-by: Xiaoyan Li <lxy.lixiaoyan@gmail.com>
> ---
>   sound/pci/hda/cs35l41_hda.c   | 2 +-
>   sound/pci/hda/patch_realtek.c | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
> index cce27a86267f..7374565ecf15 100644
> --- a/sound/pci/hda/cs35l41_hda.c
> +++ b/sound/pci/hda/cs35l41_hda.c
> @@ -420,7 +420,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
>   	 * And devm functions expect that the device requesting the resource has the correct
>   	 * fwnode.
>   	 */
> -	if (strncmp(hid, "CLSA0100", 8) != 0)
> +	if (strncmp(hid, "CLSA0100", 8) != 0 && strncmp(hid, "CSC3551", 7) != 0)

Hi,

Sorry, but this is wrong. It's configuring the device as external boost, 
but the correct is internal boost for this device.

Before accepting any new laptops to be supported, we would like to get 
the Firmware support merged first.

Thanks

Lucas

>   		return -EINVAL;
>   
>   	/* check I2C address to assign the index */
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index cee69fa7e246..49c27d948582 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -9138,6 +9138,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>   	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
>   	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
>   	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
> +	SND_PCI_QUIRK(0x1043, 0x1f12, "ASUS UM5302TA", ALC287_FIXUP_CS35L41_I2C_2),
>   	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
>   	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
>   	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
