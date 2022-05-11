Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566A25230F7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiEKKsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiEKKsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:48:19 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B454BB8E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:48:17 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2f7ca2ce255so15832857b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drfygkTowvuBLUYKKqSn7wnL9G7tj7fcltIt86mentk=;
        b=U0Z5PRzaDD8HlY7u+vcRl3tjjLWmlEi4zx9guX+v+HnsRNi1BsPtGOFeWg7v/H8I/n
         v8vG/2LxavvFpGWW5BtLREFEtxUtULs9eeO/YBB3EKYbe7VGIk6aT6klVarI5nC8mODC
         7nHyamuW4M6cY0v2L3Jr6ofjaRUER+LJwoBuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drfygkTowvuBLUYKKqSn7wnL9G7tj7fcltIt86mentk=;
        b=r3ejJIeDK93EU1uDjHClZrrXIfmCj+riKWjaujgwZ4BjKkrABJfWgArB+Yp8ulCIbh
         rvJPySZhGdG7JwEmsINAGp4v+WmvM2SQv4kNhhimiSx3eKcVTVjWKSD+u/HakfIhliQB
         QPY04XFYT/wNnr8c6cRHCjQE5Ox8fhvDRSe06Nw9CrloItMCpcSRtL0LfpC1ossqgc26
         5QH3pB5aiYKsOcBHJP/mq8UpGF7Heo/XfnZxU9ZKbuL0m+XRMrXplAPu5gj3WI/0W0Xy
         Jk504zDa6lrmvNcw/lUjG1iL1cDbUJSOrWpbv7bJjIACcp4aWXxKGRkZEs0nL6txh5Zn
         RtUw==
X-Gm-Message-State: AOAM5311LqyPcx4IUfT/sbIXjveMP7J8TWNOmg/MLFz79iKHV09cqObC
        JSFWplx8n6872MUi6i8Loqe2UIBr4tzTVsE18caOtg==
X-Google-Smtp-Source: ABdhPJxGVBQnozICEIYWYYUmj2XDVy7Iv/cHfh2VaMsWkzahJc7RVRiArSA2H274bdeXvoIWUvYywB06XduA/JHWTxw=
X-Received: by 2002:a81:23cc:0:b0:2f8:1a60:a215 with SMTP id
 j195-20020a8123cc000000b002f81a60a215mr24030993ywj.295.1652266097218; Wed, 11
 May 2022 03:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220425125546.4129-1-johnson.wang@mediatek.com>
 <20220425125546.4129-2-johnson.wang@mediatek.com> <CAGXv+5HgyN+kp86M2GgFtbruXSAMSLxsh9vf8zVE5TxRMyTyaA@mail.gmail.com>
 <a8e5fd9de1feece9051e1624c5cf3b672131a122.camel@mediatek.com>
In-Reply-To: <a8e5fd9de1feece9051e1624c5cf3b672131a122.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 11 May 2022 18:48:06 +0800
Message-ID: <CAGXv+5G6Qv1JcsZNrw5=USJSzPkczW42FgXRYqAK=xS-moO6nw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: Add MediaTek CCI dt-bindings
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     krzk+dt@kernel.org, cw00.choi@samsung.com, robh+dt@kernel.org,
        kyungmin.park@samsung.com, khilman@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 8:14 PM Johnson Wang <johnson.wang@mediatek.com> wrote:
>
> Hi Chen-Yu,
>
> On Tue, 2022-04-26 at 11:18 +0800, Chen-Yu Tsai wrote:
> > On Mon, Apr 25, 2022 at 8:56 PM Johnson Wang <
> > johnson.wang@mediatek.com> wrote:
> > >
> > > Add devicetree binding of MediaTek CCI on MT8183 and MT8186.
> > >
> > > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > > ---
> > >  .../bindings/interconnect/mediatek,cci.yaml   | 139
> > > ++++++++++++++++++
> > >  1 file changed, 139 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> > > b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> > > new file mode 100644
> > > index 000000000000..e5221e17d11b
> > > --- /dev/null
> > > +++
> > > b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> > > @@ -0,0 +1,139 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id:
> > > https://urldefense.com/v3/__http://devicetree.org/schemas/interconnect/mediatek,cci.yaml*__;Iw!!CTRNKA9wMg0ARbw!zuufEcqpKbditY3eqLTHpL8P8humMCyh4D4QWsximmw124tJUPE3ZBUyBqBtDlQ9pSDO$
> > >
> > > +$schema:
> > > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!zuufEcqpKbditY3eqLTHpL8P8humMCyh4D4QWsximmw124tJUPE3ZBUyBqBtDoE9YHyu$
> > >
> > > +
> > > +title: MediaTek Cache Coherent Interconnect (CCI) frequency and
> > > voltage scaling
> > > +
> > > +maintainers:
> > > +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > > +
> > > +description: |
> > > +  MediaTek Cache Coherent Interconnect (CCI) is a hardware engine
> > > used by
> > > +  MT8183 and MT8186 SoCs to scale the frequency and adjust the
> > > voltage in
> > > +  hardware. It can also optimize the voltage to reduce the power
> > > consumption.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - mediatek,mt8183-cci
> > > +      - mediatek,mt8186-cci
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description:
> > > +          The multiplexer for clock input of CPU cluster.
> >
> > of the bus, not CPU cluster.
>
> Thanks for your suggestion.
> I will correct it in the next version.
>
> >
> > > +      - description:
> > > +          A parent of "cpu" clock which is used as an intermediate
> > > clock source
> > > +          when the original CPU is under transition and not stable
> > > yet.
> >
> > This really should be handled in the clk controller, and not by every
> > device
> > that happens to take a clock from a mux with upstream PLLs that can
> > change
> > in clock rate. The end device hardware only takes one clock input.
> > That's it.
> >
>
> To make this intermediate clock works properly, this driver is also
> responsible for handling the Vproc voltage and ensures the voltage is
> high enough to support intermediate clock rate.
>
> If we move intermediate clock rate control to clock driver, then
> intermediate voltage control may be handled by the clock driver itself
> as well.
>
> We believe that is not reasonable because clock driver shouldn't handle
> voltage control. On the other hand, DVFS driver is more suitable for
> doing this job.

Either way the DVFS driver handles the voltage change.

Right now the driver is doing:

1. Raise voltage if scaling up
2. Mux CCI clock over to stable clock
3. Set rate for CCI PLL
4. Mux CCI clock back to CCI PLL
5. Drop voltage if scaling down

I'm saying that the clock driver should handle 2+4 transparently when any
driver requests a rate change on the CCI clock. So instead the driver would
do:

1. Raise voltage if scaling up
2. Set rate for CCI _clock_
   Here the clock driver would do:
   a. Mux CCI clock over to stable clock
   b. Change clock rate for original parent, i.e. the CCI PLL
   c. Mux CCI clock back to original parent, i.e. the CCI PLL
   and back to the devfreq driver ...
3. Drop voltage if scaling down

Does that make sense?


Regards
ChenYu
