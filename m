Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25FB502E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbiDOSIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345150AbiDOSHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:07:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613D258E40
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 11:05:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id t11so16473458eju.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V+W9l6BKZBr+oXtIh0PfdYIfqQsWRrtO76Ly+G8v6Fo=;
        b=kAXsh62LEXygSaqiO6lGmD60/VERChTI2sQ9QJkSDYxrEUMO/GAnj4lqz5kWNVRSDV
         MSh63N7iXOJyru9e10kfd/X9y6yrdrOCKBtMiIiYVuPvnZXl4OO8hbhgGiUBLQN4RfDH
         rYoM7VwAkOjHW4X3ASfgqGftUS9D5eHHQam5aC7eLpwEedCjoTCX46hDUJO2yWEapQ2q
         6n4R6aQ9kNZ6FXumoBV7yWHPMgvlqE37YU3dCnHbdnYEaB7TTQbrGh/UJT+th46wGAFY
         SfZ1j0WuOFPKChqwZaY4OG+Vsp2L42Q4cVTaBrcdbQD3fT17PiBVst267O9c3BALmTey
         F2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V+W9l6BKZBr+oXtIh0PfdYIfqQsWRrtO76Ly+G8v6Fo=;
        b=KLySxMlCSzgPCF7S/0DgWvAQ12I9cTC9OHkIKn3bkN58n4PjWkpK5HWzBDWROsyHTj
         hgo4lbIUOQRRDV4Lk5Dw941C6GDFyC1d4qIz2YEpL6j/jP6T8P/k9unk9CCQJx66b8Lo
         71w9M16y8/CqsPOGBlTyXH0+9IwGrElrEXNDRu6M4G85vVIxCxTnr0PNX04p6gqXzXbt
         78LFeJxbiDiN4+crl/t2hbVnFO3Lx/nA0DCnaTnmwndRnFuCLiJiWcg4r8ZofDIw6k1C
         bl96ovUub/sq6Fe+y5HLje9ZvE20OwyC1RMKI6+jIPcz1NKoM5nQOXbYcgPZBbtj5m9L
         dXbg==
X-Gm-Message-State: AOAM531CnNwGh6pKQR7kkni9GA+ooM5WdSRv0Wr3DwSMp0xPWy8XlNae
        r4eL3nobG2/rClUPDWQKlXI=
X-Google-Smtp-Source: ABdhPJxspEP9XE7GYyLM0SAEIEBi0G4A6rqaVqGiSHHBuwgl4oKJy++C4PRqUjQ8/+88adr+x6kDkw==
X-Received: by 2002:a17:906:1411:b0:6da:f354:fb83 with SMTP id p17-20020a170906141100b006daf354fb83mr204027ejc.539.1650045924856;
        Fri, 15 Apr 2022 11:05:24 -0700 (PDT)
Received: from [192.168.0.151] (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id y14-20020a056402440e00b00416046b623csm3150282eda.2.2022.04.15.11.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 11:05:24 -0700 (PDT)
Message-ID: <bd1b3310-3867-5b3c-cce1-cdb374b3d819@gmail.com>
Date:   Fri, 15 Apr 2022 20:05:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/8] staging: r8188eu: clean up comments in struct
 rt_firmware_hdr
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220415121023.11564-1-straube.linux@gmail.com>
 <20220415121023.11564-4-straube.linux@gmail.com>
 <f4f8d381-9ee1-c504-c41c-97a9332066c9@lwfinger.net>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <f4f8d381-9ee1-c504-c41c-97a9332066c9@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/22 17:44, Larry Finger wrote:
> On 4/15/22 07:10, Michael Straube wrote:
>> The comments in struct rt_firmware_hdr are not needed.
>> Remove them.
>>
>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>> ---
>> v3:
>> - no changes
>>
>> v2:
>> - no changes
>>
>>   drivers/staging/r8188eu/core/rtw_fw.c | 37 ++++++++-------------------
>>   1 file changed, 11 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/core/rtw_fw.c 
>> b/drivers/staging/r8188eu/core/rtw_fw.c
>> index 7cd08268f3b9..323e0c634c4e 100644
>> --- a/drivers/staging/r8188eu/core/rtw_fw.c
>> +++ b/drivers/staging/r8188eu/core/rtw_fw.c
>> @@ -14,37 +14,22 @@
>>       (le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x2300 ||    \
>>       (le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88E0)
>> -/*  This structure must be careful with byte-ordering */
>> -
>>   struct rt_firmware_hdr {
>> -    /*  8-byte alinment required */
>> -    /*  LONG WORD 0 ---- */
>> -    __le16        Signature;    /* 92C0: test chip; 92C,
>> -                     * 88C0: test chip; 88C1: MP A-cut;
>> -                     * 92C1: MP A-cut */
>> -    u8        Category;    /*  AP/NIC and USB/PCI */
>> -    u8        Function;    /*  Reserved for different FW function
>> -                     *  indcation, for further use when
>> -                     *  driver needs to download different
>> -                     *  FW for different conditions */
>> -    __le16        Version;    /*  FW Version */
>> -    u8        Subversion;    /*  FW Subversion, default 0x00 */
>> +    __le16        Signature;
>> +    u8        Category;
>> +    u8        Function;
>> +    __le16        Version;
>> +    u8        Subversion;
>>       u8        Rsvd1;
>> -
>> -    /*  LONG WORD 1 ---- */
>> -    u8        Month;    /*  Release time Month field */
>> -    u8        Date;    /*  Release time Date field */
>> -    u8        Hour;    /*  Release time Hour field */
>> -    u8        Minute;    /*  Release time Minute field */
>> -    __le16        RamCodeSize;    /*  The size of RAM code */
>> +    u8        Month;
>> +    u8        Date;
>> +    u8        Hour;
>> +    u8        Minute;
>> +    __le16        RamCodeSize;
>>       u8        Foundry;
>>       u8        Rsvd2;
>> -
>> -    /*  LONG WORD 2 ---- */
>> -    __le32        SvnIdx;    /*  The SVN entry index */
>> +    __le32        SvnIdx;
>>       __le32        Rsvd3;
>> -
>> -    /*  LONG WORD 3 ---- */
>>       __le32        Rsvd4;
>>       __le32        Rsvd5;
>>   };
> 
> The comments "LONG WORD" are useless, but the comments describing the 
> fields are still useful. I do not like this patch.
> 

Hi Larry,

You are right the in-line comments are useful. I'll send v4 keeping
them.

You only mentioned the in-line comments, just to get it right this
time:

What about the "8-byte alignment required" comment? You said in another
thread that the __le16 references need alignment 4. Should I make the
struct __aligned(8) or at least __aligned(4)?

And about "/*  This structure must be careful with byte-ordering */" ?
I think it's obvious because of the __le16 and __le32 fields and can be
removed. Do you agree on that?

regards,
Michael
