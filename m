Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C23543AD8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiFHRx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiFHRxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:53:54 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20CB65CB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 10:53:53 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-30ce6492a60so217276567b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZYP+ah1U7+mN31aQTFJq4MgSsX2goe2sE/NP4qdAU5U=;
        b=BSUl7JxGmnB729HAQjXimmjj8f9Tkw3EIFXgI1WL45S/MqvidYnh+pEtUIVi8lyYMp
         3FOd7Vft2hoB98KFadhSg8bE0bzYSCe4+jH79YukI+AoeAJsd0lJqIqRUO++n39ZG1Zf
         tOnjGxYk1ARMynx5cMnk8v+Z2OU+1I6HTrogCEIvZkBlmnMLQiRfxtrSvkSJwb30eLSc
         oxN+cJcv7FH6nko/NroiAOhIPZS9zxv4kRsCUYYnnUVD55BxhQTKb5tvcns+MCHE6z/1
         HyHj7USGIQpfG4O06Yaqc07KQDwyHEvP+16o0raoX8UKLr+o6DUKTe/otHCk2E2P7Xu1
         ie9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZYP+ah1U7+mN31aQTFJq4MgSsX2goe2sE/NP4qdAU5U=;
        b=VHUiKi8ojkxn1xVzDJA8dwSn1sipWiIC54UyVmZWQU+QOcMF/4r4ZzXnAd4JyqCGGC
         2s+X1WeQPoXM0OUEUgvojvicWG70YjWanZcuPdDlrGbajhVtpOX5GbrDyMGfYz1dXy36
         vYKrMOA7FVBwQFDImgXjqe8k9ED9cbWvnbgQUZmvBR4mNFmLL7AZmKqrmELZh3Jgvsfy
         mWNAF/WC4C1Fg+1z4493IcUd6ettCPqxbqZwEoS8k1zK4jNG/7tPr56AQBb9Cp+rBr0W
         FlA1m6q5qlwy6huXtZivbyLbNC5K/Qrnww0JArcO4lukG6KkRQBixDhIn4bvdw+yP8Ph
         XEog==
X-Gm-Message-State: AOAM532KPXfYuGlcm60xIeOQ5s0FJi/bBCk04T4MjwMcqbg8DTX7DHDH
        6zFYGIh/1JUvbB9BuBPA6LsJSH38EybvbAsxO2o/2A==
X-Google-Smtp-Source: ABdhPJyIp/kr/93Oc0dPwDHSBySwZnVz9Ba5VqpHQ/Mfh6VClr44aHdb03JA8owDUdvQtcPKFqrgVqUz+R3T/zalvrs=
X-Received: by 2002:a0d:eb08:0:b0:30c:2f46:f7aa with SMTP id
 u8-20020a0deb08000000b0030c2f46f7aamr38450413ywe.299.1654710832805; Wed, 08
 Jun 2022 10:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211122170301.764232470@infradead.org> <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com> <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com> <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com> <20220211133803.GV23216@worktop.programming.kicks-ass.net>
 <Yh7fLRYl8KgMcOe5@google.com>
In-Reply-To: <Yh7fLRYl8KgMcOe5@google.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Wed, 8 Jun 2022 10:53:41 -0700
Message-ID: <CAFP8O3JdYoMeF75XHCWue3fYG02W_95VGCU6AN+DYPj9F75kqw@mail.gmail.com>
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
To:     Peter Collingbourne <pcc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joao Moreira <joao@overdrivepizza.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Peter,

On Tue, Mar 1, 2022 at 7:06 PM Peter Collingbourne <pcc@google.com> wrote:
>
> Hi Peter,
> One issue with this call sequence is that:
>
> On Fri, Feb 11, 2022 at 02:38:03PM +0100, Peter Zijlstra wrote:
> > caller:
> >       cmpl    $0xdeadbeef, -0x4(%rax)         # 7 bytes
>
> Because this instruction ends in the constant 0xdeadbeef, it may
> be used as a "gadget" that would effectively allow branching to an
> arbitrary address in %rax if the attacker can arrange to set ZF=3D1.

Do you mind elaborating how this instruction can be used as a gadget?
How does it look like?

The information will be useful to the summary of Sami's KCFI LLVM
patch: https://reviews.llvm.org/D119296

> >       je      1f                              # 2 bytes
> >       ud2                                     # 2 bytes
> > 1:    call    __x86_indirect_thunk_rax        # 5 bytes
> >
> >
> >       .align 16
> >       .byte 0xef, 0xbe, 0xad, 0xde            # 4 bytes
> > func:
> >       endbr                                   # 4 bytes
> >       ...
> >       ret
>
> I think we can avoid this problem with a slight tweak to your
> instruction sequence, at the cost of 2 bytes per function prologue.
> First, change the call sequence like so:
>
>         cmpl    $0xdeadbeef, -0x6(%rax)         # 6 bytes
>         je      1f                              # 2 bytes
>         ud2                                     # 2 bytes
> 1:      call    __x86_indirect_thunk_rax        # 5 bytes
>
> The key difference is that we've changed 0x4 to 0x6.
>
> Then change the function prologue to this:
>
>         .align 16
>         .byte 0xef, 0xbe, 0xad, 0xde            # 4 bytes
>         .zero 2                                 # 2 bytes
> func:
>
> The end result of the above is that the constant embedded in the cmpl
> instruction may only be used to reach the following ud2 instruction,
> which will "harmlessly" terminate execution in the same way as if
> the prologue signature did not match.
>
> Peter
>


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
