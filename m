Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C743496589
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiAUTWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:22:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41976 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiAUTWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:22:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27EB8B81FA7;
        Fri, 21 Jan 2022 19:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE508C340E7;
        Fri, 21 Jan 2022 19:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642792963;
        bh=nbg9KajXn6cuNOOvxUHwQbE5zDr+iTleYlmTdaDefAY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fk7W0o85IluD1+Jup3pXAKup/RwYIIlStDj9VCeZA45jzdyYyu8lRf2Hym055wr1Z
         /M9NqURsYzdtMoKNbhyETIZQ0kVo1Hc70geJ/erSM6Jt+cruiF+6uyJIlN/FScoFdM
         BiAUY6zRArKBFlerCBCeDsIW0++vX8PPjtkXuoVvk5l1tZx2V+43c4xvqb8IYtdLFp
         dmXfKRhaQmuqRgdKixdC+TFS28plvOtD3KJvz4PYRRWlUpw/oiKK4g1CJHcagLrdJR
         pu/G7rn46rKyGg6oaAcmyqILHXMOF/L1H9wglTsQFNEMFC9FLYWoxVA6BH6x7Mke32
         YDlDfvOUPoORg==
Received: by mail-ed1-f48.google.com with SMTP id r10so13427966edt.1;
        Fri, 21 Jan 2022 11:22:43 -0800 (PST)
X-Gm-Message-State: AOAM5305bgM3T5HgtusTkDYiFaVyFEcVluRx6qCbubg0crYrgwxnR/XO
        EwEHd5buExISSncTaRTmV6JbFbvY6SvrRRC2Ig==
X-Google-Smtp-Source: ABdhPJwoKyR1d78TjQXuZ3lrQY/HG6f62VnB01DYfwcB+3jJqPmEjEpHlZfSKqgYoe+rZ0haRTrb+7SrS2xbOPtxbaw=
X-Received: by 2002:aa7:da81:: with SMTP id q1mr5502584eds.280.1642792961954;
 Fri, 21 Jan 2022 11:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20220120232028.6738-1-ansuelsmth@gmail.com> <20220120232028.6738-4-ansuelsmth@gmail.com>
 <YeoUk3t2iVbQwj5s@robh.at.kernel.org> <61eb0488.1c69fb81.d267e.3b1f@mx.google.com>
In-Reply-To: <61eb0488.1c69fb81.d267e.3b1f@mx.google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 21 Jan 2022 13:22:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK8o40m1u58djHEVAf-wp0WeBLVsyUNREy_v_vkyUTVxg@mail.gmail.com>
Message-ID: <CAL_JsqK8o40m1u58djHEVAf-wp0WeBLVsyUNREy_v_vkyUTVxg@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] dt-bindings: clock: Document qcom,gcc-ipq8064 binding
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 1:07 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> On Thu, Jan 20, 2022 at 08:04:03PM -0600, Rob Herring wrote:
> > On Fri, Jan 21, 2022 at 12:20:16AM +0100, Ansuel Smith wrote:
> > > Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
> > > clocks. The gcc node is also used by the tsens driver, already documented,
> > > to get the calib nvmem cells and the base reg from gcc.
> > >
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  .../bindings/clock/qcom,gcc-ipq8064.yaml      | 70 +++++++++++++++++++
> > >  1 file changed, 70 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> > > new file mode 100644
> > > index 000000000000..abc76a46b2ca
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> > > @@ -0,0 +1,70 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq8064.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Qualcomm Global Clock & Reset Controller Binding for IPQ8064
> > > +
> > > +allOf:
> > > +  - $ref: qcom,gcc.yaml#
> > > +
> > > +maintainers:
> > > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > > +
> > > +description: |
> > > +  Qualcomm global clock control module which supports the clocks, resets and
> > > +  power domains on IPQ8064.
> > > +
> > > +  See also:
> > > +  - dt-bindings/clock/qcom,gcc-ipq806x.h
> > > +  - dt-bindings/reset/qcom,gcc-ipq806x.h
> > > +
> > > +properties:
> >
> > This schema will never be applied because there is not a compatible
> > property to use for matching. The base/common schema is the one that
> > shouldn't have a compatible and then the specific schemas like this
> > one do.
> >
>
> Just to make things clear. To fix things up, what changes should I do?
> - I should remove the compatible from the base schema qcom,gcc.yaml
> - Add the compatible to this schema
> - Create another schema that includes all the others compatible?

Yes.

>
> Can I instead:
> - Create a qcom,gcc-common.yaml schema
> - Modify the qcom,gcc.yaml schema to ref the common one and drop the
>   other binding.
> - Fix this schema with the missing compatible?

That's fine. That's just a difference in filenames, right?

> Tell me how I should proceed since it looks to me that all the
> Documentation for the gcc driver looks a bit mess and full of
> duplicated stuff.

I think it was originally one document, but had too many if/then
schemas. Or maybe that was another QCom schema. There's no hard rule
on whether to split or not. It's a judgment call.

Rob
