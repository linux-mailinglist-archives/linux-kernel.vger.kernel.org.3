Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA142523753
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343668AbiEKP34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343663AbiEKP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:29:47 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBDC21551E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:29:45 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h85so2403944iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CtdNPcv9Xs9pvNuMfHH4clvaHcmZY+jRmMu+Z0g00OI=;
        b=FXyxzi6wVDNzYPNCgOTZK6DWrWW/t2C/I/HWs2S8QRaoWcmdq1/O3iZv5q12z7/qMK
         /mbSq+jDpBY+KphoLfTI+DM1Jpp/cx3qqnLw6hJbl91aAZWIkhmWF/9P4U0TroFCbqmf
         DfYmAdFaSP/aawKG9M/PL1pI/wZnmIrKWj9TdqQjVINq8SA0rI4H8648VOiHq8Yx32+w
         P6lajvFaoltfkAhlLfoG+sR8+bgFjakZf7A/7zBtiXTQy5RQ7Bgw9PJ2wNHK5zzu1CSq
         DppCrezZzMlWJGUQ61u+myWyE2ssCiyMW/C34eAhvzbS1WKfgStC6jfxYeqVaCQKaKJj
         YzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CtdNPcv9Xs9pvNuMfHH4clvaHcmZY+jRmMu+Z0g00OI=;
        b=YQxWtAMWx6nAu7uv9WL+nqvtwmikNPqT8BqQjI1H1UqmsKelTDx64TpqnI+AEqahSC
         CqPGtXv8BE16f09VC/xQs7DiV628ykOpQmLX2e20RyvbcO5g9wcKeUmNSp8W87+ZrUHn
         uNgTC1rWCGgM0RChWthKE4HXBKHkFTRHNTO3V1OZHNtDspuOn+NV4lnQGT8ng2V+FTfR
         xFWLfwVUFAbccxIINlhd9GkpNQRjmJVHHPGe9Oco9uKPn0KmG5utWIY+HeJM/+Vmt4Z+
         s6uWNUGHwutcIrfITeWYcizRiemG0uDahEluC95JVS9+HH3PgqRvJSHn8OxQcOprnUKn
         856w==
X-Gm-Message-State: AOAM533QzRQaOANsJh2m44u46SlO6SoZkwbc/6BlBHYDZOJX6dy6X/fg
        ZFMsPV1TmAD4ekBxqsi8xwa9zyJ/dOKQ4ozM4XVs8jqr
X-Google-Smtp-Source: ABdhPJw0enMBLm4i62iaBVoiXBvnTDT7dfPXX7omlqXOgjhfI4Tp7zPydctZejKfLHlp/69sQJwFC7rxsWL0yWC++B4=
X-Received: by 2002:a05:6602:2d90:b0:63d:b41e:e4e4 with SMTP id
 k16-20020a0566022d9000b0063db41ee4e4mr11011603iow.172.1652282984563; Wed, 11
 May 2022 08:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220506160106.522341-1-mic@digikod.net> <152da06a-330d-3125-6f41-262e0751f41b@digikod.net>
In-Reply-To: <152da06a-330d-3125-6f41-262e0751f41b@digikod.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 11 May 2022 17:29:33 +0200
Message-ID: <CANiq72mST6rfJDVGGT2+=_FUCXwms6N8mo2eoLzQ6KW64M9BtQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Fix clang-format configuration according to checkpatch.pl
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Brian Norris <briannorris@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Micka=C3=ABl,

On Wed, May 11, 2022 at 4:19 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> Miguel, what do you think about this series? Do you plan to take it for
> the next merge window? FYI, I plan to use it for Landlock [1] and send
> it for the next merge window. Could you publish your pending
> clang-format changes so that I can make sure everything is OK?

It looked good to me overall (though it indeed conflicts with what I
was doing) -- I will take it for the next merge window. I am thinking
of putting Brian as author and you as Co-developed-by for the last one
to be fair (Brian: is this OK with you too?). Thanks!

Cheers,
Miguel
