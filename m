Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C42250012A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiDMV2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiDMV2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:28:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DFD83B2C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:26:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g20so3990800edw.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V+de/3rFVxjb/70osv7B8X0g+dhZzorG7fYSV2qc3+Q=;
        b=CpSwhRjsUPV7LtAZ7mAkOTPgIl9OZI3uiR1uXZejO6jU0NSoLh/gmYcAeIC1xtV1w7
         VyCCaa3zmf0L69rqd2TiVftBbLjBySXbPKtDWDvL/JFZIiUN1sF5OGmhY+3e20GVD9wQ
         ArPXxyndGrosMYh75OaycUrgtXtAK2FvZo9SmF/SYTJvXlt1BBkQJ5+3kKj+JmBw8u7s
         4ZFgS67OxhfVuAdCsBtgjQO9i2osXfJNC+x2YlnaVGkJhzaCNCnILVpO9BvoTLlL+mQQ
         FtvcmMGHYYaMxLSj58cGTXWynIiNeUfFdLi752PhPHhb3w1Ac4acHXvjLC6GVRHcCpJc
         RBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V+de/3rFVxjb/70osv7B8X0g+dhZzorG7fYSV2qc3+Q=;
        b=3c6sG353fVQpof2o5ppmig5FjRhPQgfuBwdJMy6RcnpyN19yrFFvJc/wzBJJrDmf9n
         o3Pk3UW5UPKvBQewyXwdYur7zIIe0u11sM9oTqzLVWxJJ1VRExYHRYoyy0qhRtxkUguP
         oNNzijWWbxyJZXHCTNVFh21+LzVPaPYjqkmHUGyZ7xoS6XK4bIrCk5tkLwHXZpkwNTgt
         llXqa3El51r/eh7a+klj/ot5rjusc6KFSOjXJzQobQce78/xjsnBRETmqmeFN9f03ioT
         ze0vYuiAPIVBYNmU+J9rhSsSnKV3nzrmipgf/to30xH7SD8IP3cB2XHmFH9UJVFqjjVq
         Qpkg==
X-Gm-Message-State: AOAM5316onUsy+XOlZfMneCtMf1eEVkW0KH9ROts5j+Wwl987Ko3V1qU
        qgg9U1C3oSmILXULqWmWylg=
X-Google-Smtp-Source: ABdhPJxPuSqTitAffOMeegBCsguAek7BLb7dfXR3wSoVOg5Vy6rerzuFEu+81q1mopOFmrCaoxwcSw==
X-Received: by 2002:a05:6402:5146:b0:415:fd95:6afa with SMTP id n6-20020a056402514600b00415fd956afamr46054987edd.200.1649885172219;
        Wed, 13 Apr 2022 14:26:12 -0700 (PDT)
Received: from [192.168.0.151] (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id n14-20020a50934e000000b0042053e79386sm29270eda.91.2022.04.13.14.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 14:26:11 -0700 (PDT)
Message-ID: <f3063c1c-a9c4-336e-2ace-2802f707d3cb@gmail.com>
Date:   Wed, 13 Apr 2022 23:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: struct rt_firmware_header issues
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <94a72ecc-3acd-758b-15a4-a7d56bf03fbe@gmail.com>
 <f819690c-b53e-4693-5de1-cc4cfa1db0da@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <f819690c-b53e-4693-5de1-cc4cfa1db0da@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 22:58, Pavel Skripkin wrote:
> Hi Michael,
> 
> On 4/13/22 19:27, Michael Straube wrote:
>> Hi all,
>>
>> I think the rt_firmware_hdr structure in rtw_fw.c has some issues.
>>
>>
>> struct rt_firmware_hdr {
>>     /*  8-byte alinment required */
>>     /*  LONG WORD 0 ---- */
>>     __le16        Signature;    /* 92C0: test chip; 92C,
>>                      * 88C0: test chip; 88C1: MP A-cut;
>>                      * 92C1: MP A-cut */
>>     u8        Category;    /*  AP/NIC and USB/PCI */
>>     u8        Function;    /*  Reserved for different FW function
>>                      *  indcation, for further use when
>>                      *  driver needs to download different
>>                      *  FW for different conditions */
>>     __le16        Version;    /*  FW Version */
>>     u8        Subversion;    /*  FW Subversion, default 0x00 */
>>     u16        Rsvd1;
>>
>>     /*  LONG WORD 1 ---- */
>>     u8        Month;    /*  Release time Month field */
>>     u8        Date;    /*  Release time Date field */
>>     u8        Hour;    /*  Release time Hour field */
>>     u8        Minute;    /*  Release time Minute field */
>>     __le16        RamCodeSize;    /*  The size of RAM code */
>>     u8        Foundry;
>>     u8        Rsvd2;
>>
>>     /*  LONG WORD 2 ---- */
>>     __le32        SvnIdx;    /*  The SVN entry index */
>>     u32        Rsvd3;
>>
>>     /*  LONG WORD 3 ---- */
>>     u32        Rsvd4;
>>     u32        Rsvd5;
>> };
>>
>>
>> Then we have in rtl8188e_firmware_download():
>>
>>
>>     fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
>>
>>     <snip>
>>
>>     if (IS_FW_HEADER_EXIST(fwhdr)) {
>>         /*  Shift 32 bytes for FW header */
>>         fw_data = fw_data + 32;
>>         fw_size = fw_size - 32;
>>     }
>>
>> We add/sub 32 bytes but the size of struct rt_firmware_hdr is actually
>> 33 bytes. I noticed this when I wanted to replace:
>>
> 
> Looks like size of that structure is 36
> 
> └──$ pahole -C rt_firmware_hdr r8188eu.ko
> struct rt_firmware_hdr {
>      __le16                     Signature;            /*     0     2 */
>      u8                         Category;             /*     2     1 */
>      u8                         Function;             /*     3     1 */
>      __le16                     Version;              /*     4     2 */
>       u8                         Subversion;           /*     6     1 */
> 
>       /* XXX 1 byte hole, try to pack */
> 
>       u16                        Rsvd1;                /*     8     2 */
>       u8                         Month;                /*    10     1 */
>       u8                         Date;                 /*    11     1 */
>       u8                         Hour;                 /*    12     1 */
>       u8                         Minute;               /*    13     1 */
>       __le16                     RamCodeSize;          /*    14     2 */
>       u8                         Foundry;              /*    16     1 */
>       u8                         Rsvd2;                /*    17     1 */
> 
>       /* XXX 2 bytes hole, try to pack */
> 
>       __le32                     SvnIdx;               /*    20     4 */
>       u32                        Rsvd3;                /*    24     4 */
>       u32                        Rsvd4;                /*    28     4 */
>       u32                        Rsvd5;                /*    32     4 */
> 
>       /* size: 36, cachelines: 1, members: 17 */
>       /* sum members: 33, holes: 2, sum holes: 3 */
>       /* last cacheline: 36 bytes */
>   };
> 
> 
> And these comments like 'LONG WORD 1' looks misleading, maybe worth 
> removing.
> 
> 
>>         fw_data = fw_data + 32;
>>         fw_size = fw_size - 32;
>>
>> with:
>>         fw_data = fw_data + sizeof(struct rt_firmware_hdr);
>>         fw_size = fw_size - sizeof(struct rt_firmware_hdr);;
>>
>> To me it looks add/sub 32 is correct here but the struct is
>> wrong. I don't know if the firmware for this driver is so much different
>> from firmware for the drivers in drivers/net/wireless/realtek/rtlwifi.
>> They use a struct of size 32.
>>
> 
> I am not sure about 32... Why non-packed structures are passed via 
> wires? Maybe `__packed` is missing? Is realtek fw open-source?
> 
> Just thoughts.
> 
>> Also, souldn't the u16 and u32 variables in the struct be __le16 and
>> __le32 ?
>>
>> I wonder if we can just use the rtlwifi_firmware_header structure from
>> drivers/net/wireless/realtek/rtlwifi/wifi.h ?
>>
> 
> We _should_ use it, since its size is indeed 32 bytes.
> 
> └──$ pahole -s vmlinux | rg rtlwifi_firmware_header
> rtlwifi_firmware_header    32    0
> 
> 
> Looks like you have found a real bug
> 
> 

Hi Pavel,

I looked at the hexdump of rtl8188eufw.bin and compared it with
rtl8188efw.bin and rtlwifi_firmware_header.

The comparsion showed that Rsvd1 should be u8 instead of u16:

OFFSET      rtl8188eufw.bin
     -----------------------------------------------------------
     0x00000000  E1 88 10 00 0B 00 01  00     01     21    11    27 30 
36 00 00
                                   ^   ^      ^      ^     ^     ^
                          Subversion   Rsvd1  Month  Date  Hour  Minute

So rt_firmware_hdr is wrong, but it had no effect because 32 is
hardcoded here:

	/*  Shift 32 bytes for FW header */
	fw_data = fw_data + 32;
	fw_size = fw_size - 32;

and all fields after Subversion are not used.

regards,
Michael
