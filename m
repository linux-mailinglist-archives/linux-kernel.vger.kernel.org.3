Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C77D58D24E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiHIDQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiHIDQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:16:24 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D791CFE5;
        Mon,  8 Aug 2022 20:16:23 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 99D695C00DC;
        Mon,  8 Aug 2022 23:16:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 Aug 2022 23:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1660014982; x=1660101382; bh=ukjdWG40ZX
        7YXoAPKsrVE7MJ7agYPsfUraNaURSxFFE=; b=M2nnoezSnSgXbTceevcd29h/Th
        yiMJGnYOhMt6un4CCfY22Eexvxt4AyNwGDxFz65Vo7NXFK0P9rdqT26wzzOtnQIP
        r+7YuWxex+E0iW0dPCX0zp89K4/LFTljzjxsEJ8KglSNhal7kgA+nlB1CgcGXDR3
        k67zmZ+smSTSwInKwgM8yge9QY6xxVdA/Ih7mXQpcQXePZd0CrMbLSrcgdMBASEl
        +tfPqt8G0oVwp9f18VmtdR5mLnBZrLVw37evXp1paGjkJpOfIDBa2+Xp0ohnVofB
        moFE2SLmN1ZqP8KwggG0wdAi7KT2NqjX5CToCAPTn7HaPO2LK5u7Qe889Eug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660014982; x=1660101382; bh=ukjdWG40ZX7YXoAPKsrVE7MJ7agY
        PsfUraNaURSxFFE=; b=phspnrplSUtnxfZK4F2RUx/kFc9FjQZMwMSyg2/TanPn
        1t95cJktXjueINQj/iwqnGWgEk0BCno5q6a4HXqGGw2yoP87/h935ACXDP0ot0WM
        SQf3YBYxm5EhwO/IzNev3UZ1dbHygNe1CDlsW7ymZizrha87gTobxyWAJRQuBtOO
        PcXK/NVcdaorGF+1O4zoW+5l4VFKgBI6/ffYG5xBeu6JycWaOCdlissbae3VwHhJ
        zOJYi95oIXmAdeqG9mqh2CKZ4g3SUoZGBi01KZogLkWRRYz0Zt6lcJBQ5URmHG04
        K9LpXUuFX8nQc6BK/A4l7l+GNJi4q3SJv14Jn4N6aA==
X-ME-Sender: <xms:htHxYpGZGP4JDRA_7ZNA9oO-lxGjcuKErkHloQFrVHOZdr5s_ptsTA>
    <xme:htHxYuXEE-JSJvHSTClEselLG1lGW8yJNtwqnZu4CrQkVw04pBDwyei0S66pndTxm
    y_cbX13uWiKYhrjsw4>
X-ME-Received: <xmr:htHxYrLrzBWb0I7IOt3MF_EIqCVQDIoS5_3qRt12dFjB74fGD_y493EHcecvoENERdJUeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvfevkfgjfhfogggtsehttd
    ertdertddvnecuhfhrohhmpefnuhhkvgculfhonhgvshcuoehluhhkvgeslhhjohhnvghs
    rdguvghvqeenucggtffrrghtthgvrhhnpedvvdegledtheefieejgfevgeefiefhtdevte
    efteduhfevtdefleethfetgeeludenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:htHxYvGy_UwZdid-AKJ3U7NoV18U7cB08qPxRC3cn6DbNcFBXDAVsw>
    <xmx:htHxYvV6Oef-yE6tDdv3WDNRYBteNdrJz3aNqiF6GF3TX3E_hHR1Hw>
    <xmx:htHxYqMUtGieCdTgiGeOUwrKTxj7ki09rd6C-WpLBzxdHV4o7DL5Fg>
    <xmx:htHxYqRLP3a-rO7F1JSy3FLGcQ4IuaDHbdwlcvnFLVPoK8rq5pXz0Q>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 23:16:18 -0400 (EDT)
Date:   Tue, 09 Aug 2022 15:16:05 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v3 2/6] asus-wmi: Implement TUF laptop keyboard LED modes
To:     hdegoede@redhat.com
Cc:     andy.shevchenko@gmail.com, pobrn@protonmail.com, pavel@ucw.cz,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <UQVBGR.1W6SHRT392MR@ljones.dev>
In-Reply-To: <20220809025054.1626339-3-luke@ljones.dev>
References: <20220809025054.1626339-1-luke@ljones.dev>
        <20220809025054.1626339-3-luke@ljones.dev>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*sighs*

I swear I ran checkpatch. I just doublechecked and ran again, getting 
this:

----------------------------------------------------------------
./v3-0002-asus-wmi-Implement-TUF-laptop-keyboard-LED-modes.patch
----------------------------------------------------------------
WARNING: Prefer kstrto<type> to single variable sscanf
#108: FILE: drivers/platform/x86/asus-wmi.c:783:
+ if (sscanf(buf, "%hhd", &save) != 1)
+ return -EINVAL;

WARNING: Prefer kstrto<type> to single variable sscanf
#129: FILE: drivers/platform/x86/asus-wmi.c:804:
+ if (sscanf(buf, "%hhd", &mode) != 1)
+ return -EINVAL;

WARNING: suspect code indent for conditional statements (8, 10)
#133: FILE: drivers/platform/x86/asus-wmi.c:808:
+ if (mode >= 12 || mode == 10)
+ asus->keyboard_rgb_led.mode = 10;

WARNING: suspect code indent for conditional statements (8, 10)
#135: FILE: drivers/platform/x86/asus-wmi.c:810:
+ else
+ asus->keyboard_rgb_led.mode = mode;

WARNING: Prefer kstrto<type> to single variable sscanf
#151: FILE: drivers/platform/x86/asus-wmi.c:826:
+ if (sscanf(buf, "%hhd", &speed) != 1)
+ return -EINVAL;

I will fix, and wait for review of V3 before submitting hopefully the 
final version.

Sorry everyone.


On Tue, Aug 9 2022 at 14:50:50 +1200, Luke D. Jones <luke@ljones.dev> 
wrote:
> Adds support for changing the laptop keyboard LED modes. These
> are visible effects such as static, rainbow, pulsing, colour cycles.
> 
> These sysfs attributes are added to asus-nb-wmi:
> - keyboard_rgb_save
> - keyboard_rgb_mode
> - keyboard_rgb_speed
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  30 +++++
>  drivers/platform/x86/asus-wmi.c               | 127 
> ++++++++++++++++--
>  2 files changed, 149 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi 
> b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 04885738cf15..a9128fa5cc65 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -57,3 +57,33 @@ Description:
>  			* 0 - default,
>  			* 1 - overboost,
>  			* 2 - silent
> +
> +What:		/sys/devices/platform/<platform>/keyboard_rgb_save
> +Date:		Aug 2022
> +KernelVersion:	6.1
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		Set or save the RGB mode details (write-only):
> +			* 0 - set, the settings will be lost on boot
> +			* 1 - save, the settings will be retained on boot
> +
> +What:		/sys/devices/platform/<platform>/keyboard_rgb_mode
> +Date:		Aug 2022
> +KernelVersion:	6.1
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		Set the mode of the RGB keyboard, the mode will not apply until the
> +		keyboard_rgb_save attribute is set (write-only):
> +			* 0 to 12, each is an RGB such as static, rainbow, pulse.
> +				Not all keyboards accept every mode.
> +
> +What:		/sys/devices/platform/<platform>/keyboard_rgb_speed
> +Date:		Aug 2022
> +KernelVersion:	6.1
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		Set the speed of the selected RGB effect, the speed will not apply
> +		until the keyboard_rgb_save attribute is set (write-only):
> +			* 0 - slow
> +			* 1 - medium
> +			* 2 - fast
> \ No newline at end of file
> diff --git a/drivers/platform/x86/asus-wmi.c 
> b/drivers/platform/x86/asus-wmi.c
> index 233e73f4313d..fa0cc2895a66 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -246,7 +246,8 @@ struct asus_wmi {
>  	bool dgpu_disable_available;
>  	bool dgpu_disable;
> 
> -	struct keyboard_rgb_led keyboard_rgb_mode;
> +	bool keyboard_rgb_mode_available;
> +	struct keyboard_rgb_led keyboard_rgb_led;
> 
>  	bool throttle_thermal_policy_available;
>  	u8 throttle_thermal_policy_mode;
> @@ -748,6 +749,102 @@ static ssize_t egpu_enable_store(struct device 
> *dev,
> 
>  static DEVICE_ATTR_RW(egpu_enable);
> 
> +/* TUF Laptop Keyboard RGB Modes 
> **********************************************/
> +static int keyboard_rgb_check_present(struct asus_wmi *asus)
> +{
> +	u32 result;
> +	int err;
> +
> +	asus->keyboard_rgb_mode_available = false;
> +
> +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_MODE, 
> &result);
> +	if (err) {
> +		if (err == -ENODEV)
> +			return 0;
> +		return err;
> +	}
> +
> +	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
> +		asus->keyboard_rgb_mode_available = true;
> +
> +	return 0;
> +}
> +
> +static ssize_t keyboard_rgb_save_store(struct device *device,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	u8 save;
> +	int err;
> +
> +	struct asus_wmi *asus = dev_get_drvdata(device);
> +	struct led_classdev *cdev = &asus->keyboard_rgb_led.dev.led_cdev;
> +
> +	if (sscanf(buf, "%hhd", &save) != 1)
> +		return -EINVAL;
> +
> +	asus->keyboard_rgb_led.save = !!save;
> +
> +	err = tuf_rgb_brightness_set(cdev, cdev->brightness);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(keyboard_rgb_save);
> +
> +static ssize_t keyboard_rgb_mode_store(struct device *device,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	u8 mode;
> +
> +	struct asus_wmi *asus = dev_get_drvdata(device);
> +
> +	if (sscanf(buf, "%hhd", &mode) != 1)
> +		return -EINVAL;
> +
> +	/* These are the known usable modes across all TUF/ROG */
> +	if (mode >= 12 || mode == 10)
> +	  asus->keyboard_rgb_led.mode = 10;
> +	else
> +	  asus->keyboard_rgb_led.mode = mode;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(keyboard_rgb_mode);
> +
> +
> +static ssize_t keyboard_rgb_speed_store(struct device *device,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	u8 speed;
> +
> +	struct asus_wmi *asus = dev_get_drvdata(device);
> +
> +	if (sscanf(buf, "%hhd", &speed) != 1)
> +		return -EINVAL;
> +
> +	switch (speed) {
> +	case 0:
> +		asus->keyboard_rgb_led.speed = 0xe1;
> +		break;
> +	case 1:
> +		asus->keyboard_rgb_led.speed = 0xeb;
> +		break;
> +	case 2:
> +		asus->keyboard_rgb_led.speed = 0xf5;
> +		break;
> +	default:
> +		asus->keyboard_rgb_led.speed = 0xeb;
> +		break;
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(keyboard_rgb_speed);
> +
>  /* Battery 
> ********************************************************************/
> 
>  /* The battery maximum charging percentage */
> @@ -1047,7 +1144,7 @@ static int tuf_rgb_brightness_set(struct 
> led_classdev *cdev,
>  {
>  	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
>  	struct keyboard_rgb_led *rgb = container_of(mc_cdev, struct 
> keyboard_rgb_led, dev);
> -	struct asus_wmi *asus = container_of(rgb, struct asus_wmi, 
> keyboard_rgb_mode);
> +	struct asus_wmi *asus = container_of(rgb, struct asus_wmi, 
> keyboard_rgb_led);
>  	struct device *dev = &asus->platform_device->dev;
>  	u8 r, g, b;
>  	int err;
> @@ -1075,7 +1172,7 @@ static void asus_wmi_led_exit(struct asus_wmi 
> *asus)
>  	led_classdev_unregister(&asus->tpd_led);
>  	led_classdev_unregister(&asus->wlan_led);
>  	led_classdev_unregister(&asus->lightbar_led);
> -	led_classdev_multicolor_unregister(&asus->keyboard_rgb_mode.dev);
> +	led_classdev_multicolor_unregister(&asus->keyboard_rgb_led.dev);
> 
>  	if (asus->led_workqueue)
>  		destroy_workqueue(asus->led_workqueue);
> @@ -1148,8 +1245,8 @@ static int asus_wmi_led_init(struct asus_wmi 
> *asus)
>  	}
> 
>  	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
> -		struct mc_subled *mc_led_info = 
> asus->keyboard_rgb_mode.subled_info;
> -		struct led_classdev_mc *mc_cdev = &asus->keyboard_rgb_mode.dev;
> +		struct mc_subled *mc_led_info = asus->keyboard_rgb_led.subled_info;
> +		struct led_classdev_mc *mc_cdev = &asus->keyboard_rgb_led.dev;
>  		struct device *dev = &asus->platform_device->dev;
>  		u8 led_brightness = 255;
> 
> @@ -1174,9 +1271,9 @@ static int asus_wmi_led_init(struct asus_wmi 
> *asus)
>  		 * It's not possible to get last set data from device so set 
> defaults
>  		 * to make it safe for a user to change either RGB or modes.
>  		 */
> -		asus->keyboard_rgb_mode.save = 1;
> -		asus->keyboard_rgb_mode.mode = 0;
> -		asus->keyboard_rgb_mode.speed = 0xeb;
> +		asus->keyboard_rgb_led.save = 1;
> +		asus->keyboard_rgb_led.mode = 0;
> +		asus->keyboard_rgb_led.speed = 0xeb;
> 
>  		mc_cdev->led_cdev.brightness = led_brightness;
>  		mc_cdev->led_cdev.max_brightness = led_brightness;
> @@ -3338,6 +3435,9 @@ static struct attribute *platform_attributes[] 
> = {
>  	&dev_attr_touchpad.attr,
>  	&dev_attr_egpu_enable.attr,
>  	&dev_attr_dgpu_disable.attr,
> +	&dev_attr_keyboard_rgb_save.attr,
> +	&dev_attr_keyboard_rgb_mode.attr,
> +	&dev_attr_keyboard_rgb_speed.attr,
>  	&dev_attr_lid_resume.attr,
>  	&dev_attr_als_enable.attr,
>  	&dev_attr_fan_boost_mode.attr,
> @@ -3368,6 +3468,12 @@ static umode_t asus_sysfs_is_visible(struct 
> kobject *kobj,
>  		ok = asus->egpu_enable_available;
>  	else if (attr == &dev_attr_dgpu_disable.attr)
>  		ok = asus->dgpu_disable_available;
> +	else if (attr == &dev_attr_keyboard_rgb_save.attr)
> +		ok = asus->keyboard_rgb_mode_available;
> +	else if (attr == &dev_attr_keyboard_rgb_mode.attr)
> +		ok = asus->keyboard_rgb_mode_available;
> +	else if (attr == &dev_attr_keyboard_rgb_speed.attr)
> +		ok = asus->keyboard_rgb_mode_available;
>  	else if (attr == &dev_attr_fan_boost_mode.attr)
>  		ok = asus->fan_boost_mode_available;
>  	else if (attr == &dev_attr_throttle_thermal_policy.attr)
> @@ -3637,6 +3743,10 @@ static int asus_wmi_add(struct platform_device 
> *pdev)
>  	if (err)
>  		goto fail_dgpu_disable;
> 
> +	err = keyboard_rgb_check_present(asus);
> +	if (err)
> +		goto fail_keyboard_rgb_mode;
> +
>  	err = fan_boost_mode_check_present(asus);
>  	if (err)
>  		goto fail_fan_boost_mode;
> @@ -3751,6 +3861,7 @@ static int asus_wmi_add(struct platform_device 
> *pdev)
>  fail_fan_boost_mode:
>  fail_egpu_enable:
>  fail_dgpu_disable:
> +fail_keyboard_rgb_mode:
>  fail_platform:
>  fail_panel_od:
>  	kfree(asus);
> --
> 2.37.1
> 


