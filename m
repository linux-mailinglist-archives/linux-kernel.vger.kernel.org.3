Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E4C556EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359741AbiFVWyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbiFVWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:54:11 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DF8CD3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:54:10 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id y14so22120302qvs.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xOI/GkrveqegLV0ZiA89XQMlzXKK1gnmlyXBoe5Frn8=;
        b=CKwerhgwYtfg0OfQjTnGN6F7BITz4u9urXefas1N1EGHv2kdE8KJoAbyDvInaTs7nF
         sT3zxw/yawuZHzqCLuezSDHOaXWqxX8kT35jqywKpWSyTZAMwxTAxDDLUh/pfeG3H+Yq
         Rxsuvj/K63F30Tm3mlmjTN4XWm2R8JznQfotEfWVIjZxhmURwvAsB5kXHvYYTMSo1mKA
         iZpDrnwmeoVvfaiFifIYXwiO7Nnmn50+j5Pf9N4CzUqpN3ZBUPkCL617mNo60uwjcE4Q
         g2vNZJ9VpKe0CurrhSQlHxCQNLx8lDPn5TbA5mywMZqDlGlRxgfLII5nPfQTMH9H0vYE
         VPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xOI/GkrveqegLV0ZiA89XQMlzXKK1gnmlyXBoe5Frn8=;
        b=50lHQ0xu3/TZPNSluqV+wdpI2lSunMUQpAH0ay44KQ7p/oTgnFsVkAPUJePn+HyXFR
         naqr6UmytNQzbLNtf/qOfr1bCRQxW3y8qEm6iGm5X5l3ALtd7Uw7uRzLwKlasqig5H89
         rKx5qo/9GpHhEOChRe16zymk7OFHEROHiRxxMfgIsYe7dEhGoyDwM7FNFIifbNB4kK67
         IuZJVMdqMs39Aolr03Ql1VK9G335epcDREO0FovxhpU8xx8It9CwvfXXt3m86B6RqGjS
         8Vg4T3wPJWU7RAvnJRJS/Zqlc9gDsWKzoBglmVcvPG04KDNTznVbADWM666h+rK0ZXgI
         HZAQ==
X-Gm-Message-State: AJIora8vxbH9A72iVfUZqLRJ5JZP5Uo411UQV0glshHO4XGkDu28iwfb
        QBsODPWzKcyhK7U5PHqvX9mrWO1OGUw8K3ANEYAymA==
X-Google-Smtp-Source: AGRyM1uSjSYpOgE2K/ytbyyVG+gEi/qF/kFpxCg3I8VsfWQzv604ar9L2U7WDWZGBdknA1o3FhGywNy9FJlvIpavhqI=
X-Received: by 2002:a05:6214:1851:b0:470:2a5f:d68e with SMTP id
 d17-20020a056214185100b004702a5fd68emr22802267qvy.68.1655938449301; Wed, 22
 Jun 2022 15:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de>
In-Reply-To: <20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Wed, 22 Jun 2022 23:53:58 +0100
Message-ID: <CACdoK4LeRPkACejq87VLFgP-b=y1ZoRX3196f7xEVo-UWm8jWA@mail.gmail.com>
Subject: Re: init_disassemble_info() signature changes causes compile failures
To:     Andres Freund <andres@anarazel.de>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 at 19:19, Andres Freund <andres@anarazel.de> wrote:
>
> Hi,
>
> binutils changed the signature of init_disassemble_info(), which now caus=
es
> perf and bpftool to fail to compile (e.g. on debian unstable).
>
> Relevant binutils commit: https://sourceware.org/git/?p=3Dbinutils-gdb.gi=
t;a=3Dcommitdiff;h=3D60a3da00bd5407f07d64dff82a4dae98230dfaac
>
> util/annotate.c: In function =E2=80=98symbol__disassemble_bpf=E2=80=99:
> util/annotate.c:1765:9: error: too few arguments to function =E2=80=98ini=
t_disassemble_info=E2=80=99
>  1765 |         init_disassemble_info(&info, s,
>       |         ^~~~~~~~~~~~~~~~~~~~~
> In file included from util/annotate.c:1718:
> /usr/include/dis-asm.h:472:13: note: declared here
>   472 | extern void init_disassemble_info (struct disassemble_info *dinfo=
, void *stream,
>       |             ^~~~~~~~~~~~~~~~~~~~~
>
> with equivalent failures in
>
> tools/bpf/bpf_jit_disasm.c
> tools/bpf/bpftool/jit_disasm.c

Hi Andres,

Too bad the libbfd API is changing again :/ But many thanks for
pinning down the relevant commit, and for the report!

> The fix is easy enough, add a wrapper around fprintf() that conforms to t=
he
> new signature.
>
> However I assume the necessary feature test and wrapper should only be ad=
ded
> once? I don't know the kernel stuff well enough to choose the right struc=
ture
> here.

We can probably find a common header for the wrapper under
tools/include/. One possibility could be a new header under
tools/include/tools/, like for libc_compat.h. Although personally I
don't mind too much about redefining the wrapper several times given
how short it is, and because maybe some tools could redefine it anyway
to use colour output in the future.

The feature test would better be shared, it would probably be similar
to what was done in the following commit to accommodate for a previous
change in libbfd:

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dfb982666e380c1632a74495b68b3c33a66e76430

> Attached is my local fix for perf. Obviously would need work to be a real
> solution.

Thanks a lot! Would you be willing to submit a patch for the feature
detection and wrapper?

Best regards,
Quentin
