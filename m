Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF7E5017F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245599AbiDNPwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359210AbiDNPmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F21236;
        Thu, 14 Apr 2022 08:29:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5706C61DC2;
        Thu, 14 Apr 2022 15:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EE4C385AC;
        Thu, 14 Apr 2022 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649950157;
        bh=VfDxvkyS/FpdFkcDiBcJ2hxm8R6mL94Wq9ENWeNdGqE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HsD10AHd0KGAwx7G5NxJBlhBRD+OFG+cya++yOxAm/FJtdGmX0EDMX+C0AA+dBPiw
         EItMI2kNRUVIvX0D87gGolIsTXtt8vCS7QU41FzNnSBVhqw6iL0SP8DlfAVsKWgJ0f
         5OCK4VS8pAaBv0aOJ1mEGSC1EpCOIU8NAlAStDJvMqpB2B5F1vY3YxNoxmNEJB5Lzr
         NTK9gpz9HWwpLSpI4v3h+4/mFebrGH10EUHSdX7njvA/hWPQZ6DjaYsG2p70yW8QMV
         WJ+w/mt4+s9AwJ75eOYbSHDG/omxo8BXgxf2EQ+RBmoQbp+Ec61w/8EfMu8/EROwZA
         4G/7VPu68KXew==
Received: by mail-il1-f176.google.com with SMTP id y5so3324158ilg.4;
        Thu, 14 Apr 2022 08:29:17 -0700 (PDT)
X-Gm-Message-State: AOAM531hAWeRhupNxvN0sg8cmn0Z53PP5aN/gwXY/rfStY3EADoMidTn
        r9bUQmGTuED13rauu3nhvQuLN7MwlLDoCI/drg==
X-Google-Smtp-Source: ABdhPJy1TIctwgBcCZ2Dvctvarm3ytHizMQCj2YY3IXTqJtr+cOZYJRLcBeXwBjfV5QaFOGt+zSh79l1q5plG517MH4=
X-Received: by 2002:a92:dd86:0:b0:2bc:805c:23c7 with SMTP id
 g6-20020a92dd86000000b002bc805c23c7mr1202482iln.279.1649950156691; Thu, 14
 Apr 2022 08:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-4-krzysztof.kozlowski@linaro.org> <Ylg83Ub7wuElT+Bu@robh.at.kernel.org>
In-Reply-To: <Ylg83Ub7wuElT+Bu@robh.at.kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Apr 2022 10:29:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKmr_4rQPMYMvUyr9PL9NBPS0sjUsg3Z7VuDguMx7NwqQ@mail.gmail.com>
Message-ID: <CAL_JsqKmr_4rQPMYMvUyr9PL9NBPS0sjUsg3Z7VuDguMx7NwqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/6] dt-bindings: ufs: common: add OPP table
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:25 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Apr 11, 2022 at 05:43:44PM +0200, Krzysztof Kozlowski wrote:
> > Except scaling UFS and bus clocks, it's necessary to scale also the
> > voltages of regulators or power domain performance state levels.  Adding
> > Operating Performance Points table allows to adjust power domain
> > performance state, depending on the UFS clock speed.
> >
> > OPPv2 deprecates previous property limited to clock scaling:
> > freq-table-hz.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > ---
> >
> > Not adding Rob's review tag because patch changed significantly.
> > ---
> >  .../devicetree/bindings/ufs/ufs-common.yaml   | 34 +++++++++++++++++--
> >  1 file changed, 31 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/ufs/ufs-common.yaml b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> > index 47a4e9e1a775..d7d2c8a136bb 100644
> > --- a/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> > +++ b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> > @@ -20,11 +20,24 @@ properties:
> >        items:
> >          - description: Minimum frequency for given clock in Hz
> >          - description: Maximum frequency for given clock in Hz
> > +    deprecated: true
> >      description: |
> > +      Preferred is operating-points-v2.
> > +
> >        Array of <min max> operating frequencies in Hz stored in the same order
> > -      as the clocks property. If this property is not defined or a value in the
> > -      array is "0" then it is assumed that the frequency is set by the parent
> > -      clock or a fixed rate clock source.
> > +      as the clocks property. If either this property or operating-points-v2 is
> > +      not defined or a value in the array is "0" then it is assumed that the
> > +      frequency is set by the parent clock or a fixed rate clock source.
> > +
> > +  operating-points-v2:
> > +    description:
> > +      Preferred over freq-table-hz.
> > +      If present, each OPP must contain array of frequencies stored in the same
> > +      order for each clock.  If clock frequency in the array is "0" then it is
> > +      assumed that the frequency is set by the parent clock or a fixed rate
> > +      clock source.
> > +
> > +  opp-table: true
> >
> >    interrupts:
> >      maxItems: 1
> > @@ -75,8 +88,23 @@ properties:
> >
> >  dependencies:
> >    freq-table-hz: [ 'clocks' ]
> > +  operating-points-v2: [ 'clocks', 'clock-names' ]
> >
> >  required:
> >    - interrupts
> >
> > +allOf:
> > +  - if:
> > +      required:
> > +        - freq-table-hz
> > +    then:
> > +      properties:
> > +        operating-points-v2: false
> > +  - if:
> > +      required:
> > +        - operating-points-v2
> > +    then:
> > +      properties:
> > +        freq-table-hz: false
>
> You could also express this as:
>
> oneOf:
>   - required: [ freq-table-hz ]
>   - required: [ operating-points-v2 ]
>   - not:
>       required: [ freq-table-hz, operating-points-v2 ]

Err, NM. That doesn't work...

Reviewed-by: Rob Herring <robh@kernel.org>
