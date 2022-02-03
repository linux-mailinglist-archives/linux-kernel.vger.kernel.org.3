Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14234A7D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348661AbiBCBKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiBCBKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:10:53 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7604C061714;
        Wed,  2 Feb 2022 17:10:52 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id m9so1613839oia.12;
        Wed, 02 Feb 2022 17:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a3Qhn4eAu2Il3cIcOwXujSLNjbmBj+pQdEvnqK4x3Zc=;
        b=nPE0AJIWxu/3upqr5txI2VOUL4BjAC+1PUALQuJh0xUJhMxFpmXNZvFLpSScOZdmcI
         qGJNIuDJMsf/tvDzp5v2UpcPGIxYti8JEc8BvugK7ePDwtKIedqATkCalAT2eIU5Gl3+
         4voA2/dggPY+37ELHbo3Zleh/xwUCzs9xyQPRYEQh4BUEfbEc979qpC0FOX/mPwHkaLY
         TJ3t4/tM4/a9Z5KuKjANzCEMG7mEcrSqfstxqSlbgHXjBFFOLKdYu5ofWv5CNiZZNkuG
         DpFb1z0mFlCaisGxqs6+jSF9jZkZQ5sjmpgTxAFMqz+CWJS/F/U88UOO6GJpeBSEMIkL
         QwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a3Qhn4eAu2Il3cIcOwXujSLNjbmBj+pQdEvnqK4x3Zc=;
        b=RuYCMwG0ABO2VaJkhDCWb8OChyAf3QJcGCeVvNdtVztsHIRYY6Zzq6Aopt+Zfe6YsB
         gyJbnSwPwHh5vm7MooVMwKHc1plb6TApOSmB5uIOF8NKU2msHGAL6TqquCw8TWJT31ts
         sPtjUHD7/FEyZLOGkPV+/eTQOINpSQA9lJa5M+kyePVxjhCJdWeziuOtoDtImSqgazbX
         pIa4oopk/HpIzFTpuIebjbADFD7/46DokJNhWAlrjPD22kV5tcJULlaOIj9rDhRdKY8d
         dq3MSm6vy6J2O2x71pK1vBfdjK2OLr3ODVP6+N8wTmv6ySw1J8GTsqNWEtY8MwdCVaAE
         OKnQ==
X-Gm-Message-State: AOAM532iK/RnNx7BIuocLz12zP/oGrV1DcBYHz4Amw8XX2I1Tv4X1yfQ
        iafkFdCepXo/RAaMJlCAGYk7oyJC9OqPOg==
X-Google-Smtp-Source: ABdhPJyjN33e4o0Zy3SjGTxDrxD1Q/VHo6inAaOniTodZNiauKvTpoDBmUCsEeFzNsq0Lx3difjwow==
X-Received: by 2002:a05:6808:1782:: with SMTP id bg2mr6385022oib.235.1643850651826;
        Wed, 02 Feb 2022 17:10:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf15sm3485395oib.32.2022.02.02.17.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 17:10:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c613f73b-9c91-9aad-e367-87b9d8b17530@roeck-us.net>
Date:   Wed, 2 Feb 2022 17:10:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [ASUS EC Sensors v8 0/3]
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
References: <20220124015658.687309-1-eugene.shalygin@gmail.com>
 <CAB95QASxE8Z_z046mnOBD1Zk1oeg=xB-wS+J8Oeuj=akm8171Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAB95QASxE8Z_z046mnOBD1Zk1oeg=xB-wS+J8Oeuj=akm8171Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 15:58, Eugene Shalygin wrote:
> On Mon, 24 Jan 2022 at 02:57, Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
>>
>> This patchset replaces the HWMON asus_wmi_ec_sensors driver with
>> an implementation that does not use WMI but queries the embedded
>> controller directly.
> 
> Günter, I would like to add support for one more board model. What
> should I do? Another version update or could you, please, merge this
> patchset already?
> 
> Thank you,
> Eugene

I was waiting for someone to send me a Tested-by: for the series,
since you dropped the previous feedback. Presumably that means that
the changes from previous versions warrants another round of testing
and/or review.

Guenter
