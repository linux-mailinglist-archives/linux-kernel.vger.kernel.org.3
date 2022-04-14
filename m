Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B132B500AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbiDNKKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiDNKKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:10:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3CE716C5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:08:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r13so9077585ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fxIhTmf4CWwgx4woI1aX8OoMYh4gMjGvc4MZCp2yYgw=;
        b=YEKEdaK2CtEeQIFtsW5Q9Pc+PQj3VAR5YyF343GhApd9CcPVM5ZO9W4aORRt64cOKy
         Ds/mV9HlUsuLDZTZ7K0DrdCW7osI8ZAk0VMdjMen+qb99ZJdTFxYrOr17AKRp/dOmhdM
         vWhaHluFNt7+cnI1ZOz2ZjJ3OwjNMq2SM8qdQcdLda/y6/xSKElR5E0jlO6wittIJOKW
         c2tg4tp4S1FIhuRxuSLb1udomqgKf6HFw6RkBYXF4Wj1+/IIhn+JnrUFYDXd8wybRFQx
         imGIB2kxPw5hJ3i9nXJ2x3r20q/1cTLN7OjJGVuyboGvJF/fXZ4sULOMve5G1jjmkxSz
         KZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fxIhTmf4CWwgx4woI1aX8OoMYh4gMjGvc4MZCp2yYgw=;
        b=QzPpti3yk6f7TIK2lMiarmWUi1oBhRwuRn84Nlb+1dBRk28ZtYENDKyywzrjFIH+Eb
         qxAbn3c6+8pkYmiBwyE7Ye202v8ThUXf24lPEaiPb2EyFcPQFQ8oSBJih17u8wc6RrZ2
         XI5+EIwQbVb+h8MbJZRLjF+YceSx7DXCoKlNEdtmrAHw2CMxHB54byCm5AzEuq0+2f9S
         pCTna0YYdvmupXE63I2ai1Lh9OXnuK9qKoE7XVxMm/jaK96NeilN+88gxEJA70jQlvfG
         4kzhFQsyydjVcoUkxMHI0eeDl72lXY/uzOvuRU16/gISw2rT5x2dPYTy+uwpZAilyPq5
         3ttQ==
X-Gm-Message-State: AOAM532sWzPVgA+5jTU1fqc5lh6s5Q7XHXPUZbEc7je1sxkGCd9uDmOu
        hT7qUiMSvBH9UvloGz5vSl0=
X-Google-Smtp-Source: ABdhPJzETc4xu/QQjnhJjmC9SJlm5H2LrT29xVTSDmNt4irFWyS6PjTXFtlJN0fbXqk6uljkSqfdBw==
X-Received: by 2002:a17:907:3e90:b0:6e8:7fbb:a15c with SMTP id hs16-20020a1709073e9000b006e87fbba15cmr1614234ejc.411.1649930882723;
        Thu, 14 Apr 2022 03:08:02 -0700 (PDT)
Received: from [192.168.0.151] (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id qb10-20020a1709077e8a00b006e892cf471asm471890ejc.84.2022.04.14.03.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 03:08:02 -0700 (PDT)
Message-ID: <a40a2a1b-a8f1-e720-be92-48858d4f6678@gmail.com>
Date:   Thu, 14 Apr 2022 12:08:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: struct rt_firmware_header issues
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <94a72ecc-3acd-758b-15a4-a7d56bf03fbe@gmail.com>
 <86a66ea4-45e3-cfa2-9130-f698ae212bfd@gmail.com>
 <51e706400b914552bfda6353020da17e@AcuMS.aculab.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <51e706400b914552bfda6353020da17e@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 10:41, David Laight wrote:
> From: Michael Straube
>> Sent: 13 April 2022 20:42
>>
>> On 4/13/22 18:27, Michael Straube wrote:
>>> Hi all,
>>>
>>> I think the rt_firmware_hdr structure in rtw_fw.c has some issues.
>>>
>>>
>>> struct rt_firmware_hdr {
>>>       /*  8-byte alinment required */
> 
> Probably need an __aligned(8) at the bottom then?

I don't see any reason why this is needed. Do I miss something?

>>>       /*  LONG WORD 0 ---- */
>>>       __le16        Signature;    /* 92C0: test chip; 92C,
>>>                        * 88C0: test chip; 88C1: MP A-cut;
>>>                        * 92C1: MP A-cut */
>>>       u8        Category;    /*  AP/NIC and USB/PCI */
>>>       u8        Function;    /*  Reserved for different FW function
>>>                        *  indcation, for further use when
>>>                        *  driver needs to download different
>>>                        *  FW for different conditions */
>>>       __le16        Version;    /*  FW Version */
>>>       u8        Subversion;    /*  FW Subversion, default 0x00 */
>>>       u16        Rsvd1;
>>>
>>>       /*  LONG WORD 1 ---- */
>>>       u8        Month;    /*  Release time Month field */
>>>       u8        Date;    /*  Release time Date field */
>>>       u8        Hour;    /*  Release time Hour field */
>>>       u8        Minute;    /*  Release time Minute field */
>>>       __le16        RamCodeSize;    /*  The size of RAM code */
>>>       u8        Foundry;
>>>       u8        Rsvd2;
>>>
>>>       /*  LONG WORD 2 ---- */
>>>       __le32        SvnIdx;    /*  The SVN entry index */
>>>       u32        Rsvd3;
>>>
>>>       /*  LONG WORD 3 ---- */
>>>       u32        Rsvd4;
>>>       u32        Rsvd5;
>>> };
> ...
>>
>> Ok, I figured it out by looking at the hexdumps of firmware files. The
>> field Rsvd1 should be u8 instead of u16. I'll prepare a patch for this.
> 
> I'd also add a compile-time assert on the size.

I'll add a patch to the series I recently sent.

thanks,
Michael
