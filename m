Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC455A1A91
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbiHYUui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiHYUuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:50:32 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228672873A;
        Thu, 25 Aug 2022 13:50:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4260F32009FD;
        Thu, 25 Aug 2022 16:50:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 Aug 2022 16:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1661460625; x=1661547025; bh=nlPqMiNGXy
        9EhJuCSwSE6ojkiH8zJIe4Qglc+WZS6TA=; b=Ndbpk0r3FWtX5JI4wiCtdSEh46
        +ESxB2XLrR+56kXasnDi/KJBqZEcAvm7XERXWAN7xrVKi8WZciClRvQlIZC9QCNU
        w0JhBvgDvFsW+qoE5ym4zmo2C8EJTlCnMmfiaJccgOYqBavTlNxUOT8WCREbsSSG
        KEpZaU1NfXZpSROPDEpD/ooYD5SnrDGSl6PzaeHvfmQzc9h56sbVFusDECOBG5oX
        +3OEMYunOJHHKrvrHKtKAiWofYapmdFPHWsQDhR170nbyhhbOBlCVdPQC7QSZqJa
        7M+5ptKAXqtqGtGDGAPobSiSabKJbEedj96SnO3SMBF8TNDWBPMHhakzqpYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661460625; x=1661547025; bh=nlPqMiNGXy9EhJuCSwSE6ojkiH8z
        JIe4Qglc+WZS6TA=; b=FBp7PmXD+gmYPQl1sPE+5xBjQMUuoLmizLQ4ityH/COO
        VnwoVUK5CIyzFxWxBRH4PUZdrWTKuus6BXm7Knb8OdCfbIzPuxJIuy+zTelC7DNZ
        aenJhx0Qp3B9oQ9CKD8IUQphtq4j8QwtphV1OUuMvqinfeGc06pO6pqmMH2uzA1r
        YJtvA46/C00hHaOAw1lowDcG06bhsvJMfi183pIyxfoWB6uduarI0TX7k9BiqSEC
        jvFSBMQ4AIEAXk7ZvtHIQgauE0lgCvoWfQwiOyf2C5bE+cSGaOGNhry+8RrQ9FQF
        1YSm96Hkvlm1WDOCsYlVBKH5xWrrjzCWyU7Ie9vXlw==
X-ME-Sender: <xms:keAHYwmHbl6c7W0gCptY42lDMdyJ_ZWWbn_Xq9k_2PSkIMMDgzvAJw>
    <xme:keAHY_2woxSL5nU7G2g-om1OZYsG0UnaScAmQ6DZ22J0lsoxeU8qY0ZNDNscUrcUq
    mC2uby4ALii9Gucqc8>
X-ME-Received: <xmr:keAHY-oBUmFhlv-SFy1x7GBTo3MQPTcBNxOoX1UbMfVmwqCgeqc4j8KLZnlzgdT4xP0IzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejfedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpedvvdegledtheefieejgfevgeefiefhtdevteefteduhfevtdefleethfetgeeluden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:keAHY8l4PhITt9gYCIUy6tEg9T2nvUWr6BbReCKhPIc9nQML9S3OdA>
    <xmx:keAHY-3HrciRs1y34oeqWgUdgFODXykCtT5BQ7HT8dfy0Im0-xzMBw>
    <xmx:keAHYzuq_-h0tl0W-becxAyVmS-7580X6PKQU1198yu1Ewz0XFbeMA>
    <xmx:keAHYz90do7Q6PZCXxxuLZF8PZR0IGizD5UZIIvruNNjq7_YZZ3jTA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Aug 2022 16:50:21 -0400 (EDT)
Date:   Fri, 26 Aug 2022 08:50:04 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 1/2] asus-wmi: Adjust tablet/lidflip handling to use enum
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <G7V6HR.3WZF23WP4MCJ3@ljones.dev>
In-Reply-To: <b2ce575a-470c-5a56-2cd0-9f3e7dbac1ad@redhat.com>
References: <20220813092753.6635-1-luke@ljones.dev>
        <b2ce575a-470c-5a56-2cd0-9f3e7dbac1ad@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Aug 24 2022 at 16:12:42 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 8/13/22 11:27, Luke D. Jones wrote:
>>  Due to multiple types of tablet/lidflip, the existing code for
>>  handling these events is refactored to use an enum for each type.
>> 
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
> 
> Thank you for the patch, I've merged this but with one change:
> 
>>  ---
>>   drivers/platform/x86/asus-nb-wmi.c | 13 +++---
>>   drivers/platform/x86/asus-wmi.c    | 67 
>> ++++++++++++++++++++----------
>>   drivers/platform/x86/asus-wmi.h    |  9 +++-
>>   3 files changed, 58 insertions(+), 31 deletions(-)
>> 
>>  diff --git a/drivers/platform/x86/asus-nb-wmi.c 
>> b/drivers/platform/x86/asus-nb-wmi.c
>>  index a81dc4b191b7..3a93e056c4e1 100644
>>  --- a/drivers/platform/x86/asus-nb-wmi.c
>>  +++ b/drivers/platform/x86/asus-nb-wmi.c
>>  @@ -115,12 +115,12 @@ static struct quirk_entry quirk_asus_forceals 
>> = {
>>   };
>> 
>>   static struct quirk_entry quirk_asus_use_kbd_dock_devid = {
>>  -	.use_kbd_dock_devid = true,
>>  +	.tablet_switch_mode = asus_wmi_kbd_dock_devid,
>>   };
>> 
>>   static struct quirk_entry quirk_asus_use_lid_flip_devid = {
>>   	.wmi_backlight_set_devstate = true,
>>  -	.use_lid_flip_devid = true,
>>  +	.tablet_switch_mode = asus_wmi_lid_flip_devid,
>>   };
>> 
>>   static int dmi_matched(const struct dmi_system_id *dmi)
>>  @@ -492,16 +492,13 @@ static void asus_nb_wmi_quirks(struct 
>> asus_wmi_driver *driver)
>> 
>>   	switch (tablet_mode_sw) {
>>   	case 0:
>>  -		quirks->use_kbd_dock_devid = false;
>>  -		quirks->use_lid_flip_devid = false;
>>  +		quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
>>   		break;
>>   	case 1:
>>  -		quirks->use_kbd_dock_devid = true;
>>  -		quirks->use_lid_flip_devid = false;
>>  +		quirks->tablet_switch_mode = asus_wmi_kbd_dock_devid;
>>   		break;
>>   	case 2:
>>  -		quirks->use_kbd_dock_devid = false;
>>  -		quirks->use_lid_flip_devid = true;
>>  +		quirks->tablet_switch_mode = asus_wmi_lid_flip_devid;
>>   		break;
>>   	}
>> 
>>  diff --git a/drivers/platform/x86/asus-wmi.c 
>> b/drivers/platform/x86/asus-wmi.c
>>  index 0421ffb81927..b4690ac39147 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  @@ -485,8 +485,11 @@ static bool asus_wmi_dev_is_present(struct 
>> asus_wmi *asus, u32 dev_id)
>> 
>>   static int asus_wmi_input_init(struct asus_wmi *asus)
>>   {
>>  +	struct device *dev;
>>   	int err, result;
>> 
>>  +	dev = &asus->platform_device->dev;
>>  +
>>   	asus->inputdev = input_allocate_device();
>>   	if (!asus->inputdev)
>>   		return -ENOMEM;
>>  @@ -494,35 +497,38 @@ static int asus_wmi_input_init(struct 
>> asus_wmi *asus)
>>   	asus->inputdev->name = asus->driver->input_name;
>>   	asus->inputdev->phys = asus->driver->input_phys;
>>   	asus->inputdev->id.bustype = BUS_HOST;
>>  -	asus->inputdev->dev.parent = &asus->platform_device->dev;
>>  +	asus->inputdev->dev.parent = dev;
>>   	set_bit(EV_REP, asus->inputdev->evbit);
>> 
>>   	err = sparse_keymap_setup(asus->inputdev, asus->driver->keymap, 
>> NULL);
>>   	if (err)
>>   		goto err_free_dev;
>> 
>>  -	if (asus->driver->quirks->use_kbd_dock_devid) {
>>  +	switch (asus->driver->quirks->tablet_switch_mode) {
>>  +	case asus_wmi_no_tablet_switch:
>>  +		break;
>>  +	case asus_wmi_kbd_dock_devid:
>>   		result = asus_wmi_get_devstate_simple(asus, 
>> ASUS_WMI_DEVID_KBD_DOCK);
>>   		if (result >= 0) {
>>   			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
>>   			input_report_switch(asus->inputdev, SW_TABLET_MODE, !result);
>>   		} else if (result != -ENODEV) {
>>  -			pr_err("Error checking for keyboard-dock: %d\n", result);
>>  +			dev_err(dev, "Error checking for keyboard-dock: %d\n", result);
>>   		}
>>  -	}
>>  -
>>  -	if (asus->driver->quirks->use_lid_flip_devid) {
>>  +		break;
>>  +	case asus_wmi_lid_flip_devid:
>>   		result = asus_wmi_get_devstate_simple(asus, 
>> ASUS_WMI_DEVID_LID_FLIP);
>>   		if (result < 0)
>>  -			asus->driver->quirks->use_lid_flip_devid = 0;
>>  +			asus->driver->quirks->tablet_switch_mode = 
>> asus_wmi_no_tablet_switch;
>>   		if (result >= 0) {
>>   			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
>>   			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
>>   		} else if (result == -ENODEV) {
>>  -			pr_err("This device has lid_flip quirk but got ENODEV checking 
>> it. This is a bug.");
>>  +			dev_err(dev, "This device has lid_flip quirk but got ENODEV 
>> checking it. This is a bug.");
>>   		} else {
>>  -			pr_err("Error checking for lid-flip: %d\n", result);
>>  +			dev_err(dev, "Error checking for lid-flip: %d\n", result);
>>   		}
>>  +		break;
>>   	}
>> 
>>   	err = input_register_device(asus->inputdev);
>>  @@ -548,8 +554,9 @@ static void asus_wmi_input_exit(struct asus_wmi 
>> *asus)
>> 
>>   static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
>>   {
>>  -	int result = asus_wmi_get_devstate_simple(asus, 
>> ASUS_WMI_DEVID_LID_FLIP);
>>  +	int result;
>> 
>>  +	result = asus_wmi_get_devstate_simple(asus, 
>> ASUS_WMI_DEVID_LID_FLIP);
>>   	if (result >= 0) {
>>   		input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
>>   		input_sync(asus->inputdev);
>>  @@ -3044,20 +3051,26 @@ static void asus_wmi_handle_event_code(int 
>> code, struct asus_wmi *asus)
>>   		return;
>>   	}
>> 
>>  -	if (asus->driver->quirks->use_kbd_dock_devid && code == 
>> NOTIFY_KBD_DOCK_CHANGE) {
> 
> Given that we need to check for both the tablet_switch_mode as well as
> different event codes, I believe that keep using something like:
> 
> 	if (asus->driver->quirks->tablet_switch_mode == 
> asus_wmi_kbd_dock_devid &&
> 	    code == NOTIFY_KBD_DOCK_CHANGE) {
> 
> here is better then doing a switch-case with the code checkes nested 
> under

I think I recall that Andy requested use of the switch/case but I might 
be wrong.
Thank you for your help and clean up of this. The patch is making quite 
a few people happy.

> 
>>  -		result = asus_wmi_get_devstate_simple(asus,
>>  -						      ASUS_WMI_DEVID_KBD_DOCK);
>>  +	switch (asus->driver->quirks->tablet_switch_mode) {
>>  +	case asus_wmi_no_tablet_switch:
>>  +		break;
>>  +	case asus_wmi_kbd_dock_devid:
>>  +		if (code == NOTIFY_KBD_DOCK_CHANGE) {
>>  +			result = asus_wmi_get_devstate_simple(asus, 
>> ASUS_WMI_DEVID_KBD_DOCK);
>>   		if (result >= 0) {
>>   			input_report_switch(asus->inputdev, SW_TABLET_MODE,
> 
> Note the indent of these 2 lines is wrong now, it should be indentend 
> one
> extra step because it is inside the if (code == 
> NOTIFY_KBD_DOCK_CHANGE) {
> block now, sticking with a:
> 
> 	if (asus->driver->quirks->tablet_switch_mode == 
> asus_wmi_kbd_dock_devid &&
> 	    code == NOTIFY_KBD_DOCK_CHANGE) {
> 
> is style instead of nesting avoids the need for this extra 
> indentation.
> 
> I have fixed this up while merging the patches.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
>>  -					    !result);
>>  +						!result);
>>   			input_sync(asus->inputdev);
>>   		}
>>   		return;
>>  -	}
>>  -
>>  -	if (asus->driver->quirks->use_lid_flip_devid && code == 
>> NOTIFY_LID_FLIP) {
>>  -		lid_flip_tablet_mode_get_state(asus);
>>  -		return;
>>  +		}
>>  +		break;
>>  +	case asus_wmi_lid_flip_devid:
>>  +		if (code == NOTIFY_LID_FLIP) {
>>  +			lid_flip_tablet_mode_get_state(asus);
>>  +			return;
>>  +		}
>>  +		break;
>>   	}
>> 
>>   	if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
>>  @@ -3700,8 +3713,14 @@ static int asus_hotk_resume(struct device 
>> *device)
>>   	if (asus_wmi_has_fnlock_key(asus))
>>   		asus_wmi_fnlock_update(asus);
>> 
>>  -	if (asus->driver->quirks->use_lid_flip_devid)
>>  +	switch (asus->driver->quirks->tablet_switch_mode) {
>>  +	case asus_wmi_no_tablet_switch:
>>  +	case asus_wmi_kbd_dock_devid:
>>  +		break;
>>  +	case asus_wmi_lid_flip_devid:
>>   		lid_flip_tablet_mode_get_state(asus);
>>  +		break;
>>  +	}
>> 
>>   	return 0;
>>   }
>>  @@ -3742,8 +3761,14 @@ static int asus_hotk_restore(struct device 
>> *device)
>>   	if (asus_wmi_has_fnlock_key(asus))
>>   		asus_wmi_fnlock_update(asus);
>> 
>>  -	if (asus->driver->quirks->use_lid_flip_devid)
>>  +	switch (asus->driver->quirks->tablet_switch_mode) {
>>  +	case asus_wmi_no_tablet_switch:
>>  +	case asus_wmi_kbd_dock_devid:
>>  +		break;
>>  +	case asus_wmi_lid_flip_devid:
>>   		lid_flip_tablet_mode_get_state(asus);
>>  +		break;
>>  +	}
>> 
>>   	return 0;
>>   }
>>  diff --git a/drivers/platform/x86/asus-wmi.h 
>> b/drivers/platform/x86/asus-wmi.h
>>  index b302415bf1d9..413920bad0c6 100644
>>  --- a/drivers/platform/x86/asus-wmi.h
>>  +++ b/drivers/platform/x86/asus-wmi.h
>>  @@ -25,6 +25,12 @@ struct module;
>>   struct key_entry;
>>   struct asus_wmi;
>> 
>>  +enum asus_wmi_tablet_switch_mode {
>>  +	asus_wmi_no_tablet_switch,
>>  +	asus_wmi_kbd_dock_devid,
>>  +	asus_wmi_lid_flip_devid,
>>  +};
>>  +
>>   struct quirk_entry {
>>   	bool hotplug_wireless;
>>   	bool scalar_panel_brightness;
>>  @@ -33,8 +39,7 @@ struct quirk_entry {
>>   	bool wmi_backlight_native;
>>   	bool wmi_backlight_set_devstate;
>>   	bool wmi_force_als_set;
>>  -	bool use_kbd_dock_devid;
>>  -	bool use_lid_flip_devid;
>>  +	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
>>   	int wapf;
>>   	/*
>>   	 * For machines with AMD graphic chips, it will send out WMI event
> 


