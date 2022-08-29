Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8C95A4387
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiH2HIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiH2HIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:08:00 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099724D25B;
        Mon, 29 Aug 2022 00:07:59 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id b44so8900707edf.9;
        Mon, 29 Aug 2022 00:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=g0EP4Oyc9NAr4lZott25SkpzseNMp6ZScl0ZwkOE8NY=;
        b=y9sriilQTLe6O0EFBV7XqF0LTzkvCzVvmBZ+l3yPP5Pr4xFZHNRMv38d1GXybE4k8C
         BGbGRLI/TehaQu8uhWwSEIFu1aiem39nDTMzJauljS9TBemF/emOQIszYFRwW3J8kHYA
         t4wRGnKvMOHPdr4QU4oQihi/pBRcrB76gW1FVKA0kcSZge1GW2z0JVHjgaercGaeLaED
         iqXeBj7VfGJOgsFxdl6q5ZNj5YrUAqz6EOBRsG2aaQe+EnqUIJ5Y9NcJSuAFgQd0DqhZ
         +wsvA4roK8jJax98ydmzopEzc+DWYqMbQ4b5kP5dCRffwHs3UOJiRwrihMBIeaYgG5DW
         lt6Q==
X-Gm-Message-State: ACgBeo2lpQTEgUQwtjbwaFO3KKcLfHh9wbHVf6wb57PildCWuGCbh/Ni
        WsdHhUfmftx8JH3RRdgz/xU=
X-Google-Smtp-Source: AA6agR5Hh7Nn7AW2WJDI4RPSZM8LxksjvM53WEB3AFLUSEq2+8eIOWa/cvqn4/3eNwLvWJlYr9ea+w==
X-Received: by 2002:a05:6402:4411:b0:437:b723:72 with SMTP id y17-20020a056402441100b00437b7230072mr15694927eda.38.1661756877587;
        Mon, 29 Aug 2022 00:07:57 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id qq12-20020a17090720cc00b0073dcdf9b0bcsm4236366ejb.17.2022.08.29.00.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 00:07:57 -0700 (PDT)
Message-ID: <384c1908-6602-1a07-875f-0b2e56a06707@kernel.org>
Date:   Mon, 29 Aug 2022 09:07:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] scripts: remove obsolete gcc-ld script
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Liska <martin.liska@suse.com>
References: <20220825091517.30842-1-lukas.bulwahn@gmail.com>
 <CAKwvOdkY=ye4PKi8KwP-ux73pwZs+J_Oq3wR7ep8S81=aCWtqA@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAKwvOdkY=ye4PKi8KwP-ux73pwZs+J_Oq3wR7ep8S81=aCWtqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 08. 22, 19:19, Nick Desaulniers wrote:
> + Jiri in case this needs to be carried downstream.

Thanks.

> On Thu, Aug 25, 2022 at 2:15 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>>
>> Since commit 8564ed2b3888 ("Kbuild, lto: Add a gcc-ld script to let run gcc
>> as ld") in 2014, there was not specific work on this the gcc-ld script
>> other than treewide clean-ups.
>>
>> There are no users within the kernel tree, and probably no out-of-tree
>> users either, and there is no dedicated maintainer in MAINTAINERS.

There are out-of-tree users.

>> Delete this obsolete gcc-ld script.
>>
>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> No callers in-tree; happy to bring it back though should there later
> be. Thanks for the patch.

I agree to have this downstream-only for the time being. We have updates 
for it queued, so we'd only start tracking the full content now...

BTW the script is not nice at all. How do the clang people cope with the 
issue? (Running gcc-ld instead of ld with proper arguments when linking 
using (full) LTO. For example "-z now" -> "-Wl,-z,now".)

> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
>> ---
>> If there are no objections, I would like to get this patch included
>> through the kbuild tree.
>>
>> Masahiro-san, please pick this patch.
>>
>>   scripts/gcc-ld | 30 ------------------------------
>>   1 file changed, 30 deletions(-)
>>   delete mode 100755 scripts/gcc-ld
>>
>> diff --git a/scripts/gcc-ld b/scripts/gcc-ld
>> deleted file mode 100755
>> index 997b818c3962..000000000000
>> --- a/scripts/gcc-ld
>> +++ /dev/null
>> @@ -1,30 +0,0 @@
>> -#!/bin/sh
>> -# SPDX-License-Identifier: GPL-2.0
>> -# run gcc with ld options
>> -# used as a wrapper to execute link time optimizations
>> -# yes virginia, this is not pretty
>> -
>> -ARGS="-nostdlib"
>> -
>> -while [ "$1" != "" ] ; do
>> -       case "$1" in
>> -       -save-temps|-m32|-m64) N="$1" ;;
>> -       -r) N="$1" ;;
>> -       -[Wg]*) N="$1" ;;
>> -       -[olv]|-[Ofd]*|-nostdlib) N="$1" ;;
>> -       --end-group|--start-group)
>> -                N="-Wl,$1" ;;
>> -       -[RTFGhIezcbyYu]*|\
>> ---script|--defsym|-init|-Map|--oformat|-rpath|\
>> --rpath-link|--sort-section|--section-start|-Tbss|-Tdata|-Ttext|\
>> ---version-script|--dynamic-list|--version-exports-symbol|--wrap|-m)
>> -               A="$1" ; shift ; N="-Wl,$A,$1" ;;
>> -       -[m]*) N="$1" ;;
>> -       -*) N="-Wl,$1" ;;
>> -       *)  N="$1" ;;
>> -       esac
>> -       ARGS="$ARGS $N"
>> -       shift
>> -done
>> -
>> -exec $CC $ARGS


-- 
js
suse labs

