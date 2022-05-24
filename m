Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2F532A50
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbiEXMYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiEXMYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:24:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A4A939DA
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:24:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eg11so22799844edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=0ClCObzZM0JGjb5K73U4ZwKmob5kESvLI8Z4kupojhc=;
        b=Ybpk9ZtlkSHU53GPoO2SyDZAWpT3mBN2ihVW2C2gROI4GeXiuSpJI79zRdfGWoqcsp
         0Y0t4+jKws5CdTty5eMHiscQHbN72wh6I8SqOPcDncVWQKABcpEAV1IEzz46ytKJByZK
         xDH4rWB8OasOqyDKVumCfPJaZ+kaiUan8NULlYZgW4GxkhB2N/LykyhyxRaJ9sbh1mzF
         okRSWjbgpU3lg7aXgcfjUc2h/aezerZcfOjyuh5IZKEgScdCX1ex2ce1xtGFzVZQ/kpT
         VbWUjwWhR6vD9YtrZy4Jla+m/DUOy07Zr/I5YY3+dwBe/Ku874Y6/7c0ZFDwkjI292SQ
         413A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=0ClCObzZM0JGjb5K73U4ZwKmob5kESvLI8Z4kupojhc=;
        b=nTaKurGcPLDwqpEI3XKvJaJqjG8BwLvARrHmektG0IkcvmeTpA3nQPmqdp02iINDSN
         XHOGx+8vyvCuMv0SgIg8iL6vAonTL+RGa0+PKFMXMaiOPmHc2Bo2SzXYf1LuOFeJunB2
         rJdfnTRHelRIWsdUW33fuTcBEh/G/BJo66lsxJyWLLe/Ar6ZSaxJyQrwZFwz+QtSqZb0
         ZCLeHq/C1V/aUab9d3gM527MYQINqqB+Ud/fr9Urtvz/cujRu6ajLqDBj02VKAC3oS7V
         QyBu1urwboLs7wA+X5GOi4bqTnKBXZ2aILPBhrlEiPmrTJ9hzVLxVA73aWhp+Hhs6Krj
         HMAw==
X-Gm-Message-State: AOAM530QWLt+sbMm1KDBChKmghKTB7CqaO3DbDJsLAe19NNp4yIz7p1y
        irb5pGanO+FW/mAZnmLIkgo=
X-Google-Smtp-Source: ABdhPJwICUCNR7+MfCvVBCXJbspwcAB9rJsTABBRBnTj4ekuR7xfr1RkaPU4lCnu62sXEWbZSZwjcg==
X-Received: by 2002:a05:6402:d05:b0:425:b5c8:faeb with SMTP id eb5-20020a0564020d0500b00425b5c8faebmr28352093edb.273.1653395043293;
        Tue, 24 May 2022 05:24:03 -0700 (PDT)
Received: from [93.172.10.244] (93-172-10-244.bb.netvision.net.il. [93.172.10.244])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906648300b006f3ef214e12sm7197154ejm.120.2022.05.24.05.24.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 24 May 2022 05:24:02 -0700 (PDT)
Message-ID: <628CCE44.6020007@gmail.com>
Date:   Tue, 24 May 2022 15:23:32 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Zheyu Ma <zheyuma97@gmail.com>, arnd@arndb.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] char: xillybus: Check endpoint type before allocing
References: <Yn9XwHxWsLIJXlHu@kroah.com> <20220514114819.2773691-1-zheyuma97@gmail.com> <Yn+va5fTsuaFTxVR@kroah.com> <CAMhUBj=RMJwn2K+rQC9rQ=QEe5QkiJ29rMd8KzEC8B7vtXo+ug@mail.gmail.com> <Yocp+WZ0On9/wObu@kroah.com> <CAMhUBj=J5-V_D_kucpiWz6ZdOSSR1N9nRXQxOKgmwRA+LxW17Q@mail.gmail.com> <YouxHY48daZt7J/O@kroah.com> <628BBEEB.9010306@gmail.com> <YovBOwJs/A/5Ua7I@kroah.com>
In-Reply-To: <YovBOwJs/A/5Ua7I@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/22 20:15, Greg KH wrote:
>> Rather, it works like this: The driver uses the EP 1 IN and OUT endpoints to
>> >  query the device for a data structure, which contains information on the
>> >  device's communication channels. The driver sets up device files
>> >  accordingly, and it also gets informed on which bulk OUT endpoints are
>> >  present.
>> >  
>> >  For what it's worth, I think it's fairly safe to assume that if a device
>> >  returns a legal data structure (which passes a CRC test), it's a XillyUSB
>> >  device.
>>      
> Why?  You still need to verify that the requested endpoints match up
> with what the device really has.
>    
OK. So to summarize:

EP 1 IN and EP 1 OUT are always present in XillyUSB devices.

On top of these, there might be additional bulk OUT endpoints. The 
driver resolves which ones in setup_channels(), by scanning a data blob 
it has received from the device. This takes place in the for-loop inside 
this function. When (out_desc & 0x80) is true for a given @i in the 
loop, the device has a bulk OUT endpoint with address i+2 (e.g. if this 
condition is met for i==2, the device has a bulk OUT EP 4).

So it seems like setup_channels() would be the right place to make this 
check, since it's called during the device's probe.

I guess it would likewise make sense to check for EP 1 IN and OUT in 
xillyusb_setup_base_eps().

Thanks,
    Eli



