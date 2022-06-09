Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B16D54537C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbiFIRxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbiFIRxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:53:48 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754F3C03B5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:53:47 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id k4so11103058qth.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2kRCg7jfZbNe6bJP4sibSBG8ecFrRsFT6lBc3lrtvo8=;
        b=NV/PjGmZKmuIfQZ2ub9FV1Tum2LdaiQHgV5NBaGoEJksprsGBxHHBxO6KTcv2HygcF
         c7VL1A7hZWQm1Q8bOyxjyPwhFtbl0GJQCBf9sY6/qDyHWxBTpC/z9kcHbUyvfG8GOqqd
         0/pmHz1/9EmRgBML0oCOQ8XFsGC45VRhY2ZJg5MFNZYfOge1lfFfAeZBzAdNj59vv+cL
         qdazj+ampYjyvLfh3If3GJM3hocnvBdH9Ekii+/2v4X9Vb7Kopsvrl54gUdqcqm6iy+i
         kNqSbLrIcxpSHQE4T17CiTS6gcrrzDnxzZnIfClVznr4f1qVqZvWrBMCwViyq74KKTa5
         8EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2kRCg7jfZbNe6bJP4sibSBG8ecFrRsFT6lBc3lrtvo8=;
        b=S4OfwcNGzmw6a8c+hInu8ziOLuN2k1QOEtmlqnjo441HoRyrMFXAeKFaF3s03LgD5n
         +bFBjmvmE50uNR69VWDG7tgjJ9byxWT1BQm0BVqzkIUyUOzD6/lFdSN/9JQ2yXw+HZOa
         99fXNTacFXxs/aRl/a26DwmYm1ZiwNlpnhaiGl3hpj+vO3jLmdh3KQuslU+nvKwDNi+F
         x4eYpWTVC8RAC8jjo/Qne0Ezz3gIjtSGzBgr7U8/25+k7mMTA/CyNmbsFTdIFYJ1vUez
         VwIKdFSiXvwgtGQJ5UEVZn4bta1E6Rsjzok+YIUtjzzr4HPsB8TunHmRWalVgDEIx0NZ
         hx5w==
X-Gm-Message-State: AOAM533hkDuKCi6ITiM6SooCShobBkxE1/ZWVFgrhFB03dnJI9T9gXos
        Vx61NqqAVomiSAom7FDzsQ==
X-Google-Smtp-Source: ABdhPJxmeVGgDMz928JH1SCmLgxdxGhJR/g79AdRdwcJXOushyxWm+xvL/aGJlbZBZyI3u4w8HXFKw==
X-Received: by 2002:ac8:5c14:0:b0:2f9:38d7:b095 with SMTP id i20-20020ac85c14000000b002f938d7b095mr33723637qti.83.1654797226476;
        Thu, 09 Jun 2022 10:53:46 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id f28-20020ac840dc000000b00304d8ddf416sm17011871qtm.94.2022.06.09.10.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 10:53:45 -0700 (PDT)
Message-ID: <8fa904e1-f94f-9f7a-fe1b-fcb6ada6b321@gmail.com>
Date:   Thu, 9 Jun 2022 13:53:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 02/33] lib/string_helpers: Convert string_escape_mem()
 to printbuf
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
 <20220604193042.1674951-3-kent.overstreet@gmail.com> <YqIC4AWW0bF7nOGu@alley>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <YqIC4AWW0bF7nOGu@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 10:25, Petr Mladek wrote:
> On Sat 2022-06-04 15:30:11, Kent Overstreet wrote:
>> Like the upcoming vsprintf.c conversion, this converts string_escape_mem
>> to prt_escaped_string(), which uses and outputs to a printbuf, and makes
>> string_escape_mem() a smaller wrapper to support existing users.
>>
>> The new printbuf helpers greatly simplify the code.
>>
>> --- a/lib/string_helpers.c
>> +++ b/lib/string_helpers.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/fs.h>
>>   #include <linux/limits.h>
>>   #include <linux/mm.h>
>> +#include <linux/printbuf.h>
>>   #include <linux/slab.h>
>>   #include <linux/string.h>
>>   #include <linux/string_helpers.h>
>> @@ -301,19 +302,14 @@ int string_unescape(char *src, char *dst, size_t size, unsigned int flags)
>>   }
>>   EXPORT_SYMBOL(string_unescape);
>>   
>> -static bool escape_passthrough(unsigned char c, char **dst, char *end)
>> +static bool escape_passthrough(struct printbuf *out, unsigned char c)
>>   {
>> -	char *out = *dst;
>> -
>> -	if (out < end)
>> -		*out = c;
>> -	*dst = out + 1;
>> +	prt_char(out, c);
> 
> This modifies the behavior. The original code did not add
> the trailing '\0'.
> 
> I agree that the original behavior is ugly but it is documented
> see the comment:
> 
>   * Return:
>   * The total size of the escaped output that would be generated for
>   * the given input and flags. To check whether the output was
>   * truncated, compare the return value to osz. There is room left in
>   * dst for a '\0' terminator if and only if ret < osz.
>                               ^^^^^^^^^^^^^^
> 
> 
> I am all for changing the behavior but it would require checking
> all callers.
> 
> Anyway, adding the trailing '\0' all is not much effective.
> I suggest to use __prt_char() and add the trailing '\0' when
> the string is complete.
> 
> We must make sure that __prt_char() is able to add the last
> character even when there will not longer be space for
> the trailing '\0'.

You really think there's going to be code depending on an _absence_ of a 
trailing nul? I should've updated the comment (I missed that originally, 
doing it now) - but this seems excessively nitpicky.

And I'm looking at the callers now:
  - seq_file, which doesn't commit the results if it overflowed the buffer
  - net/sunrpc/cache.c, which also appears to turn an overflow into an error

and that's it, aside from test cases.

The nul termination is an explicit thing: as I convert to printbuf, I 
don't want functions that output to printbufs returning printbufs that 
aren't nul terminated unless explicitly documented - and there's no 
reason to be doing this except for a few fast path helpers.

> 
>> +int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
>> +		      unsigned int flags, const char *only)
> 
> We need keep the comment above this API as long as it is public.

Will do.
