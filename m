Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F351B579284
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiGSFeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiGSFea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:34:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA661EADA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:34:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r14so19991733wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZpvt/nDVkZNx/by2rqCcokxCcDrSaABgHJjiKPWe04=;
        b=UKIDUZ8n3SlCbEXFhHRnFzGE7USwYMpo7BRL8fDU2+hoEDWRWNU8BBm3h4WIdy7MNm
         knvxTFg/tVPi4D+dWPEctfKilEeI9bql6bmv+D46GWTl1cOX9y/TCiH81p8zHUgpn1ta
         BwfH7pfqqIfYFR9vgvokguR/zXt4UheVi64Qn4IjeycigbJYuNf3vwI/5yIyT7djxRP1
         oKcCED/Eidjnqds6P871ma8ccP0rMwH0oryYiIixhYOHreB3o5caRci8qDybQ5jX03FN
         TIFeXI/8BcwX9PelCOlM1I54jLq18ZDqhhdUUEtnmZaqEt7uSYSIppWX4ce/FCRX0+zV
         zg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZpvt/nDVkZNx/by2rqCcokxCcDrSaABgHJjiKPWe04=;
        b=wZpuiIr9GXbsxXawnzpTMVdw2YqbQKHFREDGLAgjsAD8J5XkuYgnO8y4aPEeSjNa3r
         ZtHXjEIpXLB024T+q85K+APtwoWS5aE1+YNwvjIQVJ2C3Tl9b43VBnli0ZL5i9GWr5bH
         HrCJKZNr0O69Q3cqEEYkIbPYd9034nf5T6jhHzdd9QsqgsJ8O9XLuu6Y/uf99NpgQtYG
         dW2zgCQ7v4LWiTnkBpNboGXsBNrqgqrPEJu8XLJcQl0Q6TblVZ/vqdRSFcBcSg2pgYKc
         lEz3XTceIlGFHWyVs4uJuyFAbAHagvzlS9h0sup70kIxb4sfssI6pncG3mPLxFdTDQDT
         if7g==
X-Gm-Message-State: AJIora/4a6jMMZmQR1Fic4reys8Xlhe6JFbmtmjJ0K1uOyjhraDkAkMy
        MqhFyA7RH+oUKo4qBE5YLN7V5wTNj39HN+tjTzEbyjV+AqhzTw==
X-Google-Smtp-Source: AGRyM1sGYqcJjifeqZclEnEFGEOeCtPHs5KpfV6He2nsjr2qXhCXqSil0twnsrVPSqh+YPAnDH49ZQO8wlw6XLGEo8Y=
X-Received: by 2002:a05:6000:1a8e:b0:21d:a7a8:54f4 with SMTP id
 f14-20020a0560001a8e00b0021da7a854f4mr25981039wry.654.1658208866803; Mon, 18
 Jul 2022 22:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsd0DaBtWk5cFxPhfM_cZRMQk3MbaxMRN3WJ-yNjAkp7Q@mail.gmail.com>
In-Reply-To: <CA+G9fYsd0DaBtWk5cFxPhfM_cZRMQk3MbaxMRN3WJ-yNjAkp7Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 18 Jul 2022 22:34:13 -0700
Message-ID: <CAP-5=fU+58WdCpAT5nc138AdQ31Pm=iuWt9Wh+WLmPk-kb+=Dg@mail.gmail.com>
Subject: Re: perf: util/annotate.c:1752:9: error: too few arguments to
 function 'init_disassemble_info'
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        perf-users <perf-users@linaro.org>, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kubakici@wp.pl,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:45 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> with reference to other email thread on perf build failure on Linus mainline
> https://lore.kernel.org/bpf/20220715191641.go6xbmhic3kafcsc@awork3.anarazel.de/T/
>
> I see perf build failures on stable-rc 5.18 .. 5.4 with this error [1]
> and also noticed on today's linus mainline tree.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> steps to reproduce:
> --------------------
>
> tuxmake --runtime podman \
>         --target-arch x86_64 \
>         --toolchain gcc-11 \
>         --kconfig
> https://builds.tuxbuild.com/2C7oWWWYOYGFtqq4SWX1yG4a2Ne/config \
>         debugkernel headers kernel modules perf
>
> Error log:
> -----------
>   CC       event-parse-api.o
>   CC       staticobjs/btf_dump.o
> find: 'x86_64-linux-gnu-gcc/arch': No such file or directory
> error: Found argument '-I' which wasn't expected, or isn't valid in this context
>
> USAGE:
>     sccache [FLAGS] [OPTIONS] [cmd]...
>
> For more information try --help
>
> and
>
>   CC       util/annotate.o
>   MKDIR    util/
>   CC       util/block-range.o
>   MKDIR    bench/
>   CC       bench/sched-pipe.o
> util/annotate.c: In function 'symbol__disassemble_bpf':
> util/annotate.c:1752:9: error: too few arguments to function
> 'init_disassemble_info'
>  1752 |         init_disassemble_info(&info, s,
>       |         ^~~~~~~~~~~~~~~~~~~~~
> In file included from util/annotate.c:1709:
> /usr/include/dis-asm.h:472:13: note: declared here
>   472 | extern void init_disassemble_info (struct disassemble_info
> *dinfo, void *stream,
>       |             ^~~~~~~~~~~~~~~~~~~~~

This include is guarded by:
#if defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)

and from the header path in the failure you are getting an installed
version of libbfd from /usr/include. Using libbfd (GPLv3) with perf
(GPLv2) is becoming an under tested combination due to:
https://www.gnu.org/licenses/gpl-faq.en.html#v2v3Compatibility
Add the make flag NO_LIBBFD=1 to test without libbfd, which will most
accurately match what distributions build.

Testing on my own machine with libbfd version 2.38 didn't show any failures.

Thanks,
Ian

> [1] https://builds.tuxbuild.com/2C7oWWWYOYGFtqq4SWX1yG4a2Ne/
>
> Best regards
> Naresh Kamboju
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
