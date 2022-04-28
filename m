Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB1B513BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351232AbiD1StV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiD1StS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDBF7893A;
        Thu, 28 Apr 2022 11:46:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27C2E61C9C;
        Thu, 28 Apr 2022 18:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A280C385B2;
        Thu, 28 Apr 2022 18:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651171561;
        bh=W8f7fDe36f4f+Eym6CMYV+jfkS0Qx3jHXxH9asFg4vc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jdAyFQOJDF9rwjgLlTOYxJfRcvhjskJT4OsMiwRI9nKf3eDbCeiT2XPq5XDO0y+5e
         TdycQjji4IK2tU9MCqIV+b7ri4IN0lz+6WC9rLv60g365aJL6stisYuRi6CRDmO14i
         xoMkRAJmdBNNWlf4VxIkWQWlL2Ba33e5YZWhT1lSyrtOKphWd2FvU1v6HLovbW2DkI
         T24+ctCML/jVBTEPFJ+g8rITrT6dA64oqBY2v70nMfP+4ypnhWxCgi7WaqJ8fXVghI
         WAGgZHspGFvhfjyoJTQsJ42ifDQU5WiXJHTLUyAO8+n6oKXaSYGUlXcaSSKnONUxiM
         hhpOVE21BpILg==
Received: by mail-pj1-f49.google.com with SMTP id m14-20020a17090a34ce00b001d5fe250e23so5201328pjf.3;
        Thu, 28 Apr 2022 11:46:01 -0700 (PDT)
X-Gm-Message-State: AOAM530cFLSl3FUfDDchAlFBWIv0MEzsFD7xqaDNe0M3Qr6b8ZEMropD
        mXot6qKstkGQKx+h0mTUB6Kml/txN5D56XOb0g==
X-Google-Smtp-Source: ABdhPJxmdsC0BMphKfk6yRxPeHZONR7yfWAe7UKYtouukIIEoW+HJaG2vJEzGYNWAi5NxIAy4BbGAWutgditCSWB0hY=
X-Received: by 2002:a17:902:b694:b0:153:1d9a:11a5 with SMTP id
 c20-20020a170902b69400b001531d9a11a5mr34601834pls.151.1651171560862; Thu, 28
 Apr 2022 11:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220423085319.483524-1-markuss.broks@gmail.com>
 <20220423085319.483524-3-markuss.broks@gmail.com> <CAL_Jsq+hBtuet-WShvvLA7vfdFdpGRSmv45bcqQhoediq7a7xQ@mail.gmail.com>
 <5b2c429b-11ad-0d14-a106-d4b1d29d69e1@gmail.com>
In-Reply-To: <5b2c429b-11ad-0d14-a106-d4b1d29d69e1@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Apr 2022 13:45:49 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Cb335=sb1aOM0TDT+7LMKFYbc-diW0V1PRkA-ASJHuw@mail.gmail.com>
Message-ID: <CAL_Jsq+Cb335=sb1aOM0TDT+7LMKFYbc-diW0V1PRkA-ASJHuw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: regulator: Add bindings for Silicon
 Mitus SM5703 regulators
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 12:04 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> Hi Rob,
>
> On 4/28/22 19:36, Rob Herring wrote:
> > On Sat, Apr 23, 2022 at 3:54 AM Markuss Broks <markuss.broks@gmail.com> wrote:
> >> This patch adds device-tree bindings for regulators on Silicon Mitus
> >> SM5703 MFD.
> >>
> >> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> >> ---
> >>   .../siliconmitus,sm5703-regulator.yaml        | 49 +++++++++++++++++++
> >>   1 file changed, 49 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> >> new file mode 100644
> >> index 000000000000..75ff16b58000
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> >> @@ -0,0 +1,49 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/regulator/siliconmitus,sm5703-regulator.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Silicon Mitus SM5703 multi function device regulators
> >> +
> >> +maintainers:
> >> +  - Markuss Broks <markuss.broks@gmail.com>
> >> +
> >> +description: |
> >> +  SM5703 regulators node should be a sub node of the SM5703 MFD node. See SM5703 MFD
> >> +  bindings at Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> >> +  Regulator nodes should be named as USBLDO_<number>, BUCK, VBUS, LDO_<number>.
> >> +  The definition for each of these nodes is defined using the standard
> >> +  binding for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
> >> +
> >> +properties:
> >> +  buck:
> >> +    type: object
> >> +    $ref: regulators.yaml#
> > The correct file is regulator.yaml.
> I was applying all the suggestions, and I thought I had somehow made a
> typo referring to a wrong file.
>
> Do I re-send the whole series with just the s/regulators/regulator/g? A
> part of series has already been merged, do I not re-send the already
> merged patches then?

Just send an incremental patch fixing the file name. If there are then
errors in the example, then you need to resend the MFD binding with
the errors fixed. Unless Lee applies v5 before you do that, then you
need an incremental fix for example.

Rob
