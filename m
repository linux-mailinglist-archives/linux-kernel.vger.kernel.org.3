Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9B448055C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 01:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhL1Agi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 19:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhL1Agh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 19:36:37 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89BBC06173E;
        Mon, 27 Dec 2021 16:36:37 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id m6so27599946oim.2;
        Mon, 27 Dec 2021 16:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EWpyKi4bdjNEDCaEceQFsgghRB7Mx+kRyl+XhrILADo=;
        b=XqHiL8CWow3/rk8AkExPLh8LKB/XpuSLIGjhRtwwA/27+mz36AaEHEW2FmhbhR4s0P
         Q9vji6sJv35p8ryJQkil+4zRN37PKklAYhDJtAlEXKuR1ISjD2sxi0ZD6xHBzfJzqBMI
         E09clMNBqHpRXYvVpKv2VXvthwoOD1kLgY28JvjgY87zpKQV4c+vwQjP+wddZokBY60h
         w9iup993hL4U13cf9HQIBGuVKrlMfChqPZhLjLYWrQFNs5fRNxugZCsbuv9NqPbg4sh/
         LdIx7lPhueSE0a+MUkabdTQvtz44w/RjMN+UlleW2FDVvNl3N5ySmsZ89SrG5lCvm9XT
         PhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EWpyKi4bdjNEDCaEceQFsgghRB7Mx+kRyl+XhrILADo=;
        b=lydSxbUG1UcPtfUSYSz7yhwwGHGFS5cI+Sr2D5dKfCbU0iHn6dMyTEmCoOYkR98+RB
         jvah551tAvmH28jSZ+1wnrTpfruCcpYEjCluzup5zatNrzgBxqsZBxBOwgiX7Anc+LOl
         VxxunwUJd3TNs8R9PV6VAi62DgsuAbg4Pu34a+2RK1wW58A1j1IvbqHkyVWjj4kHWahQ
         minhvYDJ2lCvAjaQfrIZE5I0hZkXYcxMML7L+Xg4IQddm0QQITCWu+H7En/IZ77e78CM
         YHw8st5M6c8iO1Co0ozg6ORFyrw+mgttOlfSImcLmgKsv7hcbeOzBnG9cbuCXhXSH8S2
         t2oQ==
X-Gm-Message-State: AOAM5305edmbRYBgv+wkEjg2EyN81cIxcV6gfHSQ/10hbMD21gbSrnVk
        WKVhtXVS7vxWAfky+CYppTs=
X-Google-Smtp-Source: ABdhPJwbnK9znijVeq968jcE4HTO3dldCDp6kUkKRoUIcLN0t8DRPHzlQ45zbPrluFRdtE16zzl44w==
X-Received: by 2002:a05:6808:20a6:: with SMTP id s38mr15737056oiw.152.1640651797087;
        Mon, 27 Dec 2021 16:36:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p7sm2693259ots.57.2021.12.27.16.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 16:36:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Aleksandr Mezin <mezin.alexander@gmail.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20211227113632.90672-1-jiapeng.chong@linux.alibaba.com>
 <e689de7b-033b-0ada-5135-faf7fdb1e26b@roeck-us.net>
 <CADnvcfJ_ZxQgrsxxAyrEfMLKFZGuGo6CESCWNyWYtPHkA4ZTsQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: Use min() instead of doing it manually
Message-ID: <38383f8a-a71d-22ff-93ab-8ac14f5aba07@roeck-us.net>
Date:   Mon, 27 Dec 2021 16:36:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CADnvcfJ_ZxQgrsxxAyrEfMLKFZGuGo6CESCWNyWYtPHkA4ZTsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 4:18 PM, Aleksandr Mezin wrote:
> On Mon, Dec 27, 2021 at 9:43 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 12/27/21 3:36 AM, Jiapeng Chong wrote:
>>> Eliminate following coccicheck warning:
>>>
>>> ./drivers/hwmon/nzxt-smart2.c:461:12-13: WARNING opportunity for min().
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>>> ---
>>>    drivers/hwmon/nzxt-smart2.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
>>> index 534d39b8908e..b30de7441fbb 100644
>>> --- a/drivers/hwmon/nzxt-smart2.c
>>> +++ b/drivers/hwmon/nzxt-smart2.c
>>> @@ -458,7 +458,7 @@ static int send_output_report(struct drvdata *drvdata, const void *data,
>>>
>>>        ret = hid_hw_output_report(drvdata->hid, drvdata->output_buffer,
>>>                                   sizeof(drvdata->output_buffer));
>>> -     return ret < 0 ? ret : 0;
>>> +     return min(ret, 0);
>>
>> Nack, that is just confusing. ret is an error if < 0, and min obfuscates
>> that we want to return an error or 0.
>>
>> Guenter
> 
> Should I change that ternary operator to a full "if" maybe?
> Apparently, both some people and some tools read it as "min()".
> 
No, the code is good as is, using if() doesn't really make a difference,
and I _really_ don't want to encourage people to start submitting patches
to change the other 100+ instances of the same code in the kernel.

Guenter
