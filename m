Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53F3484A55
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiADWEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiADWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:04:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E59C061761;
        Tue,  4 Jan 2022 14:04:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D5C4615C7;
        Tue,  4 Jan 2022 22:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA76C36AE0;
        Tue,  4 Jan 2022 22:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641333843;
        bh=L354uWkqpyFGbTc2T2lOANUV2rpXJgXvrwhCRapufHw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U33TgfLEc8jq4sWT4q2o5Sq5mfyRlMAlApGnBW1WDWl7dM1KwkneYhgKIlljIDqzf
         q2bXDTsqhm3jNpi111iCKUCD954qCRq61WaRIUxr1qmeGa0DG2o3iIGpAvY2BCaNZ6
         YavPDqyiLg3OYI9vtN2GviCoF3cqlqrs4+vz5hJpk3hcqMyItUo89f29Bf9Z4KRumA
         SbAnkR0lB5gr4ruFbLmRB+6r29r9D0WflfiIMpOKY4/2tiM8KSUsxtsMm+XNuHxvoM
         mCG4pJTxh1CdszuSvRAx2SvHUcNjdtpXaPWNEeBBYr+x8FRjdUfM5wnfWXpDB8MfV8
         viPsBVSannXug==
Received: by mail-ed1-f46.google.com with SMTP id m21so155102337edc.0;
        Tue, 04 Jan 2022 14:04:03 -0800 (PST)
X-Gm-Message-State: AOAM531pEI919PFXyusIcfY8mRNWhCsxYQVAACnzqr7+O4jd0rEqUffC
        vbIdYCcjhQbEdrDVhx3fChqW+MACblSplxpLhw==
X-Google-Smtp-Source: ABdhPJzWXbR+opDMZ47HZWGd5LvVBkP6EbJBGAe8frpS26RGPnAmEZl+6udHveZ0KMgOY0xIfvAsHtXqO9YH3wuribw=
X-Received: by 2002:a17:906:7945:: with SMTP id l5mr40575041ejo.82.1641333841973;
 Tue, 04 Jan 2022 14:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20211221133937.173618-1-y.oudjana@protonmail.com>
 <YcJgDToAY/vXXekl@robh.at.kernel.org> <20220104041303.349963-1-y.oudjana@protonmail.com>
In-Reply-To: <20220104041303.349963-1-y.oudjana@protonmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Jan 2022 16:03:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKCff0-d5vAXKsPQXr67zUfxgkkuOOM41i6Q5m1NLMnGA@mail.gmail.com>
Message-ID: <CAL_JsqKCff0-d5vAXKsPQXr67zUfxgkkuOOM41i6Q5m1NLMnGA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: avs: qcom,cpr: Convert to DT schema
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Niklas Cassel <nks@flawful.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 10:14 PM Yassine Oudjana
<y.oudjana@protonmail.com> wrote:
>
> On Tue, 21 Dec 2021 19:15:25 -0400, Rob Herring <robh@kernel.org> wrote:
> > On Tue, Dec 21, 2021 at 01:40:05PM +0000, Yassine Oudjana wrote:
> > > Convert qcom,cpr.txt to DT schema format.
> > >
> > > Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> > > ---
> > >  .../bindings/power/avs/qcom,cpr.txt           | 130 --------------
> > >  .../bindings/power/avs/qcom,cpr.yaml          | 161 ++++++++++++++++++
> > >  MAINTAINERS                                   |   2 +-
> > >  3 files changed, 162 insertions(+), 131 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
> > >  create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
> >
> >
> > > diff --git a/Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml b/Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
> > > new file mode 100644
> > > index 000000000000..852eb36eea93
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
> > > @@ -0,0 +1,161 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/power/avs/qcom,cpr.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Qualcomm Core Power Reduction (CPR) bindings
> > > +
> > > +maintainers:
> > > +  - Niklas Cassel <nks@flawful.org>
> > > +
> > > +description: |
> > > +  CPR (Core Power Reduction) is a technology to reduce core power on a CPU
> > > +  or other device. Each OPP of a device corresponds to a "corner" that has
> > > +  a range of valid voltages for a particular frequency. While the device is
> > > +  running at a particular frequency, CPR monitors dynamic factors such as
> > > +  temperature, etc. and suggests adjustments to the voltage to save power
> > > +  and meet silicon characteristic requirements.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    allOf:
> >
> > Don't need allOf with only 1 entry.
>
> I get this from dt_binding_check without it:
>
> Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml: properties:compatible: [{'items': [{'enum': ['qcom,qcs404-cpr']}, {'const': 'qcom,cpr'}]}] is not of type 'object', 'boolean'

Because you made 'compatible' a list rather than a dict/object.
'allOf' is a list of subschemas though.

Rob
