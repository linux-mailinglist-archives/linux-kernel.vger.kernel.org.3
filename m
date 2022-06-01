Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FAA53B094
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 02:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiFAX0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 19:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiFAX0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 19:26:18 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D326571;
        Wed,  1 Jun 2022 16:26:17 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-f16a3e0529so4757106fac.2;
        Wed, 01 Jun 2022 16:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iJNKOO8QXxNlzBsifQjmX9tXu38uHaRGSzPFyqrc1yQ=;
        b=F6pKhFBzgTwAVv4Eh+hHxVbf6gC/rdCw2/9Vq+cp4UPttHoP9e60ojNhlgIjPRAeE/
         XNmXNVYhdyFcU25HO8dk+XrjWxBJTLKm4+H4UCLVtXg9Va2EePfy+KCi2sTBGrqzD/wY
         jQgOU2PmJl0V+oF5JOXP07/zfY3nk6wH1BJjBg8/8+oHObtmz1Qkp8m+2xXYAyNT8UY8
         vxXJQh1TEwB5YHLdguovjSQAJ0/eiMY6Yi7GyBtwLOcWi/LhqpSd1ZICjXHKyH+nGUuh
         Pv2ZeHkO0g9W+l3SVLndxaZe9o6/hkG2N72cmMaMbFqMMUBz0C13Rk2iju+Yb8+jvyzX
         jhcA==
X-Gm-Message-State: AOAM530lJp+g2cDXtltVBDkypLZAka1RRiQB4KJbmG0CSdBA5vBsfP3k
        B/TWB9fNR6Ekatojp+dRcQ==
X-Google-Smtp-Source: ABdhPJw3v7nw/3t83l1+7RJSfsRWFO4E+ExNjYFS+gxyafxmeK1J23WekAZMJNOwY6C3Vq+Zc76yrw==
X-Received: by 2002:a05:6870:548f:b0:f5:dc08:f12c with SMTP id f15-20020a056870548f00b000f5dc08f12cmr1252754oan.12.1654125976450;
        Wed, 01 Jun 2022 16:26:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t9-20020a056870600900b000f5f4ad194bsm719784oaa.25.2022.06.01.16.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 16:26:15 -0700 (PDT)
Received: (nullmailer pid 696078 invoked by uid 1000);
        Wed, 01 Jun 2022 23:26:14 -0000
Date:   Wed, 1 Jun 2022 18:26:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] dt-bindings: arm: qcom: Add more sc7180
 Chromebook board bindings
Message-ID: <20220601232614.GA504337-robh@kernel.org>
References: <20220520143502.v4.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220520143502.v4.5.Ie8713bc0377672ed8dd71189e66fc0b77226fb85@changeid>
 <a2bcac04-23ad-d1ae-84f1-924c4dbad42b@linaro.org>
 <CAD=FV=WgYbD9GN_wiR29ikZMzEjKUSZGH588+nnyd3O-dNgChQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WgYbD9GN_wiR29ikZMzEjKUSZGH588+nnyd3O-dNgChQ@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 09:19:03AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Sun, May 22, 2022 at 1:01 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 20/05/2022 23:38, Douglas Anderson wrote:
> > > This adds board bindings for boards that are downstream but not quite
> > > upstream yet.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Normally this bindings doc would go together in the same series that
> > > adds the device trees. In this case, Joe has been sending patches
> > > supporting these Chromebooks. His most recent posting is:
> > >
> > > https://lore.kernel.org/r/20220510154406.v5.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid/
> > >
> > > If he were to add this patch to the end of his v6, however, it would
> > > make things a bit more complicated simply becuase it would cause
> > > conflicts with all the other patches in this series. ...so steady
> > > state it would be correct to keep it in the series with the device
> > > tree files, but for this one time I think it makes sense to keep all
> > > the Chromebook board bindings patches together.
> > >
> > > (no changes since v2)
> > >
> > > Changes in v2:
> > > - Use a "description" instead of a comment for each item.
> > > - Use the marketing name instead of the code name where possible.
> > >
> > >  .../devicetree/bindings/arm/qcom.yaml         | 92 +++++++++++++++++++
> > >  1 file changed, 92 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> > > index 3d150d1a93cd..277faf59db57 100644
> > > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > > @@ -263,6 +263,16 @@ properties:
> > >            - const: google,homestar
> > >            - const: qcom,sc7180
> > >
> > > +      - description: Google Kingoftown (rev0)
> > > +        items:
> > > +          - const: google,kingoftown-rev0
> > > +          - const: qcom,sc7180
> > > +
> > > +      - description: Google Kingoftown (newest rev)
> > > +        items:
> > > +          - const: google,kingoftown
> > > +          - const: qcom,sc7180
> > > +
> > >        - description: Acer Chromebook Spin 513 (rev0)
> > >          items:
> > >            - const: google,lazor-rev0
> > > @@ -364,6 +374,48 @@ properties:
> > >            - const: google,lazor-sku6
> > >            - const: qcom,sc7180
> > >
> > > +      - description: Google Mrbland with AUO panel (rev0)
> > > +        items:
> > > +          - const: google,mrbland-rev0-sku0
> > > +          - const: qcom,sc7180
> > > +
> > > +      - description: Google Mrbland with AUO panel (newest rev)
> > > +        items:
> > > +          - const: google,mrbland-sku1536
> > > +          - const: qcom,sc7180
> > > +
> > > +      - description: Google Mrbland with BOE panel (rev0)
> > > +        items:
> > > +          - const: google,mrbland-rev0-sku16
> >
> > Similar question to patch #3, this could be:
> >
> >
> > +      - description: Google Mrbland
> > +        items:
> > +          - enum:
> > +              - google,mrbland-rev0-sku0     # AUO panel (rev0)
> > +              - google,mrbland-rev0-sku16    # BOE panel (rev0)
> > +          - const: qcom,sc7180
> >
> > and the file gets smaller and easier to read.
> 
> Ah, I guess this answers the question of the description that I asked
> in the previous patch. Of course, this goes opposite of the feedback I
> got from Stephen in previous versions of the patch where he requested
> that I use "description" instead of comments for things. ;-)
> 
> In any case, for now I'll hold off waiting for other opinions here
> since I still feel that the "one entry per dts" is easier to read /
> reason about.

I leave it to the sub-arch maintainers to decide. I somewhat prefer as 
Krzysztof suggested. Some platforms (and most of the ones I converted) 
all the boards for an SoC are one entry (except for the 3 string cases). 
So the above looks like a good middle ground grouping revs or variations 
of boards.

Rob
