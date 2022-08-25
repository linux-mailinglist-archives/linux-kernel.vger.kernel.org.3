Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19635A11A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242344AbiHYNNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242393AbiHYNNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:13:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDC1B24B2;
        Thu, 25 Aug 2022 06:13:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A141A61B0B;
        Thu, 25 Aug 2022 13:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B2BC433C1;
        Thu, 25 Aug 2022 13:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661433217;
        bh=IZW5T8bTR6zlpO6HLb6mRol+oyWLXS34Ih/Xhypaguk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kMCucpv40+yoTKei7Vb+5ENQbEIz+hcPGK5+mqkpGqnhBHKfMa3V8YY2uFQPHbuWA
         UYm5vFaTmXEg5r2azsBJFoS2ZAo6UMzg2NLcwUQdDa2jxw092nxypn31yMlnfCNP3Q
         Pw1nYRsAV8WsH8sKUMYu5zTf3EoenvbsAMcawH6vRF2RV+7XQaZnDr/PAj1uYvX/ZD
         uFRxcL5YalTayWJpmSZGhfFBmwSgZEjhVLT+tTIGbXFmU4yA6r1yQqPtRQBrIa7vKb
         RDl3I2thfA3TQSNF+TGkEMf6dEvtIU37m3GXu+YeCid5kTybU1/Tr8a3CAjdBb4/QR
         cYj9FpbGADa1Q==
Received: by mail-vs1-f41.google.com with SMTP id m66so20787188vsm.12;
        Thu, 25 Aug 2022 06:13:37 -0700 (PDT)
X-Gm-Message-State: ACgBeo2KUZUkTIvJjxXw2ILZ6V1eeJPQdMdsi+89HwYsYjq48cpwpgOl
        vfW9fM+lrzBIdaO6KiwTv1k2Ymu0vdQtAI36sw==
X-Google-Smtp-Source: AA6agR5HHV9M9yXhQz5Wv4Fn3tOpZtPr51oSEmjee6h8mCyA1xklEwT58PruXe9mpGP3Rkw2EvGjEX5bSYAZLj5ddgM=
X-Received: by 2002:a67:c09c:0:b0:390:9073:1122 with SMTP id
 x28-20020a67c09c000000b0039090731122mr1350519vsi.85.1661433216073; Thu, 25
 Aug 2022 06:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220823145649.3118479-10-robh@kernel.org> <1491c83f-cd75-4de3-ec26-86db4adb2ade@linaro.org>
In-Reply-To: <1491c83f-cd75-4de3-ec26-86db4adb2ade@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 25 Aug 2022 08:13:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJx1s5ez-ojP8ZK_MPBWuuLRyekjK1qhHd6Ezaimna8JQ@mail.gmail.com>
Message-ID: <CAL_JsqJx1s5ez-ojP8ZK_MPBWuuLRyekjK1qhHd6Ezaimna8JQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: remoteproc: Add missing (unevaluated|additional)Properties
 on child nodes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Aug 25, 2022 at 3:23 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/08/2022 17:56, Rob Herring wrote:
> > In order to ensure only documented properties are present, node schemas
> > must have unevaluatedProperties or additionalProperties set to false
> > (typically).
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml      | 1 +
> >  .../devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml      | 1 +
> >  .../devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml     | 1 +
> >  3 files changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> > index e76c861165dd..e4a7da8020f4 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> > @@ -140,6 +140,7 @@ properties:
> >
> >    glink-edge:
> >      $ref: qcom,glink-edge.yaml#
> > +    unevaluatedProperties: false
>
> Is it actually needed? The qcom,glink-edge.yaml has
> additionalProperties:false, so I expect it to complain if anything
> appears here.

Perhaps not, but I'm trying to come up with a meta-schema to check
these though I'm not sure I can get to no warnings which is how I
found all these cases. The main remaining warnings are bus child node
pattern schemas which can perhaps be handled with
'additionalProperties: true'. The rule I have says if properties or
patternProperties is present then unevaluatedProperties or
additionalProperties must be. To handle this case, I think we'd have
to walk the $ref and check it.

Anyways, we can hold off on this one until when and if there's a
meta-schema in place.

Rob
