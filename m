Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB7546DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350461AbiFJTwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348862AbiFJTwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:52:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABE823C664
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:52:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k16so37819942wrg.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x81CyVir3pjK/ztFro5SKkqWERq2me/APMv8atNQetU=;
        b=y3UITEx0SBsS5g1x4ULHaE+KbdORxtcufS3I0QAPCfO7rtbWxyDxBifiPRqpMkPjus
         X0sbLUkmKgfJJrjCa5GcA1ZmTsM0uVG5p3FSerp8mgTJDqYzZ0Dd+0w8n+ZqqlZCMhFx
         gqR+XnYmehwlcDxCZ6WGP1BL5334b88RrOQmFrgNaFHzzk72zUGuTQKkEYAMCW4oqMak
         O7tp4NaIScT82Cf4oFocLCBqueORdOGv1sW98SblpZ+FIX3X+MMo/dv5P0BkfAeHVoSN
         CgYDNH6EWMFDwa3blv4+sp0n2zD09/4LQ4PJ1rb+i93BTauFioHs9iM2Nm1KavIWTw2q
         LRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x81CyVir3pjK/ztFro5SKkqWERq2me/APMv8atNQetU=;
        b=1POl9kCsBYBFdoIg2odvXD1//kvv/3jjc/zJvQKNB2LGEtpzNa1SlRmbtUS6U0amXp
         IvAf/kADo0vdfoKoqL7OCESy651X0+pfUFVShLClzl+g+eUSTsUBjIVJkQbTfs4V+Rfd
         WalUUcOySB3GEqK3LJxeFkq/k6rngxp1Ua9mAs91lvPaN68luVXHa7UQp6ZC04p5+TQq
         qz7C+p8es42aaap0gPlrtVqFL2ZOR9p4W83hLu+TantutPkxtQTtAEYOt4Ov9bX5CHA5
         veIrJWViL4r5Z2VejzRpdbBdWg35ZapvvHc+RndD1mLmaU8wdFqokdwdFLQKD5w+j+VH
         xt6w==
X-Gm-Message-State: AOAM533dhCM/M45mjga+Z2JcfUd2W7xHVbU4WsZbi7cx/BRVSRFl1D1x
        K7ms1xrHYR08uGKap2K2dS6cSJxxGojZatLOlbKB
X-Google-Smtp-Source: ABdhPJxM/c/b1H9ScCDVgTvg2CB9+5vuNvzZtf1lT8GASYKGK0T+lA3Wsnt70X/aY1aiYxbBDIvNYa/0m9HC35uYgEY=
X-Received: by 2002:a5d:64c7:0:b0:216:5021:687f with SMTP id
 f7-20020a5d64c7000000b002165021687fmr36417844wri.295.1654890738143; Fri, 10
 Jun 2022 12:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220608223619.2287162-1-jolindner@gmx.de>
In-Reply-To: <20220608223619.2287162-1-jolindner@gmx.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jun 2022 15:52:07 -0400
Message-ID: <CAHC9VhRfM0_zA6TbZiOGo8nCSRoh-g_J3iZG14DemnXTxGRsoA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix typos in comments
To:     Jonas Lindner <jolindner@gmx.de>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        trivial@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 6:37 PM Jonas Lindner <jolindner@gmx.de> wrote:
>
> selinux: fix typos in comments
> Signed-off-by: Jonas Lindner <jolindner@gmx.de>
> ---
>  security/selinux/hooks.c         | 4 ++--
>  security/selinux/include/audit.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Merged into selinux/next (with the duplicated subject line removed), thanks!

-- 
paul-moore.com
