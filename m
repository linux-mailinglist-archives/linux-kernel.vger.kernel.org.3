Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD9C5795BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiGSJFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGSJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:05:52 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42177642A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:05:51 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id k7so7740613qkj.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4BTG+GIfVp80pynNmMgDJXtQXBY7HIBCNVIJqyKZSZY=;
        b=VI1/yme6A0ak5sg4eI/4htETY+KS4/nUVlxnTp+iE/ccHgjUa+yVlzuwkl45gItecd
         PmAaaSwtKPkwhJNR2f8grpq3+W9BJBukPIDxtTZUvAoo9ZIpzoXcSI92p57NRRK4pClg
         pD1SzkMGoOhMYl+wv4MVk9zyS82lLeICZcMYATm6Mvlxcv40T0g9uRpUQjHj+E9x0Pdr
         M/X9u3Oel3hkIXCVjXA4mZjOsBvyY+zYBbNzahBw11cGbaP7T6K584SHv1aWeeetaMjx
         NW3aUSl2MGKqG/u1WSJIYQVf8e/bz7kNCDurk3r0pmQiGj2a+dOlFnw8jGGu2eVFik63
         p7Kw==
X-Gm-Message-State: AJIora8xFbMcswiBIDX+UGB8VN/cKysgCUZhVL+HJgdShEvZ7LdU1V3S
        Oil761Tk0qWHkRGOBdsoh+Q34b4vHoy1lA==
X-Google-Smtp-Source: AGRyM1uheFsws2V+i8gGyuhcYs+yt8kDNnrSihGlDn2R9rBQ7VSqJ5MTq4hx7hhXtntomJ33YE308g==
X-Received: by 2002:a37:63cb:0:b0:6b5:d13a:67cc with SMTP id x194-20020a3763cb000000b006b5d13a67ccmr11604650qkb.165.1658221550128;
        Tue, 19 Jul 2022 02:05:50 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id s5-20020a05620a0bc500b006b555509398sm14188593qki.136.2022.07.19.02.05.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 02:05:49 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-31e47ac84daso33523757b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:05:49 -0700 (PDT)
X-Received: by 2002:a81:168f:0:b0:31e:6128:247d with SMTP id
 137-20020a81168f000000b0031e6128247dmr494511yww.383.1658221549285; Tue, 19
 Jul 2022 02:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220715054224.6583-1-wangborong@cdjrlc.com>
In-Reply-To: <20220715054224.6583-1-wangborong@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jul 2022 11:05:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVOF4PTEteRZr4OHYt5ZubUhXCdV=E85pyVr1h=avPkSg@mail.gmail.com>
Message-ID: <CAMuHMdVOF4PTEteRZr4OHYt5ZubUhXCdV=E85pyVr1h=avPkSg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/ps3: Fix comment typo
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 3:48 PM Jason Wang <wangborong@cdjrlc.com> wrote:
> The double `when' is duplicated in line 1069, remove one.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
