Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232594EE325
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbiCaVRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240069AbiCaVQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:16:57 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90A1193168
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:15:08 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id i7so849485oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=vwheEnMBXMcJPlEvI2xlHJZOpVP1AreQm81auYsI9/8=;
        b=ar2VK6LtZKCMyzrYgJstpZ3D7g4riv7zM/db0R162mmtpP1lysOhpn9kiKqUZRimG8
         BpUvH0eMq+cUtK45ouZ/aL75DYhPUDvrMxOAsKWObMAjp+KhXPCuijxPd69EBnu0oktN
         b1Z12lDegwnHapbOeVF5DPFNerFFavRM+H6R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=vwheEnMBXMcJPlEvI2xlHJZOpVP1AreQm81auYsI9/8=;
        b=PcESfD7Rkd6IZs3coYNy0Gvoti7qhjjK0JQ7pkGlZIhxir1ICL/ucujNYPJZt2TQhd
         CyrhiFSPVb1Jbk0Ta3u2E5oyKsrchrf8+fFqtZyUV0MGB3IuJOUVJ0KpPGnCPzzzqWkn
         uGblsogEpXSpeBstNBLb7uq0kYzSJ+Qt4E/vj6adDfbUzSkGJbfapTkoIJJ4vMNomU9d
         ZWlhjbJaL+fliMsblYGPMMzJIcjDAkCSCHHlATzbHgQNjrujLpScSQZ/6eR2YO005zKv
         mM+ykJVShBICTPbiX3EPH1h0A0Q604GGs40YsFtvZi1maD9YC3yuH+K6RBsV35vaJWaC
         V+jw==
X-Gm-Message-State: AOAM532bLn86+idcWM+bhoECVoUbaI3AQuo8ODT+zwBD0EjvETE4M4GU
        9dU/Y2ptGSdip4bhH0+5irEkiI4xf4ZytwBOhI4bRWK4bZs=
X-Google-Smtp-Source: ABdhPJx9lR2+AZIr1QCq374yaTknx9Ra60AIuvbEbs1VPB4Kx5F8frh0+nkxNy7uUlikHDsDZvkEz7pXSuU8fNa45t4=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr3509973oif.63.1648761308278; Thu, 31
 Mar 2022 14:15:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 31 Mar 2022 14:15:07 -0700
MIME-Version: 1.0
In-Reply-To: <26e7298c-9337-c4d4-ce32-2a67d727ccfc@quicinc.com>
References: <1648209491-30165-1-git-send-email-quic_c_skakit@quicinc.com>
 <1648209491-30165-2-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n523f-aAUkj1SUscNgw_Gh=mP8JfXV4u_hNeFhqtfr_Fgg@mail.gmail.com> <26e7298c-9337-c4d4-ce32-2a67d727ccfc@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 31 Mar 2022 14:15:07 -0700
Message-ID: <CAE-0n53NSiQz+MV+faAWaevY2FY_Jt+gLGrD1xzX+T6Dn9uQjQ@mail.gmail.com>
Subject: Re: [PATCH V8 1/7] dt-bindings: mfd: pm8008: Modify the compatible as
 per driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya Kakitapalli <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya Kakitapalli (Temp) (2022-03-30 03:55:03)
>
> On 3/25/2022 11:32 PM, Stephen Boyd wrote:
> > Quoting Satya Priya (2022-03-25 04:58:05)
> >> Modify the compatible string as per the pm8008 mfd driver.
> >> Add reset-gpios property and make interrupts and interrupt-cells
> >> as optional properties, they are not strictly required and may
> >> cause yaml compilation errors when not added in the DT files.
> > Does it have an interrupt controller inside? If so, the properties
> > should be present even if the driver isn't using them.
>
>
> Yes it has an interrupt controller but we are not configuring/using any
> interrupts currently in the DT node. So, if we add the properties under
> "required" list it throws a make dtbs error. Do you think we can somehow
> bypass this error?
>

Can you fix the existing node to have those properties?

>
> >> Also, change the node name in example to match with the
> >> pm8008_infra DT node.
> >>
> >> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> >> ---
> >> Changes in V5:
> >>   - Remove compatible for regulators node.
> >>   - Move supply nodes of the regulators to chip level.
> >>
> >> Changes in V6:
> >>   - No changes.
> >>
> >> Changes in V7:
> >>   - Removed the intermediate regulators node and added ldos
> >>     directly under mfd node.
> >>
> >> Changes in V8:
> >>   - Change the compatible as per driver, remove interrupts from required
> >>     properties, add reset-gpios and move regulators to separate binding.
> >>
> >>   Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 15 ++++++++++-----
> >>   1 file changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> >> index ec3138c..12431ea 100644
> >> --- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> >> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> >> @@ -16,7 +16,7 @@ description: |
> >>
> >>   properties:
> >>     compatible:
> >> -    const: qcom,pm8008
> >> +    const: qcom,pm8008-infra
> > Why is the compatible being replaced with -infra postfix?
>
>
> I've changed the compatible after splitting the probe into two parts
> pm8008-infra-probe and pm8008-regulators-probe. Only reason for change
> is to make it more readable/understandable.
>
>

Please leave the pm8008 compatible alone.
