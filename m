Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CDC47178B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 02:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhLLBZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 20:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbhLLBZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 20:25:35 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82909C061714;
        Sat, 11 Dec 2021 17:25:34 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o29so9580686wms.2;
        Sat, 11 Dec 2021 17:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aeWgIsg9nRx5DjC5z2Qu5CS/pGASfsc5ob34Cm+Pa1M=;
        b=hB2TqXacA/XsZxvxS6/qIMxG2a7bQZiHfVxQUvfGhsb2VOK8GD1mgMxxNTWOw5YN8q
         oH6YUjg4/Rin5qWq8Z8mwupJojZ7Qp8qhYlxfDZTrBly06tUJQQgDXhmx9esQw3xFCik
         KJvvhJtUeTDGv62wp8u065XcQ2/eB1IbsdDQ/5AImQfReFvvLY1+NMzdSiWztbr0Z0xx
         HGWjjRBnFxlbmUU34DsZNRUg70NEuUXe0U6Y6t317WhVMiI8HFUAEjOe2hcDRS65PpCT
         XxLzTTDxStoKtUhJu1klHhmy9l16u0z+h64sD3nT9chLclNrBuUo2h2K/uW5lYvri9S4
         oriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aeWgIsg9nRx5DjC5z2Qu5CS/pGASfsc5ob34Cm+Pa1M=;
        b=FeYQq+W6QBkdVhIIDZmGv6oqJ3XhkEfK83W1M4tbmb6iGOVaqPMD2Lt2he0QmQaKQy
         0zxmJFWXIydnGf9avTjPEEZeB12yOhQbpn2De4RCvi+J9mQmapLarrN3P2Pdh9Hyg8vi
         fWuKoYQ+o6z9VyUhAxH2AUs021zvmxrfd5Bxhae+sBif+77YCT3VxpLGMNPEMYsRybs0
         ZtFDlkX9XGO9e3Ds5cI4e216q2Odm+aDGrOsdItZuEXynAB5BBivB74jOzZHecbMeKtB
         XrD33V1YX2R+2z3qQLTzTqREsgVaHEC/VTYYXRNF83BqfqIl0hvyOylokExBVxS36KoC
         drJw==
X-Gm-Message-State: AOAM5302iEE3s+fonByb3yfF86ALnhFp/3VfA9XDP3mI247/Tk1XesaW
        T4RWO8bP5rJQm21/kM/aBmE=
X-Google-Smtp-Source: ABdhPJxzzrEKp1UNQInYRNmbtVeKoLKQeM606xQFQdns+T9Jcqh0clV9X2Pg1JhhmCNb7fjkZAtiog==
X-Received: by 2002:a05:600c:a01:: with SMTP id z1mr5315067wmp.52.1639272332782;
        Sat, 11 Dec 2021 17:25:32 -0800 (PST)
Received: from ?IPv6:2003:c7:8f4e:668:2247:20d3:1195:d634? (p200300c78f4e0668224720d31195d634.dip0.t-ipconnect.de. [2003:c7:8f4e:668:2247:20d3:1195:d634])
        by smtp.gmail.com with ESMTPSA id n13sm6290489wrt.44.2021.12.11.17.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 17:25:32 -0800 (PST)
Subject: Re: [PATCH v3 2/5] Docs: usb: update comment and code near decrement
 our usage count for the device
To:     Oliver Neukum <oneukum@suse.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org
References: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
 <ca8fd26ccff6521c7477a2035e703e099da56214.1638771720.git.philipp.g.hortmann@gmail.com>
 <bc30a2f4-a913-1f5e-c1fa-e10f8f357128@suse.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
Message-ID: <54d4056a-7456-523f-7b63-bebdf0cc549b@gmail.com>
Date:   Sun, 12 Dec 2021 02:25:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <bc30a2f4-a913-1f5e-c1fa-e10f8f357128@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 10:30 AM, Oliver Neukum wrote:
> On 06.12.21 21:57, Philipp Hortmann wrote:
> 
>> Update comment: decrement our usage count ..
>> and code according to usb-skeleton.c
> 
> Hi,
> 
> and that is exactly the problem, I am afraid.
> Your patch would be correct if the underlying code were correct.
> 
>>   
>> -    /* decrement our usage count for the device */
>> -    --skel->open_count;
>> +    /* decrement the count on our device */
>> +    kref_put(&dev->kref, skel_delete);
>>   
>>   
>>   One of the more difficult problems that USB drivers must be able to
> 
> I am sorry but the code in usb-skel.c is wrong. You grab a reference
> in skel_open():
> 
>          /* increment our usage count for the device */
>          kref_get(&dev->kref);
> 
> which is good, but in skel_release() we do:
> 
>          /* decrement the count on our device */
>          kref_put(&dev->kref, skel_delete);
> 
> unconditionally.
> 
> Think this through:
> 
> - Device is plugged in -> device node and internal data is created
> - open() called -> kref_get(), we get a reference
> - close() -> kref_put() -> refcount goes to zero -> skel_delete() is called, struct usb_skel is freed:
> 
> static void skel_delete(struct kref *kref)
> {
>          struct usb_skel *dev = to_skel_dev(kref);
> 
>          usb_free_urb(dev->bulk_in_urb);
>          usb_put_intf(dev->interface);
>          usb_put_dev(dev->udev);
>          kfree(dev->bulk_in_buffer);
>          kfree(dev);
> }
> 
> with intfdata left intact.
> 
> - open() is called again -> We are following a dangling pointer into cloud cuckoo land.
> 
> Unfortunately this code is older than git, so I cannot just send a revert.
> What to do?
> 
> 	Regards
> 		Oliver
> 
I cannot see the issue you described.

Think this through:
- probe() is called and kref_init() sets refcount to 1
- open() is called and refcount is increased to 2
- close() is called and refcount is decreased to 1 -> delete() is not called
- disconnect() is called and refcount is decreased to 0 -> delete() is 
called

Putting debug messages into the code and follow the log:
[12820.221534] skeleton 2-1.6:1.0: skel_probe called
[12820.221658] skeleton 2-1.6:1.0: USB Skeleton device now attached to 
USBSkel-1
[12820.221690] usbcore: registered new interface driver skeleton
[12824.046075] skeleton 2-1.6:1.0: skel_open called
[12825.047213] skeleton 2-1.6:1.0: skel_release called
[12826.047854] skeleton 2-1.6:1.0: skel_open called
[12827.049017] skeleton 2-1.6:1.0: skel_release called
[12831.035262] usb 2-1.6: USB disconnect, device number 4
[12831.035500] skeleton 2-1.6:1.0: skel_disconnect call
[12831.035504] skeleton 2-1.6:1.0: skel_delete called
[12831.035507] skeleton 2-1.6:1.0: USB Skeleton #1 now disconnected

delete() is only called on disconnect and not earlier.

This seems to be fine to me. Please find position of debug messages below.

Thanks for your reply.

Regards,

Philipp



  /* Define these values to match your devices */
-#define USB_SKEL_VENDOR_ID     0xfff0
-#define USB_SKEL_PRODUCT_ID    0xfff0
+#define USB_SKEL_VENDOR_ID     0x1a86
+#define USB_SKEL_PRODUCT_ID    0x7523

-/* table of devices that work with this driver */
  static const struct usb_device_id skel_table[] = {
         { USB_DEVICE(USB_SKEL_VENDOR_ID, USB_SKEL_PRODUCT_ID) },
         { }                                     /* Terminating entry */
@@ -73,6 +72,7 @@ static void skel_delete(struct kref *kref)
  {
         struct usb_skel *dev = to_skel_dev(kref);

+       dev_info(&dev->interface->dev, "skel_delete called\n");
         usb_free_urb(dev->bulk_in_urb);
         usb_put_intf(dev->interface);
         usb_put_dev(dev->udev);
@@ -110,6 +110,7 @@ static int skel_open(struct inode *inode, struct 
file *file)
         /* increment our usage count for the device */
         kref_get(&dev->kref);

+       dev_info(&interface->dev, "skel_open called\n");
         /* save our object in the file's private structure */
         file->private_data = dev;

@@ -125,6 +126,7 @@ static int skel_release(struct inode *inode, struct 
file *file)
         if (dev == NULL)
                 return -ENODEV;

+       dev_info(&dev->interface->dev, "skel_release called\n");
         /* allow the device to be autosuspended */
         usb_autopm_put_interface(dev->interface);

@@ -507,6 +509,7 @@ static int skel_probe(struct usb_interface *interface,
         dev->udev = usb_get_dev(interface_to_usbdev(interface));
         dev->interface = usb_get_intf(interface);

+       dev_info(&dev->interface->dev, "skel_probe called\n");
         /* set up the endpoint information */
         /* use only the first bulk-in and bulk-out endpoints */
         retval = usb_find_common_endpoints(interface->cur_altsetting,
@@ -577,6 +580,7 @@ static void skel_disconnect(struct usb_interface 
*interface)
         usb_kill_urb(dev->bulk_in_urb);
         usb_kill_anchored_urbs(&dev->submitted);

+       dev_info(&dev->interface->dev, "skel_disconnect call\n");
         /* decrement our usage count */
         kref_put(&dev->kref, skel_delete);

