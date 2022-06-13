Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE79549986
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiFMRHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbiFMRGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:06:38 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DB12559B;
        Mon, 13 Jun 2022 05:05:56 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id l192so1663867qke.13;
        Mon, 13 Jun 2022 05:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwLyOilx9WOqvNt/3Yiyfo9fY3D0D5JL9svjFDzxcJc=;
        b=mirG+pXYdWmT/wWIEW46KPdRMH8MivKaZ/dKt1JgRO4IcipqNlZQ2fZ+lvJssw66K9
         kZCeOmE02qq1pT/JNuUZOu4KUo15Psce3yKzggqVi4b5QVxin9vPhWbOZC6t63c3MUv4
         NqTHZlyocexLMKY3KjjTXcsxJGvVnDN+c+CwhcYNcdlX94ZGvcvZvEIhYVO9/SaLbpxr
         Snqw13uQY7lDllq0/K5/9gbDyKQvGUATXyrqxCII6zdUedpYp+ogfa5DBwc2WoEwJ23J
         rj6fRmY7d2qR4WjRRgfjmaF6gfmFmmwjpyyTci7tfzindOYDw+RlFPC4kXBtNXB5rlaq
         rolw==
X-Gm-Message-State: AOAM533EyBjxxtZPjbdXEB4TZeVC2nQVnM5O5p59Af+zByw3vXqzxK/S
        k3KRcny8Q05L7HVNy4j+XyO0o11rij4z1Q==
X-Google-Smtp-Source: ABdhPJyG1Z+ss0PDfZyxXSVEb2nP2BBLomzlw8szdGzyWol2HPyjMMZZUVT5aABs6ygf5y2cuJmc3w==
X-Received: by 2002:ae9:f107:0:b0:69c:232b:bf39 with SMTP id k7-20020ae9f107000000b0069c232bbf39mr38809443qkg.310.1655121954596;
        Mon, 13 Jun 2022 05:05:54 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id ca21-20020a05622a1f1500b00304e5839734sm4874647qtb.55.2022.06.13.05.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 05:05:54 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-30c143c41e5so49016067b3.3;
        Mon, 13 Jun 2022 05:05:54 -0700 (PDT)
X-Received: by 2002:a0d:d481:0:b0:30c:44f1:2721 with SMTP id
 w123-20020a0dd481000000b0030c44f12721mr64775617ywd.283.1655121953732; Mon, 13
 Jun 2022 05:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <4dcd5c4ef92318dfa3298eb0c03945a8ce9b5833.1654942925.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4dcd5c4ef92318dfa3298eb0c03945a8ce9b5833.1654942925.git.christophe.jaillet@wanadoo.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jun 2022 14:05:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWT+sFoa9spFk1FYZb=Kyck8gPL4gRU5E8YOhdmmGAZxA@mail.gmail.com>
Message-ID: <CAMuHMdWT+sFoa9spFk1FYZb=Kyck8gPL4gRU5E8YOhdmmGAZxA@mail.gmail.com>
Subject: Re: [PATCH] media: rcar_drif: Remove useless license text when
 SPDX-License-Identifier is already used
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 12:28 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> An SPDX-License-Identifier is already in place. There is no need to
> duplicate part of the corresponding license.
>
> This is a left-over from commit adeb69705682 ("media: rcar_drif: convert to
> SPDX identifiers")
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
