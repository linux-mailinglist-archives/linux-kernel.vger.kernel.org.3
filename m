Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3073B50E0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiDYMws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiDYMwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:52:30 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29E2BC0F;
        Mon, 25 Apr 2022 05:49:26 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id e128so10631075qkd.7;
        Mon, 25 Apr 2022 05:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPorSfLzynlTTFLcIqwhfwbS6R4JDxHEiU+bfxItonI=;
        b=ew61U+SbG4M6uq31+iG2W40+tE5/fOOF3O9jude92R40tV4JFekVTqOI6qs/F21GW7
         736WZq8TEwrxI3XD4Aw678MJBuIsUNZx2KfFCkEuVGqcqvU6ZGR7RIG6x81Nejn1FImr
         Hf5sxDKFbyxJsn6BtlfNO+Xeso8XzVkDWJUiutYAE0CzllknoPCfCq3jYcyscHSfYBx/
         hKBnANTxpV0DBF9hm3f12ZAFvVmpVbDH4hpwq29LZQxFCeaXBrR0HGtuYD1gvcIpq5sf
         7ErLtz17MvvxRc5o/y2xJTPe+8zdQfDR89+JQGiDBDBxqyziIo5so6JEvLtG2TGk0GQC
         NZ3g==
X-Gm-Message-State: AOAM532icnQOw2P/vpCEeSRxqttIv8NKJ+3FwIwTfGD0xpewvRloeoiX
        vRvXogZfaYohNZgHcpLgn0D5N7tDJxzxcA==
X-Google-Smtp-Source: ABdhPJyVoVZ4MbalF6jLAYP3M1LzuKx0Wmp8oF0R6/sNDgSq3hwkPqMCV26FFEsOJGMcc8fxNp460g==
X-Received: by 2002:a05:620a:7eb:b0:69c:7933:b405 with SMTP id k11-20020a05620a07eb00b0069c7933b405mr9828582qkk.602.1650890965493;
        Mon, 25 Apr 2022 05:49:25 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id x24-20020ac87318000000b002f1fc5fcaedsm5774780qto.68.2022.04.25.05.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 05:49:24 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id v59so13909280ybi.12;
        Mon, 25 Apr 2022 05:49:24 -0700 (PDT)
X-Received: by 2002:a25:8087:0:b0:641:dd06:577d with SMTP id
 n7-20020a258087000000b00641dd06577dmr15589591ybk.207.1650890964362; Mon, 25
 Apr 2022 05:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220421203555.29011-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220421203555.29011-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220421203555.29011-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Apr 2022 14:49:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX4_PKsGGRj6yGhDGfaRD-6PqiJeCnKq0yUicfMutOP4g@mail.gmail.com>
Message-ID: <CAMuHMdX4_PKsGGRj6yGhDGfaRD-6PqiJeCnKq0yUicfMutOP4g@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: sh: rz-ssi: Drop unused macros
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pavel Machek <pavel@denx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Prabhakar,

On Fri, Apr 22, 2022 at 7:32 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Drop unused macros SSIFSR_TDC and SSIFSR_RDC.
>
> Reported-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

What does this fix?
Is the real issue that there are 32 FIFO entries, and the TDC and RDC
fields are 6 bits wide, while the mask uses 0x1f instead of 0x3f?

> --- a/sound/soc/sh/rz-ssi.c
> +++ b/sound/soc/sh/rz-ssi.c
> @@ -59,9 +59,7 @@
>  #define SSIFSR_RDC_MASK                0x3f
>  #define SSIFSR_RDC_SHIFT       8
>
> -#define SSIFSR_TDC(x)          (((x) & 0x1f) << 24)
>  #define SSIFSR_TDE             BIT(16)
> -#define SSIFSR_RDC(x)          (((x) & 0x1f) << 8)
>  #define SSIFSR_RDF             BIT(0)
>
>  #define SSIOFR_LRCONT          BIT(8)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
