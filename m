Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580804A6EBC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiBBKb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:31:27 -0500
Received: from cable.insite.cz ([84.242.75.189]:54289 "EHLO cable.insite.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232194AbiBBKb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:31:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by cable.insite.cz (Postfix) with ESMTP id 7CDEBA1A3D402;
        Wed,  2 Feb 2022 11:31:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
        t=1643797884; bh=m57sKCZLcTtk6SauTtGjeo9rjfaMH2ssP+2/C7sdvVY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qCtgBYxPM8ft2kwxbuXXs+31U2UGhoKWaWYydzgmpFH+SMepg5UEFtCYj5uBu1bPd
         IzgZMSQByfDngmXufo6qFC6PCE7vrqJUDyv90k2GO5tIAnqwcw1Yrh5SVM1SAM694i
         j+kdK/mjQYP06OqEwrEMBalPkLLsG9wPyZ3J8Ic4=
Received: from cable.insite.cz ([84.242.75.189])
        by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i4YarFuNZVz5; Wed,  2 Feb 2022 11:31:19 +0100 (CET)
Received: from [192.168.105.22] (dustin.pilsfree.net [81.201.58.138])
        (Authenticated sender: pavel)
        by cable.insite.cz (Postfix) with ESMTPSA id 21A85A1A3D400;
        Wed,  2 Feb 2022 11:31:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
        t=1643797879; bh=m57sKCZLcTtk6SauTtGjeo9rjfaMH2ssP+2/C7sdvVY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Pps74gPCpVJFjZa9EDBad20Vh2yQVkBR8cWqPq7ylJNulWdZjBMGzEYlfmJZT/uZX
         gY4T9LWlOcRoMhdQonfnCMNDC91nd6JovUUG5X2FSH9b46PMo1l3FHbspW69l7sPtW
         NwdygXmivZg54lxKE5qTGJHvh77UITxSfRv80CM0=
Subject: Re: [PATCH][next] usb: gadget: f_uac2: Fix spelling mistake
 "maxpctksize" -> "maxpcktsize"
To:     Joe Perches <joe@perches.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220202091933.580713-1-colin.i.king@gmail.com>
 <358563808e6cad1b003e4c5488cf65ff1267f1d8.camel@perches.com>
From:   Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <efcb90c2-cfbb-3264-bd6d-bca33b03fa48@ivitera.com>
Date:   Wed, 2 Feb 2022 11:31:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <358563808e6cad1b003e4c5488cf65ff1267f1d8.camel@perches.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dne 02. 02. 22 v 10:57 Joe Perches napsal(a):
> On Wed, 2022-02-02 at 09:19 +0000, Colin Ian King wrote:
>> There is a spelling mistake in a deb_dbg message. Fix it.
> []
>> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
> []
>> @@ -755,7 +755,7 @@ static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac2_o
>>   
>>   	if (max_size_bw <= max_size_ep)
>>   		dev_dbg(dev,
>> -			"%s %s: Would use maxpctksize %d and bInterval %d\n",
>> +			"%s %s: Would use maxpcktsize %d and bInterval %d\n",
> 
> why not just spell it out? or use wMaxPacketSize from the uapi include?

My reason for the ugly abbreviation (prone to misspelling for which I 
apologize) was to keep the line length limit. I would be happy to see 
wMaxPacketSize instead :-)

Pavel.

> ---
>   drivers/usb/gadget/function/f_uac2.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
> index f2237bcdba7c0..13b59128121a2 100644
> --- a/drivers/usb/gadget/function/f_uac2.c
> +++ b/drivers/usb/gadget/function/f_uac2.c
> @@ -755,12 +755,12 @@ static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac2_o
>   
>   	if (max_size_bw <= max_size_ep)
>   		dev_dbg(dev,
> -			"%s %s: Would use maxpctksize %d and bInterval %d\n",
> +			"%s %s: Would use wMaxPacketSize %d and bInterval %d\n",
>   			speed_names[speed], dir, max_size_bw, bint);
>   	else {
>   		dev_warn(dev,
> -			"%s %s: Req. maxpcktsize %d at bInterval %d > max ISOC %d, may drop data!\n",
> -			speed_names[speed], dir, max_size_bw, bint, max_size_ep);
> +			 "%s %s: Req. wMaxPacketSize %d at bInterval %d > max ISOC %d, may drop data!\n",
> +			 speed_names[speed], dir, max_size_bw, bint, max_size_ep);
>   		max_size_bw = max_size_ep;
>   	}
>   
> 
> 
