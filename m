Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA9C591385
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbiHLQHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiHLQH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:07:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5492BB01;
        Fri, 12 Aug 2022 09:07:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fy5so2804899ejc.3;
        Fri, 12 Aug 2022 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=e6zJEVJOtrs5jr41jffgUoYBgFxyThTIoik0RUHXuCw=;
        b=b4fQeI7L6yFpe/zUPCjsDzLVQ1wyNnZOADEB9EruvZ/VpoZXIgnKnLe8Mk42lZjbBL
         9hsFo8ET1u+f4g8H6BBJi++4a+ZUA5KiQt0EaN/ZS1WdZRcAgsEJ+AdxmbHX5cwIYbZq
         lUX2/qvEg2Nx95P+HRiM43aaMJxPQ5fWhVg/dOkHvbSiU4cmj1LEvNy/ydhWw1iu+5Pt
         6TfC6avTFtnPWBvxtJkk+f5bEEVvJvFzLH9Xc3KFUznflVd0/g0fF/Od5rrnc6SpucHf
         q76pGXdWs4CromZLZH7MFB7G/N4gdNSR+vbYtHuGc+jXBxIb8pB9CktAskY4GqjlVLZm
         3ecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=e6zJEVJOtrs5jr41jffgUoYBgFxyThTIoik0RUHXuCw=;
        b=Dihuaf7U4Bo3rQhG4mPHtovWjxpj5MEEr6RZnEgNgbdLH5b0xBymMAN5Hjd7ryb79e
         H8BVbNHE9gPrUll3kE7MyrxJ2Y9IBH2+MWhkZCSPUjh7XtkiE12fHrwLVwPi/3koP5BU
         Et/wUtNBA55AjBkrXREDvnqc/EUqp8xh9+jgLP/qh5TSTYl996hPN+mvnUP9gGMLYgc2
         xMOCLQHbNWWLuTmcDE6TdQbdl54yBdy1CeWwpZCydOYR3uBha+R+uEnZ2ivIPq/zGqyr
         3wnRRn0zddjw7lmZdwQLRkjaM2eVJRrleshW11mG6gtUV/1AhMctTBF92MJ2QYUnX5t3
         eAIA==
X-Gm-Message-State: ACgBeo1O4A90nXyc0A0uQKkm3kmmTbtKrKFbIYWIg//pIE3+Ulb9tI2o
        MqqFA9igOANLN89LcVnKhOja1UgSVdWjyjJRSsk=
X-Google-Smtp-Source: AA6agR4AcEvxsXoTW9XaaW1kokpsHtfsvfgZsZcSyJznwn9ZupVzTjGrJ6LGs6nECaBM1TmqWzPLesYjbEwBjSQLmAY=
X-Received: by 2002:a17:907:8b97:b0:730:9480:972a with SMTP id
 tb23-20020a1709078b9700b007309480972amr3200458ejc.648.1660320445418; Fri, 12
 Aug 2022 09:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <1660225318-4063-1-git-send-email-u0084500@gmail.com>
 <1660225318-4063-2-git-send-email-u0084500@gmail.com> <1660317233.429908.168977.nullmailer@robh.at.kernel.org>
In-Reply-To: <1660317233.429908.168977.nullmailer@robh.at.kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sat, 13 Aug 2022 00:07:14 +0800
Message-ID: <CADiBU39-4xdaMO5fOXOZyhC3w0TxdzZyfsFZXbcFw3=i+6UOMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add Richtek RT9471
 battery charger
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?5ri45a2Q6aao?= <alina_yu@richtek.com>,
        Sebastian Reichel <sre@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alinayu829@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E6=96=BC 2022=E5=B9=B48=E6=9C=8812=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E6=99=9A=E4=B8=8A11:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, 11 Aug 2022 21:41:57 +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add bindings for the Richtek RT9471 I2C controlled battery charger.
> >
> > Co-developed-by: Alina Yu <alina_yu@richtek.com>
> > Signed-off-by: Alina Yu <alina_yu@richtek.com>
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../bindings/power/supply/richtek,rt9471.yaml      | 78 ++++++++++++++=
++++++++
> >  1 file changed, 78 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/rich=
tek,rt9471.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/powe=
r/supply/richtek,rt9471.example.dtb: charger@53: usb-otg-vbus-regulator: Un=
evaluated properties are not allowed ('regulator-compatible' was unexpected=
)
>         From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/power/supply/richtek,rt9471.yaml
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/
>
Thanks, after I add 'DT_CHECKER_FLAGS=3D-m', it also can be found for this =
error.

This is typo, not 'regulator-compatible', it's 'regulator-name'.

Will be fixed in next revision.
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
