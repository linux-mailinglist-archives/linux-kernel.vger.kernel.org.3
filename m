Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241295A255F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbiHZKEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiHZKEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:04:22 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F86DA3C7;
        Fri, 26 Aug 2022 03:03:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F0015C0076;
        Fri, 26 Aug 2022 06:03:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 26 Aug 2022 06:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1661508185; x=1661594585; bh=C/04hfQf58
        qqXEDynVULUcRZ7WQWjIiHU+DlIbnltZc=; b=TXe35oeU2yhX83tiLt73Awq6sg
        T78r2YOqD+vWfgNUqQGBJf6yt6S+7+sihvP6osCc3IAs5bD0bjU0tjBMfMC/Lqs0
        KRAuNP0ewHxxosHNxo59HI/xoVQZ807bP7toG3EryilmnLAdOKcfQ0dnopuz7rqd
        LSZgQLH0MNEQWUT5iYQA4SqG6Y3ms0ijaKh2OdUCwJOUzst9hhoD09Tf8KRwiHdS
        +ZoxNotK3FS5nl4oYv5e85gjGo8eMcgVvXbpDibjZguntZ3+wu5+iBrmW3f58zD0
        i26EKF/JZ9PVAhfsrXuIdycIhV/4luIhieCJBkOZ9rm4Ab8q4aS8p0rJ8prw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661508185; x=1661594585; bh=C/04hfQf58qqXEDynVULUcRZ7WQW
        jIiHU+DlIbnltZc=; b=3Aw6qP2ZZGbsXW0RY2/dL/0Uen8enYpGfv8u2ZkI05i4
        zA9mwrqneayshNeSrAln8p/7OlV+r4cn1Push4acynNfw311JlJt5H8LfhGMAiGc
        zPu6cjHXpE/D4HwD2u/m1ohxbxPTRvcM5c/pvIARX2dAYIowbYpciCNIhJdCZNMg
        +iNxAJWcZBEZhkYwvHNg9PmIusaHfHsMSY7q8KUifJMX+EEj31NBOe5WdfUZCXsl
        6HT5f7nSKtIZ5dSz5wRekbKLx+aYVluCC7ZYTc36Vxr3Szm5N1Bu2URag3nANo5c
        Y2YHNdPq/5Onj1XS67FExA207IgEn+kggjVMT3aIsw==
X-ME-Sender: <xms:WJoIY1-pG6bLJsnvxxlvB0xZlKZRscTh-6kmBtcd4rAjojGVdjPGZw>
    <xme:WJoIY5uTfGGxgk9ifEbACUupMx8umtGc_2r1hCrOW_RM-EF-LDssRzsOjKGRri0bp
    t_qYH6JJB78WNF4LV4>
X-ME-Received: <xmr:WJoIYzBz7OKBwWVfntq3Ei9-CNplLRba-chvKA3WAA10MUCF4fpo9ceVgdyp2OgxpE4_Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:WZoIY5eXTSNX7Myc4_bBc1FqclJ4iwg0HWlTeInk2SUv7sNeSOTqKw>
    <xmx:WZoIY6P5sqvzI7V2VahJobuASsLN54VdhRU0Dad0c2mBp4mospCSsQ>
    <xmx:WZoIY7lYp-QlOzktrQCBSe91Ls920ha941FYHfl4Tib-cYvYYJlb9Q>
    <xmx:WZoIY3p7WxdXawBSvqcMThEL5TUAprz9Y1c8BzLlT-eubfblJqNzqA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Aug 2022 06:02:58 -0400 (EDT)
Date:   Fri, 26 Aug 2022 22:02:43 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v4 1/2] asus-wmi: Implement TUF laptop keyboard LED modes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        pobrn@protonmail.com, pavel@ucw.cz
Message-Id: <JWV7HR.9II7K7ZK8G9M1@ljones.dev>
In-Reply-To: <4b196309-fb73-bc77-0096-81915ac9a97d@redhat.com>
References: <20220825232251.345893-1-luke@ljones.dev>
        <20220825232251.345893-2-luke@ljones.dev>
        <0a45a991-4123-a76c-174f-435523f6d348@redhat.com>
        <XMV7HR.FTECLY4PXEQX@ljones.dev>
        <4b196309-fb73-bc77-0096-81915ac9a97d@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Aug 26 2022 at 11:59:55 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 8/26/22 11:56, Luke Jones wrote:
>> 
>> 
>>  On Fri, Aug 26 2022 at 11:47:37 +0200, Hans de Goede 
>> <hdegoede@redhat.com> wrote:
>>>  Hi Luke,
>>> 
>>>  On 8/26/22 01:22, Luke D. Jones wrote:
>>>>   Adds support for changing the laptop keyboard LED mode and 
>>>> colour.
>>>> 
>>>>   The modes are visible effects such as static, rainbow, pulsing,
>>>>   colour cycles.
>>>> 
>>>>   These sysfs attributes are added to asus::kbd_backlight:
>>>>   - kbd_rgb_mode
>>>>   - kbd_rgb_mode_index
>>>> 
>>>>   Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>   ---
>>>>    drivers/platform/x86/asus-wmi.c            | 76 
>>>> +++++++++++++++++++++-
>>>>    include/linux/platform_data/x86/asus-wmi.h |  3 +
>>>>    2 files changed, 78 insertions(+), 1 deletion(-)
>>>> 
>>>>   diff --git a/drivers/platform/x86/asus-wmi.c 
>>>> b/drivers/platform/x86/asus-wmi.c
>>>>   index 0f9f79f249c7..92f16bb9b4ef 100644
>>>>   --- a/drivers/platform/x86/asus-wmi.c
>>>>   +++ b/drivers/platform/x86/asus-wmi.c
>>>>   @@ -237,6 +237,8 @@ struct asus_wmi {
>>>>        bool dgpu_disable_available;
>>>>        bool gpu_mux_mode_available;
>>>> 
>>>>   +    bool kbd_rgb_mode_available;
>>>>   +
>>>>        bool throttle_thermal_policy_available;
>>>>        u8 throttle_thermal_policy_mode;
>>>> 
>>>>   @@ -720,6 +722,69 @@ static ssize_t gpu_mux_mode_store(struct 
>>>> device *dev,
>>>>    }
>>>>    static DEVICE_ATTR_RW(gpu_mux_mode);
>>>> 
>>>>   +/* TUF Laptop Keyboard RGB Modes 
>>>> **********************************************/
>>>>   +static ssize_t kbd_rgb_mode_store(struct device *dev,
>>>>   +                 struct device_attribute *attr,
>>>>   +                 const char *buf, size_t count)
>>>>   +{
>>>>   +    u32 cmd, mode, r, g,  b,  speed;
>>>>   +    int err;
>>>>   +
>>>>   +    if (sscanf(buf, "%d %d %d %d %d %d", &cmd, &mode, &r, &g, 
>>>> &b, &speed) != 6)
>>>>   +        return -EINVAL;
>>>>   +
>>>>   +    cmd = !!cmd;
>>>>   +
>>>>   +    /* These are the known usable modes across all TUF/ROG */
>>>>   +    if (mode >= 12 || mode == 9)
>>>>   +        mode = 10;
>>>>   +
>>>>   +    switch (speed) {
>>>>   +    case 0:
>>>>   +        speed = 0xe1;
>>>>   +        break;
>>>>   +    case 1:
>>>>   +        speed = 0xeb;
>>>>   +        break;
>>>>   +    case 2:
>>>>   +        speed = 0xf5;
>>>>   +        break;
>>>>   +    default:
>>>>   +        speed = 0xeb;
>>>>   +    }
>>>>   +
>>>>   +    err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, 
>>>> ASUS_WMI_DEVID_TUF_RGB_MODE,
>>>>   +            cmd | (mode << 8) | (r << 16) | (g << 24), b | 
>>>> (speed << 8), NULL);
>>>>   +    if (err)
>>>>   +        return err;
>>>>   +
>>>>   +    return count;
>>>>   +}
>>>>   +static DEVICE_ATTR_WO(kbd_rgb_mode);
>>>>   +
>>>>   +static ssize_t kbd_rgb_mode_index_show(struct device *device,
>>>>   +                         struct device_attribute *attr,
>>>>   +                         char *buf)
>>>>   +{
>>>>   +    return sysfs_emit(buf, "%s\n", "cmd mode red green blue 
>>>> speed");
>>>>   +}
>>>>   +static DEVICE_ATTR_RO(kbd_rgb_mode_index);
>>>>   +
>>>>   +static struct attribute *kbd_rgb_mode_attrs[] = {
>>>>   +    &dev_attr_kbd_rgb_mode.attr,
>>>>   +    &dev_attr_kbd_rgb_mode_index.attr,
>>>>   +    NULL,
>>>>   +};
>>>>   +
>>>>   +static const struct attribute_group kbd_rgb_mode_group = {
>>>>   +    .attrs = kbd_rgb_mode_attrs,
>>>>   +};
>>>>   +
>>>>   +const struct attribute_group *kbd_rgb_mode_groups[] = {
>>>>   +    NULL,
>>>>   +    NULL,
>>>>   +};
>>>>   +
>>>>    /* Battery 
>>>> ********************************************************************/
>>>> 
>>>>    /* The battery maximum charging percentage */
>>>>   @@ -1038,7 +1103,10 @@ static void asus_wmi_led_exit(struct 
>>>> asus_wmi *asus)
>>>> 
>>>>    static int asus_wmi_led_init(struct asus_wmi *asus)
>>>>    {
>>>>   -    int rv = 0, led_val;
>>>>   +    int rv = 0, num_rgb_groups = 0, led_val;
>>>>   +
>>>>   +    if (asus->kbd_rgb_mode_available)
>>>>   +        kbd_rgb_mode_groups[num_rgb_groups++] = 
>>>> &kbd_rgb_mode_group;
>>>> 
>>>>        asus->led_workqueue = 
>>>> create_singlethread_workqueue("led_workqueue");
>>>>        if (!asus->led_workqueue)
>>>>   @@ -1066,6 +1134,9 @@ static int asus_wmi_led_init(struct 
>>>> asus_wmi *asus)
>>>>            asus->kbd_led.brightness_get = kbd_led_get;
>>>>            asus->kbd_led.max_brightness = 3;
>>>> 
>>>>   +        if (num_rgb_groups != 0)
>>>>   +            asus->kbd_led.groups = kbd_rgb_mode_groups;
>>>>   +
>>>>            rv = led_classdev_register(&asus->platform_device->dev,
>>>>                           &asus->kbd_led);
>>>>            if (rv)
>>>>   @@ -3253,6 +3324,8 @@ static umode_t 
>>>> asus_sysfs_is_visible(struct kobject *kobj,
>>>>            ok = asus->egpu_enable_available;
>>>>        else if (attr == &dev_attr_dgpu_disable.attr)
>>>>            ok = asus->dgpu_disable_available;
>>>>   +    else if (attr == &dev_attr_dgpu_disable.attr)
>>>>   +        ok = asus->dgpu_disable_available;
>>>>        else if (attr == &dev_attr_gpu_mux_mode.attr)
>>>>            ok = asus->gpu_mux_mode_available;
>>>>        else if (attr == &dev_attr_fan_boost_mode.attr)
>>> 
>>>  This patch-hunk looks like it is a (mangled) leftover from 
>>> previous versions
>>>  of the patch.
>> 
>>  Do you mean:
>> 
>>  +    else if (attr == &dev_attr_dgpu_disable.attr)
>>  +        ok = asus->dgpu_disable_available;
> 
> Yes, patch hunks or chunks are the parts of a patch between
> a "@@ ... @@" line and the next "@@ ... @@" line.

Thanks. Oh gosh i see now... dgpu_disable. I'm unsure how I missed 
that. My apologies..

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
>>>>   @@ -3519,6 +3592,7 @@ static int asus_wmi_add(struct 
>>>> platform_device *pdev)
>>>>        asus->egpu_enable_available = asus_wmi_dev_is_present(asus, 
>>>> ASUS_WMI_DEVID_EGPU);
>>>>        asus->dgpu_disable_available = 
>>>> asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
>>>>        asus->gpu_mux_mode_available = 
>>>> asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
>>>>   +    asus->kbd_rgb_mode_available = 
>>>> asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
>>>>        asus->panel_overdrive_available = 
>>>> asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
>>>> 
>>>>        err = fan_boost_mode_check_present(asus);
>>>>   diff --git a/include/linux/platform_data/x86/asus-wmi.h 
>>>> b/include/linux/platform_data/x86/asus-wmi.h
>>>>   index 6e8a95c10d17..3d861477cb20 100644
>>>>   --- a/include/linux/platform_data/x86/asus-wmi.h
>>>>   +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>>   @@ -103,6 +103,9 @@
>>>>    /* gpu mux switch, 0 = dGPU, 1 = Optimus */
>>>>    #define ASUS_WMI_DEVID_GPU_MUX        0x00090016
>>>> 
>>>>   +/* TUF laptop RGB modes/colours */
>>>>   +#define ASUS_WMI_DEVID_TUF_RGB_MODE    0x00100056
>>>>   +
>>>>    /* DSTS masks */
>>>>    #define ASUS_WMI_DSTS_STATUS_BIT    0x00000001
>>>>    #define ASUS_WMI_DSTS_UNKNOWN_BIT    0x00000002
>>> 
>> 
>> 
> 


