Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172F254718B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349762AbiFKDQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiFKDQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:16:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794BE143868;
        Fri, 10 Jun 2022 20:16:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f8so748790plo.9;
        Fri, 10 Jun 2022 20:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=izhA0dul3NBXKk1k4ps+Tgt4s/S/pmcFYXYqBbcTa8Y=;
        b=h1rQGyQOYzmuaURtLY9r01a9R7uH7Sm1eSaYrtz8lwHbfMuTqy2Xcamy0ccgFe72uO
         HuleMtIeDg1UgbI1VfEBnIFviqdIFj27znO486PVdrdD1scDZSIv4FLGSDB96B5PMET/
         /0ASRCN/d+trnZ+q4/J6Vek0Yken06o+YhabaiUgDRFYnx+omKEicTnby8/0yNK1CDf1
         rXYRRVCvQEWnVyOENnUHhZnTeJsl7etrZLsEHNfZimVVMeSCFWaVTmwnv1zyZq9KNSYu
         hpbAxaELQ3YuJFmxXBepaKB69PSogbq0O8JtmAUmwzI89hEmYOTbbWXd8vHbVP1kDLeU
         aV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=izhA0dul3NBXKk1k4ps+Tgt4s/S/pmcFYXYqBbcTa8Y=;
        b=lbFwumuddPYHcCIygnbXYB03d9lvjHukskcgK9CmYqjoTgVV2iK4ZTD9ObUuss/6jS
         mIKab3YwLngD7c23ibrWRA8kMgziXwOud3k0WRD3+9XNwCvhk/U3MyPUtK9c5ORKqTYP
         HWSRv3G9iX3qf1u6HfOk+qXoDgfX5pnlABDUherMlFfYiu+lrhQ1dJMHoQAMeI/6TVDw
         Ans0hY93dxOMSDQRWr5Aa2WJiYMrhRiYNpdsRchyqk2y37zlhiBbMeZGDygcQbZ3qh44
         VHCfJl69k2cCSuazmGTLEcmQO75jdjviR2i3rC9t5VTxP08eH4O9f3jIaP5E8cN7fyPp
         EG0Q==
X-Gm-Message-State: AOAM533DjaWb9yTfeC9TpIwIn6Sg65fhFmlBApTsNN6UgWkIyUYbVGd8
        sKJuRpW9rZvES8MkWRjPVnK2udA315c=
X-Google-Smtp-Source: ABdhPJxjy5tTC7pUgPVJWvk0xO+KTI27KyHE1GQKHl65g3UJL1qZqfy+hsE0miHdA0LSHurL86xQIA==
X-Received: by 2002:a17:902:b28c:b0:168:9928:db1b with SMTP id u12-20020a170902b28c00b001689928db1bmr16106620plr.55.1654917364989;
        Fri, 10 Jun 2022 20:16:04 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id h188-20020a62dec5000000b0051bb61c0eacsm329768pfg.20.2022.06.10.20.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 20:16:03 -0700 (PDT)
Message-ID: <c25c29c7-28a6-65d4-8eb2-ac857894c1ba@gmail.com>
Date:   Sat, 11 Jun 2022 12:15:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [RFC PATCH 3/5] docs/doc-guide: Update guidelines for title
 adornments
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
 <732154bc-aa35-2326-2b64-87b6c4dd02e7@gmail.com> <871qvw2898.fsf@intel.com>
 <CANiq72n3MQnjenbQGBUKD+SqNzdGUyJW9zjTOVY4+6cKBRc9ig@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANiq72n3MQnjenbQGBUKD+SqNzdGUyJW9zjTOVY4+6cKBRc9ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On Fri, 10 Jun 2022 18:08:43 +0200,
Miguel Ojeda wrote:
> On Fri, Jun 10, 2022 at 11:11 AM Jani Nikula
> <jani.nikula@linux.intel.com> wrote:
Thank Jani and Miguel for chiming in!
As this is a RFC patch, I'm glad to have nice comments from both of you.

>>
>> When I wrote the original guidelines, it was my subjective decision to
>> steer towards using the same title adornment styles and ordering across
>> the kernel documentation. I intentionally left out all the
>> reStructuredText details about this, because the definitive
>> documentation is the reStructuredText documentation we can refer to.
>>
>> While the "Nth level title" is a more precise description, I'm not sure
>> it's actually helpful without describing how these levels should map to
>> kernel documentation structure. (Not saying the original did that
>> either, but then there wasn't much structure to speak of.)
I agree that we need to cover in doc-guide the way the kernel documentation
is organized and managed.  Total lack of such documentation is kind of
surprising to me.

> 
> To give a bit of context: this patch followed from a question I asked
> to Jonathan and Akira privately. Currently it is hard to tell the
> "nesting level", and even worse, existing files are not consistent and
> checking is not automated. Therefore, an easy way to handle this is to
> request to follow the same pattern regardless of nesting across the
> tree.
> 
>> Improving the documentation on documentation is great, but I think it's
>> a bad sign when length of the notes and warnings on something far exceed
>> the length of the thing being documented. The bulk of the text should be
>> helpful enough for people to DTRT, while leaving out exhaustive
>> descriptions of all the details that should just be references to
>> reStructuredText documentation.

So, I was not aware of such a hidden rule on what should _not_ be in
doc-guide.  :-)
In my opinion, RST documentation is not easy to follow especially for
new contributors, and putting some useful tips somewhere in doc-guide
would improve situation.

I agree with you that those notes and warning don't belong to guidelines.

Maybe add a section collecting RST tips and tricks mainly consisting
of pointers to RST and docutils documentation.

> 
> Perhaps we can move the rationale to the commit message, and keep only
> the current rules in the document. What about something like:
> 
> """
> Please stick to this relative order of adornments within each file
> (i.e. regardless of nesting level across the kernel tree):
> 
>     1. ``=`` with overline.
>     2. ``=``.
>     3. ``-``.
>     4. ``~``.
> 
> For instance::
> 
>     =====
>     First
>     =====
> 
>     Second
>     ======
> 
>     Third
>     -----
> 
>     Fourth
>     ~~~~~~
> """

I'm more inclined to keep "level"s in the example.
Without them, a new contributor might be confused to use those
adornments exactly in that order, for example:

    ==============
    Document title
    ==============

    Chapter A
    =========

    Section A.1
    -----------

    Section A.2
    ~~~~~~~~~~~

    Section A.3
    ???????????

Unlikely, but possible...

Anyway, I'll post a v2 for your further comments.
Might take a while.

        Thanks, Akira
> 
> Cheers,
> Miguel
