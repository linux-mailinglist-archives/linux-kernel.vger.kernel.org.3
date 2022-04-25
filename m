Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CEA50DBA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbiDYIw7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Apr 2022 04:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbiDYIw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:52:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AADB1888;
        Mon, 25 Apr 2022 01:49:54 -0700 (PDT)
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Ml6i4-1oAWSa3GV2-00lXOo; Mon, 25 Apr 2022 10:49:52 +0200
Received: by mail-wm1-f53.google.com with SMTP id q20so8830299wmq.1;
        Mon, 25 Apr 2022 01:49:52 -0700 (PDT)
X-Gm-Message-State: AOAM533GogKGJ857zi7cqT1tBhDCnJI99in9rszKdBW6z/wQ3o6GvAox
        eXpUkLLZ/9WGyR9O3SDxl3lQv0kKwxG8lYAr8wA=
X-Google-Smtp-Source: ABdhPJznBo55D1o0+WIRuh7wr97I06MCGT/Bj0IN0lqL0hSs0OuVvnsKvU+rzU5QmLcLYLe1/6Wmmx7p2/jDZLH/xxI=
X-Received: by 2002:a05:600c:25c5:b0:38f:f0b9:4c8c with SMTP id
 5-20020a05600c25c500b0038ff0b94c8cmr16117479wml.20.1650876592353; Mon, 25 Apr
 2022 01:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220422151725.1336997-1-mailhol.vincent@wanadoo.fr>
 <YmXMiTXEvFXZ/swU@dev-arch.thelio-3990X> <CAMZ6Rq+3XOze01dZZRTe+V44N2uo5J_=rtd9bKH7d7Fq9sNxVw@mail.gmail.com>
 <CAK8P3a31WAyh_vLqNwvv2GMcZ8SQp7gC=OV8c=Nc9pBtOSR8-g@mail.gmail.com> <CAMZ6RqL8G4uVn--Y5pBC+_c9Ex3Sjf8OJuVRwkVFFPwWd_ezLQ@mail.gmail.com>
In-Reply-To: <CAMZ6RqL8G4uVn--Y5pBC+_c9Ex3Sjf8OJuVRwkVFFPwWd_ezLQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Apr 2022 10:49:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1_XoyjOPQ0ghku_QUjUL5V6BK9kSNUXoQj2RYaA=JxFg@mail.gmail.com>
Message-ID: <CAK8P3a1_XoyjOPQ0ghku_QUjUL5V6BK9kSNUXoQj2RYaA=JxFg@mail.gmail.com>
Subject: Re: [PATCH] checksyscalls: ignore -Wunused-macros
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:YnibiRNyIgeuI2nPVLClsnhP1828FAbmVUYeoPkiNrTa8wA+aCl
 6nzkkwwCK5ra4jSO7yof9xi3ag8OBY0xP5UmorHgQsejui3M9qi3murGQaZFx/Mg2kGKXHq
 FPp3V1OHPtZbC7El9/GdWOZ+P1nSrAIqMoxlf2oErQQKh0McIDvYWRYQ4ekb5/5J01PdiXZ
 Ye1OtdgWjHzcSyzU6COLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:etjVTRUMtNY=:8cGRRh6scKpqNjfImdGj3i
 g+ZFj0No7LeBfPC67hzJbwkxVfMshswEBhgLUO4slSJQiXYB1DEi6eT2/qsqIWEnGBQrgO2R7
 LifyBz0oqLavS2KzlAF3bCy73b/s+/27PO3mk2+zc+Oxfo7qg2azx7n3yS+xb3FRzeZbOZhya
 ivvzL3J/xylS5rS8IbqUAvrJ9EmfShRzWWqgyzcdGY+O+z9HXlqXn/IY+QZFzaUd4SNtZ7adu
 H1yPXH64w1wEya33VsrnWUNDvUuAaeQPxar2UeHROM6j8veInZY+5CKE2OUS+IoO2pEmrre6/
 3q9oICfw7ubdw6Ur7GL9WuR9idFrSiNGG02qhObVaSIwZb6WaZkGt0OGGzVwVo7Onwdb+3OYc
 qc5VXwRXZYyZgzSoM2PcFClSl4+sD+ddqPDQwPhr2V3YU3CoS6Iso0qMpZYciuyG3vDWgjpzr
 Vs/Cyi9F6lSDwgLMFBZdoTIxwAMWW5LmZ9Y6/+4aAbaPIUyC7QcqDo4WPFphSfQiMrpJExoEQ
 VcQ5jokFi6lMeSlPkZmQQeGU0MqPwG9aiS5Jo43oqrtY+2ulyT84SMts6WK0NZ1k03n2GTFh0
 LwGjgh3Yzr/D3Gj/BNgaHXB2qEX/V33xfv8gPC1oyEMCL2bl0JED4J20Dz+2uLmWW4yYubmU0
 /P+xgXZW2jd0nbn0sElVaHX0uM40jvaS9B5WwgIM0MY2f2MpScUU0w0VloDmCtK3oYvPAYto4
 YvSnHaGXQji3ociDCFODER4kmqhvG5y50UJmSSIXJ25HkMT/Qbxu7Gcfe3bEdambM6+TUdJTf
 yovSdyNhvk2gDEoTKwnHy2XIq8BXy1ixZj3euLHFjUYMO7Wo1k=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 9:42 AM Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
> On Mon. 25 Apr 2022 at 15:50, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Apr 25, 2022 at 8:17 AM Vincent MAILHOL> <mailhol.vincent@wanadoo.fr> wrote:
> > > When I run W=2, I want to only see the warnings of the file I am
> > > working on. So I find it useful to fix the W=2 warnings which
> > > show up when building other files to not get spammed by
> > > irrelevant issues and to simplify the triage.
> > >
> > > My initial message lacked the rationale. I will add additional
> > > explanations in the v2 of this patch.
> >
> > I agree this is worth fixing if we want to make W=2 have any meaning at all.
> >
> > Your approach is probably fine. We could try to improve this by comparing
> > against the list from include/uapi/asm-generic/unistd.h instead of the i386
> > list. I suppose that would involve rewriting the script into a simpler one,
> > but I'm not sure if anyone has an interest in working on this.
>
> If someone wants to do it, great, but I do not have the
> confidence to do it myself so I hope you will forgive me for
> taking a pass here.

Sure, no worries.

> Another alternative I considered was to only call
> checksyscalls.sh when doing a 'make all'. This way, we keep the
> warning but people won’t be spammed when building sub projects
> because the script would not be executed.

Right, I like that as well, one less thing to be done for every
iterative make as well. The syscall table really doesn't change
all that much that this needs to be run by most developers.

      Arnd
