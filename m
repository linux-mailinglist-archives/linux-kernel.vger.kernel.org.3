Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EECA4C8B94
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiCAM3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiCAM3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:29:51 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3953ED13;
        Tue,  1 Mar 2022 04:29:10 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2d07ae0b1c0so142773347b3.2;
        Tue, 01 Mar 2022 04:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiuHzLDv+X4sDMr8N5eZFwdXrNoiDH/ZFPwIh03H038=;
        b=ZyQuGRtyR5VPEx16eh6QmT+0y8HAEtO2jYX3l92mJneEZbmhvhmIIkkvphYZfzlCle
         AMhH110sWQkByhSXcZAFUF5wfOjUoykJJLzG7V26pqt6w5rnWgVsWW+JldDr+IG04g8l
         uWefsc+iAnzB0CxnHGMzByp3iY+YK4bSnpjUJZVPevSZR8oUYULwuhtoim83u0jAnxCJ
         BcXPVRlALyG0OQJF1XO/6RDduHpXL7Z82FHi9MFl7lTJ9Qhfoxh2ZOv7i9GdEj3SaUgc
         BALsKQdCdfdnBUlQiRWW9xzScDf2jGZ2tXDI6cnbdYsGl9lMBpfRxVWl5Agw07jBXVcR
         VO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiuHzLDv+X4sDMr8N5eZFwdXrNoiDH/ZFPwIh03H038=;
        b=hOPffzdkeF/6a/ueaTiT5h4DTQh6hfPNqPDjLCpojH8HQCucfi01kFPFpWYajk+sfk
         7UkeySnjARuoFwA2Ear6IFDnbTb4LfEYVK7YdCAQFD+0+bEIdjuCwfQJpy0LVefyWjOt
         ZkoU0TI5Ngguskug+Qpj1EogQCiRWn5Hvdj981492Ppo6sT1lVfiU9/RidpgmyKhjQHV
         AkxrlTxO9BcOWAo9x5EyI30cqfigTsBHrfzlrKjBfYV+lsSXRUMJfDjIK+2NgNnW42I+
         SoRNTpMSRebXlawdX9jkmkqnQBGXii7mxrDfCJIrGhLaPJb5xpi4GB7kAmyjRqGeSURA
         Dbjg==
X-Gm-Message-State: AOAM532ACtSTD/cz46w/0eSG6wNnlmrw/oe9q7UO6qAWh6l+2BnJtQcC
        nnDQBBNzvNiNfSLV0gqG9bGJagiLrRbLJW4ZA30=
X-Google-Smtp-Source: ABdhPJyHRepGC0zo6I2k03s1BI67N1QNj1B3QXK12Syk7PUxHgjq0CUK8r+1AMO+IToXZJLpF+FlVtmOuxKBiGyYSF0=
X-Received: by 2002:a81:5597:0:b0:2d6:41f7:a00e with SMTP id
 j145-20020a815597000000b002d641f7a00emr24282471ywb.413.1646137749152; Tue, 01
 Mar 2022 04:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20220227215308.26135-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXaPc0bPE1Rf33hHg7c3Mq0UfYAqFcc+_q-NLG2y8WcYQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXaPc0bPE1Rf33hHg7c3Mq0UfYAqFcc+_q-NLG2y8WcYQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 1 Mar 2022 12:28:43 +0000
Message-ID: <CA+V-a8se2LyrxGnwUU7_uUPWPPzbzuWdkQX4He=iJJRq=DhQBA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Document RZ/V2L SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
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

On Mon, Feb 28, 2022 at 2:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Sun, Feb 27, 2022 at 10:53 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Document RZ/V2L RPC-IF bindings. RZ/V2L RPC-IF is identical to one found
> > on the RZ/G2L SoC. No driver changes are required as generic compatible
> > string "renesas,rzg2l-rpc-if" will be used as a fallback.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > DTSI changes have been posted as part of series [0].
> >
> > [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> > patch/20220227203744.18355-7-prabhakar.mahadev-lad.rj@bp.renesas.com/
> > ---
> >  .../devicetree/bindings/memory-controllers/renesas,rpc-if.yaml   | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> > index 294f1036420d..f051ffb2a421 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> > @@ -40,6 +40,7 @@ properties:
> >        - items:
> >            - enum:
> >                - renesas,r9a07g044-rpc-if      # RZ/G2{L,LC}
> > +              - renesas,r9a07g054-rpc-if      # RZ/V2L
> >            - const: renesas,rzg2l-rpc-if       # RZ/G2L family
>
> Please drop the comment on the previous line.
>
OK, I will drop and send a v2 version.

Cheers,
Prabhakar
