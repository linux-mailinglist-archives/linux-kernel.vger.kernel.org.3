Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2F35646F2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiGCLHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiGCLHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:07:36 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91117648;
        Sun,  3 Jul 2022 04:07:35 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10be7325c29so2259117fac.0;
        Sun, 03 Jul 2022 04:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=SP3rS5YoUfLWIf11KzHU9yFd2sc0DlFU2qHWaq5i2Fs=;
        b=MFOqLowgImH3myQASXMj2egJYbfCDZbY8vRieBJlvU5/XOWwd5CGTHzeEew2/2wd7d
         kMy1OvJkAHYIXsXJI/llrcYfArRp27ayyhGQPuLMJHQ7OTOlqGfbofl0RWDB69kWxozI
         msc3DmmFqywUh7NXYLDKDh25iRUlOAbeYAdtnIicVi4PqSBWeF3wZcxy2Gk8Ts/3OahN
         SNQLu1NYPVZB9rlDxtpISxyijWouqYrrwS9jVsSj6CPaPn/hsEFIde+4ooxrC44iB48v
         QtN7mO2u132zHsQ2AAY7QvQ97gnDCalzHFqVqdTvn8ExZS0QldgW8cPLuxrphcj32eys
         AeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=SP3rS5YoUfLWIf11KzHU9yFd2sc0DlFU2qHWaq5i2Fs=;
        b=Qfe7Yp9Jb2QLH+e3I0kculNlP2W97IxpJuMTqW7GdYqezMhpIwsu50qv5Dnk/gUmve
         C5gdZXzj6xZVFXoFfzNtUQRcCymEZZTJxANiQkbT8jeRkvqwyZi4sVsFfQNqc9wzfqpm
         qPNu8e7Y4ZPZ5PxGcrsD5YN2AY6A/pxwJ3/nI27OlBhLy1vmVpmqQNe5YNk3VCj3A1XU
         ARS1eMJaJtXMj9F240SLUFqRdxpRoGsAJL/xQK52UJ8gM6UJdNVS5JaXG1N51HdS+4U5
         rlaRSjpBdM9cq11frvk61Kg8kaXJWVc83fnJQQHRiOeuokmfBtuZmAMIeIj9JZcJZndI
         Cpzw==
X-Gm-Message-State: AJIora+KBL9QkDKZh9HLDXhDIGwQEJkb2urET4NTEWunvBo6gN3OIksH
        m8EOHlFv88rxmfofNjmxhu0tLaUzdOD2pCch8zA=
X-Google-Smtp-Source: AGRyM1vyWMRmkVeORBk9q0w5S5ARtOK+hH4Y7fbYMLOh81XJU/vzmu5bkC3enNJPOxWuynFI2XNucy0XbB0Ata4+OS4=
X-Received: by 2002:a05:6870:7a9:b0:10b:f5ef:5d27 with SMTP id
 en41-20020a05687007a900b0010bf5ef5d27mr520665oab.252.1656846455080; Sun, 03
 Jul 2022 04:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVVXq0Mh8=QuopF0tMZyZ0Tn8AiKEZoA3jfP47Q8B=x2A@mail.gmail.com>
 <CA+icZUW3VrDC8J4MnNb1H3nGYQggBwY4zOoaJkzSsNj7xKDvyQ@mail.gmail.com>
In-Reply-To: <CA+icZUW3VrDC8J4MnNb1H3nGYQggBwY4zOoaJkzSsNj7xKDvyQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 3 Jul 2022 13:06:58 +0200
Message-ID: <CA+icZUVcCMCGEaxytyJd_-Ur-Ey_gWyXx=tApo-SVUqbX_bhUA@mail.gmail.com>
Subject: Re: [perf-tools] Build-error in tools/perf/util/annotate.c with LLVM-14
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 3, 2022 at 1:03 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sun, Jul 3, 2022 at 12:57 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> [ ... ]
> > util/annotate.c:1766:33: error: too few arguments to function call,
> > expected 4, have 3
> >                              (fprintf_ftype) fprintf);
> >                                                     ^
> > /usr/include/dis-asm.h:472:13: note: 'init_disassemble_info' declared here
> > extern void init_disassemble_info (struct disassemble_info *dinfo, void *stream,
> >            ^
> > 1 error generated.
> > make[4]: *** [/home/dileks/src/linux/git/tools/build/Makefile.build:97:
> > util/annotate.o] Error 1
>
> This is with Debian's binutils(-dev) version 2.38.50.20220629-4.
>
> $ dpkg -S /usr/include/dis-asm.h
> binutils-dev: /usr/include/dis-asm.h
>

[ /usr/include/dis-asm.h ]

470 /* Method to initialize a disassemble_info struct.  This should be
471    called by all applications creating such a struct.  */
472 extern void init_disassemble_info (struct disassemble_info *dinfo,
void *stream,
473                                    fprintf_ftype fprintf_func,
474                                    fprintf_styled_ftype
fprintf_styled_func);

-Sedat-
