Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5D75AC1F9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 04:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiIDCOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 22:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIDCOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 22:14:15 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D32B4E61B
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 19:14:13 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id b26so5945195ljk.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 19:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IPv+2mXSogYhFtWuHySncEPNLNjPGYsVvoHKYcIxAHc=;
        b=BEVyo56zoyPKQNgv8WYaKAsOegBeut+5tSDxfNXF7rz/5dsRwra4M82vI6K5R8+0KY
         yRD0Lc46YNy9BTFOKsEoTV8qF7+TjyuxqzoRMm8pySOGQ7+TxkRldxytDTGZUIqKpjhS
         AG2Xl1kRF1Pmdjcp9d5uDqbXja+3ZPjT+2cGRBDfhVkscCMH6SeNgbySB8iqQx87qDZR
         hZnjNbBZBGuMTzcS/j1USCOd/su3dTZX8FYSBqU7MG3wGJtuQ7GegfswJnE4ojRbPJcQ
         dxIt2NpxyPpSOqTCBEyIfpjytJtmfN0DTO4lJoBafcstMkv9ft2Bsk1pRk/j+4gDXxvL
         5Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IPv+2mXSogYhFtWuHySncEPNLNjPGYsVvoHKYcIxAHc=;
        b=jyVWG2Ral8/Tpae/AcM6jkdv4qE2K+c3BEIQ7n/fI504AUx+rHtyMGiQAfCMuIHVor
         QuUf9jJczGUOd8I5YrHtYS832zZFEDk3dgoi5U74o+zhN8zmKNr0SCb4bbRFg0FTgB7n
         Wa8YeUGHIY7Mj/RKn2g33laV4BjDBQTgOp46qwtpPsq8uAv+rcy0UP+X2tdXjreoL+gV
         FXqHPeSb84XsRTCjH6M4bJxWU7rFDSfMlFTRyq5OteNAMpq6xOj7e9B9TbZM4K8BcQpp
         XNkdihj0/Jb9Q4WUrVY8YKryK7FHEBhv3X6tYFZRW/RP4xMT9bD3vH4i2qp75tMdWbIP
         K0zA==
X-Gm-Message-State: ACgBeo1uNDD6RusOD6EwdF2cxeOJj2a2Wei41uu2lfNxX9gq7HIOhFlT
        k1RPSeCytXkMw5xz3tCl2uhG62mQDEJvwKiQS43Thjf3fw==
X-Google-Smtp-Source: AA6agR4u/k8EvuNBzHpBBRcRFWG38b16KLKqnk7kvtQaavvbHhNttthfn+jnLNgHSSVTyhCIKGngPs5GWlrimGTnM+Q=
X-Received: by 2002:a2e:b604:0:b0:268:e96:233b with SMTP id
 r4-20020a2eb604000000b002680e96233bmr6600786ljn.471.1662257651496; Sat, 03
 Sep 2022 19:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220902213750.1124421-1-morbo@google.com> <20220902213750.1124421-2-morbo@google.com>
 <YxLX5i0aUoe9zBsx@nazgul.tnic>
In-Reply-To: <YxLX5i0aUoe9zBsx@nazgul.tnic>
From:   Bill Wendling <morbo@google.com>
Date:   Sat, 3 Sep 2022 19:13:59 -0700
Message-ID: <CAGG=3QUMmB8chdGT9Jhz2RQXyP7Gg0=bSwk=apu8Gv6vTiM5fg@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/paravirt: clean up typos and grammaros
To:     Borislav Petkov <bp@alien8.de>
Cc:     Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <llvm@lists.linux.dev>
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

On Fri, Sep 2, 2022 at 9:28 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Sep 02, 2022 at 09:37:49PM +0000, Bill Wendling wrote:
> > Drive-by clean up of the comment.
> >
> > [ Impact: cleanup]
>
> We used to do that type of "impact" tagging years ago but we stopped.
> Where did you dig this out from?
>
> :)
>
It was in a comment from that file. :-)

-bw
