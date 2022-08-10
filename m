Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED3658F2F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiHJTUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbiHJTUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:20:33 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052D24332B;
        Wed, 10 Aug 2022 12:20:33 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id d187so6206560iof.4;
        Wed, 10 Aug 2022 12:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=eax0+SGVw4tBj19ILUSTbTcJRsETWk3FdReG+6FrUnA=;
        b=IbyFHMxxzQhy3f9ClGQ9V/qzpGlUTkakgPiq++SxH7Fbi35T4ohcSXRkAp7MuMVRFO
         7QYDTitfVF28OuDjyayeupdL+Xz0MgXNFukBOCxqtmZ8Kc3ZDteQtjsBDuupFkgE9Qxv
         NqTYCSUjxLZkFpWtUFzmi740GOwOp+g7iS8+cUe+9cXM0I69NV3GeZoqSlX7GRIXg/GY
         Ymu2KVdgsyd8iKXCF/oNmneoamN4ZlI+U954W1JZpqKn1aVui4BaIKbKjc1GsD6oBeWT
         UkhLDb/E7Lc+fW5Uq4W9zrPTBfjJnHTBZTtXVZZWn8muYppNdVmvCfDopfwm6Jt7Tz+4
         XjRg==
X-Gm-Message-State: ACgBeo1fjvjprY2QCT+k95m5WNokGAYyF1pOdJEzGioWNq09S4Aa9N/a
        ZkRSGuwBIxAUrIrHaNrqlp2CjM5HdQ==
X-Google-Smtp-Source: AA6agR6FFKbmn+Fpy3ft72ITauYQistHwXv5H9dilXQOuhTLEsIachLlOd8qiJZOFeLXy1VKLShs/Q==
X-Received: by 2002:a05:6638:24d0:b0:342:70d4:7ad1 with SMTP id y16-20020a05663824d000b0034270d47ad1mr13422064jat.14.1660159232216;
        Wed, 10 Aug 2022 12:20:32 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g3-20020a02c543000000b003427e69f2b8sm7775181jaj.144.2022.08.10.12.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 12:20:31 -0700 (PDT)
Received: (nullmailer pid 378129 invoked by uid 1000);
        Wed, 10 Aug 2022 19:20:29 -0000
Date:   Wed, 10 Aug 2022 13:20:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: msm/dp: Add SDM845 and SC8280XP
 compatibles
Message-ID: <20220810192029.GF200295-robh@kernel.org>
References: <20220810035013.3582848-1-bjorn.andersson@linaro.org>
 <20220810035013.3582848-2-bjorn.andersson@linaro.org>
 <c5cc8752-d7e2-b870-6887-c025137ed8a1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5cc8752-d7e2-b870-6887-c025137ed8a1@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 05:47:52PM +0300, Krzysztof Kozlowski wrote:
> On 10/08/2022 06:50, Bjorn Andersson wrote:
> > Add compatibles for the DisplayPort and Embedded DisplayPort blocks in
> > Qualcomm SDM845 and SC8280XP platforms.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  .../devicetree/bindings/display/msm/dp-controller.yaml         | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > index 94bc6e1b6451..90f9302d1731 100644
> > --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > @@ -16,11 +16,14 @@ description: |
> >  properties:
> >    compatible:
> >      enum:
> > +      - qcom,sdm845-dp
> >        - qcom,sc7180-dp
> 
> Alphabetical order, please.
> 
> The DTS warnings from the bot look unrelated to this patch.

Yes, but there are a ton of them and I thought Bjorn might care. Looks 
like the schema is pretty out of sync with reality and they don't really 
look like dts side fixes.

Rob
