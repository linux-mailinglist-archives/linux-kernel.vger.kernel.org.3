Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6FE58B501
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 12:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiHFKRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 06:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiHFKQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 06:16:59 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF8312D06;
        Sat,  6 Aug 2022 03:16:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3540E32000F9;
        Sat,  6 Aug 2022 06:16:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 06 Aug 2022 06:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659781014; x=1659867414; bh=Hqmot6k+wA
        5/nwdZH9VuaMpObSSqlmQv9gNrzpjhSK4=; b=YFoI1RWKkGjGhTL3onfIc8VPJk
        oY8r4/Ihui2/dgFY1eeJbm1XzBf/o6UxTIz2jCXKny+brRJqJKHdvBtcwLcquUBK
        KnG7IiwcJJbExuGSTttM6hIXgGuW/eDx0EaQvxxiBbrD5+co866w84ylhcGVEUGw
        Qiw5U46Sehzz5SO4JOFg0q4vQ6FsKJ900mw7dtiRCfeee6+f23DmClIgJ7v8AQRB
        5mue0noSusX0zRKfW9eYyTa8RUrkKNii8v0uoVCPys4c0hgISNY+S+W5U09OW8Gl
        MzTLFlM+vnWpbPROTktxFsVXwLu/UOOuBLZRVmSN/MyFLJLJeMxQl5MYhhUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659781014; x=1659867414; bh=Hqmot6k+wA5/nwdZH9VuaMpObSSq
        lmQv9gNrzpjhSK4=; b=1Q9Be8r/Rw2JCt04nmGrZ3TTjfba5xgU3jk13Dqgw85M
        iaKPzV0gChnDA3T+f8welpx71wbclv/gT51o4GH81LSfkKeSwOvgh4k05H0zRE2u
        dwrj/PXq+lfwAZTpOkf+47wNAecqGmDlS4fJe9PCf1rqmKUwxoIoEcp3BdDYDSSp
        SD0JNLfEu10J8gpwR61ytvTKBHW1bBFdKMkyvz9LlqQcwyXIxlHK1qD1jOjR3mP1
        ooIbnmSRUaKGUAf7IGm8dfh4jQqpCngdXo6v6458A7NRsDsAYHKK1s6LLlpFEs8y
        9jR99ZS6ajFCaAU8pxrh+HK7zN+1YGoCdlnAdxqN3A==
X-ME-Sender: <xms:lj_uYkiqdnKUmFYRzqo_H_dI9getdQiZCGxAs9NYDgtB6O40ENn_Sw>
    <xme:lj_uYtBM2Quswj1doPbVzMQ5FfkkImzvzmASKhh4SimauGwBPieNLbM51wcp2cqkM
    0fn1_1y-FupDKHYURM>
X-ME-Received: <xmr:lj_uYsHsqG0s6RnqgcI_EsL9a9YMnMctDvDE1t93n1ruPhWoIeMh4O4qh1pzISdJCwmSmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeffedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:lj_uYlSgcVoJFJ6XcUXif_8MAzgjB8BxPMHgGMb3VopcSl86rDsHiA>
    <xmx:lj_uYhyAIHoSCNJbI6utVTZYqZ6EkG6xjKUBsboLmhf3PzFUHfbcdw>
    <xmx:lj_uYj5QphXwbKmlp8hWXMubA1k4bXSqoyko5ZfnS9O918CHqRY6YQ>
    <xmx:lj_uYs_0mJLLoLIXbo_PlfhgNseK1PiF0Zx2gmGFbfSYBdT12zyEdw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Aug 2022 06:16:50 -0400 (EDT)
Date:   Sat, 06 Aug 2022 22:16:35 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 1/5] asus-wmi: Add basic support for TUF laptop keyboard
 RGB
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <N7V6GR.XFSPFYLCEU9X2@ljones.dev>
In-Reply-To: <CAHp75Ve-oo=pGkpD10kbOVtrYtzQLscFq9HO0-Y5a6M_fpXDNw@mail.gmail.com>
References: <20220805081909.10962-1-luke@ljones.dev>
        <20220805081909.10962-2-luke@ljones.dev>
        <CAHp75Ve-oo=pGkpD10kbOVtrYtzQLscFq9HO0-Y5a6M_fpXDNw@mail.gmail.com>
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

Hi Andy, thanks for the feedback:

On Sat, Aug 6 2022 at 11:44:33 +0200, Andy Shevchenko 
<andy.shevchenko@gmail.com> wrote:
> On Fri, Aug 5, 2022 at 10:20 AM Luke D. Jones <luke@ljones.dev> wrote:
>> 
>>  Adds support for TUF laptop RGB control via the multicolor LED API.
>> 
>>  As this is the base essentials for adjusting the RGB, it sets the
> 
> these are
> ...or...
> essential
> 
>>  default mode of the keyboard to static. This overwrites the booted
>>  state of the keyboard.
> 
> ...
> 
>>   #include <linux/leds.h>
>>  +#include <linux/led-class-multicolor.h>
> 
> Not sure about the ordering ('-' vs. 's') in locale C.
> 

I used hid-playstation.c as a reference and followed that ordering.

> ...
> 
>>  +static int tuf_rgb_brightness_set(struct led_classdev *cdev,
>>  +       enum led_brightness brightness)
>>  +{
>>  +       u8 r, g, b;
>>  +       int err;
>>  +       u32 ret;
> 
>>  +
>>  +       struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
> 
> No need to put blank lines in the definition block. Also it would be
> better to move the longest line to be first.

Okay cool. Done.

> 
>>  +       led_mc_calc_color_components(mc_cdev, brightness);
>>  +       r = mc_cdev->subled_info[0].brightness;
>>  +       g = mc_cdev->subled_info[1].brightness;
>>  +       b = mc_cdev->subled_info[2].brightness;
>>  +
>>  +       /* Writing out requires some defaults. This will overwrite 
>> boot mode */
>>  +       err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, 
>> ASUS_WMI_DEVID_TUF_RGB_MODE,
>>  +                       1 | 0 | (r << 16) | (g << 24), (b) | 0, 
>> &ret);
> 
> What the point in those ' | 0'  additions?

They were place-holders in testing that I forgot to change in the 
second patch which adds mode configuration :(

Should be "save | (mode << 8) | (r << 16) | (g << 24), (b) | (speed << 
8), &ret);", two bytes.

> 
>>  +       if (err) {
>>  +               pr_err("Unable to set TUF RGB data?\n");
> 
> Why not dev_err() ?

I didn't know about it? Is there an example or doc on its use?

> 
>>  +               return err;
>>  +       }
>>  +       return 0;
> 
> return err;

Something like this then?

if (err) {
	pr_err("Unable to set TUF RGB data?\n");
}
return err;

If so, done.

> 
>>  +}
> 
> ...
> 
>>  +       if (asus_wmi_dev_is_present(asus, 
>> ASUS_WMI_DEVID_TUF_RGB_MODE)) {
>>  +               struct led_classdev_mc *mc_cdev;
>>  +               struct mc_subled *mc_led_info;
>>  +               u8 brightness = 127;
> 
>>  +               mc_cdev = &asus->keyboard_rgb_mode.dev;
> 
> Join this with the definition above. It's fine if it's a bit longer
> than 80 characters.

Done.

> 
>>  +               /*
>>  +                * asus::kbd_backlight still controls a base 
>> 3-level backlight and when
>>  +                * it is on 0, the RGB is not visible at all. RGB 
>> should be treated as
>>  +                * an additional step.
>>  +                */
>>  +               mc_cdev->led_cdev.name = 
>> "asus::multicolour::kbd_backlight";
>>  +               mc_cdev->led_cdev.flags = LED_CORE_SUSPENDRESUME | 
>> LED_RETAIN_AT_SHUTDOWN;
>>  +               mc_cdev->led_cdev.brightness_set_blocking = 
>> tuf_rgb_brightness_set;
>>  +               mc_cdev->led_cdev.brightness_get = 
>> tuf_rgb_brightness_get;
>>  +
>>  +               /* Let the multicolour LED own the info */
>>  +               mc_led_info = devm_kmalloc_array(
>>  +                       &asus->platform_device->dev,
> 
> With a temporary variable you may make this one line shorter and 
> nicer looking
> 
>   struct device *dev = &asus->platform_device->dev;
> 

Done.

>>  +                       3,
>>  +                       sizeof(*mc_led_info),
>>  +                       GFP_KERNEL | __GFP_ZERO);
>>  +
>>  +               if (!mc_led_info)
>>  +                       return -ENOMEM;
>>  +
>>  +               mc_led_info[0].color_index = LED_COLOR_ID_RED;
>>  +               mc_led_info[1].color_index = LED_COLOR_ID_GREEN;
>>  +               mc_led_info[2].color_index = LED_COLOR_ID_BLUE;
>>  +
>>  +               /*
>>  +                * It's not possible to get last set data from 
>> device so set defaults
>>  +                * to make it safe for a user to change either RGB 
>> or modes. We don't
>>  +                * write these defaults to the device because they 
>> will overwrite a
>>  +                * users last saved boot setting (in NVRAM).
>>  +                */
>>  +               mc_cdev->led_cdev.brightness = brightness;
>>  +               mc_cdev->led_cdev.max_brightness = brightness;
>>  +               mc_led_info[0].intensity = brightness;
>>  +               mc_led_info[0].brightness = 
>> mc_cdev->led_cdev.brightness;
>>  +               mc_led_info[1].brightness = 
>> mc_cdev->led_cdev.brightness;
>>  +               mc_led_info[2].brightness = 
>> mc_cdev->led_cdev.brightness;
>>  +               led_mc_calc_color_components(mc_cdev, brightness);
>>  +
>>  +               mc_cdev->subled_info = mc_led_info;
>>  +               mc_cdev->num_colors = 3;
>>  +
>>  +               rv = 
>> led_classdev_multicolor_register(&asus->platform_device->dev, 
>> mc_cdev);
> 
> This also becomes shorter.

Done.

> 
>>  +       }
> 
> --
> With Best Regards,
> Andy Shevchenko


