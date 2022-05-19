Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EE952DE8D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244778AbiESUmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243853AbiESUmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:42:21 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9984F7A81D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:42:19 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i11so11009805ybq.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2okLhz72KUTvla4YyoDTB8A/W8JoxXBQasuMUph8C0=;
        b=d2ACSNJz5Z8ThxTfbHc462MoLXTn6k5pKJ9S8YoDulcbrtuD12Q7GHSdwteiu3ukqF
         8jm8K7ARf6N8ex53iZDSVuRkhCCKuPM3siwOeFnm++0kLE32geBnd9BfvESLJGAOjiEx
         OR4ibZwwOngZDxrb6FIj4vWGc7cVl6ea2yFnW1Y+XnEbhVrwHFuayzfHQ21OYZV8TcVg
         1/dne1LxTfdLS2mn6T/t8oofcir+h2ipDqF2MJyXJVi6J/c3Zyowqds2/KZpXKnG55qo
         DWbEU2HpavtgJ7G69pKePU2mXV+TgVs3Xn5a81GpLuMBsCElSG1yF1jX7cnhwb+TYZ5J
         KL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2okLhz72KUTvla4YyoDTB8A/W8JoxXBQasuMUph8C0=;
        b=ezvxOOdIebMpZY7eE+2EQG0NrC0+RVRIDZ63rPlM8dbqlrYZu32AZlFwi18FwCsP85
         PEWNQVCVJJxqr2XdMBInJm0y/J4hR5PZKIx886aA7Dja8DM9DL/3kpho68+b6Fekrqwv
         pR7NAytBIuM/Tt5w5CheZxX2ht/db/W7Icm/AcZ3t+sueiTSOCxQUcY4w5dxMzodXVAZ
         eJ4C72v+yJTzrKPMI3zw+9MMLlFZtDY3mnQ3WU+GNAqyXxX3SAkMiK7oxDOTheAS8drr
         zfcavh7RdtP6Kl/flnNpS/vSgsQj3+HxjtpqfR26i9bwxXsYbZ3FaHTHfvkd1tfLbBcQ
         phmw==
X-Gm-Message-State: AOAM533bbH2wteGzhp+U807czu39l33IzlF5HaPrnfTGAyg0WYlRcU7r
        bFHhMLiwfF+pp/TcnIonhebIIEy7zRH9kTe/bxMaKg==
X-Google-Smtp-Source: ABdhPJxJ/yh/6kwjFetK+yKNj03Si68VL6xzAYIFBlugdZlKFzZHju2VwSEDLPIqRhvMZjc2UyCWKc4FGr1HAakdJJs=
X-Received: by 2002:a05:6902:18a:b0:64b:30ae:da2a with SMTP id
 t10-20020a056902018a00b0064b30aeda2amr5956500ybh.314.1652992938667; Thu, 19
 May 2022 13:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <CA+icZUWr+-HjMvY1VZf+nqjTadxSTDciux0Y5Y-+p_j4o7CmXg@mail.gmail.com>
 <CABCJKueVcwYishxSoEyn9b1vaGTXdoYWF7VyANPm7V=H+yyfhQ@mail.gmail.com>
 <CA+icZUUBqz1zTcj61nK=sbkWcSncKYZgR2Qg0FSCWi9un84yLw@mail.gmail.com>
 <YoPuMhc03hUJxmPs@dev-arch.thelio-3990X> <CA+icZUU0k8UHRiFvV45nr1xY0p3SgaG+MLjJoEnmUCQ8T+WGdg@mail.gmail.com>
 <Yoan3dgL988r0Mv/@dev-arch.thelio-3990X>
In-Reply-To: <Yoan3dgL988r0Mv/@dev-arch.thelio-3990X>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 19 May 2022 13:41:42 -0700
Message-ID: <CABCJKueRFbzmJaZVj=oSP9mg+93mQrYo-eiX+ZZh0EP34VdE-g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] KCFI support
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 1:26 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, May 19, 2022 at 11:01:40AM +0200, Sedat Dilek wrote:
> > On Tue, May 17, 2022 at 8:49 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > I have run kCFI (v1, I haven't had time to test v2) on x86_64 hardware,
> > > both AMD and Intel. I have only found two failures so far: the i915
> > > issue that I mention below and a failure in the KVM subsystem, which I
> > > can see by just running QEMU:
> > >
> >
> > Is there a fix around this issue?
>
> No, I mentioned it offhand to Sami in IRC but I never followed up. This
> failure appears to be introduced by commit f922bd9bf33b ("KVM: Move MMU
> notifier's mmu_lock acquisition into common helper").
>
> Sami, do you want an issue opened around this somewhere?

Yes, please file a bug. The ClangBuiltLinux Github is probably the best place.

Sami
