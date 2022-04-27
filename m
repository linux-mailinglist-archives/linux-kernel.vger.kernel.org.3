Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EED511373
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359382AbiD0IaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351635AbiD0IaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:30:24 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D293E37A95
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:27:13 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2eba37104a2so10704277b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8VLGTbA5pN1qEZ6t/KO2HTTvYC1CxFpkUcCfBoknVFA=;
        b=LthBaeXhB5m21amgnJGSUwV5Z/VsBONkcQLGDLBe+ndjyAOXSFAT1IMkogQuUJbOGS
         T2UZ39+LlTXq9omzL9f/RRBgprO+S27MczBOzRB9Le/ImMGtVHrBjzB+8E0zilsnIboq
         lsSMcXucnmRpfcrek4ceFxCFhmv/uTiz4SS2eaN5x802kMdOOOFhBUF0vy3QZsi2B5+I
         jLe2FwO6ZJCI5vx0lQ758wlMvdR3NkD+2Cex51g2ES+lfk1DFEcKQvKg3/TvlrELd297
         PWbXvqkR46B4WROrly6W+LozlrEcAtn7e+KqRHoWFQx63INrxKuzlxurFexxeYoHtsZr
         xMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VLGTbA5pN1qEZ6t/KO2HTTvYC1CxFpkUcCfBoknVFA=;
        b=q7pStQOrTcR9mM5WxoW+8W+lipu6Gcayqq0QGU+gf++x1N1WDjmArwb43b9iLROdoP
         5NbOtrtnBVcR5yxFn8wxe65p1ijS4nixZOjZFbvztiEK2q5l/We2EoT71NXnsjYr3OU3
         MZnUm0TQQ6Y1URq2h7LeUWO3OCJVS3vLpAk803AUAYhlyyHLKnYQCBjtl4uPFyJqvOoN
         HL5RLgyApY7NJeG3lnnQypMYi8/WkmRTPda7T3iOIvauXaBW5ZJ8PV9vj6gYP37RBQIm
         NhFcgCcFS9mAhaLEnWLVrFK4KEOn7JQX4Ba0nUzhCHuRXxElbjG41NX/VdndTrcIS2W6
         6yCA==
X-Gm-Message-State: AOAM533G5w5+6+Cg67BG9xuq2tyw3mx09YiOXG6HJ+uGrz+HHKL+fvC4
        jSfLQc1Ya1YOx+47mA591YOLwtiGh9ZJftEBqTE=
X-Google-Smtp-Source: ABdhPJzlNHMClbFxQx+v1+LlOFHdifLb7BtDjVuQN7y3+RAqEWjhBaA+uSvMWAJ8DgPJE6tgDbWaP5AM87eVBNPoRj0=
X-Received: by 2002:a81:ac57:0:b0:2f1:99ec:91a2 with SMTP id
 z23-20020a81ac57000000b002f199ec91a2mr26024358ywj.329.1651048033160; Wed, 27
 Apr 2022 01:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220316041612.71357-1-jiangshanlai@gmail.com>
 <20220317221943.6vhoqx3fdv7py6hi@treble> <CAJhGHyC1qPee2QOpgR8B+2Sd+XzfoJD3NL9biFZ5gKE-B9r_rQ@mail.gmail.com>
 <20220318170312.rc2zgtubddg4dpya@treble> <CAJhGHyAjXgqxxH+myLt0nMcSLQWWLrcOb8WevyQNf-Oajip7-A@mail.gmail.com>
In-Reply-To: <CAJhGHyAjXgqxxH+myLt0nMcSLQWWLrcOb8WevyQNf-Oajip7-A@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 27 Apr 2022 16:26:59 +0800
Message-ID: <CAJhGHyBbN82UTEqFy1_=bPo+8a13S24jUzwKu5o5jJu3jbkETA@mail.gmail.com>
Subject: Re: [PATCH] x86/sev: Add ENCODE_FRAME_POINTER after stack changed for #VC
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 8:24 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> On Sat, Mar 19, 2022 at 1:03 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> > Ok, maybe Joerg can test it.  It looks obviously right to me though.
>
> It looks also obviously right to me.
>
> Hello, Joerg
>
> Any feedback?
>
> > Since it fixes a real frame pointer unwinding bug, it probably needs:
> >
> >   Fixes: a13644f3a53d ("x86/entry/64: Add entry code for #VC handler")
> >
> > Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
>
> Hello, Borislav
>
> Can you have a look at the patch, please?
>
> Thanks
> Lai


Hello

Ping.

Thanks
Lai
