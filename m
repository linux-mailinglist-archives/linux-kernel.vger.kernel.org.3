Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7907853784D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiE3Jdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbiE3Jdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:33:45 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12982703DB;
        Mon, 30 May 2022 02:33:45 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id p1so1206136ilj.9;
        Mon, 30 May 2022 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=BGx+e99PPghbdp++D+/i/DC00d+Ut3D/EZRdk+l5k0k=;
        b=hFw+qJCpardOi5TfC5gK9ZZjLaWJdKD4ITQ0D6gYh3hT/cPDlR2BAuZdfPJosye8yf
         fZlUra50EpxTrRCUM3p/EWgvTxLpUu34ig62eB2HrqUPu3dSdgLfgPgAYvyHdNThGGv7
         huDdJX/OHgRVCUUbipoYluhkpnchuQaWKheRQVV2dWr68K5gWChEee2zAKnKnjux905E
         uNcSIrZhKt5D+2SEh4gnjEJmB6+p+cdwUKhH5j+ga1UmuxIyKmDoR2mulptKakHF0E0e
         b+hWF2VZBtDzobaB2vbevgUj+IP+XfVA6P9rPJtQeq9TT80KTcjAJT7AhlJF3lengZua
         H+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=BGx+e99PPghbdp++D+/i/DC00d+Ut3D/EZRdk+l5k0k=;
        b=DPKD5wv76YvKIF/3qZ3EDkuGtOWQnXUIGTP6tS7CNkmU5AHYz1i2oqSZ0RLdyL8WGY
         zAYgo+9WbPMP/nP7VG3gecFy9NsO5z8amiyZvNKoqMRp6eJGXxdXJSaGOJgJJYQCByhL
         N/DL3GmbAHeZKP3X0qz7S32bwcVmJ7YlttJ+VZv17fJhllL3CFvToRAsl2saSiSne/7F
         dUn05T8z7FtiClHXnhgl/++4+1ylJuwNx07AQYO+we557Zwuwqbt+5yzJRtrz00g9HSI
         Bepr25YPclQlQDddC5/olwji1d04LTRmoEcFo3YI+OnkpnJ8+UfCMCloaij5Xyd4yfP0
         LWwg==
X-Gm-Message-State: AOAM533xh5fuMXICoWPUyqqGlwGdsPPp6QkG/u65rPYZiyz4jpn6p5u6
        jk2tnY0zb7aDrqHLlVeY3Nw67T52IzvghQOmcO84mr/EtHA=
X-Google-Smtp-Source: ABdhPJzpBCGf/4ji3z6ExVXHZ42C9i6peWshESL3DAtXjme0Wx+ZiP0xnqjolkIvr4dzF2VYbf9FSN5mGRN6SbUrbwM=
X-Received: by 2002:a92:d149:0:b0:2d1:5bd:1ec2 with SMTP id
 t9-20020a92d149000000b002d105bd1ec2mr28125953ilg.100.1653903224280; Mon, 30
 May 2022 02:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220528154704.2576290-1-masahiroy@kernel.org>
 <CA+icZUU7zUCD=xrrYLQyKkDMC-Fj-PFcmHbTiPU8ytOpYq8ZDw@mail.gmail.com> <CAK7LNAQZE-JE67HGTzy7r7mRv_2Gzv0LWUOoVr82V9iNx4q-4g@mail.gmail.com>
In-Reply-To: <CAK7LNAQZE-JE67HGTzy7r7mRv_2Gzv0LWUOoVr82V9iNx4q-4g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 30 May 2022 11:33:08 +0200
Message-ID: <CA+icZUUPBS6WWtWvEhZ=cHAmKB77BCgGMzHKag+eezcxO1KMAQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] kbuild: remove redundant cleanups in scripts/link-vmlinux.sh
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 7:32 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
...
> > Might be related to this patchset or not:
> >
> > $ LC_ALL=C ll .*vmlinux*export*
> > -rw-r--r-- 1 dileks dileks 4.2K May 29 15:11 ..vmlinux.export.o.cmd
> > -rw-r--r-- 1 dileks dileks 508K May 29 15:11 .vmlinux.export.c
> > -rw-r--r-- 1 dileks dileks 2.6M May 29 15:11 .vmlinux.export.o
> >
> > You see the leading double-dot for ..vmlinux.export.o.cmd - intended or not?
>
> This is intended.
>
> The source file (.vmlinux.export.c) is a dot file.
>
> .*.cmd prepends one more dot.
>

Fine with me.
-sed@-
