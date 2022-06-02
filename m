Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A333253B476
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiFBHkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiFBHkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:40:03 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEBBB6A;
        Thu,  2 Jun 2022 00:40:00 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id v29so2846686qtc.12;
        Thu, 02 Jun 2022 00:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXA7li8ZK3RigjqNVXUH284U624036W4Ac97gDcHmjQ=;
        b=2GSBRSn2tu7hqgbrYbVHW5+7PNMzqbzY6xp0xQh+EUUmsAJJ4vjAsyBU1Jbv1yMQ2u
         KGjQf2sFimhtsTdvoznjpYNEzmHFRYeQ9OmJuiojNUE9tYceStbPNQuPb4yb48bqHBcv
         lxp72Av1YrfHFpt9J8gCDiDC7fVTGlyHULhY900As5TnmQGDXqraAD3/4U+elR0h8LNh
         tpY6ev182TjuYYbYHjUXQLI1VxcMzCq1AVtyvN1x03eqCx1uk7K9Ja1ZJ0I3aOOesxx3
         F5adhl5gzD0O4moinletr3wn/W+Lw+OgIFG7WsHpclxfWMUJiVE/eqRcyrNIiuVUvPzB
         SU3w==
X-Gm-Message-State: AOAM532H6UWqAeyklKHjWww8Ypq85YwG2fAe0+rkI9woXTnQGll/E0CO
        7I/pi8z5OrhHacC/GavxMstGTgtRzVkXoQ==
X-Google-Smtp-Source: ABdhPJxq8iSVrj3S3wVTInHOlEs8nlld/3iw5UTL1IfU49jn1YPBjNrAguAomVsWxkw13kBJRPvZ3w==
X-Received: by 2002:a05:622a:1192:b0:304:b4e5:7cba with SMTP id m18-20020a05622a119200b00304b4e57cbamr2627105qtk.305.1654155599297;
        Thu, 02 Jun 2022 00:39:59 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id x6-20020ac81206000000b002f3bbad9e37sm647770qti.91.2022.06.02.00.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 00:39:59 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id z186so6933196ybz.3;
        Thu, 02 Jun 2022 00:39:58 -0700 (PDT)
X-Received: by 2002:a25:d748:0:b0:65c:6b00:55af with SMTP id
 o69-20020a25d748000000b0065c6b0055afmr3639736ybg.365.1654155598697; Thu, 02
 Jun 2022 00:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220528153132.8636-1-ojeda@kernel.org> <20220528153132.8636-2-ojeda@kernel.org>
In-Reply-To: <20220528153132.8636-2-ojeda@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Jun 2022 09:39:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUa+JJ-mwTtveerndzmjVV95tqK1iWDRDPDRf6MPtpvww@mail.gmail.com>
Message-ID: <CAMuHMdUa+JJ-mwTtveerndzmjVV95tqK1iWDRDPDRf6MPtpvww@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] docs: add SVG version of the Linux logo
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Garrett LeSage <garrett@lesage.us>,
        IFo Hancroft <contact@ifohancroft.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Sat, May 28, 2022 at 10:15 PM Miguel Ojeda <ojeda@kernel.org> wrote:
> In the Rust for Linux patch series, Jonathan Corbet requested [1] that
> we avoid binary assets (such as the logo), possibly by recreating
> them in SVG format.
>
> However, it turns out there is no SVG version of the Linux logo
> in the kernel tree yet, only a GIF one from the pre-v2.0.0 days.
>
> This patch fixes that by adding a SVG version of the Linux logo,
> which we could then use in the Rust for Linux documentation and
> other similar places.

Perhaps you want to add a Rust logo to drivers/video/logo/, to be
shown using fb_append_extra_logo() when Rust technology is included?

;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
