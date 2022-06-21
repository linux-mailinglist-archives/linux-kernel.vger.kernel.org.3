Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04273553E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355356AbiFUWGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353230AbiFUWGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:06:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C7A2D1D0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:06:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f39so9012264lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWSQrXn4FKbri7bJtVQ68GL0P+1bReHIxO5pBLDYc2w=;
        b=eJQBYtmvEHSqRbZSbiMYBb0Af4lOvLWdbaqfzOi/mavmjcPHXudqxs0/8DcAOEd1E1
         Q6DTzllxxeZVj00vYojpiTMGw/Rch/Atoq7QS8sGL56difveeOsZW5g2D5iIqhMqJULz
         VsGEdoHkAacQ8BaeqtkdvNhZ7LuZDwQ2DbCm87RVaQIfJcNxjKz3avfCsJLTvCM4Hbxt
         c+APLFfOm2uNLCA1lq4UyZ2L0ro12ho5cFSNTQ01fGatdurXr047nYPa/YoHp8qpTWOh
         1kv8iPu0ZaJDYzyp29ORL8Fb+Cy79IMcpO02nYbkfK+t5Y7bishSTSMN2Ap+TPiY5MUY
         f8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWSQrXn4FKbri7bJtVQ68GL0P+1bReHIxO5pBLDYc2w=;
        b=cNmdrw+FlG1RRZ4PRDwrAdXPG0oAkQnYwmt8BCHojC2CEIFkUO7z2/JkaRZMviLuXn
         hiVKPrAvmsA8ApOeC6gtU1xls8UIO0b15+VvQpumiPPT3ej0g+lcInfV4bwoRl8qyDCm
         M+FmOWh9r2Gf2jUiyHaaofyZQiSa0bSPzhvWyoBKTkNxT9XgS5mdO9MHgJEFGJtEjoqH
         9/axLAEbuTuL7fEDEFP/PmP3Vz7kGZYLEdEFLXNc6QVE001JVTQilOklpdrVmulT3UQG
         cRVzRvi11zAFeqtRqWCQIn66ivgUlurOC276z605J1FLruMFSC+5/3/jWVWK/7N/Gjgt
         ZuAQ==
X-Gm-Message-State: AJIora+6SGvM8YfK8DkM8cJ4TFaQEMq90jzwoXJSkfhvmDE0e3vr4Cnj
        /IQ4K08IImny+wX2jvJkZRL5KuDiZAflVWZ4sbRaxQ==
X-Google-Smtp-Source: AGRyM1v8wo7hwa2uixvj6gCTLmESdbXg1gm7BPj/ZZLC1D/uXa0EJN44zvwdPUncmLNKd/yrJlJKQGixM27d4moFLnk=
X-Received: by 2002:a05:6512:3f9f:b0:47d:c87e:f8f3 with SMTP id
 x31-20020a0565123f9f00b0047dc87ef8f3mr219129lfa.401.1655849177384; Tue, 21
 Jun 2022 15:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnb-DiAnq4bT7XiJpFtqyJYpWNw1shEp8gWYpVmUpRBaA@mail.gmail.com>
 <8c5012c88989a8f05a3b67540b9172336c57ddf7.camel@redhat.com>
In-Reply-To: <8c5012c88989a8f05a3b67540b9172336c57ddf7.camel@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Jun 2022 15:06:06 -0700
Message-ID: <CAKwvOdmJgU_MZjwuVXz5QvFdA4+eTHKqxT06HMAq=Hau03ar9Q@mail.gmail.com>
Subject: Re: Plumbers conf presentation on -fanalyze?
To:     David Malcolm <dmalcolm@redhat.com>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 3:08 PM David Malcolm <dmalcolm@redhat.com> wrote:
>
> On Thu, 2022-04-14 at 14:42 -0700, Nick Desaulniers wrote:
> > Hi David,
> > Jose and I are currently in the planning process to put together a
> > Kernel+Toolchain microconference track at Linux Plumbers Conference
> > this year (Sept 12-14) in Dublin, Ireland.
> >
> > We had seen
> > https://developers.redhat.com/articles/2022/04/12/state-static-analysis-gcc-12-compiler#scaling_up_the_analyzer
> > particularly the section on The Linux kernel and were wondering if
> > you'd be interested in presenting more information about -fanalyze to
> > kernel and toolchain developers there?
>
> Thanks!  I'm very much interested, but am not yet sure about travel
> (both in terms of (a) budget and (b) possible new virus strains).  Is
> this conference going to be purely in-person, or hybrid virtual/in-
> person?

Hi David,
If you're still considering attending Linux Plumbers conf, please
submit a proposal:
https://lpc.events/event/16/abstracts/
Please make sure to select "Toolchains Track" as the "Track" after
clicking on "Submit new abstract."

>
> Dave
>


-- 
Thanks,
~Nick Desaulniers
