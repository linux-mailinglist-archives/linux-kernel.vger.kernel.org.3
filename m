Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CAC569DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiGGIvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiGGIvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:51:47 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB554F186;
        Thu,  7 Jul 2022 01:51:46 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id b24so12869671qkn.4;
        Thu, 07 Jul 2022 01:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8TTCMhm7I/OLPKvXGM7JXMEkeorr37t0n/MgDLHxknI=;
        b=oSjiSE/XijE+I5lzEu0e/Pz/X22yrLJP+wcQwNcyl1205BZHuUo9eiL21O2fLubnjg
         MwWgo1HBvckHST1XKQ5ea5Uq7pBlGJ/b4wcxLfJs00duoLCXwxc670diq8H0ZY0EQ1on
         RS3OV2ZgemS6cweeR7uVT94lE5pqrPAvwyoO578AoMWb+oplzWj6sn1iBzBMUOTarHck
         O/xq4Caw6S4M/2MDrBnYGahEFqUkNUEz0hjjFVqEL3GqYGAjx5zOjLyfQSy4Zx/vm6nn
         8+6seX4WVcmygiew5pwcnmXRhqOBdC3RsqvG8AbOxbLjk83Iuefo14PrV0o+Lpr0b2OE
         4mKw==
X-Gm-Message-State: AJIora+SxjZc3XF1MuAEXWnJU0HMX6EdcImGYyW/I8KABOPErjUOguuI
        tKkO+/xwVELJuKkS3anH5nrVv19Lj5a4NFhB
X-Google-Smtp-Source: AGRyM1viU2Kndlp+zQmvPbLpSpVwCKDMVFkme2eTbE257Mjq1O8Kgz9dJqnfvSXPVH4ho1HFhN7vOw==
X-Received: by 2002:a37:a488:0:b0:6af:4bb:fea9 with SMTP id n130-20020a37a488000000b006af04bbfea9mr30242026qke.380.1657183905222;
        Thu, 07 Jul 2022 01:51:45 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id i13-20020a05622a08cd00b00317ccf991a3sm5958085qte.19.2022.07.07.01.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 01:51:44 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-31cf1adbf92so36642197b3.4;
        Thu, 07 Jul 2022 01:51:44 -0700 (PDT)
X-Received: by 2002:a81:1090:0:b0:31c:9be5:6c95 with SMTP id
 138-20020a811090000000b0031c9be56c95mr22889103ywq.384.1657183904507; Thu, 07
 Jul 2022 01:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220705155038.454251-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705155038.454251-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Jul 2022 10:51:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVw4Vcq8VCQBVFkuuA5cKGkZodgkqirh6Mohu-FmQFUvA@mail.gmail.com>
Message-ID: <CAMuHMdVw4Vcq8VCQBVFkuuA5cKGkZodgkqirh6Mohu-FmQFUvA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: hwinfo: renesas,prr: move from soc directory
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

On Tue, Jul 5, 2022 at 5:50 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Group devices like Chip ID or SoC information under "hwinfo" directory.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> This should go via Renesas tree because of changes around soc/renesas/renesas,prr.yaml.
>
> Changes since v1:
> 1. Split from https://lore.kernel.org/all/20220705154613.453096-1-krzysztof.kozlowski@linaro.org/

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.20.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
