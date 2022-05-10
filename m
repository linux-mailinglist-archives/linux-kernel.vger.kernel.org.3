Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554C8520CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 06:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiEJEdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 00:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbiEJEbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 00:31:48 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2722555A6;
        Mon,  9 May 2022 21:27:37 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id f3so7573704qvi.2;
        Mon, 09 May 2022 21:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=vMpaHuuuOG4MGEWXiRfaUjNNiANU4+C8012F//qkXo8=;
        b=VC4yVVFd/at+KN9tejUb+tTTTy3SktsyRsPMmN1Xbj4dRCy1d0ArQwTL4vrl6r4qwt
         CVogS8g3yw3RYsC2GXSpWF4m27QOcRMgcTv73Y0G2UpLUCvdo7i6Dg3KiZsWD1TcSGR3
         BicwMdlaVxi2OMw+EzdJg/5A+gYjQEWwut5p+K0SpMG3UOADxORAJBJXTLxgI+iO5Sgi
         eZjTgLxzmEKb5yOH3G5IYGMGcw+mSdtlzslM2jxAYrvyH0WTMgy3KmDGqGnf2/MmV29U
         7QnqYWAl9Crd7HZSw6ukvHvCjoYfLzqJXFAHGZqIlp1fE8KuroZyYlPQ1JwKaua3+oD7
         yHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=vMpaHuuuOG4MGEWXiRfaUjNNiANU4+C8012F//qkXo8=;
        b=Qh4Nb6plr2Wcq3ICcKJ5YJ5iCj3NmlIK/kyGWi9zDAamrgGQrEQuntwxfKZF7ZkBSK
         7U2RAtzHQzA/4t9OYNm2fBM8wXocFyokum6G6LZBmjw2LUgTzuOxZjYa/9Bc/SSGVJ9E
         xbrCdkoBFiwUG6rhZ3lnKgyfxz6q9CzH3vePnnKTS0VU0EXJK+vQUmBx0DzxSQuZxgP/
         csH51+pJ2sfVVUU0HrX6P02KgXVES16VWuQh/a8JbWfYwwo6U+Bl0KMrJ4UD0pYKAXE1
         ZshylpVGIX+XWJr/9f++ako4KBIpjyUCUbZMlixFFxT1P9boCcy8pPlNJVm7LppPh3eP
         rjsg==
X-Gm-Message-State: AOAM530DoV0HR6N7OxYxEQjvBGqShijiieIMmCMaIdcm5AROn79w+75i
        hRNFcqTOQZ2fqmo3rgdRkTb+XVu1lM/ehgRcmTM=
X-Google-Smtp-Source: ABdhPJwO7MdX2N+BxIvvqfhmxboqfMxlBiZaJL3wP1cEl/CpufKLHoQMnnY4JeZx47aYXO2bdL5yKMHOwUpp65u4jnw=
X-Received: by 2002:a05:6214:3017:b0:45a:6c33:2ae9 with SMTP id
 ke23-20020a056214301700b0045a6c332ae9mr16619988qvb.108.1652156856955; Mon, 09
 May 2022 21:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220425125546.4129-1-johnson.wang@mediatek.com>
 <20220425125546.4129-2-johnson.wang@mediatek.com> <94efefab-918d-2367-4b74-076dd6f23936@gmail.com>
 <e8124721a4ecd591ffea2c4d70853c1f89c83975.camel@mediatek.com>
In-Reply-To: <e8124721a4ecd591ffea2c4d70853c1f89c83975.camel@mediatek.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Tue, 10 May 2022 13:27:00 +0900
Message-ID: <CAGTfZH1dipThTeaZiD1JucYYQB+M19wVrhRy0aCC+7TydNFXjQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: Add MediaTek CCI dt-bindings
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, krzk+dt@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kevin Hilman <khilman@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 11:59 AM Johnson Wang <johnson.wang@mediatek.com> wrote:
>
> Hi Chanwoo,
>
> On Mon, 2022-05-09 at 21:09 +0900, Chanwoo Choi wrote:
> > Hi,
> >
> > On 22. 4. 25. 21:55, Johnson Wang wrote:
> > > Add devicetree binding of MediaTek CCI on MT8183 and MT8186.
> > >
> > > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > > ---
> > >   .../bindings/interconnect/mediatek,cci.yaml   | 139
> > > ++++++++++++++++++
> > >   1 file changed, 139 insertions(+)
> > >   create mode 100644
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
> > > https://urldefense.com/v3/__http://devicetree.org/schemas/interconnect/mediatek,cci.yaml*__;Iw!!CTRNKA9wMg0ARbw!z6ogArqzuIzPR3TYO1aW-Z-scpuZJxIriWMofdfnvrKTXAYBBLZeitAPIKyZayMYZGsR$
> > >
> > > +$schema:
> > > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!z6ogArqzuIzPR3TYO1aW-Z-scpuZJxIriWMofdfnvrKTXAYBBLZeitAPIKyZa9f2pALd$
> > >
> > > +
> > > +title: MediaTek Cache Coherent Interconnect (CCI) frequency and
> > > voltage scaling
> > > +
> > > +maintainers:
> > > +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> >
> > Why did you add your author information?
> > Please add your author information.
>
> Sorry, I don't really understand what you mean.
> Could you please explain your advice again?
>
> The author of this driver is 'Jia-Wei Chang'.
> We have added author information to the driver code and this binding
> document as above.

Firstly, sorry for the confusion.

I have discussed this patch with you. I think that you (Johnson Wang)
should be added to 'maintainers' of this binding document as following:

+maintainers:
+  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
+  - Johnson Wang <johnson.wang@mediatek.com>

>
> >
> > And add this dt-binding information to MAINTAINERS
> > as following: because I cannot catch the later patch
> > of modification.
> >
> > cwchoi00@chanwoo:~/kernel/linux.chanwoo$ d
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index edc96cdb85e8..a11e9c1947b7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5698,6 +5698,7 @@ L:        linux-pm@vger.kernel.org
> >   S:     Maintained
> >   T:     git
> > git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
> >   F:     Documentation/devicetree/bindings/devfreq/
> > +F:     Documentation/devicetree/bindings/interconnect/mediatek,cci.y
> > aml
> >   F:     drivers/devfreq/
> >   F:     include/linux/devfreq.h
> >   F:     include/trace/events/devfreq.h
> >
>
> I will add it in the next version.
>
> BRs,
> Johnson Wang
> >
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
> > > +      - description:
> > > +          A parent of "cpu" clock which is used as an intermediate
> > > clock source
> > > +          when the original CPU is under transition and not stable
> > > yet.
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: cci
> > > +      - const: intermediate
> > > +
> > > +  operating-points-v2: true
> > > +  opp-table: true
> > > +
> > > +  proc-supply:
> > > +    description:
> > > +      Phandle of the regulator for CCI that provides the supply
> > > voltage.
> > > +
> > > +  sram-supply:
> > > +    description:
> > > +      Phandle of the regulator for sram of CCI that provides the
> > > supply
> > > +      voltage. When it presents, the cci devfreq driver needs to
> > > do
> > > +      "voltage tracking" to step by step scale up/down Vproc and
> > > Vsram to fit
> > > +      SoC specific needs. When absent, the voltage scaling flow is
> > > handled by
> > > +      hardware, hence no software "voltage tracking" is needed.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - clocks
> > > +  - clock-names
> > > +  - operating-points-v2
> > > +  - proc-supply
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/mt8183-clk.h>
> > > +    cci: cci {
> > > +        compatible = "mediatek,mt8183-cci";
> > > +        clocks = <&mcucfg CLK_MCU_BUS_SEL>,
> > > +                 <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
> > > +        clock-names = "cci", "intermediate";
> > > +        operating-points-v2 = <&cci_opp>;
> > > +        proc-supply = <&mt6358_vproc12_reg>;
> > > +    };
> > > +
> > > +    cci_opp: opp-table-cci {
> > > +        compatible = "operating-points-v2";
> > > +        opp-shared;
> > > +        opp2_00: opp-273000000 {
> > > +            opp-hz = /bits/ 64 <273000000>;
> > > +            opp-microvolt = <650000>;
> > > +        };
> > > +        opp2_01: opp-338000000 {
> > > +            opp-hz = /bits/ 64 <338000000>;
> > > +            opp-microvolt = <687500>;
> > > +        };
> > > +        opp2_02: opp-403000000 {
> > > +            opp-hz = /bits/ 64 <403000000>;
> > > +            opp-microvolt = <718750>;
> > > +        };
> > > +        opp2_03: opp-463000000 {
> > > +            opp-hz = /bits/ 64 <463000000>;
> > > +            opp-microvolt = <756250>;
> > > +        };
> > > +        opp2_04: opp-546000000 {
> > > +            opp-hz = /bits/ 64 <546000000>;
> > > +            opp-microvolt = <800000>;
> > > +        };
> > > +        opp2_05: opp-624000000 {
> > > +            opp-hz = /bits/ 64 <624000000>;
> > > +            opp-microvolt = <818750>;
> > > +        };
> > > +        opp2_06: opp-689000000 {
> > > +            opp-hz = /bits/ 64 <689000000>;
> > > +            opp-microvolt = <850000>;
> > > +        };
> > > +        opp2_07: opp-767000000 {
> > > +            opp-hz = /bits/ 64 <767000000>;
> > > +            opp-microvolt = <868750>;
> > > +        };
> > > +        opp2_08: opp-845000000 {
> > > +            opp-hz = /bits/ 64 <845000000>;
> > > +            opp-microvolt = <893750>;
> > > +        };
> > > +        opp2_09: opp-871000000 {
> > > +            opp-hz = /bits/ 64 <871000000>;
> > > +            opp-microvolt = <906250>;
> > > +        };
> > > +        opp2_10: opp-923000000 {
> > > +            opp-hz = /bits/ 64 <923000000>;
> > > +            opp-microvolt = <931250>;
> > > +        };
> > > +        opp2_11: opp-962000000 {
> > > +            opp-hz = /bits/ 64 <962000000>;
> > > +            opp-microvolt = <943750>;
> > > +        };
> > > +        opp2_12: opp-1027000000 {
> > > +            opp-hz = /bits/ 64 <1027000000>;
> > > +            opp-microvolt = <975000>;
> > > +        };
> > > +        opp2_13: opp-1092000000 {
> > > +            opp-hz = /bits/ 64 <1092000000>;
> > > +            opp-microvolt = <1000000>;
> > > +        };
> > > +        opp2_14: opp-1144000000 {
> > > +            opp-hz = /bits/ 64 <1144000000>;
> > > +            opp-microvolt = <1025000>;
> > > +        };
> > > +        opp2_15: opp-1196000000 {
> > > +            opp-hz = /bits/ 64 <1196000000>;
> > > +            opp-microvolt = <1050000>;
> > > +        };
> > > +    };
> >
> >
>


-- 
Best Regards,
Chanwoo Choi
