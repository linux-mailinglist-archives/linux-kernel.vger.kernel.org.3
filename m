Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D835700BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiGKLgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiGKLg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:36:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56537220CA;
        Mon, 11 Jul 2022 04:23:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o15so4574598pjh.1;
        Mon, 11 Jul 2022 04:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V2hi29zaVU8MpDrbIr1LBzWu6oIVZkx4uhls09N1iMI=;
        b=nLMmZF660+o+xylnarsj9lUf2mPLhoUOPPKw5AczgvbjgB4wcEoHpDsmkyHYhpEdyO
         UeADL6cw7EuVggGdLacgdJykIp9yqVasIJ/2hfMFHpj5q/nT6mPvCkL0uBdrPUtWGhhF
         vVgKhZ021iRwRh8sbABQYT7pSfLYlAvPyUY9SExmPdVsryc2bmaLn7bflrpqe3Mz4BYK
         DtQ1ZTF1vdZbAdEqKxOilbRiqWX3of88sGvBtdOx2RcAUDBeqbn+kJWXaGN0vOp0s0UN
         odh2QsVLcBshDBFr4dMexVIoFzZ/ByCh76amD6ROomZ3FLifJg5DoBreQk5MwBui3ImS
         nElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V2hi29zaVU8MpDrbIr1LBzWu6oIVZkx4uhls09N1iMI=;
        b=E+6ypLkM503JbAmhtWF2KYcRX5evvUsDaPFzbTvKun3s6Rsp/WHhqk+FLw9hykF+Xc
         H7Sr2YzDbvac+hVdMxiFtY6WXxhnGMKUbunDO60XQkjJLqjhbEmg7+4M2Vv37ue0Rn5l
         UWHMgMVBhgGyBgzDGWV1ZCTYWOCp0Lozmt7wN2XA1hwjCP7/tX9qefrxEsseh8yPOvZG
         5V1MD70BZBr81CezBPv2C39v90f9r2jSP3zPNzhlmrUQMoQ8KYMa5IH0+w639jHxcZQm
         6tiZlZMLaM2Zf83mOg/A6ADCECV95dtBjgy607fc3ve/LEAL1Zs44IPvVemFtB5tj95X
         RZIg==
X-Gm-Message-State: AJIora/EISycvqRAZPWcA1SzT+0RKXX/HTEsaUmgEK6mpOWkGIZO3Ar3
        Y/l1K14Gj+5/9dkKKBK8WQk=
X-Google-Smtp-Source: AGRyM1vkl1THcxpcbNPSJxMvk5rvxBmCdHpyDVn1AANjWxAhyfwsm7PUqOA5NUkingOGSfmjO2lSDQ==
X-Received: by 2002:a17:902:720b:b0:16b:decd:5a66 with SMTP id ba11-20020a170902720b00b0016bdecd5a66mr18045697plb.33.1657538624829;
        Mon, 11 Jul 2022 04:23:44 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b00161ccdc172dsm4508372pls.300.2022.07.11.04.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:23:44 -0700 (PDT)
Message-ID: <aa67554f-4836-6160-40d4-7f86398a21fc@gmail.com>
Date:   Mon, 11 Jul 2022 20:23:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Expectation to --no-pdf option (was Re: [PATCH v2 0/5] Address
 some issues with sphinx detection)
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+huawei@kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <cover.1656756450.git.mchehab@kernel.org>
 <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
 <20220707211558.438a27d4@sal.lan>
 <3ba5a52e-cab6-05cf-a66e-adc58c467e1f@gmail.com>
 <87bktzhfcj.fsf@meer.lwn.net> <20220708155910.7c4ea35c@sal.lan>
 <d54415bb-9bad-6fd8-5636-218c04d5615a@gmail.com>
 <02a76970-78fb-5d09-6890-cc1dc11ca4db@gmail.com>
 <20220709085946.083025aa@sal.lan>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220709085946.083025aa@sal.lan>
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

On Sat, 9 Jul 2022 08:59:46 +0100,
Mauro Carvalho Chehab wrote:
> Em Sat, 9 Jul 2022 08:01:02 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> [-CC: ksummit-discuss]
>> On Sat, 9 Jul 2022 00:27:25 +0900, Akira Yokosawa wrote:
>>> On Fri, 8 Jul 2022 15:59:10 +0100,
>>> Mauro Carvalho Chehab wrote:  
>>>> Em Fri, 08 Jul 2022 08:02:52 -0600
>>>> Jonathan Corbet <corbet@lwn.net> escreveu:
>>>>  
>>>>> Akira Yokosawa <akiyks@gmail.com> writes:
>>>>>  
>>>>>> In my tests, the mathjax extension works with all the versions of Sphinx
>>>>>> I tested (1.7.9, 2.4.4, 3.4.3 (debian bullseye), 4.2.0 (openSUSE LEAP 15.4),
>>>>>> and 5.0.2).
>>>>>> Note that math expressions should look much sharper (vector fonts)
>>>>>> than those from imgmath (pixel images).
>>>>>> The time for a browser to complete the rendering might be longer than
>>>>>> with imgmath, especially for pages with a lot of math expressions,
>>>>>> though.  (Yes, I see some of media documents have a lot of them.)
>>>>>>
>>>>>> When you are detached from network connections, browsers will give
>>>>>> up and show those expressions in mathjax source code.   
>>>>  
>>>>> -extensions.append("sphinx.ext.imgmath")
>>>>> +extensions.append("sphinx.ext.mathjax")  
>>>>
>>>> There are two problems with this:
>>>>
>>>> 1. mathjax doesn't work for PDF output - nor would work if we add support
>>>>    for man pages some day;  
>>>
>>> Hmm, if I understand what is written in the following page:
>>>     https://www.sphinx-doc.org/en/master/usage/extensions/math.html
>>>
>>> , both imgmath and mathjax extensions are relevant only for HTML output.
>>>
>>> It says:
>>>
>>>     Changed in version 1.8: Math support for non-HTML builders is integrated
>>>     to sphinx-core. So mathbase extension is no longer needed.
>>>
>>> When did you see the issue of "mathjax doesn't work for PDF output" ?  
>>
>> For the record,
>>
>> I tested mathjax and PDF output with Sphinx 1.7.9, whose latex mode
>> can't handle nested tables.
>> I had no problem in building userspace-api.pdf and math expressions
>> in it look perfect.
>>
>> So I believe mathjax does not affect PDF output.
> 
> Did you also test epubdocs?
No, I didn't.

Now I see that mathjax doesn't work with epubdocs.

I think I found a means to use mathjax only for htmldocs.
It is mentioned in an issue at Sphinx:

    https://github.com/sphinx-doc/sphinx/issues/3740#issuecomment-385503305

Actually, it turns out that the mathjax extension is loaded by default
since Sphinx 1.8.  A simple assignment in conf.py can enable it:

    html_math_renderer = 'mathjax'

As a matter of fact, it can be enabled via the SPHINXOPTS make variable.

Just try this against current docs-next:

    make SPHINXDIRS=userspace-api SPHINXOPTS="-D html_math_renderer='mathjax'" htmldocs

> 
> It was an issue when we decided to use imgmath. If this got fixed for
> both supported non-html outputs, we can start using mathjax and get
> rid of installing latex and dvipng.

As far as I know, ebook readers don't understand javascript and mathjax
doesn't work. imgmath is mandatory for epub.

> 
>> Mauro wrote:
>>> As imgmath works everywere, we opted to use it instead. We were
>>> actually hoping that the lack of proper math support on Sphinx were
>>> something that later Sphinx versions after 1.3.1 would have fixed.   
>>
>> I'm not going to test earlier versions of Sphinx and I have no idea
>> of what issue Mauro saw at the time, but it sounds to me the issue
>> has been fixed since.
> 
> Good.

I'm suspecting now that pdfdocs had no issue with mathjax, but I'm not sure.

>  
>>>   
>>>> 2. Some Kernel developers disable javascript.  
>>> OK, mathjax has no chance, then...  
>>
>> On the second thought, I think mathjax (latex-free "make htmldocs")
>> is good enough for test build purposes.  When javascript is disabled,
>> math expressions are rendered in mathjax source.
> 
> Hmm... are there a way to use it with javascript disabled? 

No chance. Javascript is a must for mathjax.

>                                                            If so, maybe
> we can force it to always render math expressions during the build, instead
> or relying on javascript at exec time.
> 
>> As conf.py is programmable, it is possible to choose sphinx.ext.imgmath
>> when dvipng is found on the build system.
> 
> Not sure I like the idea. This would actually mean in practice that
> all developers that are currently doing doc builds will keep using
> imgmath, because they all have it already installed.

The purpose here is to get more developers who actually run "make htmldocs"
on their (not limited to) documentation changes.  Difference of math rendering
doesn't matter much.

One possible improvement for imgmath is to use its SVG format option, which
uses dvisvgm instead.  It will provide scalable math expressions similar to
those provided by mathjax.  Of course you need properly working dvisvgm.

> 
>> As for sphinx-pre-install, what about adding an option
>>
>>     --no-js   For those who disable javascript in their browser.
>>
>> which provide the list of required packages for dvipng?
> 
> It is not that simple.
> 
> Sphinx has a configurable theme engine. On our builds, we're using
> since the beginning the RTD (readthedocs) theme as default, but
> recent versions default to classic if sphinx_rtd_theme package is
> not installed.
> 
> All themes I know that provide a search button use JS to implement
> such feature.
> 
> So, a "--no-js" won't provide a javascript-free build environment.
I see.

What about "--imgmath" ? 

> 
> -
> 
> On a side discussion, should we keep recommending the install of 
> sphinx_rtd_theme? It is not mandatory anymore to have it installed,
> and the theme is more a matter of personal preferences. 
> 
> Also, when testing or modifying the docs, the theme doesn't really
> matter.
> 
> So, IMHO, we could stop recommending it.
I agree.

        Thanks, Akira

> 
> Regards,
> Mauro   
