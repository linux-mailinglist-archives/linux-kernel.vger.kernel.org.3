Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A030F598962
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345133AbiHRQya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245254AbiHRQyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:54:24 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB11FB3B3B;
        Thu, 18 Aug 2022 09:54:22 -0700 (PDT)
Received: from [IPV6:2a01:cb08:8f65:d300:4b96:ac4c:4229:8341] (unknown [IPv6:2a01:cb08:8f65:d300:4b96:ac4c:4229:8341])
        (Authenticated sender: thierry.guibert@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 26CFF20058B;
        Thu, 18 Aug 2022 18:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1660841660;
        bh=fNODoRwgMqBmiUR1DtqC90sxQo+eXH53t3BH10G1AUc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OLtzt4Fk62Nw6vgrczyAQ4ugiZWjaWhDyFgUgI9pFYROtn+MbKuIeyr6mFOVUPB29
         qPyfU6CUgFbMdhCUfDZopG0gvqMt835jisfYcQ/tThOk+ufNmz95LW8lQUxpQegf0f
         AW9M5hvdnRQRLVbhbcV9h9yY4jz4HEn+96A0Hqv8rDucvZNusZ2G9tdNbu/eQeoFdc
         Wkc7NsdcYV3FL1NjRnJ1n/Zu6egxISGM3MYomhXNgrBOYsfWhFAhxNrSV8ymvT3htS
         IUXVcdcCY8/S4uKXQy2NxwKSSaf82nKEXrrCglLrWnI/mR8jXGPlwD9LMy6XDsbJdM
         I2UTYt58MY6cA==
Message-ID: <67aa9041-b9c9-435f-f4a2-b453344ba779@free.fr>
Date:   Thu, 18 Aug 2022 18:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] CDC-ACM : Add Icom PMR F3400 support (0c26:0020)
To:     Greg KH <gregkh@linuxfoundation.org>,
        Thierry GUIBERT <thierry.guibert@croix-rouge.fr>
Cc:     oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220817102440.117640-1-thierry.guibert@croix-rouge.fr>
 <Yv5U7Xw5gHSY5EH0@kroah.com>
Content-Language: fr
From:   Thierry GUIBERT <thierry.guibert@free.fr>
In-Reply-To: <Yv5U7Xw5gHSY5EH0@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Do you expect me to reorder the whole structure by VendorId / ProductId ?

I can place my node after Castles VEGA 3000, but nodes "MARETRON USB100" 
"Alcatel OT-I650" and "DATECS FP-2000" are misplaced too in that case.

Regards,


On 18/08/2022 17:04, Greg KH wrote:
> On Wed, Aug 17, 2022 at 12:24:40PM +0200, Thierry GUIBERT wrote:
>> Supports for ICOM F3400 and ICOM F4400 PMR radios in CDC-ACM driver
>> enabling the AT serial port.
>> The Vendor Id is 0x0C26
>> The Product ID is 0x0020
>>
>> Output of lsusb :
>> Bus 001 Device 009: ID 0c26:0020 Prolific Technology Inc. ICOM Radio
>> Couldn't open device, some information will be missing
>> Device Descriptor:
>>    bLength                18
>>    bDescriptorType         1
>>    bcdUSB               2.00
>>    bDeviceClass            2 Communications
>>    bDeviceSubClass         0
>>    bDeviceProtocol         0
>>    bMaxPacketSize0        64
>>    idVendor           0x0c26 Prolific Technology Inc.
>>    idProduct          0x0020
>>    bcdDevice            0.00
>>    iManufacturer           1 ICOM Inc.
>>    iProduct                2 ICOM Radio
>>    iSerial                 3 *obfuscated*
>>    bNumConfigurations      1
>>    Configuration Descriptor:
>>      bLength                 9
>>      bDescriptorType         2
>>      wTotalLength       0x0030
>>      bNumInterfaces          2
>>      bConfigurationValue     1
>>      iConfiguration          0
>>      bmAttributes         0xc0
>>        Self Powered
>>      MaxPower                0mA
>>      Interface Descriptor:
>>        bLength                 9
>>        bDescriptorType         4
>>        bInterfaceNumber        0
>>        bAlternateSetting       0
>>        bNumEndpoints           1
>>        bInterfaceClass         2 Communications
>>        bInterfaceSubClass      2 Abstract (modem)
>>        bInterfaceProtocol      1 AT-commands (v.25ter)
>>        iInterface              0
>>        Endpoint Descriptor:
>>          bLength                 7
>>          bDescriptorType         5
>>          bEndpointAddress     0x83  EP 3 IN
>>          bmAttributes            3
>>            Transfer Type            Interrupt
>>            Synch Type               None
>>            Usage Type               Data
>>          wMaxPacketSize     0x0040  1x 64 bytes
>>          bInterval              12
>>      Interface Descriptor:
>>        bLength                 9
>>        bDescriptorType         4
>>        bInterfaceNumber        1
>>        bAlternateSetting       0
>>        bNumEndpoints           2
>>        bInterfaceClass        10 CDC Data
>>        bInterfaceSubClass      0
>>        bInterfaceProtocol      0
>>        iInterface              0
>>        Endpoint Descriptor:
>>          bLength                 7
>>          bDescriptorType         5
>>          bEndpointAddress     0x82  EP 2 IN
>>          bmAttributes            2
>>            Transfer Type            Bulk
>>            Synch Type               None
>>            Usage Type               Data
>>          wMaxPacketSize     0x0200  1x 512 bytes
>>          bInterval               0
>>        Endpoint Descriptor:
>>          bLength                 7
>>          bDescriptorType         5
>>          bEndpointAddress     0x02  EP 2 OUT
>>          bmAttributes            2
>>            Transfer Type            Bulk
>>            Synch Type               None
>>            Usage Type               Data
>>          wMaxPacketSize     0x0200  1x 512 bytes
>>          bInterval               0
>>
>> Signed-off-by: Thierry GUIBERT <thierry.guibert@croix-rouge.fr>
>> ---
>>   drivers/usb/class/cdc-acm.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
>> index 9b9aea24d58c..7735c6edce73 100644
>> --- a/drivers/usb/class/cdc-acm.c
>> +++ b/drivers/usb/class/cdc-acm.c
>> @@ -1813,6 +1813,9 @@ static const struct usb_device_id acm_ids[] = {
>>   	{ USB_DEVICE(0x0ca6, 0xa050), /* Castles VEGA3000 */
>>   	.driver_info = NO_UNION_NORMAL, /* reports zero length descriptor */
>>   	},
>> +	{ USB_DEVICE(0x0c26, 0x0020), /* Icom ICF3400 Serie */
>> +	.driver_info = NO_UNION_NORMAL, /* reports zero length descriptor */
>> +	},
> These were all in sorted order, until your entry :(
>
> Can you fix this up to be in the correct order and resend a v2?
>
> thanks,
>
> greg k-h
