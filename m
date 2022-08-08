Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD3858CAF2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243820AbiHHO7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243754AbiHHO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:59:07 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4A115801
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:58:42 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id cr9so3376521qtb.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Bu+gercJAKNBiVI/xRPX/N+yTvyeFBnpoFe9lW5UJK8=;
        b=qKNZE1MFNiW3RaVZsJMikZVUimfv8CEbYCC5tRa+Uzrv0NhadG3wFN465J/Y9E8P4V
         GcfhfgSfj9g4S0icxUIiJEsItySlaiU4KL0iFxzGmXpPRJy4syS8pFP95ZR+xePwrXYR
         pL3s+ukAxyeRfvlWRWCKrfvg2aTKl843q80MoJYp7ULyXbJmoyBLoJS0coy4rHczlhKE
         KvK3t65xsa+jsrHZ4+F6250pJoe4xFm3duPY5qtpYETd1o+ImXFc8IZ08p9C+FpjgGns
         VWoxr0AiBmExh0PJkN97mYcPTSo5YhfPwPed3I6A/0jdHveHL43FjcyGQA2HEL+xgfEQ
         QAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Bu+gercJAKNBiVI/xRPX/N+yTvyeFBnpoFe9lW5UJK8=;
        b=7vYSjPjhtI+JRDxZZ4rhISA+T4oJre7bRo2wjIcf1C+6NPy9ZTWymzGLc63/LjpsE4
         PN0aEaNuYRC/EaayGXr7VCdueGHCFPXLjwPrHBPat1QcCnBRCkQH/5VAsKhdv8lkdQUc
         iyh25HjwuCJlwxvDE5b0kz/eHsfShzVsJ7op6iyYF+bKYMGh13GfiRqJYgbDCQcsRJLK
         UnRA8ybfw4W5fOFiosKknhtyR4EPQTj7an6mJfeeKKW5kqX5+TRGxVuKnFl3XPq6z6jw
         rZPOMgouYppEzPEEFY9wymO8ioOYbpfkMv2hQHKA/pwE5yDF0IfscJVOpixOagu+9zfI
         YeWw==
X-Gm-Message-State: ACgBeo2gLJ1rw2Q1gQHpZtPNJlf/fdHDhcX6iWLuK3VfZ7nq4EghNmrf
        Lwga8J9JIzK19JYehSbJjw==
X-Google-Smtp-Source: AA6agR65xBTy/nfGA7xvtSZBCsMbm5+5ILCgB3bJO3U6cWkn+dMyxTmXR0zc9pYZjZT8wqIVKC7tXQ==
X-Received: by 2002:ac8:7c45:0:b0:33a:e45d:b78f with SMTP id o5-20020ac87c45000000b0033ae45db78fmr16382451qtv.182.1659970720960;
        Mon, 08 Aug 2022 07:58:40 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id u33-20020a05622a19a100b00342e86b3bdasm6367238qtc.12.2022.08.08.07.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 07:58:40 -0700 (PDT)
Message-ID: <61bbfb03-3493-5e1e-da00-fee555393d4a@gmail.com>
Date:   Mon, 8 Aug 2022 10:58:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v5 02/32] lib/string_helpers: Convert string_escape_mem()
 to printbuf
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy@kernel.org>
References: <20220808024128.3219082-1-willy@infradead.org>
 <20220808024128.3219082-3-willy@infradead.org>
 <CAHp75Vcua1dCZQ-ZvcAxkorfXzr6rmJO6=wVYLoomdMzLXDRtw@mail.gmail.com>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <CAHp75Vcua1dCZQ-ZvcAxkorfXzr6rmJO6=wVYLoomdMzLXDRtw@mail.gmail.com>
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

On 8/8/22 08:03, Andy Shevchenko wrote:
> On Mon, Aug 8, 2022 at 4:41 AM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
>>
>> From: Kent Overstreet <kent.overstreet@gmail.com>
>>
>> Like the upcoming vsprintf.c conversion, this converts string_escape_mem
>> to prt_escaped_string(), which uses and outputs to a printbuf, and makes
>> string_escape_mem() a smaller wrapper to support existing users.
>>
>> The new printbuf helpers greatly simplify the code.
> 
> ...
> 
>>   struct device;
>>   struct file;
>>   struct task_struct;
>> +struct printbuf;
> 
> Keep it ordered?

I generally try to keep my #includes alphabetized, missed this :)

> 
> ...
> 
>> @@ -71,6 +74,7 @@ static inline int string_escape_mem_any_np(const char *src, size_t isz,
>>          return string_escape_mem(src, isz, dst, osz, ESCAPE_ANY_NP, only);
>>   }
>>
>> +
>>   static inline int string_escape_str(const char *src, char *dst, size_t sz,
>>                  unsigned int flags, const char *only)
>>   {
> 
> Stray change.

Fixed

> ...
> 
>>                  if (!(is_append || in_dict) && is_dict &&
>> -                                         escape_passthrough(c, &p, end))
>> +                   escape_passthrough(out, c))
> 
> That (a bit strange) indentation is on purpose. Can we keep it?

Yep, done

>>                          continue;
> 
> ...
> 
> Not sure if the below was in the original text, but maybe it makes
> sense to amend.
> 
>> + * Description:
>> + * The process of escaping byte buffer includes several parts. They are applied
> 
> a byte in the buffer (?)

See below

> 
>> + * in the following sequence.
>> + *
>> + *     1. The character is not matched to the one from @only string and thus
>> + *        must go as-is to the output.
>> + *     2. The character is matched to the printable and ASCII classes, if asked,
>> + *        and in case of match it passes through to the output.
>> + *     3. The character is matched to the printable or ASCII class, if asked,
>> + *        and in case of match it passes through to the output.
>> + *     4. The character is checked if it falls into the class given by @flags.
>> + *        %ESCAPE_OCTAL and %ESCAPE_HEX are going last since they cover any
>> + *        character. Note that they actually can't go together, otherwise
>> + *        %ESCAPE_HEX will be ignored.
>> + *
>> + * Caller must provide valid source and destination pointers. Be aware that
>> + * destination buffer will not be NULL-terminated, thus caller have to append
> 
> the caller has

Yeah I'm actually not changing the function comment for 
string_escape_mem(), that's just git getting confused since I reused 
most of it for prt_escaped_mem(). I'll leave any fixups for that for you 
if that's ok - the docs look clear enough to me.

Cheers
