Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9E14C09F8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbiBWDJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiBWDJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:09:05 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4743D4A917;
        Tue, 22 Feb 2022 19:08:39 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i6so14010810pfc.9;
        Tue, 22 Feb 2022 19:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=lr/gOX9xgp0nq2qYu+zDnEx5Mljg5EzzT3crt0n0JOI=;
        b=RV7SIwuv5XMqCcLWETrWXwl0P9OCI/vI4lXp3wsCKDfkgNvR9GQ03TQHUfixkGJ5Z+
         A2Wt768FNZnXGwjl50fQcSZ83zjPfl+QAmru2ZZAR/gl5/40/tS8gtiWYLCcuoDg/mND
         WSl7Gou7ZVppQeyCWnozOdkHRvbyKcovwQxl6Om0m7LhymXWY6vXvPhxlSGVhRyJYr9M
         Zv27Rl8kBFAPBYG/uiO/aEgya69XbbY6XlLCfJNOofOFpOkphtNWVAeTiD8G8+hpMn1/
         ve/9UtH4nDe3mWOBcUOcUhGBxQxtCl9G8mZ7fPyAFcSmn/wEhhMUyDJKR0O1IbqhiDnl
         Wg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=lr/gOX9xgp0nq2qYu+zDnEx5Mljg5EzzT3crt0n0JOI=;
        b=pSE0nZlcuDhpLX0SfoqcTgf4dJv4uB0XDMlCAucBqnWMwefYSguG+jMR8LadjML4F3
         NG2dZm572Fgq42pqg/VHBMfsqmWqKgCNCdi3B3Ho/GYoJnaAHlxcySVKMwWPVwqFvmSu
         cV8piVvMP1QFLrqtHXYX+sHquJ41dgELbQvlKC2MhMIioM151xUbAQBjT5rX23Uqb3DE
         b4fVV4W7laiGfoKlobm+vAqOj2Nx1RehCSlMLwVHUMMHaA91dkTG6IVKKRmNVBXE7OGQ
         IfbxlBZn4k2DZemMfoaB8llnjLQQN1baR7p+ApaNi4yr1Av79FEybGreE51GJzDLsg/Y
         Nw0w==
X-Gm-Message-State: AOAM5338bI2hCNj6turlKIQxhoeagZ6iXy9l/X2LjyRef1qh7u7ZtGJr
        JBVfwwK7ktXHWERCvgge/L4=
X-Google-Smtp-Source: ABdhPJzaVSSOm1SByrnZ80ZZWZuFliWYmXzRz8Jj842pwtAg7YIPw01bmh8mYJIqcY+UJ/RBA2zmfw==
X-Received: by 2002:a63:51:0:b0:372:8dda:4fa with SMTP id 78-20020a630051000000b003728dda04famr22588931pga.75.1645585718732;
        Tue, 22 Feb 2022 19:08:38 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm1042164pjc.56.2022.02.22.19.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 19:08:38 -0800 (PST)
Message-ID: <ff98f455-0221-7ff0-08ed-8dea9f08694b@gmail.com>
Date:   Wed, 23 Feb 2022 12:08:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?B?VG9tYXN6IFdhcm5pZcWCxYJv?= <tomasz.warniello@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <525f3696-91f4-5a4a-c9ef-24758ccaa2bb@infradead.org>
Subject: Re: [PATCH v4 00/11] Transform documentation into POD
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <525f3696-91f4-5a4a-c9ef-24758ccaa2bb@infradead.org>
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

Hello Randy, Tomasz,

On Tue, 22 Feb 2022 13:31:31 -0800,
Randy Dunlap wrote:
> Hi--
>=20
> On 2/21/22 21:39, Randy Dunlap wrote:
>> Hi Tomasz,
>>=20
>> On 2/18/22 10:16, Tomasz Warnie=C5=82=C5=82o wrote:
>>> This series transforms the free-form general comments - mainly the us=
age
>>> instructions and the meta information - into the standard Perl
>>> documentation format. Some of the original text is reduced out. And s=
ome
>>> is simply dropped.
>>>
>>> The transformation includes language, paragraphing and editorial
>>> corrections.
>>>
>>> The only change in the script execution flow is the replacement of th=
e
>>> 'usage' function with the native standard Perl 'pod2usage'.
>>>
>>> The to-do suggestion to write POD found in the script is ancient, thu=
s
>>> I can't address its author with a "Suggested-by" tag.
>>>
>>> This version follows the advice received on v3, except I'm leaving
>>> the old copyrights untouched.
>>>
>>> The process consists of 14 steps.
>>>
>>> Patches beginning with no 3 are disfunctional until no 9 has been
>>> applied.
>>>
>>> 1) Add the basic POD sections
>>> 2) Relink argument parsing error handling to pod2usage
>>>
>>> The following subseries is disfunctional before its last part.
>>>
>>> 3) Translate the DESCRIPTION section
>>> 4) Translate the "Output format selection" subsection of OPTIONS
>>> 5) Translate the "Output format selection modifier" subsection of OPT=
IONS
>>> 6) Translate the "Output selection" subsection of OPTIONS
>>> 7) Translate the "Output selection modifiers" subsection of OPTIONS
>>> 8) Translate the "Other parameters" subsection of OPTIONS
>>> 9) Replace the usage function
>>>    =20
>>> Here the DESCRIPTION and OPTIONS subseries is finished. The -h and -h=
elp
>>> parameters are handled by POD now.
>>>    =20
>>> 10) Drop obsolete comments
>>> 11) Refresh the copyright lines
>>>
>>> Let's see what's wrong this time.
>>=20
>> This patch series looks good to me.
>> I'll do some testing with it now.
>=20
> I did not encounter any problems in testing.
>=20
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>=20
> Thanks.

Well, I half expected Randy would find a few issues in the series,
but seeing Randy's Acked-by, let me express my concerns.

I won't delve into the details of each patch, but just compare the
end result to the current behavior.

First of all, comparison of "./scripts/kernel-doc -h | wc -l":

    before: 46
    after:  93

Such a bloat in line counts looks pretty alarming to me.

Especially, added SYNOPSIS of

     kernel-doc [-h] [-v] [-Werror]

       [ -man |

         -rst [-sphinx-version VERSION] [-enable-lineno] |

         -none

       ]

       [

         -export |

         -internal |

         [-function NAME] ... |

         [-nosymbol NAME] ...

       ]

       [-no-doc-sections]

       [-export-file FILE] ...

       FILE ...


is hard to parse for me.
This might be an accurate representation of command arguments,
but it would take some time for me to see which combination of
argument works for my use case.

Let's see what "perl --help | head -n10" says:

    Usage: perl [switches] [--] [programfile] [arguments]

      -0[octal]         specify record separator (\0, if no argument)

      -a                autosplit mode with -n or -p (splits $_ into @F)

      -C[number/list]   enables the listed Unicode features

      -c                check syntax only (runs BEGIN and CHECK blocks)

      -d[:debugger]     run program under debugger

      -D[number/list]   set debugging flags (argument is a bit mask or al=
phabets)

      -e program        one line of program (several -e's allowed, omit p=
rogramfile)

      -E program        like -e, but enables all optional features


The "Usage:" doesn't tell much about available switches, but as they are =
covered
immediately after, this is good enough.

"perl --help | wc -l" says: 33

Let's see one of the few scripts with POD documents: ./scripts/get_feat.p=
l.

"./scripts/get_feat.pl -h | head -n 5" says:

    Usage:

        get_feat.pl [--debug] [--man] [--help] [--dir=3D<dir>] [--arch=3D=
<arch>]

        [--feature=3D<feature>|--feat=3D<feature>] <COMAND> [<ARGUMENT>]



        Where <COMMAND> can be:


, which I can parse easily.

"./scripts/get_feat.pl -h | wc -l" says: 37

So my preference is to keep current free-form help text for the brevity. =

Nowadays, ./scripts/kernel-doc is mostly invoked by
Documentation/sphinx/kerneldoc.py.
I don't see much point for such a non-user-facing script having nice-look=
ing
well-structured documentation in the first place.

For the record, let me add a random tag to this whole series:

Disliked-by: Akira Yokosawa <akiyks@gmail.com>

This is by all means a personal preference, so I don't mind if Jon applie=
s
this series as is.

        Thanks, Akira

>=20
>>> Tomasz Warnie=C5=82=C5=82o (11):
>>>   scripts: kernel-doc: Add the basic POD sections
>>>   scripts: kernel-doc: Relink argument parsing error handling to
>>>     pod2usage
>>>   scripts: kernel-doc: Translate the DESCRIPTION section
>>>   scripts: kernel-doc: Translate the "Output format selection"
>>>     subsection of OPTIONS
>>>   scripts: kernel-doc: Translate the "Output format selection modifie=
r"
>>>     subsection of OPTIONS
>>>   scripts: kernel-doc: Translate the "Output selection" subsection of=

>>>     OPTIONS
>>>   scripts: kernel-doc: Translate the "Output selection modifiers"
>>>     subsection of OPTIONS
>>>   scripts: kernel-doc: Translate the "Other parameters" subsection of=

>>>     OPTIONS
>>>   scripts: kernel-doc: Replace the usage function
>>>   scripts: kernel-doc: Drop obsolete comments
>>>   scripts: kernel-doc: Refresh the copyright lines
>>>
>>>  scripts/kernel-doc | 347 +++++++++++++++++++++----------------------=
--
>>>  1 file changed, 159 insertions(+), 188 deletions(-)
>>>
>>>
>>> base-commit: 2a987e65025e2b79c6d453b78cb5985ac6e5eb26
>>=20
>=20
> --=20
> ~Randy

