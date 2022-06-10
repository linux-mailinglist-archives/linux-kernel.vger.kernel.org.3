Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484775459C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbiFJB6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJB6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:58:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013C17642;
        Thu,  9 Jun 2022 18:58:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so974969pjo.0;
        Thu, 09 Jun 2022 18:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O3LtD/aDVvE2wBzGRW4V0+STwua/GO8Xrmfqlkp9N2s=;
        b=lxXJTgddIZrrXoH1Ic5uWclhiaG3LHEknnCzwkN3/Lvs84IVaofd0opU2VXzapsNTR
         GbXkjCLfnIX/o2FTHzH4BCk9LBSLMch6rySPhwS7XbfRj2F8VpFjQGM1QWLI5BmzAve9
         1pzvdcgW2ZfpH/nJSozRjn6+HSv1gJ8fdgYUNOKDeunXAlOb6EaG9jU5Dln81bqzr7w3
         nImxh+W+aoEGuk+t1ZqDZAPVPro8Okpfkl+OEf/rlRAx9J8/LFdiI5a512kZ8tH4Ogyf
         wksI1S1CHjAjDoYtZbR9g3DDuJzYwHNeunyNVwnbKZUsM9TXzQiR5D34ROEl9EpR0c+a
         HztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O3LtD/aDVvE2wBzGRW4V0+STwua/GO8Xrmfqlkp9N2s=;
        b=WLgUuB7ehvG7GNJl64hNMRRt+lvddDhibusN7AcUAjoQ/DZJOzgn4HPaprmsr7ZJei
         CGXGdqfnErKeTTqptcC7L6TS9mYXZoPc9hVmN+9ZnxJBroW+3R9K/pJYLjYo79xgKEnM
         vSKMrvHN0aycIgs/dr6SjemScn4EQwR+hxX24sfzr595Q9l7ekFN2eAIqBirW1P8jic2
         njskxVMVdj1/MUBHm771gGfWUZx1jivyKfRSMSG7QP2X4X3nk74pLYaUHreq3105x8Ca
         /M08DJRgaDNCGEdlYRXbnrMaZzOp7RFrVTfz8pSS6Gg7+T99bdvvmDyZjRMTXdCafbL4
         0rGQ==
X-Gm-Message-State: AOAM532VUIBsF+2/wNutJperiTAgZqBKaHfm8X8LW04w4/fleGm4eNvi
        0nxw3ZFT7gMz4coDYkaycLg=
X-Google-Smtp-Source: ABdhPJwUDyRRXAZMFHVN/1bQuIDfalX0tHlEaBneQ7uoGFzqoFeqBwVJM4PdLoHdY7RKLVeea1SeOw==
X-Received: by 2002:a17:90a:b703:b0:1dd:1e2f:97d7 with SMTP id l3-20020a17090ab70300b001dd1e2f97d7mr6264351pjr.62.1654826293469;
        Thu, 09 Jun 2022 18:58:13 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 72-20020a62144b000000b0051b416c065esm17832918pfu.8.2022.06.09.18.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 18:58:12 -0700 (PDT)
Message-ID: <7bac8111-d18c-4edc-0722-66e6312daab9@gmail.com>
Date:   Fri, 10 Jun 2022 10:58:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/5] docs/doc-guide: Mention make variable SPHINXDIRS
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
 <ff89c064-e24a-0f2f-fc03-b029e5d04338@gmail.com>
 <87v8t9504m.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87v8t9504m.fsf@meer.lwn.net>
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

On Thu, 09 Jun 2022 09:26:17 -0600,
Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
[...]
>> --- a/Documentation/doc-guide/sphinx.rst
>> +++ b/Documentation/doc-guide/sphinx.rst
>> @@ -151,6 +151,10 @@ If the theme is not available, it will fall-back to the classic one.
>>  
>>  The Sphinx theme can be overridden by using the ``DOCS_THEME`` make variable.
>>  
>> +There is another make variable ``SPHINXDIRS``, which is useful when test
>> +building a subset of documentation.  Again, see the documentation section
>> +of ``make help`` for the details.
> 
> This should definitely be documented, it's kind of sad that we never did
> that.  Rather than redirect readers to type a "make" command, though,
> why not just tell them how to use it here?

Good point.
I have updated the hunk as follows:

+There is another make variable ``SPHINXDIRS``, which is useful when test
+building a subset of documentation.  For example, you can build documents
+under ``Documentation/doc-guide`` by running
+``make SPHINXDIRS=doc-guide htmldocs``.
+The documentation section of ``make help`` will show you the list of
+subdirectories you can specify.

Thoughts?

        Thanks, Akira

> 
> Thanks,
> 
> jon
