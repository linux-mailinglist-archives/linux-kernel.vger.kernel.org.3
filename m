Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E02F595230
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiHPFvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiHPFvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:51:18 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759F613790E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:52:10 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h78so1850519iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=3dmOD03BwYXBud0lxKQcHHjg16Ss2/ECnEAwc3JbiOU=;
        b=NAyapcRJQGYTxs+U6LVEuGjzxrPfHm8EZ0ZM5HppHmscYE94CPP1HuwLjttVJY68Wo
         ygzyarPH1oN10pyr3e3R2XQ03uwuJlnJ8Q5/JNuoK1PlpmItwg5bw7b8/Vv2i4IffBRE
         cTGzAcOlwRbvcJDUro83ybc2zBGXjo6TklaY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=3dmOD03BwYXBud0lxKQcHHjg16Ss2/ECnEAwc3JbiOU=;
        b=4Ov3BgZrlW4PKZj+EufL0m+HMhNdqrC+rUK2tJ0wr+Q9otG4RE4Kh8B34LhvWmv0F+
         0ObBDlIVOtFPny9XAJgzM4W9vrDQ+LubYImVEIGa2oWOjwWbllBVl5BcOWq2phm6k3Pb
         RnrUzjKDlHKBe6+Tmz4uS/QvUhZTuxcR7rntCIhBzFSqlVBgNIs1PjItabfHp/f8oXMr
         gEjOR63F9ORjjBjnrlsoMJwqHtnuZUjPTU1IG6SSuaMpBx6YDwK2Nvci/aWysPxqkkT3
         xf8PpinOELX+MVA6u8a8TBGXSX50o/ymzGUx1wGaG8wm3rForw/THCAHnPczpM6lFPmx
         jcvw==
X-Gm-Message-State: ACgBeo0GJct04vK0IoTZoJkLeOQ7JE9WaROzhO+KToC6zKSCdwvR7loc
        2+04zGQ1Ah7GVLeT0QpMvkQk3w==
X-Google-Smtp-Source: AA6agR6UARi1oa+pE1di/e0n6PH8IX32F67Nis5Cu6bmxz46ZQ+1wfihHxQcWCedvvZE3s0pCXX1/A==
X-Received: by 2002:a05:6602:148b:b0:657:c59b:f336 with SMTP id a11-20020a056602148b00b00657c59bf336mr7470342iow.141.1660603921283;
        Mon, 15 Aug 2022 15:52:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q55-20020a056638347700b00343617e8368sm3720770jav.99.2022.08.15.15.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 15:52:00 -0700 (PDT)
Subject: Re: [PATCH v2] selftests/sgx: Ignore OpenSSL 3.0 deprecated functions
 warning
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-sgx@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220812180714.566257-1-kristen@linux.intel.com>
 <YvlLYtbmAM2Hrtds@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <deb34fb5-3620-a817-341e-b6ef601201c6@linuxfoundation.org>
Date:   Mon, 15 Aug 2022 16:51:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YvlLYtbmAM2Hrtds@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/22 1:22 PM, Jarkko Sakkinen wrote:
> On Fri, Aug 12, 2022 at 11:07:13AM -0700, Kristen Carlson Accardi wrote:
>> OpenSSL 3.0 deprecates some of the functions used in the SGX
>> selftests, causing build errors on new distros. For now ignore
>> the warnings until support for the functions is no longer
>> available and mark FIXME so that it can be clear this should
>> be removed at some point.
>>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> ---
>>   tools/testing/selftests/sgx/sigstruct.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
>> index 50c5ab1aa6fa..a07896a46364 100644
>> --- a/tools/testing/selftests/sgx/sigstruct.c
>> +++ b/tools/testing/selftests/sgx/sigstruct.c
>> @@ -17,6 +17,12 @@
>>   #include "defines.h"
>>   #include "main.h"
>>   
>> +/*
>> + * FIXME: OpenSSL 3.0 has deprecated some functions. For now just ignore
>> + * the warnings.
>> + */
>> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
>> +
>>   struct q1q2_ctx {
>>   	BN_CTX *bn_ctx;
>>   	BIGNUM *m;
>> -- 
>> 2.36.1
>>
> 
> Thank you.
> 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BR, Jarkko
> 

Thank you both.

Applied for rc2/3

thanks,
-- Shuah
