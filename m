Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0335A3B3C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 05:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiH1Dr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 23:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH1DrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 23:47:22 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D9227B26;
        Sat, 27 Aug 2022 20:47:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y1so3153228plb.2;
        Sat, 27 Aug 2022 20:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=9yF9aJA9PLqVj6jwxFEtA03qUU5dbwSuNEe37sUJd6o=;
        b=GO1Pp418OvXhMPpt2K5PYCEl+YMt7CAz1LYA9oeY8dLdQRfB2pZNoLPXRtUiaPU4aj
         LGpRXIQKumzeamiqQUURLEfDxgbCR+skX+tKsc/ulApYBLj6XzSpTSMJcgCCIwTYnvCi
         xWYjnC80oz4cv4J4SyhghxoNYK69fsD7+RElLTtli6bRvqhCc+i140B+ANDynPKEtbJQ
         QoY5xb9903+PUVYhwhuQQ8BiTLsRJbt99WcqvDg7GiGhFwUSJ/X/sRWu5+mIeXoeVGEW
         Na/nxyZ+OHB8z2GkRXW0J9WeOtfjdAuEk1j+dbx8VO7S0m8fKZVd7wLXqOAmNNnsCVxt
         nRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9yF9aJA9PLqVj6jwxFEtA03qUU5dbwSuNEe37sUJd6o=;
        b=24EuOS2XVkVhvaycc8UWGAuon6fBydjUIMuPDGgHZrD9jH1vu8ad7vKe8hNRvzMnfC
         FQam3b5S7Vj1BlPPxMtCnlrmxJJdWbbfGrYS9cjg5WUhmHPrf3q6TA+0P3WQT+k25OuV
         CIOBJQjiFVK7ijeqdI0Jh/wp7Cqq9fXY6CDMMzpQxFsPK90qZD4obVKfFg8YggRPb/MF
         s8r9co7xX5EYICY7BsP2h6sVhUZujCluGefN+wSWFDkyS3DV79crr1qfNdOfw9mvZhy1
         LZv3nHBnKha+s9QynIDLVuQZ+mgMtEqU8Ie1CBAc8bL8fTcpWQJukphMJF+OD3E5Ai4R
         LrRA==
X-Gm-Message-State: ACgBeo3RXprlteRLkFxc3PY585JHw0FFZfrlLII55FO60Y7J/A954OCa
        qzAJTYv9WQDGgbM0KG8QMRo=
X-Google-Smtp-Source: AA6agR5S+cR6mjhFef8XZponsk849IQTud53GI+FizJEH1Dxpvfr1lMOTm3usoeywlS7pOoUiaYF5g==
X-Received: by 2002:a17:90a:4d82:b0:1fb:6497:e071 with SMTP id m2-20020a17090a4d8200b001fb6497e071mr11951004pjh.166.1661658439859;
        Sat, 27 Aug 2022 20:47:19 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b001745662d568sm2870143plb.278.2022.08.27.20.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 20:47:19 -0700 (PDT)
Message-ID: <e7e3cfb5-fc82-5ce4-b964-e3eec01dcc2c@gmail.com>
Date:   Sun, 28 Aug 2022 12:47:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] docs/conf.py: Respect env variable SPHINX_IMGMATH
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <9b8ff6d7-e97a-c03f-7d46-4b80ae3cf196@gmail.com>
 <5a582b2b-d51c-a062-36b2-19479cf68fab@gmail.com>
 <2032102a-e2d3-6105-f4e6-bba7decdbb66@infradead.org>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <2032102a-e2d3-6105-f4e6-bba7decdbb66@infradead.org>
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

Hi Randy,  thank you for looking into this!

On Sat, 27 Aug 2022 17:38:41 -0700, Randy Dunlap wrote:
> Hi Akira,
> 
> On 8/26/22 21:38, Akira Yokosawa wrote:
>> On some distros with coarse-grained packaging policy, dvipng is
>> installed along with latex.  In such cases, math rendering will
>> use imgmath by default.  It is possible to override the choice by
>> specifying the option string of "-D html_math_renderer='mathjax'"
>> to sphinx-build (Sphinx >= 1.8).
>>
>> To provide developers an easier-to-use knob, add code for an env
>> variable "SPHINX_IMGMATH" which overrides the automatic choice
>> of math renderer for html docs.
>>
>>     SPHINX_IMGMATH=yes : Load imgmath even if dvipng is not found
>>     SPHINX_IMGMATH=no  : Don't load imgmath (fall back to mathjax)
> 
> Please add SPHINX_IMGMATH to Documentation/doc-guide/sphinx.rst
> (I guess), where other Sphinx environment variables are listed.

Right.
As I mentioned in the coverletter, (quoted below):

> I mentioned in the thread of [3] that imgmath can generate scalable
> math images in SVG.
> 
> My plan was to implement that option as well.  But during tests under
> Fedora/CentOS/openSUSE, I encountered a couple of warnings from dvisvgm.
> That would be regressions on existing systems which happen to have
> not-working dvisvgm along with working dvipng.  I'm thinking of adding
> the SVG option later if I can figure out the minimal requirement for
> dvisvgm under imgmath.

, I'm working on follow-up changes related to SPHINX_IMGMATH.

My plan is to update related docs and help text in Makefile when I manage
the SVG option. At that time, SPHINX_IMGMATH will have additional options
like 'svg' and 'png'.

Hopefully, such follow-up changes can make the v6.1 merge window.

Does this plan work for you?

        Thanks, Akira
> 
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>> Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>> ---
>> Changes since v2:
>>  - Emit warning on unknown setting of SPHINX_IMGMATH.
>>
>> Changes since v1:
>>  - No logical changes.
>>  - Renames:
>>      LOAD_IMGMATH -> SPHINX_IMGMATH (Mauro),
>>      opt_load_imgmath -> env_sphinx_imgmath.
>>  - Acked-by from Mauro.
>> --
>>  Documentation/conf.py | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/conf.py b/Documentation/conf.py
>> index c4aaedd96220..9678a8215457 100644
>> --- a/Documentation/conf.py
>> +++ b/Documentation/conf.py
>> @@ -124,8 +124,20 @@ autosectionlabel_maxdepth = 2
>>  # mathjax is the default math renderer since Sphinx 1.8.
>>  have_latex =  have_command('latex')
>>  have_dvipng = have_command('dvipng')
>> -load_imgmath = ((have_latex and have_dvipng)
>> -                or (major == 1 and minor < 8)
>> +load_imgmath = have_latex and have_dvipng
>> +
>> +# Respect SPHINX_IMGMATH (for html docs only)
>> +if 'SPHINX_IMGMATH' in os.environ:
>> +    env_sphinx_imgmath = os.environ['SPHINX_IMGMATH']
>> +    if 'yes' in env_sphinx_imgmath:
>> +        load_imgmath = True
>> +    elif 'no' in env_sphinx_imgmath:
>> +        load_imgmath = False
>> +    else:
>> +        sys.stderr.write("Unknown env SPHINX_IMGMATH=%s ignored.\n" % env_sphinx_imgmath)
>> +
>> +# Always load imgmath for Sphinx <1.8 or for epub docs
>> +load_imgmath = (load_imgmath or (major == 1 and minor < 8)
>>                  or 'epub' in sys.argv)
>>  
>>  if load_imgmath:
> 
> thanks.
