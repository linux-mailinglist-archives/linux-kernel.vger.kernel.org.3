Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3A159B6AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 01:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiHUXH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 19:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiHUXH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 19:07:28 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C003718E31;
        Sun, 21 Aug 2022 16:07:26 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3942B3200902;
        Sun, 21 Aug 2022 19:07:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 21 Aug 2022 19:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1661123242; x=1661209642; bh=czDpEEAMWh
        sY8eA8N88MVKQ3wyFIGynWGLd906dyt3Y=; b=pi2nckzTX3lXmAZq897Op8xOg9
        yoJ+lwhZEcRwCsYaCRBVfpVY+74S1MEAoK7l+nfEd9h3YrHljfgu8ieIk/5Qy4bZ
        gx//zG0EzqNlvA6d3ju9ThNRIVDaaaMVj8ugqBHbmMwFhSCystr/+vspPwwJpbdy
        Hgk/gfzLvY9MkBM2zfDom+K5LWG6y0cNgEYrHKeuilKWJcat30UykzDGUpgTwwwg
        vylok/AaZnXNIUjNm45HyMPyCc6hU3u0kU0yLYfuWEhO1wnShLVbzEMT5/CtSPzy
        sGGq14+w/uUtoqESb5BY8R53Jy5M3+M5gQTjbNBYAV0pmJ9oi90O/gwSqo5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661123242; x=1661209642; bh=czDpEEAMWhsY8eA8N88MVKQ3wyFI
        GynWGLd906dyt3Y=; b=rsAgZsKBm4XfAWRMar9HYypU4cGmGdzPTv15u8jX/UOh
        Qunl+/tFVCJYGM179zfE4oKNAQfrm8mvlRcQZBatZUmjLjYRl9dShMjQ3SKUMSbi
        r4pudOilJSepSqqeKWxaycFi7x5OZxS11Ep3hIYj7nQsDgCIcPq+Rqo0ET6VDfW8
        gUbXFnnEnhrBMJXwU6SNy8ZPdpNUmYEpf2OEIVqkqcwpQHV2AYihzs11QRBgNsnX
        sb0CUVb1uAk0pqBBJeTMZoACFqO5QbStwitjbwVCasgcsNoKSlf5Kx/MJGXSw39r
        oFeEKO/Lb4Rf/CsRuarYP6tqvU1sEZTEBN2FFpTXGQ==
X-ME-Sender: <xms:qroCYwU0bwdHdcR8qyb0ueHZ-j7ickrOsKe0OARk7O-m5lxIlOvr4g>
    <xme:qroCY0nAp6XsGIihCyFbGo5VYvLNTINqyUa_RjLV_CkArGsUmOBibEr-BGSGA0UqB
    KoOY-e9Ku92lHN004U>
X-ME-Received: <xmr:qroCY0bN2sedCI0pjLuXe0l13ol9q3YnCbzKT9aWkSkRBQjajiHg1CCBbUHeVrvdVNdE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeiiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    ephfeigedtveefjeeukeetfeektdeffeefteekfeffieeiteeigeehhfdutdeitdehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:qroCY_W2AeIVsLWI-SHPTQugw0OYk5FQaJ2e_j7h2UzU1vn6wtwJqA>
    <xmx:qroCY6nIOiGK0IS8gC_cBO0vcqlwnGaXoNWbM3Kzo_KKb2b-_HiWqg>
    <xmx:qroCY0fiAQFLKqCi-cLvp4-cBzRg1mIc4TxBr_j0D0bd-qWPLihq2w>
    <xmx:qroCY_zhbH_zMGWr1Bi-yG3eD7mCTfT7sDiOmZTopMurgAKYOHEnKw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Aug 2022 19:07:19 -0400 (EDT)
Date:   Mon, 22 Aug 2022 11:07:06 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] asus-wmi: Support the hardware GPU MUX on some laptops
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <UVMZGR.6LXKPONA9OS33@ljones.dev>
In-Reply-To: <e186622e-f3e6-5715-9f6d-bc41fb41560d@amd.com>
References: <20220813092624.6228-1-luke@ljones.dev>
        <e186622e-f3e6-5715-9f6d-bc41fb41560d@amd.com>
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

Hi Mario,

On Mon, Aug 15 2022 at 23:16:12 -0500, Mario Limonciello 
<mario.limonciello@amd.com> wrote:
> On 8/13/22 04:26, Luke D. Jones wrote:
>> Support the hardware GPU MUX switch available on some models. This
>> switch can toggle the MUX between:
>> 
>> - 0, Dedicated mode
>> - 1, Optimus mode
>> 
>> Optimus mode is the regular iGPU + dGPU available, while dedicated
>> mode switches the system to have only the dGPU available.
>> 
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> ---
>>   .../ABI/testing/sysfs-platform-asus-wmi       | 11 ++++
>>   drivers/platform/x86/asus-wmi.c               | 62 
>> +++++++++++++++++++
>>   include/linux/platform_data/x86/asus-wmi.h    |  3 +
>>   3 files changed, 76 insertions(+)
>> 
>> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi 
>> b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>> index 574b5170a37d..03124eab7f01 100644
>> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>> @@ -58,6 +58,17 @@ Description:
>>   			* 1 - overboost,
>>   			* 2 - silent
>>   +What:          /sys/devices/platform/<platform>/gpu_mux_mode
>> +Date:          Aug 2022
>> +KernelVersion: 6.1
>> +Contact:       "Luke Jones" <luke@ljones.dev>
>> +Description:
>> +               Switch the GPU hardware MUX mode. Laptops with this 
>> feature can
>> +			   can be toggled to boot with only the dGPU (discrete mode) or 
>> in
>> +			   standard Optimus/Hybrid mode. On switch a reboot is required:
>> +                       * 0 - Discrete GPU,
>> +                       * 1 - Optimus/Hybrid,
> 
> This feel like it should probably export using 
> /sys/class/firmware-attributes.  That's exactly how those types of 
> attributes work.
> 
> As a bonus, software like fwupd 1.8.4 knows how to manipulate it and 
> you don't need special documentation.
> 
>> +
>>   What:          /sys/devices/platform/<platform>/dgpu_disable
>>   Date:          Aug 2022
>>   KernelVersion: 5.17
>> diff --git a/drivers/platform/x86/asus-wmi.c 
>> b/drivers/platform/x86/asus-wmi.c
>> index e2b51b5550e8..0421ffb81927 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -230,6 +230,7 @@ struct asus_wmi {
>>     	bool egpu_enable_available;
>>   	bool dgpu_disable_available;
>> +	bool gpu_mux_mode_available;
>>     	bool throttle_thermal_policy_available;
>>   	u8 throttle_thermal_policy_mode;
>> @@ -668,6 +669,59 @@ static ssize_t egpu_enable_store(struct device 
>> *dev,
>>   }
>>   static DEVICE_ATTR_RW(egpu_enable);
>>   +/* gpu mux switch 
>> *************************************************************/
>> +static int gpu_mux_mode_check_present(struct asus_wmi *asus)
>> +{
>> +	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, 
>> ASUS_WMI_DEVID_GPU_MUX);
>> +
>> +   return 0;
>> +}
>> +
>> +static ssize_t gpu_mux_mode_show(struct device *dev,
>> +                  struct device_attribute *attr, char *buf)
>> +{
>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>> +   int result;
>> +
>> +   result = asus_wmi_get_devstate_simple(asus, 
>> ASUS_WMI_DEVID_GPU_MUX);
>> +   if (result < 0)
>> +       return result;
>> +
>> +   return sysfs_emit(buf, "%d\n", result);
>> +}
>> +
>> +static ssize_t gpu_mux_mode_store(struct device *dev,
>> +                   struct device_attribute *attr,
>> +                   const char *buf, size_t count)
>> +{
>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>> +   int result, err;
>> +   u32 optimus;
>> +
>> +   err = kstrtou32(buf, 10, &optimus);
>> +   if (err)
>> +       return err;
>> +
>> +   if (optimus > 1)
>> +       return -EINVAL;
>> +
>> +   err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, 
>> &result);
>> +   if (err) {
>> +       dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
>> +       return err;
>> +   }
>> +	/* !1 is considered a fail by ASUS */
>> +	if (result != 1) {
>> +		dev_warn(dev, "Failed to set GPU MUX mode (result): 0x%x\n", 
>> result);
>> +       return -EIO;
>> +   }
>> +
>> +   sysfs_notify(&asus->platform_device->dev.kobj, NULL, 
>> "gpu_mux_mode");
>> +
>> +   return count;
>> +}
>> +static DEVICE_ATTR_RW(gpu_mux_mode);
>> +
>>   /* Battery 
>> ********************************************************************/
>>     /* The battery maximum charging percentage */
>> @@ -3165,6 +3219,7 @@ static struct attribute *platform_attributes[] 
>> = {
>>   	&dev_attr_touchpad.attr,
>>   	&dev_attr_egpu_enable.attr,
>>   	&dev_attr_dgpu_disable.attr,
>> +	&dev_attr_gpu_mux_mode.attr,
>>   	&dev_attr_lid_resume.attr,
>>   	&dev_attr_als_enable.attr,
>>   	&dev_attr_fan_boost_mode.attr,
>> @@ -3195,6 +3250,8 @@ static umode_t asus_sysfs_is_visible(struct 
>> kobject *kobj,
>>   		ok = asus->egpu_enable_available;
>>   	else if (attr == &dev_attr_dgpu_disable.attr)
>>   		ok = asus->dgpu_disable_available;
>> +	else if (attr == &dev_attr_gpu_mux_mode.attr)
>> +		ok = asus->gpu_mux_mode_available;
>>   	else if (attr == &dev_attr_fan_boost_mode.attr)
>>   		ok = asus->fan_boost_mode_available;
>>   	else if (attr == &dev_attr_throttle_thermal_policy.attr)
>> @@ -3464,6 +3521,10 @@ static int asus_wmi_add(struct 
>> platform_device *pdev)
>>   	if (err)
>>   		goto fail_dgpu_disable;
>>   +	err = gpu_mux_mode_check_present(asus);
>> +   if (err)
>> +       goto fail_gpu_mux_mode;
>> +
>>   	err = fan_boost_mode_check_present(asus);
>>   	if (err)
>>   		goto fail_fan_boost_mode;
>> @@ -3578,6 +3639,7 @@ static int asus_wmi_add(struct platform_device 
>> *pdev)
>>   fail_fan_boost_mode:
>>   fail_egpu_enable:
>>   fail_dgpu_disable:
>> +fail_gpu_mux_mode:
>>   fail_platform:
>>   fail_panel_od:
>>   	kfree(asus);
>> diff --git a/include/linux/platform_data/x86/asus-wmi.h 
>> b/include/linux/platform_data/x86/asus-wmi.h
>> index a571b47ff362..c023332842a2 100644
>> --- a/include/linux/platform_data/x86/asus-wmi.h
>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>> @@ -98,6 +98,9 @@
>>   /* dgpu on/off */
>>   #define ASUS_WMI_DEVID_DGPU		0x00090020
>>   +/* gpu mux switch, 0 = dGPU, 1 = Optimus */
>> +#define ASUS_WMI_DEVID_GPU_MUX 0x00090016
>> +
>>   /* DSTS masks */
>>   #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
>>   #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
> 

You can see previous discussion here 
https://lore.kernel.org/platform-driver-x86/c3bb0989-78d9-c513-1669-75407b2acbac@redhat.com/

Below is Hans response verbatim:

 > Yes it sounds like a BIOS setting is being toggled from within
 > Linux, which would normally be done through the
 > "firmware-attributes" class, but all existing "firmware-attributes"
 > class drivers allow changing all BIOS setting not just a single
 > setting, so using the  "firmware-attributes" class here is not really
 > appropriate.

Kind regards,
Luke.


