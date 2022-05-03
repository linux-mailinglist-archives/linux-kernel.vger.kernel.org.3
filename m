Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191D6518BEF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbiECSMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiECSMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:12:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391083EAB1
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:09:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id bg25so10324927wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FGUxPrzjI78BA1FDy50uQWcrTLirYMlLkUJ+7H09hDo=;
        b=DOkMy16hOEa5G+NiABpSRJI/5qnS/23Fgla038FCGDOWawxG4ToWbvMhqHO4sQYZem
         hvfVJZJbM+0LGlsFNBWMnrLa2N4B6Ci2s+3UP3iWmb0RrbDGA6glNNed8O2aQV6zhkAg
         VpFy6uUb+BUWS4gm/zinLbPtQEGd4CBX3lUasRwwAHWMuWUxuUr40Gre44slJjotkpz0
         m1dqBP3uY+3gtiWq4xGX6VZunGu040EXRhbhVzgXAeBOCoVgUftlg7kjbjw7dWHaAkEI
         EhtKavYBVAGX15veMloA4EQs+36hyBanxTLWEMqwkHwhB1Nw5mH7egvHhvoJvCJCcb1c
         2TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FGUxPrzjI78BA1FDy50uQWcrTLirYMlLkUJ+7H09hDo=;
        b=PeHsMsWcx255cO1vo24Nqq+ss+fxVehZCdPrTsuoVrkaUY4wt5jE015PZaNg7vkeQQ
         NoUMIApSxcQqYzLxBfnRajo11gmZ3CVoE2bYFnDeaKeA3nDxJPQxQMPcrR6FnUKrKvxo
         n91P7f8X8f7XZTZx8dz12ve/UigDs6/adfhjgALpydB4ayLte4sFpqdKLf4mcBLV6kxp
         1UHE6iW6tVy7ntAiW2mvMvjYGzjlI68+ZxxL5oupo24OhiD1NiyzrWxAmuhyolCUwa9R
         l5VsZls8B9Cjg1ug4cSvG+EYHvwwFps7ANDJy6hNuR3rPS5SS5g5lszPGfuvhn3W22Ej
         xixQ==
X-Gm-Message-State: AOAM531qZqVRLI1I3bHtSYdkdgmslWSIlCMLobooGQgy2sVgrt+d9JYn
        LZUrq+U7h+Y1+021vM4AjTvglNkrULvzQyYDJsVC
X-Google-Smtp-Source: ABdhPJz8V6A4NLi3gByFCmDPUvIX7h8XeCZUuGOAA7TrZf7o8M1QoEBfUcYVZUrLW79Qy+wom7w0dKIuYr2li6iTM6E=
X-Received: by 2002:a1c:f009:0:b0:387:6fea:8ebc with SMTP id
 a9-20020a1cf009000000b003876fea8ebcmr4504416wmb.84.1651601340763; Tue, 03 May
 2022 11:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220502141052.34413-1-cgzones@googlemail.com>
In-Reply-To: <20220502141052.34413-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 14:08:50 -0400
Message-ID: <CAHC9VhQEAcwWvEfV_-4cO6ZRzjGs_7cEpKi3jTXF1HJ_vp16iQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: avoid extra semicolon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 10:10 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Wrap macro into `do { } while (0)` to avoid Clang emitting warnings
> about extra semicolons.
> Similar to userspace commit
> https://github.com/SELinuxProject/selinux/commit/9d85aa60d12e468e7fd510c2=
b5475b5299b71622
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next with some whitespace tweaks.

--=20
paul-moore.com
