Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EDC4FA950
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbiDIPkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiDIPkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:40:40 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3D48EB63
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 08:38:33 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2eba37104a2so125547277b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 08:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=c83XXeCLB1ObdQnEZnhIKS/qqF+2RWAtT2NYf+GsPds=;
        b=R6QRTwR4/WVRaI3N6X3kcGZ7radK3OCxxA9Iiky/Y9+Zq+Ntf3HsoRg4kgJHMH7QM5
         wiw+xQhRBtbZDn/5SqVFKt7O87y31/J9Bbf83a4IY8LT5xOWmU0oWFFOKqIlSjbGrW7V
         ioke3SR3doSBhHmmjKo6vzDOOIQaVNFwQKdgZkoYU3hC0WK9UelHieBnjK9A4XI5v3fc
         eneNQHDINBamUDR1Cq972Nb1bFlJonjwhPOA6aNEaX2/cQxAamtQMdK25ROnZ/lGH7Gy
         aJoLnTrMUwsRg9oB7ETVLOmY6YZ5rOiYcY9At2hh11XwwYnTQP3D04pEMjlmruwXdDMt
         ExtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=c83XXeCLB1ObdQnEZnhIKS/qqF+2RWAtT2NYf+GsPds=;
        b=wZYwrPKik4HxutIGa6MoITJyQV9H95Ayp3nCBBXrE0NpnxLOTgkDdFu6aTAV2VQUdf
         ISdEzreKPE1673C9tPfanc3JVaGayoPPQEB5QeUJZmPT4ivtldTzE5SO4IebkKUNkKUx
         ZMYPnanYk9vhvnMuTU7FmMSy1r7XOY+E1kekXYVfLQ7FG6MOlzCQKwOi2PLXvX6TE9iu
         OUSVEsxyceZTMn+O7Uf/5kJxIxCW8LyuQDm6hNwBheLbGXeGgX5/VcV4+BzNL0QGF2Hw
         AKpDeF67sytn3XJ6Xj51wSHFa3PPcw3Vp4ZJvt1wIqKOQKCBBDLPpEVBfmmHNhU5XyWf
         GxLw==
X-Gm-Message-State: AOAM53061mvyHjCs6OxvmIbpZ7TEJuoEjFrpvm0eXybX8qBd7oiHB5cN
        1GB6Tt2I/xLMNHYk5tAugxT4Ke5wZeJOYqGeqvrSBQT9EGIlFnxetBE=
X-Google-Smtp-Source: ABdhPJyxxWvz2BL/ufhkVYlQVcbsbC3E+no+AgVJiB+I3e3iHJD/jxX02dAHun7+HxiVLH0p6S4v3ndz554mV7QbHkc=
X-Received: by 2002:a0d:cb46:0:b0:2eb:f8fc:1e21 with SMTP id
 n67-20020a0dcb46000000b002ebf8fc1e21mr2323316ywd.261.1649518712044; Sat, 09
 Apr 2022 08:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <CADt9uBkMkrywjSo_jyUJtS85ATTQtRTVXPRsRVUKZpujYo9SUQ@mail.gmail.com>
 <CADt9uBmCpGDOgd24QA=5sbO+JVQMA+z8xTO5z3W=MWyM9hsiSw@mail.gmail.com>
 <CADt9uB=OwN2OtzDfOk+SjF2QWdZnyzmD6KeqNd-gxZ_j6dkW4g@mail.gmail.com> <CADt9uBk+s04NFr+MepmqdLEbbt4d7tmZ5Jxz2jV8v6SmkdnaAA@mail.gmail.com>
In-Reply-To: <CADt9uBk+s04NFr+MepmqdLEbbt4d7tmZ5Jxz2jV8v6SmkdnaAA@mail.gmail.com>
From:   NULL <ayz.out@gmail.com>
Date:   Sat, 9 Apr 2022 16:38:21 +0100
Message-ID: <CADt9uB=RkXXbvOOSCPmx8sMnoESd4yA+apda2fo-Yy5jYPYe3Q@mail.gmail.com>
Subject: Fwd: Request: Regarding the phasing out of "a.out support" in Linux Kernels
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Forwarding To Relevant People.
 (Have been unable to respond to previous talks, many apologies for
the late input.)



  --------- Forwarding message --------
From: <ayz.out@gmail.com>
Date: Apr 9, 2022
 Subject: Request: Regarding the phasing out of "a.out support" in Linux Kernels

To: <bp@alien8.de>, <x86@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <bp@suse.de>, <arnd@arndb.de>


Noticed in the previous conversations that it was mentioned nobody had
complained of it being removed, I do understand that everything must
be taken out eventually...

But I still wanted to ask that it remain active in 5.18's full release
while announced that it would be inactive/turned off by default in the
future 5.19 & 5.20 releases (5.20 being the last that would have it as
inactive before full removal of related code) if LTS

I feel that would be considered a fair & reasonable 'heads up' and
provide a modern LTS version of the kernel that has the function still
available by default.
 This is just a simple request from an interested user of Linux that
wouldn't be as qualified or experienced as some of the others involved
in the decision making process & I always would of-course respect
whatever final decision that everyone lands on after the discussions
are closed. :3
