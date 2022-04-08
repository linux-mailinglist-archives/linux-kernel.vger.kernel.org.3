Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE06C4F9E8B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbiDHVD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiDHVD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:03:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE67C38
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:01:21 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MSKq0-1nWNF000QS-00SdGi; Fri, 08 Apr 2022 23:00:54 +0200
Message-ID: <69de07fb-efdb-5296-f48b-e3af2ac5ef49@i2se.com>
Date:   Fri, 8 Apr 2022 23:00:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: bcm2835-audio: remove compat ALSA card
Content-Language: en-US
To:     Adrien Thierry <athierry@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220408150359.26661-1-athierry@redhat.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220408150359.26661-1-athierry@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2wzDVLaV8o2so10n9KyiFkmxspw0I3AUaKUm5jc3cx6TJpdh2Su
 E3NqVdqRiyutqINeveBbNXYXi1CQXwRT/EBccmuiKHqINrPjIE+F0Rikisc31JxYmhCu7uS
 KbD5Sjz7SPk4s9RyEbReP88hH+pxP+I27Pg6LxEh+bBM1QNDEFf4+mi8tsGpCJT8/8zCcAM
 24Z8R+0LujTvq8aXxjH3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G0yUGXC3bew=:vBCim0xKQiACHSo1FlFIGP
 bOamjqWFZxZelO2hz5SJJc3sx25jM4A/fnJ3eF0vtwaJdtKLx2EXtoDAjLfAzvZmpg0HcGGKp
 xjkPhhA0CJ99JtyGod3KGiliOWKGmdLUPEZCiV2xUBg21yQO5n6Wxg5fyBcXQ8dsYbfnjh0KH
 PbjB1aBagLn5Zbn+p6hYjVTWHNzpWx2FBNxb2XGb843YNxw2nmp/eXczKduDm81pBj+3wxc58
 1K/4GVQ21ELSUbu9D/OCEb+5SP9qsqBPXLtxbBaYAbjnMwAbJhNXTwg0Kv+cirK1qXHqPIWmz
 1PStRK1XMz0DxQehweJQYGW1nqkPRv3O42jKSjq6NA7DbAaV6o1859i9CdmygOesc97xq+Tgs
 9YKutv4T4UikPQDniyGqJDE5zc+pdxFu3F2Ye/qSOTsBcukeU5VjbcKWCIFrihgRiaCdqpGSz
 z2QLq8nEz5xWfuqG9tOCWtyqfUBUnRpxAuzGVsCFZOvCeBqFcX7GI1dLSmf4v5r7sEpsvWURX
 lXJlYzyuFFpwTMyOXUNc1r8tReiSJqGw9yA+hbiUBg07W0XQ0e4QC47JPx3spfi+6FqGXgE7N
 6N9cNnuE08Q8Cw0ikMX46enF+szJ/ls5SCQFlse6iqXTUu76g7XAHbpZr4fMga9UUEOCS99Mk
 uyQxDEiBg+oARM+a8RHrcr4xfxGi6YGdp+giq1SG+TIyNxAVmPy86B7s5MOreSPwk7WBr3i/R
 XZ3cCt6k+txEOV/t
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrien,

[ add Maxime and Takashi ]

Am 08.04.22 um 17:03 schrieb Adrien Thierry:
> Remove compat ALSA card, which has overlapping functionality with the
> two other cards described by the driver (HDMI and headphones)
>
> This handles TODO item "Revisit multi-cards options and PCM route mixer
> control".
>
> Move the S/PDIF device that was part of the compat ALSA card to the HDMI
> card.
>
> Only enable headphones card by default, because HDMI breaks when using
> both vc4 and bcm2835-audio with HDMI card enabled.
>
> Signed-off-by: Adrien Thierry <athierry@redhat.com>
> ---
>
> I was able to test PCM output on 3.5mm and HDMI on a Raspberry Pi 4.
> However, I couldn't test the HDMI S/PDIF device since I don't own a S/PDIF
> capable speaker.

thanks for taking care of this issue. Unfortunately i cannot give a 
technical review to this patch. So hoping Maxime or Takashi can do ...

Best regards

>
>   .../vc04_services/bcm2835-audio/bcm2835-ctl.c | 86 ++-----------------
>   .../vc04_services/bcm2835-audio/bcm2835.c     | 33 ++-----
>   2 files changed, 15 insertions(+), 104 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> index 3703409715da..1c1f040122d7 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> @@ -117,15 +117,6 @@ static const struct snd_kcontrol_new snd_bcm2835_ctl[] = {
>   		.get = snd_bcm2835_ctl_get,
>   		.put = snd_bcm2835_ctl_put,
>   	},
> -	{
> -		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> -		.name = "PCM Playback Route",
> -		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> -		.private_value = PCM_PLAYBACK_DEVICE,
> -		.info = snd_bcm2835_ctl_info,
> -		.get = snd_bcm2835_ctl_get,
> -		.put = snd_bcm2835_ctl_put,
> -	},
>   };
>   
>   static int snd_bcm2835_spdif_default_info(struct snd_kcontrol *kcontrol,
> @@ -220,7 +211,14 @@ static int create_ctls(struct bcm2835_chip *chip, size_t size,
>   	return 0;
>   }
>   
> -int snd_bcm2835_new_ctl(struct bcm2835_chip *chip)
> +int snd_bcm2835_new_headphones_ctl(struct bcm2835_chip *chip)
> +{
> +	strscpy(chip->card->mixername, "Broadcom Mixer", sizeof(chip->card->mixername));
> +	return create_ctls(chip, ARRAY_SIZE(snd_bcm2835_ctl),
> +			   snd_bcm2835_ctl);
> +}
> +
> +int snd_bcm2835_new_hdmi_ctl(struct bcm2835_chip *chip)
>   {
>   	int err;
>   
> @@ -232,71 +230,3 @@ int snd_bcm2835_new_ctl(struct bcm2835_chip *chip)
>   			   snd_bcm2835_spdif);
>   }
>   
> -static const struct snd_kcontrol_new snd_bcm2835_headphones_ctl[] = {
> -	{
> -		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> -		.name = "Headphone Playback Volume",
> -		.index = 0,
> -		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
> -			  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
> -		.private_value = PCM_PLAYBACK_VOLUME,
> -		.info = snd_bcm2835_ctl_info,
> -		.get = snd_bcm2835_ctl_get,
> -		.put = snd_bcm2835_ctl_put,
> -		.count = 1,
> -		.tlv = {.p = snd_bcm2835_db_scale}
> -	},
> -	{
> -		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> -		.name = "Headphone Playback Switch",
> -		.index = 0,
> -		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> -		.private_value = PCM_PLAYBACK_MUTE,
> -		.info = snd_bcm2835_ctl_info,
> -		.get = snd_bcm2835_ctl_get,
> -		.put = snd_bcm2835_ctl_put,
> -		.count = 1,
> -	}
> -};
> -
> -int snd_bcm2835_new_headphones_ctl(struct bcm2835_chip *chip)
> -{
> -	strscpy(chip->card->mixername, "Broadcom Mixer", sizeof(chip->card->mixername));
> -	return create_ctls(chip, ARRAY_SIZE(snd_bcm2835_headphones_ctl),
> -			   snd_bcm2835_headphones_ctl);
> -}
> -
> -static const struct snd_kcontrol_new snd_bcm2835_hdmi[] = {
> -	{
> -		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> -		.name = "HDMI Playback Volume",
> -		.index = 0,
> -		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
> -			  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
> -		.private_value = PCM_PLAYBACK_VOLUME,
> -		.info = snd_bcm2835_ctl_info,
> -		.get = snd_bcm2835_ctl_get,
> -		.put = snd_bcm2835_ctl_put,
> -		.count = 1,
> -		.tlv = {.p = snd_bcm2835_db_scale}
> -	},
> -	{
> -		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> -		.name = "HDMI Playback Switch",
> -		.index = 0,
> -		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> -		.private_value = PCM_PLAYBACK_MUTE,
> -		.info = snd_bcm2835_ctl_info,
> -		.get = snd_bcm2835_ctl_get,
> -		.put = snd_bcm2835_ctl_put,
> -		.count = 1,
> -	}
> -};
> -
> -int snd_bcm2835_new_hdmi_ctl(struct bcm2835_chip *chip)
> -{
> -	strscpy(chip->card->mixername, "Broadcom Mixer", sizeof(chip->card->mixername));
> -	return create_ctls(chip, ARRAY_SIZE(snd_bcm2835_hdmi),
> -			   snd_bcm2835_hdmi);
> -}
> -
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> index 628732d7bf6a..00bc898b0189 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> @@ -10,17 +10,13 @@
>   #include "bcm2835.h"
>   
>   static bool enable_hdmi;
> -static bool enable_headphones;
> -static bool enable_compat_alsa = true;
> +static bool enable_headphones = true;
>   static int num_channels = MAX_SUBSTREAMS;
>   
>   module_param(enable_hdmi, bool, 0444);
>   MODULE_PARM_DESC(enable_hdmi, "Enables HDMI virtual audio device");
>   module_param(enable_headphones, bool, 0444);
>   MODULE_PARM_DESC(enable_headphones, "Enables Headphones virtual audio device");
> -module_param(enable_compat_alsa, bool, 0444);
> -MODULE_PARM_DESC(enable_compat_alsa,
> -		 "Enables ALSA compatibility virtual audio device");
>   module_param(num_channels, int, 0644);
>   MODULE_PARM_DESC(num_channels, "Number of audio channels (default: 8)");
>   
> @@ -63,19 +59,20 @@ struct bcm2835_audio_driver {
>   	enum snd_bcm2835_route route;
>   };
>   
> -static int bcm2835_audio_alsa_newpcm(struct bcm2835_chip *chip,
> +static int bcm2835_audio_dual_newpcm(struct bcm2835_chip *chip,
>   				     const char *name,
>   				     enum snd_bcm2835_route route,
>   				     u32 numchannels)
>   {
>   	int err;
>   
> -	err = snd_bcm2835_new_pcm(chip, "bcm2835 ALSA", 0, AUDIO_DEST_AUTO,
> -				  numchannels - 1, false);
> +	err = snd_bcm2835_new_pcm(chip, name, 0, route,
> +				  numchannels, false);
> +
>   	if (err)
>   		return err;
>   
> -	err = snd_bcm2835_new_pcm(chip, "bcm2835 IEC958/HDMI", 1, 0, 1, true);
> +	err = snd_bcm2835_new_pcm(chip, "IEC958", 1, route, 1, true);
>   	if (err)
>   		return err;
>   
> @@ -90,18 +87,6 @@ static int bcm2835_audio_simple_newpcm(struct bcm2835_chip *chip,
>   	return snd_bcm2835_new_pcm(chip, name, 0, route, numchannels, false);
>   }
>   
> -static struct bcm2835_audio_driver bcm2835_audio_alsa = {
> -	.driver = {
> -		.name = "bcm2835_alsa",
> -		.owner = THIS_MODULE,
> -	},
> -	.shortname = "bcm2835 ALSA",
> -	.longname  = "bcm2835 ALSA",
> -	.minchannels = 2,
> -	.newpcm = bcm2835_audio_alsa_newpcm,
> -	.newctl = snd_bcm2835_new_ctl,
> -};
> -
>   static struct bcm2835_audio_driver bcm2835_audio_hdmi = {
>   	.driver = {
>   		.name = "bcm2835_hdmi",
> @@ -110,7 +95,7 @@ static struct bcm2835_audio_driver bcm2835_audio_hdmi = {
>   	.shortname = "bcm2835 HDMI",
>   	.longname  = "bcm2835 HDMI",
>   	.minchannels = 1,
> -	.newpcm = bcm2835_audio_simple_newpcm,
> +	.newpcm = bcm2835_audio_dual_newpcm,
>   	.newctl = snd_bcm2835_new_hdmi_ctl,
>   	.route = AUDIO_DEST_HDMI
>   };
> @@ -134,10 +119,6 @@ struct bcm2835_audio_drivers {
>   };
>   
>   static struct bcm2835_audio_drivers children_devices[] = {
> -	{
> -		.audio_driver = &bcm2835_audio_alsa,
> -		.is_enabled = &enable_compat_alsa,
> -	},
>   	{
>   		.audio_driver = &bcm2835_audio_hdmi,
>   		.is_enabled = &enable_hdmi,
>
> base-commit: 1831fed559732b132aef0ea8261ac77e73f7eadf
