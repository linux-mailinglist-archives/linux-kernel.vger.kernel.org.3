Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F63581D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbiG0Bi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiG0Bi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:38:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA8F205DE;
        Tue, 26 Jul 2022 18:38:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l22so739635wrz.7;
        Tue, 26 Jul 2022 18:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NyfWQPodtUVEZDiUxMb2w+9DVvwHvhHURiZlW1jlzXU=;
        b=RkpC+M9KOdxXZbkUTfFDVPn7aVz7+QhDvAm3AwbNq96u9mGAEe1LWRdq3YuzAmB/WM
         fVdZTaRFO7U85zj622caD9eihmQpX62cKyujnzkyFa6VJdtGTnjG54NMxQLxknERaKLM
         3Guu+jAaS5mir+0mLHgwVFJmKLrRB6ItmBBS2j9DZtlP3rSewcRBwcttx5KkK/b8YIQj
         iByyOTHhy1myzvXfZJeqNk+Zml0xZihdEY8bdorbptymT4S9e4w04gGdgz2CdVtNu6yY
         rheh6acec2Hd0FM0zbPhwDbesBXPD4IrNv7soJZtLMKL6A1GDow/e+mAvrt2ET9Bzrar
         y9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NyfWQPodtUVEZDiUxMb2w+9DVvwHvhHURiZlW1jlzXU=;
        b=i2sEHo0ibpWdHHg2SC9SO6rVcVcqgm/0J2XHb3nb4tveiieuBUoZJez0Sg6R5LItBY
         f3dJcXL0uEqJWoNwjnvdIChmBU62WqeeS0DJ7PsTA428QbtlT6C+kH/SAkFWbTOYt8jx
         fJ3p8PkQvStriABLOdLezt2xSbJIp5ECcNLUeaEsWircfU3GdIxHuTYDp2S0h2tFuqKA
         tp4Ho3rtijd9fpEbBpSiBFi6xZM/XV7IDdTHXnAb63piIpIplHBXZO8PMCEEHIsjN4Lt
         D8qFPqitoRnwVigKpp2zHw9xPdcBL7C9YjSPwSD9oW7Yfs5CquYb0MXHl/pPU31LRlxP
         lzOw==
X-Gm-Message-State: AJIora8F02lEFp5qjoh4297rmQlBh2C5Ag8cKuu1wVWiVqXpZwlhcUbe
        ltxGDp9C9XCTpbzui11mIpsVv1uykzmnmKG3NYVEbQwY7Ls=
X-Google-Smtp-Source: AGRyM1vQs2v2FPb/G7p+LcHuB/Y8Z/I8qlGq/6/emnQ8f09itv98pv+iXsu7/71IXgs7MRrXH0GWk261MUYDw/2iTA4=
X-Received: by 2002:a5d:6d8a:0:b0:21d:a6f3:f458 with SMTP id
 l10-20020a5d6d8a000000b0021da6f3f458mr12773003wrs.574.1658885933746; Tue, 26
 Jul 2022 18:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220726102404.564498-1-gengcixi@gmail.com> <20220726102404.564498-2-gengcixi@gmail.com>
 <e07cc297-1b89-e6f5-c16e-26750c8402c4@linaro.org>
In-Reply-To: <e07cc297-1b89-e6f5-c16e-26750c8402c4@linaro.org>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Wed, 27 Jul 2022 09:38:17 +0800
Message-ID: <CAF12kFsJrkvq=9iDQycHJoXE5LL+-FD6sPQp-XxzeQJgi4DbRg@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=B9=B4=
7=E6=9C=8827=E6=97=A5=E5=91=A8=E4=B8=89 01:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On 26/07/2022 12:24, Cixi Geng wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Add bindings for Unisoc system global register which provide register m=
ap
> > for clocks.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-g=
lbreg.yaml
> >
>
> The patch depends on patch in clk tree, so either it goes via clk tree,
> there is cross-tree merge or it must wait for v5.20-rc1.
ok, I will resend this patchset after v5.20-rc1.thanks
>
>
> Best regards,
> Krzysztof
