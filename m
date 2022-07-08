Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB3F56BDFE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbiGHP1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiGHP1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:27:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEDB7359F;
        Fri,  8 Jul 2022 08:27:29 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d10so10019033pfd.9;
        Fri, 08 Jul 2022 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=g+mHkBvSd1sn5xTv8y/Le2buRp58wYG3oF5qe/pxnt0=;
        b=S1D1ROu9Go1+pxi6GH3PJF98VLIfPYBp0Fw9HNDSqYSZ2oe6nF7OQmqoRXhGD44yqm
         c7MkSs0r72N70KVs8n/6Qx4iyrCM6L8HAa03o0TVAdZbFHgriqamp3tcGXU22iRg7j2/
         0/T4FNi1qmYVyiYTCGJpMgz2FZ+gjhdQBnzlVFnnRv/q6G/YeXCW365KKbtKfVfCJVH5
         jtiCeRR7ECoDnyh67B1CFiLOsVLkU9WPjHPznrCF65gjk2vrrLtJekvaCwLEeqXriiex
         QJsmPlGTDAEsJQoHOLsdJcX7VhsPgIUyB9CDA0nPY6SSawWp7rmyEbLUvPRlUnxBb9cu
         bLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g+mHkBvSd1sn5xTv8y/Le2buRp58wYG3oF5qe/pxnt0=;
        b=BWCxd1RNThw7h3SLy7djcibzNUkha3eWO8GOmOkRW7YD9fOhGrYzViwhzlNHz7Rd2w
         JFRtejFvmMMhepnpKZwequH7MenmhGuBxh5YLeIR8YEmAlEVbiPg5fNHtMX7XEKDALQP
         w2uH0RSierdNrhDgdht25cPmihAEhYaXsICorYPwjaKiHrM6EQlbA4SqD4n5px8mYeWo
         OQeuqG6n13tcGPLL9zd3bBw02sqYmCPE2XrlKfh119P/vrQrpljPml3CN/qWUjJxo215
         0SVRmlm4KS30wJQH6+Ncaac/oxUOKT4u1fTlqtQU2129W+gQdj7GIcGtbrBZFOqDvwdp
         MozA==
X-Gm-Message-State: AJIora/5m7oZKNQo0P7B3HESKbGTDs39TDoRnzcWV69pmabKCWWEzLm7
        /alHUWvVyKZ+AWexjG5yDi4=
X-Google-Smtp-Source: AGRyM1tsgLfR9UC3v0KsaKUCMd8A2cfbjKmdyCldTHGSuAHefR8Le8hI4SzytDgdVIwIFAdNKmjeuA==
X-Received: by 2002:a05:6a00:3307:b0:528:9522:6d3 with SMTP id cq7-20020a056a00330700b00528952206d3mr4616931pfb.65.1657294048987;
        Fri, 08 Jul 2022 08:27:28 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id ml5-20020a17090b360500b001ef82d23125sm1749506pjb.25.2022.07.08.08.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 08:27:28 -0700 (PDT)
Message-ID: <d54415bb-9bad-6fd8-5636-218c04d5615a@gmail.com>
Date:   Sat, 9 Jul 2022 00:27:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Expectation to --no-pdf option (was Re: [PATCH v2 0/5] Address
 some issues with sphinx detection)
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+huawei@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>
References: <cover.1656756450.git.mchehab@kernel.org>
 <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
 <20220707211558.438a27d4@sal.lan>
 <3ba5a52e-cab6-05cf-a66e-adc58c467e1f@gmail.com>
 <87bktzhfcj.fsf@meer.lwn.net> <20220708155910.7c4ea35c@sal.lan>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220708155910.7c4ea35c@sal.lan>
Content-Type: text/plain; charset=UTF-8
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

On Fri, 8 Jul 2022 15:59:10 +0100,
Mauro Carvalho Chehab wrote:
> Em Fri, 08 Jul 2022 08:02:52 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
>> Akira Yokosawa <akiyks@gmail.com> writes:
>>
>>> In my tests, the mathjax extension works with all the versions of Sphinx
>>> I tested (1.7.9, 2.4.4, 3.4.3 (debian bullseye), 4.2.0 (openSUSE LEAP 15.4),
>>> and 5.0.2).
>>> Note that math expressions should look much sharper (vector fonts)
>>> than those from imgmath (pixel images).
>>> The time for a browser to complete the rendering might be longer than
>>> with imgmath, especially for pages with a lot of math expressions,
>>> though.  (Yes, I see some of media documents have a lot of them.)
>>>
>>> When you are detached from network connections, browsers will give
>>> up and show those expressions in mathjax source code. 
> 
>> -extensions.append("sphinx.ext.imgmath")
>> +extensions.append("sphinx.ext.mathjax")
> 
> There are two problems with this:
> 
> 1. mathjax doesn't work for PDF output - nor would work if we add support
>    for man pages some day;

Hmm, if I understand what is written in the following page:
    https://www.sphinx-doc.org/en/master/usage/extensions/math.html

, both imgmath and mathjax extensions are relevant only for HTML output.

It says:

    Changed in version 1.8: Math support for non-HTML builders is integrated
    to sphinx-core. So mathbase extension is no longer needed.

When did you see the issue of "mathjax doesn't work for PDF output" ?

> 2. Some Kernel developers disable javascript.
OK, mathjax has no chance, then...

        Thanks, Akira

