Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7635576849
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiGOUkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGOUkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:40:16 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B341A528A6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:40:15 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10bd4812c29so8644660fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UClsEqV3JD19ACu3JsNCWl/cLZeryKIb1irorP73Kww=;
        b=RVUd2g3PIrxABLRIB1PNNTftaU79wvj5UgCLSgXOAFRI4kW3+YteNAOmOYEvtd5aEg
         NF9EHuEcCgzN7/GDIJPlhLl+rxA9j8Yhx4LwFUQPW60/Wf+hEcqlR9Q9V8FgHZt6q+Gp
         U5QACBFUVwS1hHAYaIWlTNQ7TxJF2wM2ut0aPMXNt2nYKA5xaWLhaaW9XXSVXnbG+Jc2
         u08x2aCitbp+mejBem5CxkqiiKYVhMkuNw6kFAhnvIBTv98gdQhEYMUjncv78a1nq9vT
         slXdcanwItyVoZgzdBaTrVL+bM38aB/FSZsIiq+okBUw7cdWVPfky50mBo0+D/JP5G42
         B1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UClsEqV3JD19ACu3JsNCWl/cLZeryKIb1irorP73Kww=;
        b=WhmvLV7pxgUawtmdSCZ276nkFXdHc1kwqaCfPLygMDJzfR4JoqrnxCSVf7XmZml8ii
         epujiRLyY/CajXjUYhF/ZUBW9+NQZI53dOwp2317SO4u53pFwMqVmqKdL2VY3DGRO/h8
         6hUDGgieVJ6GWlJPeBDvw00E4gAE2nWHy/Y1NYDnaV5+z5N8fEYJznOreMIe6p1+p1g8
         v3e5lunYx1Oh3ec++qZPDbjTrHp6Vf8PQ5Km/Ib0IOES3X7u2ucuGJJ8e3kmyWi6/Ar7
         3l37YbfEh1yVLLvkFW2LDCKr5hnWa+ZlPAIw2YjAEQxpGGUZNIaVhpSXAo9B0hPMrfPW
         m37g==
X-Gm-Message-State: AJIora/iNzzvJ8jjwwo1zih+fXhN52SsWgkui+UsVKMHrPIdVupI32Ei
        QQdY4OHk5NpKWEH2wfImhNKuDBmHEdbGZdDcWihZAiBKSTQ=
X-Google-Smtp-Source: AGRyM1tfRbAM589Ft1sdKHiA3BtukLPlMAhE/lLFiqPbTB8j7bIekBpV6v1Ndn5hJL0aCl1+ULCZ+Yn5GmTQA793onM=
X-Received: by 2002:a05:6808:2292:b0:33a:5ec2:8f63 with SMTP id
 bo18-20020a056808229200b0033a5ec28f63mr666595oib.112.1657917614793; Fri, 15
 Jul 2022 13:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <CALMp9eS5pBrKWe=LbWXON6bhTdhbX9rB2aF+c-h_a0=SXfyj7A@mail.gmail.com>
 <f68c283c-cfc9-bc63-5d0f-143295a575d4@citrix.com>
In-Reply-To: <f68c283c-cfc9-bc63-5d0f-143295a575d4@citrix.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 15 Jul 2022 13:40:03 -0700
Message-ID: <CALMp9eSe6dRvSAa6CQp9P_dO5840OqSmhXrS2AabZeCyL_3j=g@mail.gmail.com>
Subject: Re: Retbleed (RSBA vs BTC)
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
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

On Thu, Jul 14, 2022 at 6:07 PM Andrew Cooper <Andrew.Cooper3@citrix.com> wrote:
>
> On 15/07/2022 01:29, Jim Mattson wrote:
> > What is the value in conflating the Intel and AMD findings under the
> > same moniker (arch/x86/kernel/cpu/common.c)? The vulnerabilities seem
> > quite different to me.
>
> They are entirely different, beyond the fact that they both pertain to
> the `ret` instruction.

BTC affects much more than just the 'ret' instruction.

> Suffice it to say that I tried very hard to prevent this confusion...
>
> > The Intel CPUs tagged with RETBLEED should already report RSBA. The
> > paper just highlights this previously disclosed vulnerability. Or are
> > there Intel CPUs subject to Retbleed that don't report RSBA, and I'm
> > just confused?
>
> There are CPUs which suffer from RSBA, that don't have MSR_ARCH_CAPS and
> therefore can't enumerate it.
>
> IIRC, MSR_ARCH_CAPS only appeared with Cascade Lake (or thereabouts), so
> the earlier Skylake CPUs (which are the majority subject of "Intel
> Retbleed") lack the RSBA enumeration.

Ah, right. I was thinking that we got IA32_ARCH_CAPABILITIES on older
parts with microcode updates, but I was mistaken.

> > On the AMD side, however, Branch Type Confusion is a much bigger deal.
> > All instructions are subject to steering by BTI, not just returns with
> > an empty RSB.
> >
> > Don't these two vulnerabilities deserve separate names (and don't we
> > already have a name for the first one)?
> >
> > Tangentially, I believe that the following line is wrong:
> > VULNBL_INTEL_STEPPINGS(SKYLAKE_X, X86_STEPPING_ANY, MMIO | RETBLEED),
> >
> > Steppings 5, 6, and 7 are "Cascade Lake," with eIBRS, and I don't
> > think Cascade Lake suffers from RSBA.
>
> As documented, Cascade Lake does suffer RSBA when eIBRS isn't active, so
> it's not a binary affliction state.

Is there no value in separating RRSBA from RSBA? Per Table 1 in
Intel's "Return Stack Buffer Underflow" technical paper, Cascade Lake
exhibits RRSBA behavior, but not RSBA behavior.
