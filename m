Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159684DC3E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiCQKYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiCQKYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:24:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D013E0CB;
        Thu, 17 Mar 2022 03:23:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id s29so8148807lfb.13;
        Thu, 17 Mar 2022 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q997/aim32qAN844XtyF1EgVZGYQu0iTF+26V6EakWA=;
        b=dCYZRbOJJduJbzFTmXHHEDdLPUTx6ttR6pFI89o//ywj4hPEtjACrI+j95gZRrm/UQ
         nyZ07FdMf0uNwL05rvb/qgTcwvRK71SEP+LCmH1J1NH7n6n4yw1CkF6JDptYFqg2oXIU
         gQqfoYUIpeMhm2jO2eWRHnV3PIBUq4cYAyqJuZz6HEok/dPZttjRj62Vuuo4W4XkcKZh
         bf4s5hNRBwWB5/tPBBozYMxxfhE/zx8Uh8ousphxZ9sTaYsMI2BLZy2Q0RTSjFG3uaxQ
         7WwwLbJvygjQqaej6K7B/v4QAxvJMWiSNKWi5gl7sTt0dy264mY0QaxOfm2FlPQsEl/r
         9KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q997/aim32qAN844XtyF1EgVZGYQu0iTF+26V6EakWA=;
        b=VlmuMT6tYhvKOTUxJLaEp3ZUstC4+/yxrjmx5gIa/VAAEYTveTN+nRN1Ji3gGIswnF
         G6g9dSU5F+re5jFBY38JZXoMqAEeEazb3gVZlwkxW8n5+0dGM0vtQRT2riRhhKgkwFWN
         Rp1QOl3VXcL1qYXc8umbECirgJXvuGiSsVVDcgKATdsg4lwEJsD7vjauxKKkYNBpHRhw
         rDBd6o5XsOWU5/je28k0+GKJxMXgIqJ6ppQIsuJtx0J/B4DRi+nCcTF8cZavcZiUD9UP
         n9TVHRgsx+STdGMVqcWOWeiMWuryepJmHad4IdC0+i02/l+LhvbwKgCMkgBbRQLQt7Oj
         9DYw==
X-Gm-Message-State: AOAM530azvhtsbkbsa8i1NPBrJV6ZxpIg64dCXMWTe+07HivNLr4ctZS
        owVnSoB6uEibyX8obU/5/qQe6w7g8eOA2JNpo40=
X-Google-Smtp-Source: ABdhPJx6Yw5sqc3oHgOC+M1OOphrf/GwfLoaeL01BvrlD7R30s1AwRtOdfgYh4FrjRTymS/KC7T98VTRHMz7/o96Mo4=
X-Received: by 2002:a05:6512:2256:b0:449:f79a:e762 with SMTP id
 i22-20020a056512225600b00449f79ae762mr1357073lfu.261.1647512602353; Thu, 17
 Mar 2022 03:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <1647235924-15572-1-git-send-email-vincent.sunplus@gmail.com>
 <1647235924-15572-3-git-send-email-vincent.sunplus@gmail.com> <7d560277-95e2-070c-e603-30f00dea7f51@canonical.com>
In-Reply-To: <7d560277-95e2-070c-e603-30f00dea7f51@canonical.com>
From:   =?UTF-8?B?5pa96YyV6bS7?= <vincent.sunplus@gmail.com>
Date:   Thu, 17 Mar 2022 18:24:33 +0800
Message-ID: <CAPvp3RhOs5y2XBYEdY31f5rc9yP5o-x_2KB2=umhL7VdvGXYTw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: usb: Add bindings doc for Sunplus USB
 HOST OHCI driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Krzysztof

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> =E6=96=BC 2022=E5=
=B9=B43=E6=9C=8815=E6=97=A5
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:42=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 14/03/2022 06:32, Vincent Shih wrote:
> > Add bindings doc for Sunplus USB HOST OHCI driver
> >
> > Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> > ---
> >  .../bindings/usb/sunplus,sp7021-usb-ohci.yaml      | 69 ++++++++++++++=
++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/sunplus,sp702=
1-usb-ohci.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-o=
hci.yaml b/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ohci.ya=
ml
> > new file mode 100644
> > index 0000000..7583b68
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ohci.yam=
l
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) Sunplus Co., Ltd. 2021
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/sunplus,sp7021-usb-ohci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
>
> Looks good. Few minor nitpicks:
>
> > +title: Sunplus SP7021 OHCI Controller Device Tree Bindings
>
> Remove "Device Tree Bindings" words here. Title is about hardware.
>

Yes, I will remove it.

> > +
> > +allOf:
> > +  - $ref: usb-hcd.yaml#
>
> Put entire "allOf:" just before "properties:".

Yes, I will modify it.

>
> > +
> > +maintainers:
> > +  - Vincent Shih <vincent.sunplus@gmail.com>
> > +
> > +description:
> > +  Sunplus SP7021 USB HOST IP is a USB2.0 Host Controller. It supports =
both
> > +  Enhanced Host Controller Interface (EHCI) and Open Host Controller I=
nterface
> > +  (OHCI).
> > +
> > +  It supports 32-bits address bus and 64bit data bus interface, compli=
ant
> > +  to AMBA AXI interface for data transfer.
> > +
> > +  It supports 32-bits address and data bus interface, compliant to AMB=
A
> > +  AHB interface for register configurations.
> > +
> > +  It supports 32-bits address and data bus interface, compliant to AMB=
A
> > +  AXI interface for register alternative configurations.
> > +
> > +  The UTM Interface block generates PHY control signals, compliant to
> > +  USB2.0 Transceiver Macrocell Interface Specification Revision 1.0.
> > +
> > +properties:
> > +  compatible:
> > +    const: sunplus,sp7021-usb-ohci
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
>
> You might need here phys. Are you sure you do not need to configure the
> phy for OHCI? You should not assume it would be configured by other drive=
r.
>

Yes, OHCI driver does not need to configure phy according to the
suggestion of our RD.
The default status of phy after power-on is good enough for OHCI.

> Best regards,
> Krzysztof

Thanks for your review.
