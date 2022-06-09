Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E873A5447C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbiFIJke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiFIJkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:40:31 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAE94AE2E;
        Thu,  9 Jun 2022 02:40:30 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id b17so7695105qvz.0;
        Thu, 09 Jun 2022 02:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USvCbIzf7kAWUlatXORQPqOzuZzCVX+P1+Q0wg0R4kk=;
        b=sLatTqhzzXcYQmVAFNg6p6Tq1D6sVYw+SCYynmxc/YSnyzo5RBPA3Y35ePz5F2aQIZ
         7gXvohWavA7ltUuFEb8MMFRFLrXMYrXK89rcTnQZlQXsNW+FerbJk2APNIxyaEFQXvIy
         umQyD2XNAi8QwAbGtNA06dGqbwFrnaIwsTlPRJS36UMrpaqKu6ZBVli0zCpN3BwFOXeA
         xcs3XFgwG4r1pF8i27f2pYns/vZXenGWxXYfbzWJezrIa8sUEZeX/8Wt2bCbkVyQ6ZAE
         lAhGXOG/SUCEW2DbtKwG7fRJz3YGbBEzFQ8/7BixD7N02547CFrIVHVAE7Ij2L9OIqm+
         LWaw==
X-Gm-Message-State: AOAM533ZCwgQsVu1MDTxAFw0xy2XTb0/6yoh9W6UjtHB83xpTnOCwqKc
        SpqGsvKR5vvF70n/9A/6aImH/ln+eSO0iA==
X-Google-Smtp-Source: ABdhPJz+iv0hediA7Bcnt/YymjKhMjXfuX0Ul4PpaBbgIoTYXp1eXEiPKK/celRAw7N1DGeLehYDeg==
X-Received: by 2002:ad4:5d46:0:b0:464:5970:5b9 with SMTP id jk6-20020ad45d46000000b00464597005b9mr28744911qvb.25.1654767629817;
        Thu, 09 Jun 2022 02:40:29 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id v5-20020a05622a130500b00304fce6a137sm4784267qtk.66.2022.06.09.02.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 02:40:29 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-30ce6492a60so235013257b3.8;
        Thu, 09 Jun 2022 02:40:28 -0700 (PDT)
X-Received: by 2002:a81:6157:0:b0:30c:7e4d:b28e with SMTP id
 v84-20020a816157000000b0030c7e4db28emr41765469ywb.502.1654767628538; Thu, 09
 Jun 2022 02:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220526204231.832090-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526204231.832090-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Jun 2022 11:40:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUWnqppXcOfsr=HU4cuwFx6__GK_Fjbpvdse2e3T0K92A@mail.gmail.com>
Message-ID: <CAMuHMdUWnqppXcOfsr=HU4cuwFx6__GK_Fjbpvdse2e3T0K92A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: adjust whitespace around '='
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm-soc <arm@kernel.org>, arm-soc <soc@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
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

On Thu, May 26, 2022 at 10:42 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.20.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
