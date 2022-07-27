Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F7B58222C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiG0IbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiG0IbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:31:00 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082DE28A;
        Wed, 27 Jul 2022 01:31:00 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z132so10259320yba.3;
        Wed, 27 Jul 2022 01:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMQ6MzKO4jVrKuo9MQJs2hunXZNbN/6XhlZSMs6O3qQ=;
        b=PsSNWPTTliI2TkTnuFteKWoRbYUjQOc1fggFhpxgXJGYJvBawQ98/rpfuA2XNqwpO2
         +Ocz7HBDc+1bU5C4XjZc3Rb4QSkvDQGEtwmBJbJ1eDmV3SvrwIZLm85g3Jjvn31OoD09
         q3et9y2X/7rHiqPoI3SehR/bGGUWPPEYL8TZbWTCjutGkvFXkaIxpiqOjuF9U1rqBwxS
         d644Ejz/C1L9bu+uw7j31uKtbRswfGH85/rKX7j5Mbvw2G/9hpCMw5G1JlhlA7CjA6Fj
         MOLdZF7jNJajYTB7aBhFz2+5mtHeMRmS9x16jby3UjqRoVJiovYxq6kzu8o45HghytWE
         4zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMQ6MzKO4jVrKuo9MQJs2hunXZNbN/6XhlZSMs6O3qQ=;
        b=kkHOjeBAog/4jmH97S8371qQtQpaJUcB2w6N7jg8kBDqnJoQg16EqqdKnTR8rBBEGZ
         LZm+RqA5HTqOwWm3Ct6Kd3AzD0zRl6v8TQC0FKOE3u04EytZckkh1Ux1K3Ax+p+TN2bb
         z17gzOeG5CkfJFheswwdsYFCk0H183pnZtK2CsO4RjStQW+mXsKSYYsYse/i+kDm/J76
         gJXmLNiQi9FaJ41dyIuj0E0kYCTmTTSdnOeI6fYYQBhL/ORhhNHou0PSXUxOI9qtlvlt
         aqXGzJL44tkZIgLUK8R4t1RvHwiEeIQfJ7eai5LYoj/I07CyLDDSLtnDkRudHfFZTzh3
         uzQA==
X-Gm-Message-State: AJIora+wX4wmxZVfLvCIK48+8Z6kFO6fHPPsOU2P0rGrOiXUfOe+eFwe
        DbNtVPYO6yMtR3D79YFsd74vzvDE5U8wIQe+s4I=
X-Google-Smtp-Source: AGRyM1vpUsVjD1ybSSmSGeK4NXqsi3Dx+hXAOInHiOv+cY4eJ1nmeGjIHzJ1YrD2CFZRsw3XBJIKnvSKBHEsvWKm7/E=
X-Received: by 2002:a5b:508:0:b0:66e:db78:cc3f with SMTP id
 o8-20020a5b0508000000b0066edb78cc3fmr17203541ybp.299.1658910659135; Wed, 27
 Jul 2022 01:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <cc6f723a-441e-55fc-5044-890d45fb79b4@microchip.com> <CA+V-a8vwhsa2S2UX+hi0MPnrjpfRYLzo1Ca1vffx-5A9jr6Hpg@mail.gmail.com>
 <bcc1dbc9-37a2-157a-1da2-7e51d3edb6f7@microchip.com>
In-Reply-To: <bcc1dbc9-37a2-157a-1da2-7e51d3edb6f7@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Jul 2022 09:30:32 +0100
Message-ID: <CA+V-a8urJWn4Ob2Xs0w7f5YHJ1Ak362cM0427e494VqGREkYPw@mail.gmail.com>
Subject: Re: [PATCH 6/6] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
To:     Conor.Dooley@microchip.com
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Wed, Jul 27, 2022 at 9:21 AM <Conor.Dooley@microchip.com> wrote:
>
>
> On 27/07/2022 09:09, Lad, Prabhakar wrote:
> > Hi Conor,
> >
> >>
> >> Missing files? Where is your Makefile for this directory?
> >> Or the board dts?
> >>
> > My plan was to get the initial minimal SoC DTSi and then later
> > gradually add the board DTS, but it looks like I'll have to include it
> > along with this series.
> >
>
> You could still add a minimal dts & add more things to it over time I
> guess?
>
Agreed.

Cheers,
Prabhakar
