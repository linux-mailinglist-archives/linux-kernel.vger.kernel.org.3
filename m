Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A7D49D3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiAZUjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiAZUjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:39:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6D8C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:39:47 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w14so787833edd.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l7DUOY04nkFG5go2AK7MEd/Kn3oqfvoF5znhY+cKRCI=;
        b=Y4YS3nqxVI3qAI9hE231qFibOam+wQhPEQMglpNTCeicUI6uahT9M4ujieJxvh40wF
         W3bX0huo14ja4NoM5IfWpfM93n7KDc7dn5OF4Uanjy7TLf0muY/bJW4hhpyoGMMEs6DN
         QDykz47b7Sg8JcYAz9BhI+pasVDsOigYaU6fvSRqnMJOzGpFVz/zaL7U2iUusLFlCkI7
         u0bYsbKPymr8JRieJceQEzo1oDDysT0y5Od5cKXSJowvZZE4U84kRq38ytPEF3CzS7+K
         UoegJq+1SFxF//FuZCAKpwS59UayCF6AzRSPQ/mBXWdJt/eOdU32GlCQpETPX3LnoS4R
         8ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l7DUOY04nkFG5go2AK7MEd/Kn3oqfvoF5znhY+cKRCI=;
        b=7JFTJx0wcQIyYpbUAhF3TL5wltQ/Lbkw6sUcfmRqDRPi7vKZRaAS+RPmYsRqufbfOC
         rCEgUdhO1Fns1amL4AGOHsZF7AMiypCLUC2kibC2fhboZzhFH6jG4XxKYAWMpC/bLTdt
         V2sjJm015ZtbB/hyE4r2UXH7w525SgXXGmWsgxR5zJgngKF8XzEayTFb5WS3bz6wgKeO
         ciwhxM6qQG5n8fvPoJtMiMKeyGo8EftAJKNUAc9jeVqBc4+1K+5XQ+LoToCrMshF/sfL
         No33QS3ZAZqpqWs5UjRnoqjud7QafFogB9kvF/RP4Iy+ONgR6VBTSTrk6na4/QJz/vrv
         +cYw==
X-Gm-Message-State: AOAM533sPTHAryd34czuCtk3221sTqdH4D3vzk+otWKk7NA57f+s661I
        epN3GmOsvMCS2dvzeUd2QtKrXnPsI+/4U2Cy8TCQ
X-Google-Smtp-Source: ABdhPJwyF7U+ek4Il56UU3sKDPPKNSjRF7qsyBRSDNyaokYCGGTsL7whQzihFmepsVtYfAS79Kbt7ZsVZaP4HqEqydw=
X-Received: by 2002:aa7:c40a:: with SMTP id j10mr715995edq.232.1643229585969;
 Wed, 26 Jan 2022 12:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-5-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-5-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 15:39:35 -0500
Message-ID: <CAHC9VhSxd+D+33O9EEkm2h=Gv6EfByLMJx9dyj0DjcT9GhfKhQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] selinux: drop unused parameter of avtab_insert_node
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 9:14 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The parameter cur is not used in avtab_insert_node().
>
> Reported by clang [-Wunused-parameter]
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Merged, thanks.

--=20
paul-moore.com
