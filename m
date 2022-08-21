Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2CD59B65A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 22:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiHUUmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 16:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiHUUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 16:42:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D2A20BDC
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 13:42:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u6so6471746eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ytg8wSZWOCPe4CnccRBrta8ht+qokdOShIMsqXvGJ6M=;
        b=fA4aQHscI2shQHYOmnR2Xwx9+obNj9UZEMeJ25/SilaPMP2o4EeIxRVnvZ33838bCE
         J1tS1GtgsaEsfoIBiyccXKGKhK/wBYJrOOWZ9SzOqeMHpsVws9k98hpGRJayHRVwi4+x
         SEBG2kfPrvvStksM9ezhdWZ5h4EmXo8FSbQP4XcewnFWQkzxS4xqGflf+YBIjZI7g1P9
         peW1GRxt5455Eyuz4IhHcPkBsCkqakS86gr+KV8JgEUqcom6yvxPN8L+U3GskUdV026P
         U4p3SGlMxLHWrYM9d9CpAN7+GhmU2DwOc66bkn5CE6fuFXWwE9RbGnrAHzsIFjNWg03I
         XvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ytg8wSZWOCPe4CnccRBrta8ht+qokdOShIMsqXvGJ6M=;
        b=gIhMRKV5ISQ9w8ncwFevJNn7Ykwk82A3eQ7+Inx7Lv493m6DLpKIOzMMaTwhvm5t1t
         jHFvpNTxLu/3AvNSy18WTclLrM2bDPbQqDyUScEwFd39EHDCARGb76EajFgUvpqshg17
         5QTRF4OTtY4Ejhjgmt8RSVMclQEBSD7uYfXyvB2GQq9YUXm710xyts19MILetNC8L5jn
         BzH7oVqTtGuVfN8B+KbVbAdApjetsIBxlTSPkWcfCDnXaIvnwgzlQ5zcOtAcyQVK8nQX
         dZ3VYK1KVawMJ6t3e3PYmP7oCeVDcP2pfdEkXHFRPOlbIodRg7rUgRO1DHnzKYYKGONA
         YkNA==
X-Gm-Message-State: ACgBeo1ZBBmLeh0I3AMcFsgdgDuKZzAWlYS5ie9YBmD6DbO+j46a327B
        yrNYEs1XHqlzWKRXX26s2XJVoybRLwg=
X-Google-Smtp-Source: AA6agR7qpCNzQzmCRrNEZwFdei0N+XLYeIXXTa0wS+9st54BOP5Dme5For9yHUcY3r3LnbjyCxcf5g==
X-Received: by 2002:a05:6402:7c8:b0:445:ce63:7ab0 with SMTP id u8-20020a05640207c800b00445ce637ab0mr13671231edy.8.1661114521994;
        Sun, 21 Aug 2022 13:42:01 -0700 (PDT)
Received: from [192.168.0.100] (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id ss2-20020a170907c00200b0072f42ca292bsm5123226ejc.129.2022.08.21.13.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Aug 2022 13:42:01 -0700 (PDT)
Message-ID: <052337eb-e1d5-2d91-7288-25db08c89016@gmail.com>
Date:   Sun, 21 Aug 2022 22:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 01/19] staging: r8188eu: make rtw_remainder_len() static
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220820181623.12497-1-straube.linux@gmail.com>
 <20220820181623.12497-2-straube.linux@gmail.com>
 <bdbe8b77-4847-196c-a2f9-ccc779ff8d5b@gmail.com>
Content-Language: en-US
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <bdbe8b77-4847-196c-a2f9-ccc779ff8d5b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/22 21:57, Philipp Hortmann wrote:
> On 8/20/22 20:16, Michael Straube wrote:
>> The function rtw_remainder_len() is only used in xmit_linux.c.
>> Make it static.
>>
>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>> ---
>>   drivers/staging/r8188eu/include/xmit_osdep.h | 1 -
>>   drivers/staging/r8188eu/os_dep/xmit_linux.c  | 2 +-
>>   2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h 
>> b/drivers/staging/r8188eu/include/xmit_osdep.h
>> index 130dc06efe73..55347de455c8 100644
>> --- a/drivers/staging/r8188eu/include/xmit_osdep.h
>> +++ b/drivers/staging/r8188eu/include/xmit_osdep.h
>> @@ -37,7 +37,6 @@ int rtw_os_xmit_resource_alloc(struct adapter 
>> *padapter,
>>   void rtw_os_xmit_resource_free(struct adapter *padapter,
>>                      struct xmit_buf *pxmitbuf, u32 free_sz);
>> -uint rtw_remainder_len(struct pkt_file *pfile);
>>   void _rtw_open_pktfile(struct sk_buff *pkt, struct pkt_file *pfile);
>>   uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen);
>> diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c 
>> b/drivers/staging/r8188eu/os_dep/xmit_linux.c
>> index 85ef27735b88..33400a9b08e1 100644
>> --- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
>> +++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
>> @@ -11,7 +11,7 @@
>>   #include "../include/osdep_intf.h"
>>   #include "../include/usb_osintf.h"
>> -uint rtw_remainder_len(struct pkt_file *pfile)
>> +static uint rtw_remainder_len(struct pkt_file *pfile)
>>   {
>>       return pfile->buf_len - ((size_t)(pfile->cur_addr) -
>>              (size_t)(pfile->buf_start));
> 
> Hi Michael,
> 
> cannot apply your patch on top of the patch series(11),
> [PATCH] staging: r8188eu: remove ODM_ConfigRFWithHeaderFile()
> 
> cat ~/Downloads/\[PATCH\ 01_19\]\ staging\ r8188eu\ make\ 
> rtw_remainder_len\(\)\ static.eml | git am
> Applying: staging: r8188eu: make rtw_remainder_len() static
> error: patch failed: drivers/staging/r8188eu/include/xmit_osdep.h:37
> error: drivers/staging/r8188eu/include/xmit_osdep.h: patch does not apply
> Patch failed at 0001 staging: r8188eu: make rtw_remainder_len() static
> 
> It looks like it should fit but it does not. Have you changed something 
> manual in the patch?
> 
> Thanks for your support.
> 
> Bye Philipp
> 

Hi Philipp,

looks like you didn't apply

[PATCH] staging: r8188eu: remove rtw_endofpktfile()

first. On top of that it should work.
I mentioned that in the cover letter. ;)

thanks,
Michael
