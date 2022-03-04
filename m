Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08184CD96B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240824AbiCDQsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239119AbiCDQs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:48:27 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E6A614A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:47:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so7322209pju.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 08:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UWkk0uBu0jNx1jlmlEAHZrCFH0Ow2QY0VnclMogaKZA=;
        b=KwXz8HiKBcGhZmtQJUtz/f6kjUWc334PSXkjKi8gcJTaOQo0/sEQE3McfTBWtYFR5k
         Qpe2leEGKxHy/f4ieXWmHCQgkDADja6/P9RNcDVKjFujZHP7JJD4hKd+ZUJYMrE3OVWl
         9uoPUTZ9qdmMBmpKdlHEnOt3WNKQeT4p+j6M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UWkk0uBu0jNx1jlmlEAHZrCFH0Ow2QY0VnclMogaKZA=;
        b=H4+exRNVz+9pEaHHrscyLgqOxJeLPAK0w5/k0AahI5ICI+AQ45jmZz3ajgUkd2VCKF
         4lpJy+L8BlbArFGmKS8Awa1G50DTtRjUyUWSPRL+kBd/iDOAFewh+kDvtCMOnFpLS3PM
         ku12P+GIoGE6E+5fe8P//ywuTlNsM4RBwS2ETJ/kHQ8FUUWdAj3QDTTuGXCU/eGvMSvw
         WuSMQxB0HAvmTYa6zFjPDQECm6dkBcNoIFr+o+G0LH+8igF7+mbFdHmsNCq3VB93N1TO
         jT3aFXarJbDLak6w8aRzzTjKswsSsU9Km8+TWELW132PdmGe15A9ALmgjJ5pgJ3Pzvy5
         ko9g==
X-Gm-Message-State: AOAM5328XUMEc1qqEnROvima3qo+2N9Tr2/1j9wBxqY8YY2UxmAPQUat
        dYgaunz6zA6ggdGcxL3jp3igTg==
X-Google-Smtp-Source: ABdhPJygDLM6vn1CP8G+JFD6hR5yUQJTkAg+Zd8FsLvVEDVetnN/4JV4PNsbL8vscZhnR7uaJNWENg==
X-Received: by 2002:a17:90a:67c9:b0:1b9:51d5:6c13 with SMTP id g9-20020a17090a67c900b001b951d56c13mr11551613pjm.216.1646412457902;
        Fri, 04 Mar 2022 08:47:37 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f35b:8ac4:5a84:dca])
        by smtp.gmail.com with UTF8SMTPSA id u14-20020a17090adb4e00b001bee5dd39basm10050651pjx.1.2022.03.04.08.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 08:47:37 -0800 (PST)
Date:   Fri, 4 Mar 2022 08:47:34 -0800
From:   "mka@chromium.org" <mka@chromium.org>
To:     "Linyu Yuan (QUIC)" <quic_linyyuan@quicinc.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Tao Wang (Consultant) (QUIC)" <quic_wat@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "ravisadineni@chromium.org" <ravisadineni@chromium.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "swboyd@chromium.org" <swboyd@chromium.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI0=?= =?utf-8?Q?=3A?= Re: [PATCH v20
 3/5] usb: misc: Add onboard_usb_hub driver
Message-ID: <YiJCpt46S1ngV+y7@google.com>
References: <SA1PR02MB86067ACF0C96F18B7306D208903A9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <SA1PR02MB860660B6F33011E5A97F7930903A9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <YhURQAksLKVuzU36@google.com>
 <SA1PR02MB860602E0AC4D9BD0BC4245B5903C9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <YhXolQDwIMbTi/O2@kroah.com>
 <DM8PR02MB81988555CA6B66BB3FD5E488E3019@DM8PR02MB8198.namprd02.prod.outlook.com>
 <Yh0UZUU9/9Hd6Pc1@google.com>
 <DM8PR02MB8198F2BFE9E933CC8F2C148BE3029@DM8PR02MB8198.namprd02.prod.outlook.com>
 <Yh5K0u3jp4jTXCPi@google.com>
 <DM8PR02MB819876BA541F3C62D971EF09E3039@DM8PR02MB8198.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR02MB819876BA541F3C62D971EF09E3039@DM8PR02MB8198.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 05:14:30AM +0000, Linyu Yuan (QUIC) wrote:
> > From: mka@chromium.org <mka@chromium.org>
> > Sent: Wednesday, March 2, 2022 12:33 AM
> > To: Linyu Yuan (QUIC) <quic_linyyuan@quicinc.com>
> > Cc: gregkh@linuxfoundation.org; Tao Wang (Consultant) (QUIC)
> > <quic_wat@quicinc.com>; balbi@kernel.org; devicetree@vger.kernel.org;
> > dianders@chromium.org; frowand.list@gmail.com; hadess@hadess.net;
> > krzk@kernel.org; linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> > mathias.nyman@intel.com; michal.simek@xilinx.com;
> > peter.chen@kernel.org; ravisadineni@chromium.org; robh+dt@kernel.org;
> > rogerq@kernel.org; stern@rowland.harvard.edu; swboyd@chromium.org
> > Subject: Re: 回复: 回复: Re: [PATCH v20 3/5] usb: misc: Add
> > onboard_usb_hub driver
> > 
> > > In my opinion, if it need update VID/PID table in this driver to support a
> > new HUB,
> > > we can parse VID/PID from device tree and create dynamic VID/PID entry
> > to id_table of onboard_hub_usbdev_driver.
> > >
> > > Hope you can understand what I said.
> > 
> > Not really.
> > 
> > I doubt that what you are suggesting would work. The easiest thing
> > to convince people would probably be to send a patch (based on this
> > one) with a working implementation of your idea.
> 
> I show my idea, but not test,
> 
> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> index e280409..1811317 100644
> --- a/drivers/usb/misc/onboard_usb_hub.c
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -10,6 +10,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> +#include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> @@ -173,6 +174,58 @@ static void onboard_hub_remove_usbdev(struct onboard_hub *hub, const struct usb_
>  	mutex_unlock(&hub->lock);
>  }
>  
> +#define MAX_HUB_NUM		4
> +#define MAX_TABLE_SIZE		(MAX_HUB_NUM * 2)
> +static struct usb_device_id onboard_hub_id_table[MAX_TABLE_SIZE + 1];
> +MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
> +
> +static void onboard_hub_add_idtable(__u16 vid, __u16 pid)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_TABLE_SIZE; i++) {
> +		if (!onboard_hub_id_table[i].idVendor)
> +			break;
> +
> +		if (onboard_hub_id_table[i].idVendor == vid &&
> +		    onboard_hub_id_table[i].idProduct == pid)
> +			return;
> +	}
> +	if (i == MAX_TABLE_SIZE)
> +		return;
> +
> +	onboard_hub_id_table[i].idVendor = vid;
> +	onboard_hub_id_table[i].idProduct = pid;
> +	onboard_hub_id_table[i].match_flags = USB_DEVICE_ID_MATCH_DEVICE;
> +}
> +
> +static int onboard_hub_parse_idtable(struct device_node *np)
> +{
> +	int size = of_property_count_elems_of_size(np, "vidpid", sizeof(int));
> +	int ret, i;
> +	u16 *ids;
> +
> +	if (!size || size % 2)
> +		return -EINVAL;
> +
> +	ids = kzalloc(sizeof(u16) * size, GFP_KERNEL);
> +	if (!ids)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u16_array(np, "vidpid", ids, size);
> +	if (ret) {
> +		kfree(ids);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < size; i+=2)
> +		onboard_hub_add_idtable(ids[i], ids[i+1]);
> +
> +	kfree(ids);
> +
> +	return 0;
> +}
> +
>  static ssize_t always_powered_in_suspend_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> @@ -210,6 +263,10 @@ static int onboard_hub_probe(struct platform_device *pdev)
>  	struct onboard_hub *hub;
>  	int err;
>  
> +	err = onboard_hub_parse_idtable(dev->of_node);
> +	if (err)
> +		return err;
> +
>  	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
>  	if (!hub)
>  		return -ENOMEM;
> @@ -378,15 +435,6 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
>  	onboard_hub_remove_usbdev(hub, udev);
>  }
>  
> -static const struct usb_device_id onboard_hub_id_table[] = {
> -	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
> -	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
> -	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0414) }, /* RTS5414 USB 3.2 */
> -	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 */
> -	{}
> -};
> -MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
> -
>  static struct usb_device_driver onboard_hub_usbdev_driver = {
>  	.name = "onboard-usb-hub",
>  	.probe = onboard_hub_usbdev_probe,

I see multiple issues with this approach:

1. The new device tree property 'vidpid'. It is (or should be) redundant
   with the compatible string, I very much doubt you could convince DT
   maintainers to add it.
2. You don't want to modify the driver to enabled support for new USB hubs.
   That means you would have to use a compatible string that is already in
   the driver, but which doesn't match the VID:PID of the hub. While this
   might work it's a hack.
3. If the USB hub is probed before the platform device it won't use this
   driver because the VID:PID isn't in the device id table.
4. Possible race conditions when changing the device id table on the fly

