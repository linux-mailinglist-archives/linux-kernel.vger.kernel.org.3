Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F4B58FA32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiHKJnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiHKJnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:43:01 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71D693503
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:42:59 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B5YQUh014676;
        Thu, 11 Aug 2022 04:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : from : subject : to : references : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=4hB4VqJ9D2x+F7YMOyUoVMiAiQyBxRswQNLToL9PR6c=;
 b=Kz7lnxctZc9xy4nWB6XwLNI9jDbm0FNKmtfsLS9thaBxbTAmkKOlHkQi8g4zxhvYeVzU
 QPQBKAan5hcDNP33zg3w2i960NMGajpU/b9V/+PMPHvgxSRJ4AbRg4IjjojUBjRMX3Bc
 HVcnRsHZBWMj482ZyqiFDJuQDIxImGKF2zepcQk5014ZpZDpBstJvtighNnAwBvbLyyI
 fMtgF/Co8E1MCbWNPa7g1QSvHq6oqMGIbW4GOBF1hI8thk5c8ijyQEaM8GYZoUZw6aRo
 cYB199q9JSwxG0ptmJD3K9f8fXz1kyRMkvupSw8/JP0ckR0RfE8X0K3k9ASVWq67ajMc xQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3huwqpa6q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 04:42:47 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 11 Aug
 2022 04:42:46 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Thu, 11 Aug 2022 04:42:46 -0500
Received: from [198.90.202.47] (unknown [198.90.202.47])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 137002C5;
        Thu, 11 Aug 2022 09:42:45 +0000 (UTC)
Message-ID: <c671ad96-e1aa-4cda-eef1-fd8fe906ec36@opensource.cirrus.com>
Date:   Thu, 11 Aug 2022 10:42:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH] Sound: pci/hda: Add quirk for HP Envy x360 ey0xxx
To:     Fae <faenkhauser@gmail.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
References: <20220811053950.11810-1-faenkhauser@gmail.com>
Content-Language: en-US
In-Reply-To: <20220811053950.11810-1-faenkhauser@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: t_fb2mJxYa0FJGf6QW3832kMA_NpcEl6
X-Proofpoint-ORIG-GUID: t_fb2mJxYa0FJGf6QW3832kMA_NpcEl6
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

On 8/11/22 06:39, Fae wrote:
> This patch fixes speaker output on the HP Envy x360 ey0xxx
> The mic/speaker mute LEDs are still non-functional but they aren't required for basic funtionality
>
> Also the quirk is labeled ALC287_FIXUP_CS35L41_I2C_2 however it does not only apply to ALC287
> Its function is the generic cs35l41 fixup telling the driver that there's 2 i2c speakers. It isn't actually specific to ALC287
>
> I did have a bit of luck getting the mic mute LED to work but it was to finicky to submit ( I used the ALC245_FIXUP_HP_GPIO_LED quirk )
> I had no luck getting the speaker mute LED to work
>
> Signed-off-by: Fae<faenkhauser@gmail.com>
> ---
>   sound/pci/hda/cs35l41_hda.c   | 3 ++-
>   sound/pci/hda/patch_realtek.c | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
> index 129bffb431c22..21d8c2de128ff 100644
> --- a/sound/pci/hda/cs35l41_hda.c
> +++ b/sound/pci/hda/cs35l41_hda.c
> @@ -1156,7 +1156,8 @@ static int cs35l41_no_acpi_dsd(struct cs35l41_hda *cs35l41, struct device *physd
>   	hw_cfg->valid = true;
>   	put_device(physdev);
>   
> -	if (strncmp(hid, "CLSA0100", 8) == 0) {
> +	if ((strncmp(hid, "CLSA0100", 8) == 0) ||
> +	    (strncmp(hid, "CSC3551", 7) == 0)) {

Sorry, but we can't accept this. The HID CSC3551 was created for a whole 
range of laptops, with all types of Boost.

With this HID the driver expects to read configurations from the BIOS.


>   		hw_cfg->bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
>   	} else if (strncmp(hid, "CLSA0101", 8) == 0) {
>   		hw_cfg->bst_type = CS35L41_EXT_BOOST;
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 8a57636f622e9..e7053cbc6bb6e 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -9179,6 +9179,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>   	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
>   	SND_PCI_QUIRK(0x103c, 0x841c, "HP Pavilion 15-CK0xx", ALC269_FIXUP_HP_MUTE_LED_MIC3),
>   	SND_PCI_QUIRK(0x103c, 0x8497, "HP Envy x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
> +	SND_PCI_QUIRK(0x103c, 0x8a31, "HP ENVY x360 2-in-1 Laptop 15-ey0xxx", ALC287_FIXUP_CS35L41_I2C_2),
>   	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
>   	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
>   	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
