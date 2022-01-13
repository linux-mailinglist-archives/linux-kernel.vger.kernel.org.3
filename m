Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276B148CF90
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 01:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiAMALx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 19:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbiAMALq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 19:11:46 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ED0C06173F;
        Wed, 12 Jan 2022 16:11:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d19so7230524wrb.0;
        Wed, 12 Jan 2022 16:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rkHi0jgfi7N4v6Pquca5d8zy0G/Md33AU4AUQvjxZfQ=;
        b=SduoNkt/K2mCtPnUNRSkBsVVyUgxTuicIgHzCalz1IotXK5FGrdMxztEVj2jmYpynZ
         LOXqY0jdALwLGN97vgjU13xfwcNh4R112XbyDtMhk/Wsnyw3bUHsL06Q0lfeHvnw4x4c
         mSdUdSGlwjxgkTUB/dtE71QsUukUUJDI7RRlUrMQiQQ1a7hoPT/7w8osI4weRe0oJQ9q
         o0/sAjLuF6heNzVPHBKwtL0c3sLpG1aDncymoIZwrD1Gp2Iq4UTFaKBhOYGYsjr4q237
         T2Dn4N4H+s1IGdTgZjano38VEoQIXC1Kt8brBJve7fNZhPQ0nrdk4pcdAGxcLcpXOwt2
         EUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rkHi0jgfi7N4v6Pquca5d8zy0G/Md33AU4AUQvjxZfQ=;
        b=m6/NBQ27fYwG7fqNp8Z5BsUED65ZLGjEKMMDvP1ylOB64bATzBuB0wQeaVu9MVPJLO
         k9K5F8SNc9lrBLUyFr/VBXjU+3LLfyT5zBDGlOxt1y8A86uL6YAFA10Po3Ro9rWW3gn4
         XHGYMbZhCKltNHhe4jJHRFeoO4Ti+s36uBzCxqn/Rcd/ZSd332YTRJnrBBQgkDGzsoAC
         8lbTeyqdxuR0OcnpynX6Vq4gpBt7ySV6mHQWRARcCRsExwm577rdSQbLNswRe3lKWyJ5
         B122gPHMt/MsYMmfX/mrQM8Utb3Y3Nt37vZk5VRQUtLZnwVcWqWmVAsuk/P7Kb/7wo2a
         Iw7g==
X-Gm-Message-State: AOAM5335Gs6tYJEii1YocXvUn/JA8qOGVIMUe3e7iEvU9eWBoY8cTv9g
        2biveZ1DIN5fO+UQd+vbxj2tF7ycQelXauZy
X-Google-Smtp-Source: ABdhPJxtckVLkhMzVD7fP+ItsKIrZPqovIDCItYZbaisK3o5kgvL2aWZsKXMkHxU1K+rfNST84eN+g==
X-Received: by 2002:adf:ba8b:: with SMTP id p11mr1712450wrg.390.1642032704587;
        Wed, 12 Jan 2022 16:11:44 -0800 (PST)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id bh26sm6576662wmb.3.2022.01.12.16.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 16:11:44 -0800 (PST)
Message-ID: <a049118e-888b-991b-8df8-640c828b4e08@gmail.com>
Date:   Thu, 13 Jan 2022 00:11:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ata: pata_ali: remove redundant return statement
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220112234741.1232858-1-colin.i.king@gmail.com>
 <2d9b4f08-967e-6040-a954-e7bfa7e4dce1@opensource.wdc.com>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <2d9b4f08-967e-6040-a954-e7bfa7e4dce1@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2022 23:52, Damien Le Moal wrote:
> On 1/13/22 08:47, Colin Ian King wrote:
>> A return statement is unnecessarily complicated, currently value
>> in variable mask is bitwise-masked and the variable is being
>> updated and then returned. Just updating the mask is all that is
>> required as the following statement is a return.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   drivers/ata/pata_ali.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
>> index ab28a6707b94..1b90cda27246 100644
>> --- a/drivers/ata/pata_ali.c
>> +++ b/drivers/ata/pata_ali.c
>> @@ -123,7 +123,7 @@ static unsigned long ali_20_filter(struct ata_device *adev, unsigned long mask)
>>   		mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
>>   	ata_id_c_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
>>   	if (strstr(model_num, "WDC"))
>> -		return mask &= ~ATA_MASK_UDMA;
> 
> Yeah, not to mention that is really ugly as the return should really
> have been:
> 
> return mask & ~ATA_MASK_UDMA;

Yep, I did think of that as the original intention, but two return 
statements one after the other was equally as ugly. It was a 50/50 
choice of what was perceived as the better fix :-)

> 
>> +		mask &= ~ATA_MASK_UDMA;
>>   	return mask;
>>   }
>>   
> 
> Will queue this up.
> 
Thank you.

