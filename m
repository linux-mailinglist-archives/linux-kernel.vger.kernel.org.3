Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00176599B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347979AbiHSLiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346618AbiHSLiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:38:22 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB87DF3F;
        Fri, 19 Aug 2022 04:38:17 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3321c2a8d4cso113872497b3.5;
        Fri, 19 Aug 2022 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NmhoqI7k4G6QeMKgIeqojmW1W43PHTYsxk5F7putWNQ=;
        b=ISEypOIUgRx4LtgZAU/Zt9gtmdQJMf1Necwp6xhN2wGJcJKV06jBwOeuYw+RgxNwwk
         zOJDTubjM1fsdCiY8e3XX1JQ0D/EB8focolh0vfSxVMqlHxwF71rDamRJ1f8FyHzrLpd
         GMpiWW0vNYD8UUeDX5lJv0g4RSIXGo2ZoxhT1d1fmaYBvZvn1aO7+UgFV6d0EH5c+q0L
         c+7qJiWS6nPlt/6MpSDqoMvKsvFunWJcyOmp4FmR+pniCa8tKxopBLzlExRZT1GpF1+l
         uhrabPieck9hpQKVoDsWyZOVtiYKQtAgT+7/YCID3abj6gHVno4bsiz+sa3a8+h1+xZx
         4HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NmhoqI7k4G6QeMKgIeqojmW1W43PHTYsxk5F7putWNQ=;
        b=Q4VgH+3pImTA6Bv8w1VcftapiyRDWC27NRa6681CC9qVfXzICEazPap4lSm8C9KSGP
         SUHBH7WyHTWtBvL0Dw5f3Mu8TB2n7mEqyDDn7BhYgsek8RnECkOwyMrJfpPLThqLCtQx
         D87JPS0ypJvsMqGJNgdPPTaaDMU1Z+nmP4KnGiFlZli7OKYYxYDDtGo/78T5r9fe5GX2
         LZUOaMvpykCrJfKmRPHoLxQChKaj/Bwbm7SHkyuAR3DjM/vEpkngnRh+F98qDiSwqEWA
         QqAQN/xFXpjk9J6GUUYvvvWQE2qknIwtsLjcKdJF/MwbLiZ4w/BzOY+YlSh+SgzSVks3
         79tw==
X-Gm-Message-State: ACgBeo3ggkbxvlLHs7mhLugzxSeeDGPS+Z2N0OVVZ7m4r/eZYV2k5s7S
        waas3GHPOJJJvWvNC1epGKlHwdRzRZ4WYO+o5Ks=
X-Google-Smtp-Source: AA6agR4/Vfe8x/za+bJPvbu3J3Q/1xJd9HVg7k/3oR1ufo6PrA2tdscx1U9Y0c+tmx0YQ1vTbLzMESsVWI1NfuQhhmU=
X-Received: by 2002:a81:1c4b:0:b0:337:4e8:8bdc with SMTP id
 c72-20020a811c4b000000b0033704e88bdcmr5909913ywc.65.1660909097055; Fri, 19
 Aug 2022 04:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220801214718.16943-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXKnve1-KE+GF5YVe3k8w0oQA96P9VAfB9XxVMbuKiN7g@mail.gmail.com>
In-Reply-To: <CAMuHMdXKnve1-KE+GF5YVe3k8w0oQA96P9VAfB9XxVMbuKiN7g@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 19 Aug 2022 12:37:50 +0100
Message-ID: <CA+V-a8v84auNSF7HSO=VxvofHKuO75YG7DxdSmUvjUdjx8zf7w@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: dt-bindings: media: Document RZ/G2L CSI-2 block
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Thu, Aug 18, 2022 at 9:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Aug 1, 2022 at 11:47 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Document the CSI-2 block which is part of CRU found in Renesas
> > RZ/G2L SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > RFC v2 -> v1
> > * Fixed review comments pointed by Rob and Jacopo.
>
> Thanks for the update!
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> > @@ -0,0 +1,149 @@
>
> > +  resets:
> > +    items:
> > +      - description: CRU_CMN_RSTB reset terminal
> > +
> > +  reset-names:
> > +    const: cmn-rstb
>
> While it doesn't hurt to always have reset-names, you may want to drop
> it, as there is only a single reset.
>
Agreed, I will drop it.

Cheers,
Prabhakar
