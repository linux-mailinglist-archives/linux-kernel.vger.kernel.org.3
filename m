Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FAD505EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347770AbiDRTvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347788AbiDRTu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:50:58 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427D529CAE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:48:09 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e2fa360f6dso15267320fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=R8MVyQVH63UKDlO5ebK94G5i5p2wDyYsAtV0teKaE/s=;
        b=ZhCqVdEkoLVNEjcGJlt+Orq1svQI51yFjZ5yzspPDulfEmlo4fFK77Zj/fvsCzAmzt
         0PiusX7wSluCRHHd/8c0/S5RUDr6NxLnpuvBYmGj1wnGgX4lUKcRNl3DDiy3uQvqz/jj
         ITwRwDMHccDzMO0LQuZiVYK7ZyYb3YYtHJEXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=R8MVyQVH63UKDlO5ebK94G5i5p2wDyYsAtV0teKaE/s=;
        b=yLwOIYXAoEOpH4GE4RzYvMSPgl2TwBFcUksv/9dsui5gQUbY2H1mytueIUWHXsuKfB
         kSt0ReZUDbOLrYehjkSp6jYPsCQD8N/+LplLtsoO0vyim9CtpDMz6nnKajHFfEJGB5E1
         9kC0yGBhlvRpSpKTPFV0jBtCWcqbEr//jZaZqlfidCD2Qyn4ZIoTHAWybpwsVYXeF0Ma
         clSVLiabLJDIlI5bWKY+Hf0VCJgR0YwFFjjfuvwvZTExW5oscj9aiT1pZd4dHL0CwvE3
         pAUQ/JTBRady0IVxFEfcPOvoNgJGcljmQInvzmnhADEUwHWpFA6W54ruyA9OymYnBxDw
         TZjw==
X-Gm-Message-State: AOAM533ciCF0s2vD4WgFN4RuOlwIJM9K9LqVggC9wHkwohFcINLuUQ+j
        18Ldxf4M9Jj9Cg5cKlV5THtFOoGb2ZwN22WFY+CTQg==
X-Google-Smtp-Source: ABdhPJxNTgtzk/Xz7kcv1RUxdYb0jMn0kKe1rbAUme2rCqK9BQTcKgtEnt+Xs0lHTfuvKTMKV0qsQkfn2jAOY12S3mE=
X-Received: by 2002:a05:6870:3907:b0:e5:a6fd:4047 with SMTP id
 b7-20020a056870390700b000e5a6fd4047mr4779741oap.193.1650311288551; Mon, 18
 Apr 2022 12:48:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Apr 2022 12:48:08 -0700
MIME-Version: 1.0
In-Reply-To: <d32fc9f8-65cd-a30f-cdf2-f019bbe7cd69@linaro.org>
References: <20220412220033.1273607-1-swboyd@chromium.org> <20220415005828.1980055-1-swboyd@chromium.org>
 <20220415005828.1980055-3-swboyd@chromium.org> <d32fc9f8-65cd-a30f-cdf2-f019bbe7cd69@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 18 Apr 2022 12:48:08 -0700
Message-ID: <CAE-0n53yggqX+mNcRQ+_iVHZhZgw-cCBVSC+ka++vwprpKMaGQ@mail.gmail.com>
Subject: Re: [PATCH 5/2] dt-bindings: interconnect: Remove sc7180/sdx55 ipa compatibles
To:     Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Elder (2022-04-15 13:15:21)
> On 4/14/22 7:58 PM, Stephen Boyd wrote:
> > These interconnects are modeled as clks, not interconnects, therefore
> > remove the compatibles from the binding as they're unused.
> >
> > Cc: Alex Elder <elder@linaro.org>
> > Cc: Taniya Das <quic_tdas@quicinc.com>
> > Cc: Mike Tipton <quic_mdtipton@quicinc.com>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
> What's the proper thing to do for properties that stop being
> used?  Do we delete them, like this, or deprecate them somehow?
> Old DTBs might define the values that are deleted here.

I think we leave them around until the last dts user stops using them.

>
> Shouldn't devicetree@vger.kernel.org
>   be copied on this and
> the other DTS patches?

Sure. I added it now. Thanks.

>
> > ---
> >
> > I don't know who should apply this. Probably whoever takes the dtsi
> > patches, Bjorn?, because otherwise dt_bindings_check will fail.
> >
> >   Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> > index 5a911be0c2ea..ab859150c7f7 100644
> > --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> > @@ -31,7 +31,6 @@ properties:
> >         - qcom,sc7180-config-noc
> >         - qcom,sc7180-dc-noc
> >         - qcom,sc7180-gem-noc
> > -      - qcom,sc7180-ipa-virt
> >         - qcom,sc7180-mc-virt
> >         - qcom,sc7180-mmss-noc
> >         - qcom,sc7180-npu-noc
> > @@ -68,7 +67,6 @@ properties:
> >         - qcom,sdm845-mem-noc
> >         - qcom,sdm845-mmss-noc
> >         - qcom,sdm845-system-noc
> > -      - qcom,sdx55-ipa-virt
> >         - qcom,sdx55-mc-virt
> >         - qcom,sdx55-mem-noc
> >         - qcom,sdx55-system-noc
>
