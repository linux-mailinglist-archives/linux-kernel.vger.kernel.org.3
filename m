Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EA8465D96
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345010AbhLBExS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbhLBExN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:53:13 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DADC061574;
        Wed,  1 Dec 2021 20:49:50 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y196so22006294wmc.3;
        Wed, 01 Dec 2021 20:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sKU5HJ0S+kS0uCi/hPOcXn/RvplQ4/OOHozBlPG8axU=;
        b=Ky0ktax/aDFtiXZA0nFZv5Za76KIGG7Fs/oVhhiRQ+wJjJrYyLAfH79eQLYmh+qlGg
         ud8mq0jWaMTMhKtWM1tz6RSe4dr1Igamb/uIVlqwzmvVMMwn92isyPG3TnyUKcsb9Iw1
         g7cz5hCnBbkJziZBz6Q0OvZmoZg8n/TzAU37VvxaMuqFk3dqxxmTCNXnxORwbIrOnWOV
         XUcpWBTX3x4W8E3Y0mXusISUxmdoG5lQUbFRjf3Y30UdrQDRW7320MmBrT1jO36GlFo2
         mOUX/660zG4ZNl8RZ3AkXJJFz13/dmZYfgPhpFurNrcUX0NHGcrL+tusLLCTBWIzzTj9
         YKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sKU5HJ0S+kS0uCi/hPOcXn/RvplQ4/OOHozBlPG8axU=;
        b=A52k3lRLXCrUMEqHrZcNPVPmphGO0XnsUSLZWvWeBbpkUOZXzP0h0i4afNHWSC0skL
         1nYVXzxPfn2RLLzjWKXnv+3efUwna9OFdV5g+RLKOL5GbWisRlke/O0B1zuHK33nNa+v
         N3Ikzedbc0Xuoc6vihmKfqZkBBxIwTirHvjMQpMoWODNWwLmHQ8PaBYlNpCM6yEBE7aC
         uG5o/xzCLlUzrjrHEQXn94mbHmfmCLvhiiSSPftcGCije+VHTdVF5SO+7d02WHiDg7PD
         uPduUDRV30r5G0RoMKSSPiThaKaKaN2XM7et0tRSd9Kf42hZPV+8N3tSTIjhj1B/nx0w
         pA6g==
X-Gm-Message-State: AOAM532/faf/57EYZVFaxioAV+Zxs7q5rGF9zXgQksSeBRPuUGmEXE8R
        3jVrEsFXUrr5jbtwd5s8fNOabifBUp/+cw==
X-Google-Smtp-Source: ABdhPJx3POnji2GhsPdvyHebwXOOKlHM8TGMLEYC3jefB/37OvdBOAIcGv2WRE5orQCInO14VMtSUQ==
X-Received: by 2002:a05:600c:1d06:: with SMTP id l6mr3267298wms.97.1638420588766;
        Wed, 01 Dec 2021 20:49:48 -0800 (PST)
Received: from ?IPv6:2003:c7:8f4e:658:f367:7a48:ecf:570a? (p200300c78f4e0658f3677a480ecf570a.dip0.t-ipconnect.de. [2003:c7:8f4e:658:f367:7a48:ecf:570a])
        by smtp.gmail.com with ESMTPSA id a9sm1473364wrt.66.2021.12.01.20.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 20:49:48 -0800 (PST)
Subject: Re: [PATCH 1/4] Docs: usb: update usb_bulk_msg receiving example
To:     Alan Stern <stern@rowland.harvard.edu>
References: <cover.1638152984.git.philipp.g.hortmann@gmail.com>
 <28a76eedad7027277754cef84ca34810b0cfe6f4.1638152984.git.philipp.g.hortmann@gmail.com>
 <YaaFNO1t3GIaGFPI@rowland.harvard.edu>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Message-ID: <ad2fcdfa-5688-4d09-2c82-c405adeae4ee@gmail.com>
Date:   Thu, 2 Dec 2021 05:49:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaaFNO1t3GIaGFPI@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 9:10 PM, Alan Stern wrote:
> On Mon, Nov 29, 2021 at 09:21:41PM +0100, Philipp Hortmann wrote:
>> Clarification that this example is not in the driver template anymore.
>> Update code example so that it fits best to usb-skeleton.c
>>
>> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
>> ---
>>   .../driver-api/usb/writing_usb_driver.rst     | 30 +++++++++----------
>>   1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
>> index b43e1ce49f0e..a9608ad18d77 100644
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
>> +driver. Instead we call `usb_bulk_msg` function, which can be used
>>   to send or receive data from a device without having to create urbs and
>> -handle urb completion callback functions. We call the :c:func:`usb_bulk_msg`
>> +handle urb completion callback functions. We call `usb_bulk_msg`
>>   function, giving it a buffer into which to place any data received from
> 
> The reason for the last two changes above isn't clear.  You removed some of the
> markup indicators and made the text ungrammatical.  This does not seem like an
> improvement.
> 
> Alan Stern
>
This two changes were made because of an earlier comment to the same 
document, but may be I understood this wrong:
On 10/19/21 11:17 PM, Jonathan Corbet wrote:
...
We shouldn't be using :c:func: anymore; just say usb_register() and the
right things will happen.  Definitely worth fixing while you are in the
neighborhood.
...
If you're making this change, take out "the" (as well as :c:func:).
...
___
Please find the full email under the link:
https://lore.kernel.org/linux-usb/87h7dcsohs.fsf@meer.lwn.net/T/

Please give me an example for the right wording. I am not a native 
English speaker. Is the article in this case required?
Thanks for your support.
Philipp Hortmann
