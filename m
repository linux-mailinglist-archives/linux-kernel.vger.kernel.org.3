Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCC858B8F6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 03:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiHGBzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 21:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiHGBzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 21:55:12 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876649FFF;
        Sat,  6 Aug 2022 18:55:10 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C85245C00B1;
        Sat,  6 Aug 2022 21:55:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 06 Aug 2022 21:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1659837309; x=
        1659923709; bh=W6vVBCABa5xeS4lFFAZL4VKwy3Ysr6bCN+nYbUKHguY=; b=R
        xLaKFf/daVe8sqwajX8GVLqInRL6FVxEp3ftqyc6OyfgHHrBP2pv8kIoF4ZGyY+o
        bQF2LWGQzFPlzbdV7tW21wWhxJ7viKd9Lyuv72Cabb2js6AedQ8BRJYs8PWsiJ1/
        XuPqEJ03gPQPuEgOyKIsFYrZRF6IrBE6a9+//Rt/YfCCxJA7S00hndxNuJqO47LG
        71R3oAHlAIVD/llBsih6lyTq0XNgc6XH1Evepro0ZqDDPmyV2yN4RPHV31FDC9zl
        fU65IynotDUfeOVBBqdoMd1r8RPS6UrYJoQUDN4uD2GtW93aS3QfzEuI1+zBHc91
        suJR1L9L2Z0fMtIc1I7WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1659837309; x=
        1659923709; bh=W6vVBCABa5xeS4lFFAZL4VKwy3Ysr6bCN+nYbUKHguY=; b=V
        4LiNTbrA6PkBR5qYx8eqrhDwCaJU4wYhbjAxADNt8iCg44DpdUnip4HzgdsLT+yN
        YkvllaHSfht2efQT3koQ+8KIQ7vhlILSrtgNBV9RUeawznc4BI9BUiNFiP6MbKT8
        dp07xdjsyl3vf3EL/Q58VSGlDXTyqi62TxqEhZHMNqippxAseWkXn/x9MWu9SWfb
        L5cxrqCMKv9nU8cxQbUbpfqZgclLjpxOD4IV5JoTNaWcBYvubI8zFmZtXhP7mwg0
        /9cK0Fw4WpZ+vAOHaIb34v5a6sWFDDC4FFwNduxqhjPMONvz2BqAmYtcURXortbc
        0Sdjp/dfzCMvjUHauJ1kA==
X-ME-Sender: <xms:fRvvYg6B_NzEzyr3iamcuxcc-9wdc2ASrk_rJX2jko5HKQT2t56ZJQ>
    <xme:fRvvYh6jU1i-n9AfSPNymmwQcSz1M0TfeEGel9jJTaH5kUW-XvQl6JuWyXAprG5rm
    mIVm5oG68Q7WiNCCjI>
X-ME-Received: <xmr:fRvvYve_MRtCY84FBN6ifNSytSLmV_5xXIPY3IPnY46Ypp58wGpt7kBRN3n3-psZIySqWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefgedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvfevkfgjfhfogggtgfesth
    hqredtredtshenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgv
    shdruggvvheqnecuggftrfgrthhtvghrnhepffetkeeugedvteeuhfeiudduffffhffgue
    fhleefleejhefflefhveetieevkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:fRvvYlISPrVCJSahNRAsIL5kHmqNqN8t3Aer0zzeEdeCXTNFtjp1RQ>
    <xmx:fRvvYkI9vyumlPkMByCE2tLPXGBiQxNPw46lhHbvlcdj4ZKU-91gCA>
    <xmx:fRvvYmz9NKdvYcv9Om09_pwcep9Y5wP7MKo9q33KmUxHgub2txgLsw>
    <xmx:fRvvYrXwBwAXsShaCk3uFd6wOYmqj6ACttLpo4i_wJUf8di_9SJWHw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Aug 2022 21:55:05 -0400 (EDT)
Date:   Sun, 07 Aug 2022 13:54:52 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 1/5] asus-wmi: Add basic support for TUF laptop keyboard
 RGB
To:     =?iso-8859-2?q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <GN28GR.5DRC7JSLXRDT3@ljones.dev>
In-Reply-To: <06B-xdz9pdNnj8DeXMMmdUi9Z7NAmQd3mFSHALyKMARSKZmal3FTLvXYKeF7SX_h78ko8RCpbC3t9wUanK6T2nNz1sYVtrSSGEcsfWAxtXY=@protonmail.com>
References: <20220805081909.10962-1-luke@ljones.dev>
        <20220805081909.10962-2-luke@ljones.dev>
        <06B-xdz9pdNnj8DeXMMmdUi9Z7NAmQd3mFSHALyKMARSKZmal3FTLvXYKeF7SX_h78ko8RCpbC3t9wUanK6T2nNz1sYVtrSSGEcsfWAxtXY=@protonmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barnab=E1s,

Thank you for taking the time to review

On Sat, Aug 6 2022 at 17:30:04 +0000, Barnab=E1s P=F5cze=20
<pobrn@protonmail.com> wrote:
> Hi
>=20
>=20
> 2022. augusztus 5., p=E9ntek 10:19 keltez=E9ssel, Luke D. Jones=20
> <luke@ljones.dev> =EDrta:
>=20
>>  Adds support for TUF laptop RGB control via the multicolor LED API.
>>=20
>>  As this is the base essentials for adjusting the RGB, it sets the
>>  default mode of the keyboard to static. This overwrites the booted
>>  state of the keyboard.
>>=20
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>  ---
>>   drivers/platform/x86/asus-wmi.c            | 89=20
>> ++++++++++++++++++++++
>>   include/linux/platform_data/x86/asus-wmi.h |  3 +
>>   2 files changed, 92 insertions(+)
>>=20
>>  diff --git a/drivers/platform/x86/asus-wmi.c=20
>> b/drivers/platform/x86/asus-wmi.c
>>  index 0e7fbed8a50d..33384e3321bb 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  @@ -25,6 +25,7 @@
>>   #include <linux/input/sparse-keymap.h>
>>   #include <linux/kernel.h>
>>   #include <linux/leds.h>
>>  +#include <linux/led-class-multicolor.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>>   #include <linux/pci_hotplug.h>
>>  @@ -190,6 +191,11 @@ struct fan_curve_data {
>>   	u8 percents[FAN_CURVE_POINTS];
>>   };
>>=20
>>  +struct keyboard_rgb_led {
>>  +	struct led_classdev_mc dev;
>>  +	struct mc_subled subled_info[3]; /* r g b */
>>  +};
>>  +
>>   struct asus_wmi {
>>   	int dsts_id;
>>   	int spec;
>>  @@ -234,6 +240,9 @@ struct asus_wmi {
>>   	bool dgpu_disable_available;
>>   	bool dgpu_disable;
>>=20
>>  +	bool keyboard_rgb_mode_available;
>=20
> I think this variable could be introduced in the next patch, it is=20
> not used in this one.
>=20

Thank you for spotting this. I must have missed it when I split the=20
patches.

>=20
>>  +	struct keyboard_rgb_led keyboard_rgb_mode;
>>  +
>>   	bool throttle_thermal_policy_available;
>>   	u8 throttle_thermal_policy_mode;
>>=20
>>  @@ -1028,6 +1037,35 @@ static enum led_brightness=20
>> lightbar_led_get(struct led_classdev *led_cdev)
>>   	return result & ASUS_WMI_DSTS_LIGHTBAR_MASK;
>>   }
>>=20
>>  +static int tuf_rgb_brightness_set(struct led_classdev *cdev,
>>  +	enum led_brightness brightness)
>>  +{
>>  +	u8 r, g, b;
>>  +	int err;
>>  +	u32 ret;
>>  +
>>  +	struct led_classdev_mc *mc_cdev =3D lcdev_to_mccdev(cdev);
>>  +
>>  +	led_mc_calc_color_components(mc_cdev, brightness);
>>  +	r =3D mc_cdev->subled_info[0].brightness;
>>  +	g =3D mc_cdev->subled_info[1].brightness;
>>  +	b =3D mc_cdev->subled_info[2].brightness;
>>  +
>>  +	/* Writing out requires some defaults. This will overwrite boot=20
>> mode */
>>  +	err =3D asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,=20
>> ASUS_WMI_DEVID_TUF_RGB_MODE,
>>  +			1 | 0 | (r << 16) | (g << 24), (b) | 0, &ret);
>>  +	if (err) {
>>  +		pr_err("Unable to set TUF RGB data?\n");
>>  +		return err;
>>  +	}
>>  +	return 0;
>>  +}
>>  +
>>  +static enum led_brightness tuf_rgb_brightness_get(struct=20
>> led_classdev *cdev)
>>  +{
>>  +	return cdev->brightness;
>>  +}
>=20
> If you can't query the brightness from the hardware, I think you can=20
> leave
> `led_classdev::brightness_get` to be `NULL`. This callback is only=20
> used from
> `led_update_brightness()` as far as I can see.
>=20

I did wonder about this. Thanks, I've nulled it.

>=20
>>  +
>>   static void asus_wmi_led_exit(struct asus_wmi *asus)
>>   {
>>   	led_classdev_unregister(&asus->kbd_led);
>>  @@ -1105,6 +1143,57 @@ static int asus_wmi_led_init(struct asus_wmi=20
>> *asus)
>>   					   &asus->lightbar_led);
>>   	}
>>=20
>>  +	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
>>  +		struct led_classdev_mc *mc_cdev;
>>  +		struct mc_subled *mc_led_info;
>>  +		u8 brightness =3D 127;
>>  +
>>  +		mc_cdev =3D &asus->keyboard_rgb_mode.dev;
>>  +
>>  +		/*
>>  +		 * asus::kbd_backlight still controls a base 3-level backlight=20
>> and when
>>  +		 * it is on 0, the RGB is not visible at all. RGB should be=20
>> treated as
>>  +		 * an additional step.
>>  +		 */
>>  +		mc_cdev->led_cdev.name =3D "asus::multicolour::kbd_backlight";
>>  +		mc_cdev->led_cdev.flags =3D LED_CORE_SUSPENDRESUME |=20
>> LED_RETAIN_AT_SHUTDOWN;
>>  +		mc_cdev->led_cdev.brightness_set_blocking =3D=20
>> tuf_rgb_brightness_set;
>>  +		mc_cdev->led_cdev.brightness_get =3D tuf_rgb_brightness_get;
>>  +
>>  +		/* Let the multicolour LED own the info */
>>  +		mc_led_info =3D devm_kmalloc_array(
>>  +			&asus->platform_device->dev,
>>  +			3,
>>  +			sizeof(*mc_led_info),
>>  +			GFP_KERNEL | __GFP_ZERO);
>>  +
>=20
> I am a bit confused as to why dynamic allocation is needed here.=20
> Haven't you
> already "allocated" the storage in `keyboard_rgb_led::subled_info`?

Honestly, I write rust 90% of the time which is quite clear on these=20
things, so here I wasn't very sure about what to do - I read the=20
hid-playstation.c and it had something similar so I used it and=20
completely forgot about the struct allocation.

I've updated to `struct mc_subled *mc_led_info =3D=20
asus->keyboard_rgb_mode.subled_info;` and removed the dynamic alloc.

>=20
>=20
>>  +		if (!mc_led_info)
>>  +			return -ENOMEM;
>>  +
>>  +		mc_led_info[0].color_index =3D LED_COLOR_ID_RED;
>>  +		mc_led_info[1].color_index =3D LED_COLOR_ID_GREEN;
>>  +		mc_led_info[2].color_index =3D LED_COLOR_ID_BLUE;
>>  +
>>  +		/*
>>  +		 * It's not possible to get last set data from device so set=20
>> defaults
>>  +		 * to make it safe for a user to change either RGB or modes. We=20
>> don't
>>  +		 * write these defaults to the device because they will=20
>> overwrite a
>>  +		 * users last saved boot setting (in NVRAM).
>>  +		 */
>>  +		mc_cdev->led_cdev.brightness =3D brightness;
>>  +		mc_cdev->led_cdev.max_brightness =3D brightness;
>>  +		mc_led_info[0].intensity =3D brightness;
>>  +		mc_led_info[0].brightness =3D mc_cdev->led_cdev.brightness;
>>  +		mc_led_info[1].brightness =3D mc_cdev->led_cdev.brightness;
>>  +		mc_led_info[2].brightness =3D mc_cdev->led_cdev.brightness;
>>  +		led_mc_calc_color_components(mc_cdev, brightness);
>>  +
>>  +		mc_cdev->subled_info =3D mc_led_info;
>>  +		mc_cdev->num_colors =3D 3;
>=20
> `led_mc_calc_color_components()` uses `led_classdev_mc::num_colors`,=20
> so I think
> it needs to be set before calling it. But that function sets the=20
> subled brightness
> based on the intensity, so it will overwrite the brightness values=20
> that have just
> been set.

Ah thanks, I don't think I understood that before. I've removed=20
mc_led_info[i].brightness setting now.

>=20
>=20
>>  +
>>  +		rv =3D=20
>> led_classdev_multicolor_register(&asus->platform_device->dev,=20
>> mc_cdev);
>>  +	}
>>  +
>>   error:
>>   	if (rv)
>>   		asus_wmi_led_exit(asus);
>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h=20
>> b/include/linux/platform_data/x86/asus-wmi.h
>>  index a571b47ff362..d63c9945a17d 100644
>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>  @@ -98,6 +98,9 @@
>>   /* dgpu on/off */
>>   #define ASUS_WMI_DEVID_DGPU		0x00090020
>>=20
>>  +/* TUF laptop RGB control */
>>  +#define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
>>  +
>>   /* DSTS masks */
>>   #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
>>   #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
>>  --
>>  2.37.1
>>=20
>>=20
>=20
>=20
> Regards,
> Barnab=E1s P=F5cze


