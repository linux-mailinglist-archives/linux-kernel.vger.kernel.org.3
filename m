Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8679054AEAA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbiFNKox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242976AbiFNKop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:44:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D823D4889B;
        Tue, 14 Jun 2022 03:44:42 -0700 (PDT)
Received: from mail-yw1-f171.google.com ([209.85.128.171]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M9ntb-1o6qvU0Dn3-005pCs; Tue, 14 Jun 2022 12:44:41 +0200
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-30fdbe7467cso25375657b3.1;
        Tue, 14 Jun 2022 03:44:40 -0700 (PDT)
X-Gm-Message-State: AJIora9YmfidbEhKptpk6GMGoCNvgERNUROiq5G2t6WYJO9J1kS8rm3O
        grlNZhl1D0WiKwcYRq2FM875bCFyxAiIm5s0ax0=
X-Google-Smtp-Source: AGRyM1tr/ng9g9sm93eXlz+bdGnyiIzeyyD0zeJbGcgCyaf7ssINAXTuhAQgINggNB8yp6EGGkLewqJtLvVBwFTVyu4=
X-Received: by 2002:a81:2f84:0:b0:314:2bfd:bf1f with SMTP id
 v126-20020a812f84000000b003142bfdbf1fmr4800845ywv.320.1655203479718; Tue, 14
 Jun 2022 03:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655194858.git.qinjian@cqplus1.com> <42ed93cf0e5cfeaffdf50d63da558a3f1f6c1021.1655194858.git.qinjian@cqplus1.com>
In-Reply-To: <42ed93cf0e5cfeaffdf50d63da558a3f1f6c1021.1655194858.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jun 2022 12:44:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0p3M2Z7aaB3tGJSud3Tr+E7BtwQka6j5HS3VooV7L8XQ@mail.gmail.com>
Message-ID: <CAK8P3a0p3M2Z7aaB3tGJSud3Tr+E7BtwQka6j5HS3VooV7L8XQ@mail.gmail.com>
Subject: Re: [PATCH v18 05/10] clk: Add Sunplus SP7021 clock driver
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ey+dO0+lUy7FfGtAxlF5Bijf8TCIsvXafMT3lHTzHl/7apLNQzy
 CtpLCAuknHeB88VpoOoZigtOBMnXW4C66GHMWSFewXNW0hIpON+KFQd7jXxXBUGKGvhuKV3
 u8Fh1n/uUfCqYv3PVHTzYRos1txUt2TMJD1M4mg28wA9KrqB9YR2XHgZhspjfCHcKlCgD9A
 HLm9/Sf3Du2RUi1ZSPhQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xzCm8Sh6xA8=:/Fidt+9OqPZYqqIuZqLMc9
 dtOMh1fukRJvCDE4s48Hn7iDLXI/clYZF6Sk+abYf0B9qOYQW58uYw65UgzXBKV2IzCkKxtWI
 TDn7za1VzREeHhxhM6QFlWu/6RgzWm/LG6Agcco8zo+3QXJiFW4vHDUGpRsVO3UIynTwPVI5P
 gmDZG14LU5HsCIDCrbMPjzbgkMMKXmWwNj/o/hb09sySuGsE9SfL3b+4/o0WH1FBiQCRD9nQN
 V4PkV3B8b+AS8Yp/yG7EoI9zl0rbCT9ap5LUK7TkSW2CjI8XtwxVF6vTUN9Gn5OvHBNnWl8Gu
 X/wGG0wWy2smh6DgOc6SutuEKyyNqa+6G3nYZnI+m0qd6U7JeOW78L/LQLH48rsmTd+MfgT25
 MsdYNoFzpjdZ31fbVu3gj7vgZdmLeJy6Sbfdt/RvfCYtJAAh3tQ/5Vi5Bkk6Ux+l0gIhdBEVt
 lI1MivnTBKCd4EogxRWKZoNd75k+lxWs4y8T8TbYN0arb3kjduglhBCAmZU9VCcPWk4RT98l0
 bi9t8WtmbtiWt+c+uB/8P9H+hbW1ysPU0UXBt0QH6ayvuM4KuNlf4s+OjGXHaYQrYpOonlVjz
 4PYNlAHLzqlUYxUabMewpyI6A+ICyNuBKWZCZN9LGd7s0mpb6tA1bv3u1PL5wUtRCZXec4V0C
 x7cc6UZFgiQJq1KThZWymR9XX/+YCaFxcTqNpou5kSG2yD8Awj29jlFDG9OOQrbsK1XIRwvhZ
 24OkaD1oeBmsFws7fFoyy5UQIZCoFHPvTP4ZElXRpHTqyMZCqpBOMa5/ozKbCgcfb1L1F47r5
 ti+MUTlKymS5l3ej58mBoP3X/x2FGiSLQZbinXir0pJ2d6n4Aq8I8gz+HLsTW4QSvuHgB0kMF
 X8M4UhJokuPBvNqqILGQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:31 AM Qin Jian <qinjian@cqplus1.com> wrote:
>
> Add clock driver for Sunplus SP7021 SoC.
>
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
> Fix the comments from Stephen Boyd.

Do you mean you still need to address the comments from Stephen, or
that you have
done this already?

I can't apply the series if there are patches in it that still need to
be fixed or
finish review, so I hope this is only waiting for a final Ack.

        Arnd
