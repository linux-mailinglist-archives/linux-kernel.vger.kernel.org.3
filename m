Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5AD58C21B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbiHHDcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbiHHDcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:32:15 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38BD10FD4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 20:32:04 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id u8so5602515qvv.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 20:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Yj+MnLFYD/HwL2E6dAUW7ycXT7mcSO8VW/+oNyHAJ4k=;
        b=eU5ih1fgjTB3N/PjOD7STqAOUhBDdC/ux97uRwCrgJGxj3FCO0fyC7L/SKca6cFRor
         93YmEF4JlVQSNhBR6V985kd7QYByvpgOjpgdtZXgDG9112dKquhHxRuqRvLE613Isy6j
         I8Mv6hVz9Iv6xbPWon8cYM9rquKRSx+J1d0yZY0+QcD6wWO8ufCLiaJV14uot/H7e8+e
         ZeHaDCk0lOv3bFA0QcoP3QDn2eHYtuMhelMV5NThGkVwy26pQZIB50klq+l5dM402RgO
         9q8q6GX28Dd36yKW+8T0avaWnsb/YsL8S6otNtQXtZ3o4vqwtvu4KqWX0dCGW48XLma6
         U05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Yj+MnLFYD/HwL2E6dAUW7ycXT7mcSO8VW/+oNyHAJ4k=;
        b=UOijk/KVvH4tIQmkF975lEl44/+SbbJ77xs0/F9y8fNfl7pHtWqEBORSrq2u0fynWO
         w0UM5E2/tS8HMZTtwfUCNYEuKctM+IEt+h1PGPTI0vk/HnsCiq0JDoTFEAVCqvqwJv9v
         y1fe+B7mXVLpI2XCHuKUPnjTFFvEiiojpTyaR/uZDZl0YdclCwexVtPAVDBA+LMfK6CA
         QSogX5vOOjmM9IIwH+iNOqHhrcbHCInmTf9B+2PpBEyttzB48gvXRXWAE3vPITZp7tvy
         uglNfC8/QEVNyBMOT9WupfKgzbSNV3ohr0IMmpHzsUpwo8MWinVd1tdNvaRN1ZTnKJW2
         eKwg==
X-Gm-Message-State: ACgBeo3RqnBkJYxVMFgx3J/WajgBPpVO98RBuLB4BM16U8GgSUoqo9aY
        QyEN6YkP0tl/S7Xlx8r6MdqBTsd3yA==
X-Google-Smtp-Source: AA6agR7B8zfGwqMPdHtJpZpCKZ6huayCxtX9zF9MQ7p8jchNkt83o+u+FbvLLxGl7jKMUhjXEZhEeA==
X-Received: by 2002:ad4:5ded:0:b0:478:f7a1:bc4e with SMTP id jn13-20020ad45ded000000b00478f7a1bc4emr12585535qvb.54.1659929523790;
        Sun, 07 Aug 2022 20:32:03 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id s65-20020a372c44000000b006b5cc25535fsm8323845qkh.99.2022.08.07.20.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 20:32:02 -0700 (PDT)
Message-ID: <8e1df054-062f-63c9-16b4-38143f3e7983@gmail.com>
Date:   Sun, 7 Aug 2022 23:32:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v5 31/32] tracing: Convert to printbuf
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Ingo Molnar <mingo@redhat.com>
References: <20220808024128.3219082-1-willy@infradead.org>
 <20220808024128.3219082-32-willy@infradead.org>
 <20220807225113.6a74b481@gandalf.local.home>
Content-Language: en-US
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <20220807225113.6a74b481@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/22 22:51, Steven Rostedt wrote:
> On Mon,  8 Aug 2022 03:41:27 +0100
> "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
>>   
>> @@ -9826,20 +9821,8 @@ static struct notifier_block trace_die_notifier = {
>>   void
>>   trace_printk_seq(struct trace_seq *s)
>>   {
>> -	/* Probably should print a warning here. */
>> -	if (s->seq.len >= TRACE_MAX_PRINT)
>> -		s->seq.len = TRACE_MAX_PRINT;
>> -
>> -	/*
>> -	 * More paranoid code. Although the buffer size is set to
>> -	 * PAGE_SIZE, and TRACE_MAX_PRINT is 1000, this is just
>> -	 * an extra layer of protection.
>> -	 */
>> -	if (WARN_ON_ONCE(s->seq.len >= s->seq.size))
>> -		s->seq.len = s->seq.size - 1;
>> -
>>   	/* should be zero ended, but we are paranoid. */
>> -	s->buffer[s->seq.len] = 0;
>> +	printbuf_nul_terminate(&s->seq);
>>   
>>   	printk(KERN_TRACE "%s", s->buffer);
>>   
>> diff --g
> 
> Please remove the two tracing patches and the deletion of the seq_buf from
> the series.

Well, that's not really an option, as Christoph already (rightly) 
pointed out.

If you've got actual engineering concerns that you'd care to articulate 
I'd (still) like to try to work with you - otherwise, I don't think this 
is something I can accommodate you on.
