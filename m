Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD9255D16F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiF0Je2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiF0JeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:34:23 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF0163D9;
        Mon, 27 Jun 2022 02:34:21 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id y14so13877081qvs.10;
        Mon, 27 Jun 2022 02:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5th0qpP/J1ycxyypwJPUwSeLA3QY+9VgG/84MEtg00=;
        b=LKmvaQuvjMNtr2jA3MZX5X+OVC62FMHIl/huLurFrECWr2caDZ4gw/8A+gNgbe6cfI
         I1pLeabPlqAwpIyiIxX/97CM6MSQqPssYFz8EMl8RpoVoQSj2/yeHGuMoh7ZwWf4TJWc
         ywyZreVkO4VQGuTSHX8P1aPrrGKe/D/f/AVroalK2FzHwNOBY2/ofwerz+E9NiGy9mM8
         l02nSjj/Wwx9wknMAfWsdUauQ2hdAIqjIdhJiC+ekaIRJzIhvjoqiGqofYpr7Hb8VcYU
         7QIWirmvEqhEqWnDy7SsTQU8pEhTdD+IfnTFbct123BeXt+8hMbAj2NWYPx7VDmyvFrG
         U/IA==
X-Gm-Message-State: AJIora803xRn0luYV7G7mQCuuUSiOefHJgUq+J1D1+AoAgbb8bAq7BAE
        ccCjbPEjqZtHrAjuq5XZ+E6uyT9YUaGG8A==
X-Google-Smtp-Source: AGRyM1utvzLdA+PTPQs9Kw/g22g0rpxqI/GgMV2tm1q04ZDXA/G7m7E5sr2HvGffP6r6mhKyo/q4Qg==
X-Received: by 2002:a05:6214:21ce:b0:470:f4e:951b with SMTP id d14-20020a05621421ce00b004700f4e951bmr7793594qvh.14.1656322460566;
        Mon, 27 Jun 2022 02:34:20 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id p24-20020ac84098000000b00317ccf991a3sm5954243qtl.19.2022.06.27.02.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 02:34:20 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-3177f4ce3e2so79475447b3.5;
        Mon, 27 Jun 2022 02:34:20 -0700 (PDT)
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr6407552ywd.283.1656322459903; Mon, 27
 Jun 2022 02:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220623103024.24222-1-chris.paterson2@renesas.com>
In-Reply-To: <20220623103024.24222-1-chris.paterson2@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Jun 2022 11:34:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXeR_7gJb0PJVheUjyR68=a9yCD5ixtskKB0EZT3-HVrw@mail.gmail.com>
Message-ID: <CAMuHMdXeR_7gJb0PJVheUjyR68=a9yCD5ixtskKB0EZT3-HVrw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a07g054l2-smarc: Correct SoC name
 in comment
To:     Chris Paterson <chris.paterson2@renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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

On Thu, Jun 23, 2022 at 12:30 PM Chris Paterson
<chris.paterson2@renesas.com> wrote:
> This dts is for the RZ/V2L SMARC EVK, not RZ/G2L.
>
> Fixes: f91c4c74796a ("arm64: dts: renesas: Add initial device tree for RZ/V2L SMARC EVK")
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.20.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
