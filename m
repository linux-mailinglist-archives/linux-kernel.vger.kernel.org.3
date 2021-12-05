Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34636468C51
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbhLERIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbhLERIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:08:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB3FC061714;
        Sun,  5 Dec 2021 09:04:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so8735800wme.0;
        Sun, 05 Dec 2021 09:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jCYMfFyqt6/AeKOu1W/uZvXhc4K+GFrf5xdA28bFr9M=;
        b=lDY0kBObUw7ewFrCyvP0U3x1JxtchQ7/pv+D0sUKzSBVDl/laIv0DhpB4vdnC7LxIq
         9fSwGSud++fNW2d4+aAfkuX2d3KccsvrlFhvlbja5Fia3JZfcaiYXg0mC3b5Rwk5SlOM
         XyjqDhRACOv76QGmBiuMhtQk9qU6EHQDFCrINQlZpas/SfhaJCdIEYupaHvAPxUuzuRe
         2ZKqQGQQlEI5YH7Gcu9AwhLTww5vQSmSxUZlX0xU5++AqVwjbeaA26hWVaAlEZAQdMak
         W7y0ZvNV5Fai5d6xGRg/vm8KHwBYf2NPI2wSrYU7Sr+ec41AUfjmoMUaDbnEdCCEAIUI
         pB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jCYMfFyqt6/AeKOu1W/uZvXhc4K+GFrf5xdA28bFr9M=;
        b=xrsn3Vk4qp0JdQTdIxuCzdXfbJu/Mc4gtyGFSc3vOZ3hdH+q0hygtHCAZiXDn1Ymxn
         hN/+0oxFjkZEpluFgIm8b2BTPpRp8yug1ncYw7vj1xHKGp6DXChasND5uVbkEbz1RtqZ
         rB7V4fEh0jEFzEVec6kEoXuta/r4Pcic4Aed5M9I2hTPnECUz5VxoBVOtUWrCIUxG0ia
         nUd5GimAO5KxhGWRoFB0CDdPkrcqwLvYEgUfnwVEcEVijIfjr87H/xjQXWTZyoCr/+//
         59Sggmku1PwT1r+iopCcXo/BtgYFUSs51nxAild4XoSNk9U3FTGWeYmHyNtRK2qxJyGy
         176A==
X-Gm-Message-State: AOAM532XUO6P/yyyvXjM6OD9yROyeWBRsQqujbgD3FAynlgfd05SMLeQ
        5Q+UF6nruAAcmFnABuoBHH+vybEh85ps8Q==
X-Google-Smtp-Source: ABdhPJyy9qqc2ZeFnA/K0WTxEqeQ9KDdINOKgbH2NxxZeL+BjHs4nmvsJWDKDC7PCXWKvAtrLAeQew==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr32449028wmp.52.1638723889960;
        Sun, 05 Dec 2021 09:04:49 -0800 (PST)
Received: from ?IPv6:2003:c7:8f4e:628:71b5:dda5:dfe9:acb0? (p200300c78f4e062871b5dda5dfe9acb0.dip0.t-ipconnect.de. [2003:c7:8f4e:628:71b5:dda5:dfe9:acb0])
        by smtp.gmail.com with ESMTPSA id b15sm11070176wri.62.2021.12.05.09.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Dec 2021 09:04:49 -0800 (PST)
Subject: Re: [PATCH v2 1/4] Docs: usb: update usb_bulk_msg receiving example
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <cover.1638630342.git.philipp.g.hortmann@gmail.com>
 <0bd9336e18abad338b4967664a4667b96dae6be6.1638630342.git.philipp.g.hortmann@gmail.com>
 <Yayb6+SrQKUG4bDl@kroah.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
Message-ID: <f3a1b2ba-85fe-e829-0d11-07a4bc4d8756@gmail.com>
Date:   Sun, 5 Dec 2021 18:04:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yayb6+SrQKUG4bDl@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/21 12:00 PM, Greg KH wrote:
> On Sat, Dec 04, 2021 at 05:35:11PM +0100, Philipp Hortmann wrote:
>> Clarification that this example is not in the driver template anymore.
>> Update code example so that it fits best to usb-skeleton.c
>> Update format of function names
>>
>> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
>> ---
>> V1 -> V2: Added "Update format of function names" to patch description
>>            Corrected format of function names like the following example:
>>            "`usb_bulk_msg` function" to "usb_bulk_msg()"
>> ---
>>   .../driver-api/usb/writing_usb_driver.rst     | 32 +++++++++----------
>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
>> index b43e1ce49f0e..ed11398837e5 100644
>> --- a/Documentation/driver-api/usb/writing_usb_driver.rst
>> +++ b/Documentation/driver-api/usb/writing_usb_driver.rst
>> @@ -218,36 +218,36 @@ do very much processing at that time. Our implementation of
>>   ``skel_write_bulk_callback`` merely reports if the urb was completed
>>   successfully or not and then returns.
>>   
>> -The read function works a bit differently from the write function in
>> +This read function works a bit differently from the write function in
>>   that we do not use an urb to transfer data from the device to the
>> -driver. Instead we call the :c:func:`usb_bulk_msg` function, which can be used
>> +driver. Instead we call usb_bulk_msg(), which can be used
>>   to send or receive data from a device without having to create urbs and
>> -handle urb completion callback functions. We call the :c:func:`usb_bulk_msg`
>> -function, giving it a buffer into which to place any data received from
>> +handle urb completion callback functions. We call usb_bulk_msg(),
>> +giving it a buffer into which to place any data received from
>>   the device and a timeout value. If the timeout period expires without
>>   receiving any data from the device, the function will fail and return an
>>   error message. This can be shown with the following code::
>>   
>>       /* do an immediate bulk read to get data from the device */
>> -    retval = usb_bulk_msg (skel->dev,
>> -			   usb_rcvbulkpipe (skel->dev,
>> -			   skel->bulk_in_endpointAddr),
>> -			   skel->bulk_in_buffer,
>> -			   skel->bulk_in_size,
>> -			   &count, 5000);
>> +    rv = usb_bulk_msg(dev->udev,
> 
> Why are you changing the varible name?  That seems unnecessary.
Reason is that retval does not exist in skel_read().
> 
>> +		      usb_rcvbulkpipe (dev->udev,
>> +		      dev->bulk_in_endpointAddr),
>> +		      dev->bulk_in_buffer,
>> +	              dev->bulk_in_size,
>> +		      &len, 5000);
>>       /* if the read was successful, copy the data to user space */
>> -    if (!retval) {
>> -	    if (copy_to_user (buffer, skel->bulk_in_buffer, count))
>> -		    retval = -EFAULT;
>> +    if (!rv) {
>> +	    if (copy_to_user (buffer, dev->bulk_in_buffer, len))
>> +		    rv = -EFAULT;
>>   	    else
>> -		    retval = count;
>> +		    rv = len;
>>       }
> 
> Leaving the variable name alone keeps this patch much smaller.
Will leave the variable name in the next patch.
> 
>>   
>>   
>> -The :c:func:`usb_bulk_msg` function can be very useful for doing single reads
>> +usb_bulk_msg() can be very useful for doing single reads
> 
> You are doing different things in this patch, one is converting the
> function style and one is updating the text.  How about doing just the
> function name stuff first, all in one patch, and then the updates, as
> that would make it much easier to read.
Will be changed.
> 
> Also, any reason you aren't cc:ing the USB maintainer on these changes?  :)
According to:
perl scripts/get_maintainer.pl --separator , --nokeywords --nogit 
--nogit-fallback --norolestats -f 
Documentation/driver-api/usb/writing_usb_driver.rst
Jonathan Corbet 
<corbet@lwn.net>,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org
you are not in charge.
thanks,
Philipp Hortmann
> thanks,
> 
> greg k-h
> 

