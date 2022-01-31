Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63794A5005
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378609AbiAaUSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:18:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378534AbiAaUSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643660313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UR1qnuWWHKtGOuSRNx9fqkhQWixSIDEP01FlH+p7F5s=;
        b=ZxRZiJGs1EhxT/wsbDq+PauZQqHDzaugJF586GMdDOotlgYXAo2Tz4rPV8yj5ekrdO2eZ9
        pSBSf5SKJqj6Wg2tb+ny3cTSIFQbm95PLMjYMQtJdsm0783dcJQpzFFtaLgOKvg5TFELg9
        xUCNRq63i6CUDo6crIt+CkLUd95dzbo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-WEg2UzbNMl-vyasKQ4T_6g-1; Mon, 31 Jan 2022 15:18:32 -0500
X-MC-Unique: WEg2UzbNMl-vyasKQ4T_6g-1
Received: by mail-qk1-f200.google.com with SMTP id a134-20020ae9e88c000000b0047ebe47102dso10567024qkg.18
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UR1qnuWWHKtGOuSRNx9fqkhQWixSIDEP01FlH+p7F5s=;
        b=4ysMNBT7sC1tHikpdBaX54PRRxRYbvsURIOCWyW+2bj1JCLdNICX7QuiZgro3a4A1q
         DsLA7XrBWdfoutontvTgc73AWbW4XT1DESyA/SIpXDXGozopl0fSj4A8qbkgAtHx5d/w
         djPW8a5Dgg7s2lZgifDF9968K/137oGxPq+gBRhAIqG214sHyx6mUuR3JinqpW5QCBWW
         XI4EB8+p0qbOY5EVpj8Z7aTTYCv4P5ouuvVD405VVt1/uS2Gf9Ye4BBgnlxOxburW56T
         7WqFY23vIMLfwDLhfpjNKxGl0dv7bL+Ys7Xp07eDhwkD6wx4RFRkBupwcviLC9Fl6jeL
         Lkpg==
X-Gm-Message-State: AOAM5302WaFnl4ZNzNCGO2CaGse+eeL/5rCykNjGEKhPWw/W8eGCy/s1
        s02LRiP6j8iVSMEaVRYjtAV9PS4KDyCKs+LKUKEeq9OvypN0B2EdOLlU03LVn9JrsGxKVVq/xDC
        Idd3ExFta5l9GRwc2En3UFkfpg3RNEV9VaK9FlCxUvN0RfNg9rg1ac5+hqn5RIW+YKLbxKU0=
X-Received: by 2002:a05:622a:15d2:: with SMTP id d18mr2796960qty.627.1643660311584;
        Mon, 31 Jan 2022 12:18:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGwO0NBU7bn3wTwpfumrhnTMD09THL9KCsJv4cw+l+J902R+8ySnhdFLDbQAGPKTfR2o2zoQ==
X-Received: by 2002:a05:622a:15d2:: with SMTP id d18mr2796941qty.627.1643660311314;
        Mon, 31 Jan 2022 12:18:31 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id y15sm9466742qko.95.2022.01.31.12.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 12:18:30 -0800 (PST)
Subject: Re: [PATCH] ACPICA: cleanup double word in comment
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220131133337.1556355-1-trix@redhat.com>
 <CAJZ5v0g5Xxd9kBPUdsC6D4fVHfZafKiGgkTONo2mpqvfgoFDgw@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <69d0ac2f-f953-0890-b2d7-1c43c61be43f@redhat.com>
Date:   Mon, 31 Jan 2022 12:18:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g5Xxd9kBPUdsC6D4fVHfZafKiGgkTONo2mpqvfgoFDgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/31/22 10:51 AM, Rafael J. Wysocki wrote:
> On Mon, Jan 31, 2022 at 2:33 PM <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Remove the second 'know'.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> This is ACPICA material, so it needs to be submitted to the upstream
> project via https://github.com/acpica/acpica/
>
> Also, it would be good to combine all of the analogous changes in one patch.

I am not sure if this is the last one for acpica, the finder script is 
very slow.

I will wait a bit and combine these in a day or two.

And take care of the other repo.

Tom

>
>> ---
>>   drivers/acpi/acpica/exfldio.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
>> index bdc7a30d1217c..b92605df3872c 100644
>> --- a/drivers/acpi/acpica/exfldio.c
>> +++ b/drivers/acpi/acpica/exfldio.c
>> @@ -104,7 +104,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
>>   #ifdef ACPI_UNDER_DEVELOPMENT
>>          /*
>>           * If the Field access is any_acc, we can now compute the optimal
>> -        * access (because we know know the length of the parent region)
>> +        * access (because we know the length of the parent region)
>>           */
>>          if (!(obj_desc->common.flags & AOPOBJ_DATA_VALID)) {
>>                  if (ACPI_FAILURE(status)) {
>> --
>> 2.26.3
>>

