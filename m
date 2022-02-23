Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7444C0A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiBWDSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiBWDSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:18:30 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B9D266E;
        Tue, 22 Feb 2022 19:18:03 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f8so18696155pgc.8;
        Tue, 22 Feb 2022 19:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hyoGBcKpu2tzubHVr6sjqJH+foo5cVTjuATdYIPzmOw=;
        b=C0+Bi2ysHTpxEnYmiqZo8yYFjh+ztdmRXc1QQ1EnrUm5b46SmVDG+c73yRBQKhzvRD
         6cw2e1pcXnZHU6s9IMswHCLcBevLxZ+YuAybSPJ2sOHnwSUwEMOBfWMCoU3uj8Iwipjc
         E5VXRi1CkUkwardkFAzxKtFCxL6e9786CwCLftROaxKIJPr7wbJ5tOy93khZTb3pgFPH
         uXAgiQ8kPCbsmkre/N6nfAl3OrugL8DbzUAvGVcZXCf0r5dcFMO7VrQ0R4svhYI2cd7J
         PPn0/clof8kFyHuP9IFRNx4Zzi+X8yUgrFRaHbhXnSbNJZ2ViJtHunVHs44gGnVgJUqS
         8dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hyoGBcKpu2tzubHVr6sjqJH+foo5cVTjuATdYIPzmOw=;
        b=H+JaB0Q4IjBE99Ev24rXkJLG9orA4HmnqdcjOGwp4U9LcGuKZ/98nWVtZpp63tviCb
         U+yd1SxbfQhwbFuAA8qzSmpOEBKH35QkK5Ct1DZuwPAGxNcI8uOP8FYWTeCyjFuVn+UK
         6RKCI/NcUY9VJC2R4RFLNNNppcWMSt7f/6b923FL9u5oODUVQXZQMor+kURGjL4dyHSJ
         TZ0QlhaCCV2mg0nKL7/QovUnA2GsarqadSusuj/94+hovG/IMBvs4tQkYueAi11jTjGa
         ahUOGTltGyXNY2bCKthYpFJk1an/+Wjb+0jjYxucwk9ADnYkbB/rhg2cOVbU2p32OpLs
         5Ejw==
X-Gm-Message-State: AOAM5329oep5B5dDiJJkbs4w2RAjpJQCqPMXoOYjaTX7tnxc7GGZCQQv
        TaL71Jff1QZRf8HTNUbFKz8=
X-Google-Smtp-Source: ABdhPJx2k/XMstllahwLEpmG9KCG4vHiZgb2E4NsxvN7W20AUOjbJaCdp/6eNKgzYcEnwSkZqMjdjA==
X-Received: by 2002:a63:7d1c:0:b0:373:d43f:3ab7 with SMTP id y28-20020a637d1c000000b00373d43f3ab7mr18214118pgc.425.1645586282742;
        Tue, 22 Feb 2022 19:18:02 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id s5sm22392324pgo.37.2022.02.22.19.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 19:18:02 -0800 (PST)
Message-ID: <939ef119-8a84-9206-bd7c-cfd215bb0200@gmail.com>
Date:   Wed, 23 Feb 2022 12:17:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 00/11] Transform documentation into POD
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?B?VG9tYXN6IFdhcm5pZcWCxYJv?= <tomasz.warniello@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <525f3696-91f4-5a4a-c9ef-24758ccaa2bb@infradead.org>
 <ff98f455-0221-7ff0-08ed-8dea9f08694b@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <ff98f455-0221-7ff0-08ed-8dea9f08694b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I myself botched line feeds/carriage returns in copy/paste.

Please find a fixed version below:

On Wed, 23 Feb 2022 12:08:35 +0900,
Akira Yokosawa wrote:
> Hello Randy, Tomasz,
>=20
> On Tue, 22 Feb 2022 13:31:31 -0800,
> Randy Dunlap wrote:
>> Hi--
>>
>> On 2/21/22 21:39, Randy Dunlap wrote:
>>> Hi Tomasz,
>>>
>>> On 2/18/22 10:16, Tomasz Warnie=C5=82=C5=82o wrote:
>>>> This series transforms the free-form general comments - mainly the u=
sage
>>>> instructions and the meta information - into the standard Perl
>>>> documentation format. Some of the original text is reduced out. And =
some
>>>> is simply dropped.
>>>>
>>>> The transformation includes language, paragraphing and editorial
>>>> corrections.
>>>>
>>>> The only change in the script execution flow is the replacement of t=
he
>>>> 'usage' function with the native standard Perl 'pod2usage'.
>>>>
>>>> The to-do suggestion to write POD found in the script is ancient, th=
us
>>>> I can't address its author with a "Suggested-by" tag.
>>>>
>>>> This version follows the advice received on v3, except I'm leaving
>>>> the old copyrights untouched.
>>>>
>>>> The process consists of 14 steps.
>>>>
>>>> Patches beginning with no 3 are disfunctional until no 9 has been
>>>> applied.
>>>>
>>>> 1) Add the basic POD sections
>>>> 2) Relink argument parsing error handling to pod2usage
>>>>
>>>> The following subseries is disfunctional before its last part.
>>>>
>>>> 3) Translate the DESCRIPTION section
>>>> 4) Translate the "Output format selection" subsection of OPTIONS
>>>> 5) Translate the "Output format selection modifier" subsection of OP=
TIONS
>>>> 6) Translate the "Output selection" subsection of OPTIONS
>>>> 7) Translate the "Output selection modifiers" subsection of OPTIONS
>>>> 8) Translate the "Other parameters" subsection of OPTIONS
>>>> 9) Replace the usage function
>>>>    =20
>>>> Here the DESCRIPTION and OPTIONS subseries is finished. The -h and -=
help
>>>> parameters are handled by POD now.
>>>>    =20
>>>> 10) Drop obsolete comments
>>>> 11) Refresh the copyright lines
>>>>
>>>> Let's see what's wrong this time.
>>>
>>> This patch series looks good to me.
>>> I'll do some testing with it now.
>>
>> I did not encounter any problems in testing.
>>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>
>> Thanks.
>=20
> Well, I half expected Randy would find a few issues in the series,
> but seeing Randy's Acked-by, let me express my concerns.
>=20
> I won't delve into the details of each patch, but just compare the
> end result to the current behavior.
>=20
> First of all, comparison of "./scripts/kernel-doc -h | wc -l":
>=20
>     before: 46
>     after:  93
>=20
> Such a bloat in line counts looks pretty alarming to me.
>=20
> Especially, added SYNOPSIS of
>=20
>      kernel-doc [-h] [-v] [-Werror]
>        [ -man |
>          -rst [-sphinx-version VERSION] [-enable-lineno] |
>          -none
>        ]
>        [
>          -export |
>          -internal |
>          [-function NAME] ... |
>          [-nosymbol NAME] ...
>        ]
>        [-no-doc-sections]
>        [-export-file FILE] ...
>        FILE ...
>=20
> is hard to parse for me.
> This might be an accurate representation of command arguments,
> but it would take some time for me to see which combination of
> argument works for my use case.
>=20
> Let's see what "perl --help | head -n10" says:
>=20
>     Usage: perl [switches] [--] [programfile] [arguments]
>       -0[octal]         specify record separator (\0, if no argument)
>       -a                autosplit mode with -n or -p (splits $_ into @F=
)
>       -C[number/list]   enables the listed Unicode features
>       -c                check syntax only (runs BEGIN and CHECK blocks)=

>       -d[:debugger]     run program under debugger
>       -D[number/list]   set debugging flags (argument is a bit mask or =
alphabets)
>       -e program        one line of program (several -e's allowed, omit=
 programfile)
>       -E program        like -e, but enables all optional features
>=20
> The "Usage:" doesn't tell much about available switches, but as they ar=
e covered
> immediately after, this is good enough.
>=20
> "perl --help | wc -l" says: 33
>=20
> Let's see one of the few scripts with POD documents: ./scripts/get_feat=
=2Epl.
>=20
> "./scripts/get_feat.pl -h | head -n 5" says:
>=20
>     Usage:
>         get_feat.pl [--debug] [--man] [--help] [--dir=3D<dir>] [--arch=3D=
<arch>]
>         [--feature=3D<feature>|--feat=3D<feature>] <COMAND> [<ARGUMENT>=
]
>=20
>         Where <COMMAND> can be:
>=20
> , which I can parse easily.
>=20
> "./scripts/get_feat.pl -h | wc -l" says: 37
>=20
> So my preference is to keep current free-form help text for the brevity=
=2E=20
> Nowadays, ./scripts/kernel-doc is mostly invoked by
> Documentation/sphinx/kerneldoc.py.
> I don't see much point for such a non-user-facing script having nice-lo=
oking
> well-structured documentation in the first place.
>=20
> For the record, let me add a random tag to this whole series:
>=20
> Disliked-by: Akira Yokosawa <akiyks@gmail.com>
>=20
> This is by all means a personal preference, so I don't mind if Jon appl=
ies
> this series as is.
>=20
>         Thanks, Akira

Sorry for the noise.
Akira

>=20
>>
>>>> Tomasz Warnie=C5=82=C5=82o (11):
>>>>   scripts: kernel-doc: Add the basic POD sections
>>>>   scripts: kernel-doc: Relink argument parsing error handling to
>>>>     pod2usage
>>>>   scripts: kernel-doc: Translate the DESCRIPTION section
>>>>   scripts: kernel-doc: Translate the "Output format selection"
>>>>     subsection of OPTIONS
>>>>   scripts: kernel-doc: Translate the "Output format selection modifi=
er"
>>>>     subsection of OPTIONS
>>>>   scripts: kernel-doc: Translate the "Output selection" subsection o=
f
>>>>     OPTIONS
>>>>   scripts: kernel-doc: Translate the "Output selection modifiers"
>>>>     subsection of OPTIONS
>>>>   scripts: kernel-doc: Translate the "Other parameters" subsection o=
f
>>>>     OPTIONS
>>>>   scripts: kernel-doc: Replace the usage function
>>>>   scripts: kernel-doc: Drop obsolete comments
>>>>   scripts: kernel-doc: Refresh the copyright lines
>>>>
>>>>  scripts/kernel-doc | 347 +++++++++++++++++++++---------------------=
---
>>>>  1 file changed, 159 insertions(+), 188 deletions(-)
>>>>
>>>>
>>>> base-commit: 2a987e65025e2b79c6d453b78cb5985ac6e5eb26
>>>
>>
>> --=20
>> ~Randy
>=20
