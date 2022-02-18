Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7863C4BB691
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiBRKNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:13:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiBRKNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:13:43 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9BE5EDD9;
        Fri, 18 Feb 2022 02:13:27 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id d26so4563415vsh.0;
        Fri, 18 Feb 2022 02:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biimC3ZT2BE1qWlcoP/prHvVGaEl3yOP7VCC6ZAmJec=;
        b=GwlLUnzqr3Qf3/Dlfc26dn9yftBoS5iP5IpWB4rtuwydAkaKmjQWsLZwhWfNec32Fy
         vU06IuHCMjfdas3jzEwCTjhSKL73a0rZJJs25JRPDH5B+bKxnw86876PRsCB0dDL04rO
         ybPIK74pfix7tqGQotSe/VR+guWJ6JpIOZ/NpdnURUEDRq2TRabyMf46uJKhwVu0rbPi
         ENHKRtIr2PEj6sko+y74D8QXuq3Wi7kxVAnhGTEhkMX3ETf7A1melPOhB+mK/ZeQCl8b
         E/T67/8ixxTCjIS1PVIsqwe15Kbx5NGcoQaO0Q+oco0WWeJrYWt/GlNNeU4hIDICXvEQ
         +BkA==
X-Gm-Message-State: AOAM531atcCGBI5TWGOguFU4H5fS14Fe2uKg7TnqswRMxBEd+7qFIzF3
        Ia3VXb/fHiXOKF4By3TFP50k5BvZbU6wPQ==
X-Google-Smtp-Source: ABdhPJzboswq3Qf4DkeS6az73Pe3optwurOBz43dfLXN1TnoFH5VquHl77Z8ldgag6e98Z3Q8txQlA==
X-Received: by 2002:a05:6102:ccb:b0:31b:93d6:aba7 with SMTP id g11-20020a0561020ccb00b0031b93d6aba7mr2966959vst.79.1645179206169;
        Fri, 18 Feb 2022 02:13:26 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id z23sm4964827uaq.2.2022.02.18.02.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 02:13:26 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id bj24so4548372vkb.8;
        Fri, 18 Feb 2022 02:13:25 -0800 (PST)
X-Received: by 2002:a05:6122:ca1:b0:330:b95b:e048 with SMTP id
 ba33-20020a0561220ca100b00330b95be048mr3094832vkb.39.1645179205702; Fri, 18
 Feb 2022 02:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20220216181003.114049-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20220216181003.114049-1-nikita.yoush@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Feb 2022 11:13:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUM0tKbJ_8OkNA4Ep_mzhmwr=JNC+v48hgqZtAGu--p1Q@mail.gmail.com>
Message-ID: <CAMuHMdUM0tKbJ_8OkNA4Ep_mzhmwr=JNC+v48hgqZtAGu--p1Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: ulcb-kf: fix wrong comment
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Feb 16, 2022 at 7:10 PM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> Fix comment referencing salvator board, likely a copy-paste leftover.
>
> ulcb-kf.dtsi has nothing to do with salvator.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Fixes: 80c07701d5918928 ("arm64: dts: renesas: ulcb-kf: add pcm3168
sound codec")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
