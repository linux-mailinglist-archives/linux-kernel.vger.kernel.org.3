Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D715A5CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiH3Hcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiH3Hc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:32:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD822A431
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:32:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z6so14321642lfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Eji6PfnetUxjQWQNmNTakZ0GC+nZVjefNIjiiKx7moM=;
        b=Y0KPVd1kR1gE9M2EkCjBhgd5MvrfZDrI3sNF+dsW070vrOtJwZi7Kgk5iG9/J4M0yM
         JbvVOarhVyapGXJWjGsZ5Y3kyLEEP15iXzXKH3xpgqJ5l3tS54r3yv9iMEiPToVToThV
         KifmuIndpaDj5A8H3xUWm+A9aTIitNoGAPViE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Eji6PfnetUxjQWQNmNTakZ0GC+nZVjefNIjiiKx7moM=;
        b=OFT5xBNOujTK4FV1En5jbLkiaLHnn7iHvRs7hrHWFyxZuVl4sXUukfGU78qDT7kpED
         biIikM1Ul8NwwLOHSmYvW4dFfAQJMLpl1F7apBZE2FC4W2HBKvBQ/dTebZcO0CjrHpe+
         wo002U0uQdQ+mz0iV8j06cbsvOvsVIpXqvTzJVBXoSkCa4UDh1zfGgsLp8LtlJPdZ/oZ
         lbONzmjRy7zoYGW2jV0ycNQJaWVQVC647E6UdJbYIORqahiZjHqBDpK+JcJZvnsSIcG0
         Ipc0krWfy6PgoIqN0Srn/pdd2doOyjVIuJtwqMmBXfjTyeDiCTkYPF0BjqJ55vslwwva
         h57g==
X-Gm-Message-State: ACgBeo25pJCnVOKM+DYb6qQuDJeV/Dx9r6Gt+05toRBFm0N+bwKKssvx
        X8HRzKL+BhV+5EliqSBavOJjcg==
X-Google-Smtp-Source: AA6agR6M8H7ruSctbEDCn6rn2Dvz8Vl6vFaH1IXmie6+yi7qrMnkkIN957laBbOFT0OF5i1omOvd6g==
X-Received: by 2002:a05:6512:2511:b0:493:50c:ec3 with SMTP id be17-20020a056512251100b00493050c0ec3mr7102905lfb.665.1661844741975;
        Tue, 30 Aug 2022 00:32:21 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id v4-20020ac258e4000000b004946c3cf53fsm615377lfo.59.2022.08.30.00.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:32:21 -0700 (PDT)
Message-ID: <cac2eaf0-2a56-d750-3508-7b5ed03e1eb5@rasmusvillemoes.dk>
Date:   Tue, 30 Aug 2022 09:32:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] lib/test_printf.c: Add ip6 tests
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220830003119.1793219-1-kent.overstreet@linux.dev>
 <20220830003119.1793219-2-kent.overstreet@linux.dev>
 <Yw1sKTOEs1Nrdb2S@google.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Yw1sKTOEs1Nrdb2S@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 03.47, Sergey Senozhatsky wrote:
> On (22/08/29 20:31), Kent Overstreet wrote:
>> diff --git a/lib/test_printf.c b/lib/test_printf.c
>> index 4bd15a593f..6a56dbf076 100644
>> --- a/lib/test_printf.c
>> +++ b/lib/test_printf.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/dcache.h>
>>  #include <linux/socket.h>
>>  #include <linux/in.h>
>> +#include <linux/in6.h>
>>  
>>  #include <linux/gfp.h>
>>  #include <linux/mm.h>
>> @@ -61,6 +62,9 @@ do_test(int bufsize, const char *expect, int elen,
>>  		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
>>  			bufsize, fmt, ret, elen);
>>  		return 1;
>> +		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d (%s != %s)\n",
>> +			bufsize, fmt, ret, elen, test_buffer, expect);
>> +		return 1;
>>  	}
> 
> I assume you intended to replace first pr_warn() with the second one?

Probably, but that's not ok. The test framework does not trust
vsnprintf(), especially not when it does not behave as expected. So I
very much carefully do not treat the buffer as a nul-terminated string
until I have verified that it does have a nul character (that's tested a
few lines below), and then when I compare the buffer contents can I pass
it as a %s argument. Also note how that test takes the 'we may be
testing a truncated write' into consideration, by printing the expect
string via %.*s.

tl;dr, please just remove that hunk.

Rasmus
