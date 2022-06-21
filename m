Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7713C553E51
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354503AbiFUWIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiFUWIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:08:09 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210062ED77
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:08:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y32so24650628lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXWwIJvBgndA3WhK3GL3i3aCpDws4Fk1OlRLme0f82A=;
        b=mRKePrjtbODAs180aZDsLAEONbuWrZ7iGPXcpUcfSsrbTaJykoYbaixY19NrzKgz7j
         1/my6u6yhWkZb5L5apnLqQX9tN9kuwSNicpksyprremF6LMxq2Iy334TSqxCxNTO94NL
         bo9B0OdZSvL3+EoKfiLr4jPe6x/Okg94myvTB7LOBFfxM2w8kpRF8rIsJ2B91aZxzjp2
         OizmhlznIuMCkJWavRj5GCmTeE4RqozPM5Tx3k0xtMn0R8rQsPIBQPhu2LRW2AwpXJN8
         Qoens8HmrxcVEMMc2WJpaBQeFUfS9L2PvzbNgnc/KBmZgVP2q8DPl0VpJILYyw6zURnN
         Nkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXWwIJvBgndA3WhK3GL3i3aCpDws4Fk1OlRLme0f82A=;
        b=6mJrnVWtHHylryLeQTPZ44smDs/h4jSG5eS8JUJaju5AnVzSXzi7ERrSj3U9mfR6/v
         HFfTYr0ESS+Qru9DlP/dJ3YfZglzSH0G+yToJCYUUqWSNqv13Rztpfd+GnrNvVgMcnjH
         ljX2OYpzmcurh8mDMRDxxJkf9Gnaq1hyfll4hy/6/kgzswDhCMPpRwv+M+aGFRHhgHBn
         Sytf9vnAIzPSc/BRiMxlK2cXO3bIAXU3KwFMrUR+NVQ0AqJN+uqjxyK53Mnf5G0JHI4Z
         5/mkqlAzAAhCxZgJAzrCjx7VKGvHijJOnM0IJYrJ9SnEZZZ5gY0XRzDuN0D9ymrFq6S6
         2oGQ==
X-Gm-Message-State: AJIora/Ymx55wGzN0quADGQPUXw0e49oiV1Su0ncZYfS7geRsQu0XLG8
        +LQKT1fT30wqXHGg/oXUy6bD25Tq0q8ZbtqjHm6CIGxjuM8PmA==
X-Google-Smtp-Source: AGRyM1tLMp5Ggp2CW7vw70R1i+unH7HMYj8AjZRj1bFWF1Nw2npoZKI4aWcJQ+py3yCG2KULLc91IK4cn22E3FnjVOc=
X-Received: by 2002:a05:6512:118f:b0:47f:69ef:91b4 with SMTP id
 g15-20020a056512118f00b0047f69ef91b4mr261672lfr.100.1655849286267; Tue, 21
 Jun 2022 15:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=nEddFaTVQ80JrHcpjVv34=EhxJ9bb7rUFrRapuGFj2A@mail.gmail.com>
In-Reply-To: <CAKwvOd=nEddFaTVQ80JrHcpjVv34=EhxJ9bb7rUFrRapuGFj2A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Jun 2022 15:07:55 -0700
Message-ID: <CAKwvOdnG3YWLEJ87a2HptA5y4mDBKWp3ZpEV_g6jN9t9uJZA0Q@mail.gmail.com>
Subject: Re: Fast Kernel Headers talk @ Plumbers?
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
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

On Wed, Apr 20, 2022 at 11:14 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Hi Ingo,
> Jose and I are currently in the planning process to put together a
> Kernel+Toolchain microconference track at Linux Plumbers Conference
> this year (Sept 12-14) in Dublin, Ireland.
>
> We were very excited to see numbers posted about improvements to
> kernel build times from your work.  If you're planning on attending
> plumbers and our MC gets approved, would you be able to present on
> this work?
>
> Would others be interested in such a topic?

Hi Ingo,
Any interest in talking more about your fast kernel headers work at
plumbers this year?
If you're still considering attending Linux Plumbers conf, please
submit a proposal:
https://lpc.events/event/16/abstracts/
Please make sure to select "Toolchains Track" as the "Track" after
clicking on "Submit new abstract."

> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
