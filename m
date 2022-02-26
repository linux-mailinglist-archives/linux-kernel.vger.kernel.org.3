Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682334C53C3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 06:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiBZFAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 00:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiBZFAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 00:00:42 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3983D13CA3F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 21:00:09 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id bt13so9802603ybb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 21:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dBJcL8Qf+TxOQv4LjyViq+grimzIFiZfY7ueI3KJitY=;
        b=jxFzEkYsbLIftRWm+0RpjaJBvZdrGUbgH6K1kDQLEqksd80u/UQblgo7mgvZSERLC/
         OqMOBczKDE16cm2uUo0JOYKZF0vUk3tmN8ehFmKqo0f5qBVhhjDKGVJEdAzh1cCYV+Dv
         stq4xeJNc/VEPa2RKnQUyoH3p5wg8MhPHF2Qp0xL8BNXesL1nBjWLVwWI1xSgxfWB/Nf
         HRZWLt48WhyrO2Z3AnW8xm8c17X3VHyj39zqoQ3rkQbTSt7iEO9a2FltulP8AwYGwnth
         F1kV9/YPG+N+qa8qMsIpy73wI3F0WmyHR37/wd/prebRD+EFbAJGv1fzTyUhNJc7edaa
         KXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dBJcL8Qf+TxOQv4LjyViq+grimzIFiZfY7ueI3KJitY=;
        b=XkhMVvNpS3UHH2ljGW8aVYBT+uUFtUIeDS4tA+pv+CFqv5PPiW26GR6BHhpQCRdlze
         cdoYWDIyYjUh0ju5Uv1yvewaj2Klv4BNTwnuixoCzWh2/giiY+sSTSxKjXVE7u0wUZOQ
         N3DvIuBxOHGlRRz3Zr3i4ZNO8hopvhcFfsxFHkhhFvUME6/TNINKjq67D15vH2QPI72x
         96y5LkiWIKQ4fTzyfrXX4NCrC+gf3q6pvVqhO/0ttKM9eLL/D7wzudQQt4oqTZia0Zj/
         gIc8x7EArsG3sdITWzxP3vhB5MKQVzCPlVmLwEtkGQiNjRhTAtmRRC2VkMUXZDZ7prDH
         vIKg==
X-Gm-Message-State: AOAM531rpwulsZeK6QFBxHb7JKuVH1nBVCzgAqgNzMlA70vsSqkgJ+jV
        9H8c6AniwXyNNYJJCyWomQi4R0hUYDiZnqTealO8wg==
X-Google-Smtp-Source: ABdhPJwvE2obkD/N/LaYSDIcdg2fFCtX0H+0nWJZmURWhxUt52hUSSHFy3xBGUsuBtCiIY2dqk8aLATb8lKGpvuJjAA=
X-Received: by 2002:a25:286:0:b0:61d:5da1:ac65 with SMTP id
 128-20020a250286000000b0061d5da1ac65mr10662428ybc.63.1645851608342; Fri, 25
 Feb 2022 21:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20220224145138.952963315@infradead.org> <20220224151322.307406918@infradead.org>
 <202202241627.EEF3D5D2@keescook> <YhgnA8O4Bp19hfse@dev-arch.archlinux-ax161>
 <YhlTRhh7qj538ygM@dev-arch.archlinux-ax161> <605731324a76f36aafa87bd9390808c3@overdrivepizza.com>
 <202202252055.AB16A4B8@keescook>
In-Reply-To: <202202252055.AB16A4B8@keescook>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Fri, 25 Feb 2022 20:59:57 -0800
Message-ID: <CAFP8O3LDdGKQ0HzhfmsuDRfCEWC3sAAizUTjU_UKERzseX+H3w@mail.gmail.com>
Subject: Re: [PATCH v2 05/39] x86: Base IBT bits
To:     Kees Cook <keescook@chromium.org>
Cc:     Joao Moreira <joao@overdrivepizza.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        Mark.Rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com, llvm@lists.linux.dev
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

On Fri, Feb 25, 2022 at 8:58 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Feb 25, 2022 at 04:29:49PM -0800, Joao Moreira wrote:
> > > https://github.com/ClangBuiltLinux/linux/issues/1606
> >
> > Candidate fix: https://reviews.llvm.org/D120600
>
> And landed! Thanks!
>
> Since this is a pretty small change, do you think it could be backported
> to the clang-14 branch?
>
> --
> Kees Cook

I have pushed it to release/14.x :)
https://github.com/llvm/llvm-project/commit/f8ca5fabdb54fdf64b3dffb38ebf7d0=
220f415a2

The current release schedule is
https://discourse.llvm.org/t/llvm-14-0-0-release-schedule/5846


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
