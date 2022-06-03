Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AF353C9A6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244128AbiFCMCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241360AbiFCMCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:02:30 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136FA261B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:02:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso11899991pjl.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9xBy4wFvn5xJAaUn+NnronTtWBh/ftM5UxRMYDW/EYg=;
        b=NH9O3UoCSpdTdnjQaS2ULUL/iFc3T+XynkP3zEhKRZ6ESmKk43pHQ5REXixinsWqFK
         WARGm9p0MuUMHR2CNkY4pSfbp8SSm/nSez42JWB9brZdQYCv0YilZZFpuv+xD+6Wbgqv
         V2n9uwMr5KK7WsyTXM/p4qSvHNazRu1KceC/uTcy4J32ioXYaCzyHBn6Lw2C/m5Tl/sP
         DpCetx8nEUKWzp7DV7gVlYidpClLcBvX7dGs7Q6RgOl4XVvms2EePApN0sTprp6lT0VI
         /EDbGxQkInod2UiBjC+fr2PGih7ZWl0FaHKgUyM+TcR/p7K5sMGK2z3NRl5d8/lDgXp8
         V4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9xBy4wFvn5xJAaUn+NnronTtWBh/ftM5UxRMYDW/EYg=;
        b=XPjV/RUXpBe1m8qEKUepfyZsNUV0Yg3E+YWh8N0BneQRfMXnSkwWYuic1qaTf/GZVc
         eQRBAiSRHrFm+FyAa2BKyY9QZuLi4UmHqDYo/p2jC8hs6KcjfNcuWkepSogJBOYcQd3y
         NabjCOwRoMVnO2MfPRCvViX5sJFXuccYRvaw5QSGq8DkzW9/pr+QrnQdvZiv/39OAts9
         4pF/E9+Hhc8Xqf0oFRxx63QCjloH7oo2+kKHZt8fwWqK0et5OPwByZYHS++hMuqm36qE
         jIub4aW2vm3+ifhykrgtO887eGohHWeDyzKsUC2hxpBIgslbTyZpaa4Edmr50BIjWE9G
         z4kQ==
X-Gm-Message-State: AOAM531xTTZzHlmGbXZFOop+90fCjhRhPy/gjgI+bb6Yd66use1Aucf4
        awZnUOXYdREfcIIu7fRVuqf2Hz+ys6u+wRAc
X-Google-Smtp-Source: ABdhPJzJ9NES9xNdg5+Seft2pbfbt8o/L7o09YDCBvzSKZlUgr+nfBzrQ0pVmTxeBg6T6clLWql+jQ==
X-Received: by 2002:a17:90a:5d03:b0:1e0:cc5b:4808 with SMTP id s3-20020a17090a5d0300b001e0cc5b4808mr10789277pji.180.1654257748528;
        Fri, 03 Jun 2022 05:02:28 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.243.30])
        by smtp.gmail.com with ESMTPSA id a5-20020aa79705000000b0051850716942sm5492158pfg.140.2022.06.03.05.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 05:02:28 -0700 (PDT)
Message-ID: <991f7966-0734-36ea-b206-a428620efe41@gmail.com>
Date:   Fri, 3 Jun 2022 17:32:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] char: lp: ensure that index has not exceeded LP_NO
Content-Language: en-US
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     Shreenidhi Shedi <sshedi@vmware.com>, linux-kernel@vger.kernel.org
References: <20220515075455.306082-1-sshedi@vmware.com>
 <64570db1-e9f2-4f23-1d14-3d4b35776bca@gmail.com>
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <64570db1-e9f2-4f23-1d14-3d4b35776bca@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/22 5:27 pm, Shreenidhi Shedi wrote:
> On 15/05/22 1:24 pm, Shreenidhi Shedi wrote:
>> After finishing the loop, index value can be equal to LP_NO and lp_table
>> array is of size LP_NO, so this can end up in accessing an out of bound
>> address in lp_register function.
>>
>> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
>> ---
>>  drivers/char/lp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
>> index bd95aba1f..e61060f3c 100644
>> --- a/drivers/char/lp.c
>> +++ b/drivers/char/lp.c
>> @@ -971,7 +971,7 @@ static void lp_attach(struct parport *port)
>>  			if (port_num[i] == -1)
>>  				break;
>>  
>> -		if (!lp_register(i, port))
>> +		if (i < LP_NO && !lp_register(i, port))
>>  			lp_count++;
>>  		break;
>>  
> 
> Hi Greg and Arnd Bergmann,
> 
> Please review the above changes. Ignore second patch.
> 
> --
> Shedi

Sorry, not the second patch. Ignore the 3rd patch which fixes checkspec.pl warnings.

--
Shedi
