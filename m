Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3C348B694
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350432AbiAKTPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350415AbiAKTPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:15:10 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C92C06173F;
        Tue, 11 Jan 2022 11:15:10 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id q186so401648oih.8;
        Tue, 11 Jan 2022 11:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cFyibHsoE6yG/EPoMHiX4V+rPgSAiTGU9x4HAOvuiBE=;
        b=hWlGRsprNCVoFre91ltBjeJnz25+E1CrB05wGQErrYhwoJApvnexOxS6gVNMQTemoq
         rUe8SLo0StcmfPtFo2GVyQH340Rq72u9AkIxa8GWqx8Fxyoqg444qkiFcdNnmI7t3cXo
         UVLTkxcBUjPPlvi+rVOLq8JrFauvhyufJqgztolonxdMK0w3EbYKZzYBfyRli0aGG2Bt
         rZJfazhYET8X1fALiYh8Lgz8sp8ki6WmDSKaZ4TN8TM3t1SGUP9z0fDHN/UciULyZsgQ
         LI+VZRUEZuYWKZl56B+fWalx3eWqyh/7uKq/NejkZlNYlgf04vTRDOolvO14xebRrq2y
         ZiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cFyibHsoE6yG/EPoMHiX4V+rPgSAiTGU9x4HAOvuiBE=;
        b=SwWtPB5ewppOkDcFIX2Af+2XhGXtsb9xh2u+xkPiAE1UeSum2tceS0lKjAuK57vSJF
         TjcWZ7XR+cdH3qlwDn7dAkihyNOTht5xsaM7j53NNyeH6iYaL91RWQFEROT1g6YCBfzk
         4cbNz/TDQMoKwdh8AANaIeQJpGTtPw8AdIotcgkxL22Ym47LucE6TWI8xutH4U2Z41OR
         3bKsiN83MaDJH21HL1HMBlg67f5b2qhqeYlJr92vln0Swju+u/MS0PMqzUCNpJ2fSY3d
         hY7Psz3BaiRTqnkghFnWeN3gxeVgmK3/NEdX8sQmbf0+ypQqipeiJ4wJ2Um3OC034Nsk
         yqEg==
X-Gm-Message-State: AOAM530K7Pw+Z832O/A8R1dZSZ8bDiZRhPdXRmdrmef12q0VshaqRNUW
        cVsP6C2bQ+vQgeFNugFRTkSlT12W+EM=
X-Google-Smtp-Source: ABdhPJytchmp3pAV/8hn/QStTcSDhDKavzsJEuDfqWTMjTPu2+CCnI3Tlz+Lqy4rsf0sVvLlKrqa1g==
X-Received: by 2002:a05:6808:5a:: with SMTP id v26mr1927689oic.67.1641928509427;
        Tue, 11 Jan 2022 11:15:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n26sm2106401ooc.48.2022.01.11.11.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 11:15:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
References: <20220111160900.1150050-1-eugene.shalygin@gmail.com>
 <20220111160900.1150050-2-eugene.shalygin@gmail.com>
 <805dd382-262c-36f0-fcf5-5776223040c8@roeck-us.net>
 <CAB95QATsy2ACgyxWLy2PM2peqoYDEa_j96VNSHBG6GMd+x3LzQ@mail.gmail.com>
 <050ee3ed-4c30-afb9-d7ce-898d634284be@roeck-us.net>
 <CAB95QATb_En0KqXRktY99q8UXmosCftMrekpFiAKrAocwFEKmg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b5753e72-fe0d-1102-64cb-49de242184bb@roeck-us.net>
Date:   Tue, 11 Jan 2022 11:15:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAB95QATb_En0KqXRktY99q8UXmosCftMrekpFiAKrAocwFEKmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/22 10:52 AM, Eugene Shalygin wrote:
>> Just drop it.
> 
> OK.
> Are there any other edits (want to generate as few new emails as possible)?
> 

No need to resend because of this; I can drop it myself. No,
I don't have any further comments at this point, but I would
like to see (test/review) feedback by others before applying
the series.

Guenter
