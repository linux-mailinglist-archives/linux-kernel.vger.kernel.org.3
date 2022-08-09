Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2787E58E1B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiHIVUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiHIVTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:19:54 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F036716E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 14:19:52 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id q184so15405177oif.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 14:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=hNlW3Ttjo6hcKSmczDTwdd2QKUouaTsCCWwKHrhweGE=;
        b=BRfV4z6DWOOjIZ30/4MWe+gRyxAjuF9V/kCXnVzmgU5d/F/TjuE7CzqQMzTVnJSWZz
         QXWzD+tEIzNn12p+kpPNgtkCiLilaDe16IedyW0sgbxQBnYJb5gYyaHR+QzXQQAQcJp3
         9yC713TUBnnUbo50hEll3xfdpSOB/j6luzKJByfxX/z7LMrASEawunk2DG54Z6Hm7V3m
         vL7NqPsu6G20AHIujJtfQMe5FA6tkBJiYXqi3odx08Jn/JdyeoN56HqWjLtB2Tx2tSBv
         Zw/7UrRQM3ycLBYgNFttBngeOkc2VaIbtrMr5g+olNyB8lj6g0RvId2OSaJOdFeJob+C
         UFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=hNlW3Ttjo6hcKSmczDTwdd2QKUouaTsCCWwKHrhweGE=;
        b=2NIiSm26Qa0N3ocp9eHFDw3OwPOYy+QTf0tKnUo/qq+JWiHTxjCElqiSOw7cOW52Fw
         oCg0scxvxCdfyFMFjh4dFYiQ3Txw4dxvpB+C0MrpzMkGoFaO8A9SinCJmmQ8UFCAu63m
         lIttxyPtwQzoYhdbmyocI7vM1XASf+/5HogQez2ZHY3K0Q7G4Ibyciu5wBpq4irPVubm
         RAVyN58Veg7lL7K9BX6GmonNaFS18Jh4g2KWVWILty34deC+XnTq7RgH31UsQMcjSOHS
         snZ64UmOg0I9ZevoLazu+9YhnKTyAnlgtQfetwZukxX7mJm85AAkQF155J6XcDzPmxCG
         zlsQ==
X-Gm-Message-State: ACgBeo309kC1iArcYXC4ESd9KubTml5toLN/njzGoDSQ4rfAQXMSwT3l
        gYo2RMXrLH7MwqHMTnZZ93LVjQ==
X-Google-Smtp-Source: AA6agR7idOPYc+eaQAA7KvKF9Mz5DOdDvcYF6yvaDTZ5slwvk0RzyRrzEC/ED8RzxTrKFqY3Ba05Og==
X-Received: by 2002:a05:6808:302b:b0:2f9:eeef:f03 with SMTP id ay43-20020a056808302b00b002f9eeef0f03mr170439oib.128.1660079992065;
        Tue, 09 Aug 2022 14:19:52 -0700 (PDT)
Received: from baldur ([2600:380:785a:7aa8:200:ff:fe00:0])
        by smtp.gmail.com with ESMTPSA id p10-20020a056830130a00b00636cc9926dbsm229555otq.40.2022.08.09.14.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:19:51 -0700 (PDT)
Date:   Tue, 9 Aug 2022 16:19:49 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>
Subject: Re: [PATCH V7 1/5] dt-bindings: clock: Add "qcom,adsp-pil-mode"
 property
Message-ID: <YvLPdVv2/7pJLeru@baldur>
References: <1658910477-6494-1-git-send-email-quic_c_skakit@quicinc.com>
 <1658910477-6494-2-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658910477-6494-2-git-send-email-quic_c_skakit@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27 Jul 03:27 CDT 2022, Satya Priya wrote:

> The LPASS Peripheral loader clocks would be used to bring
> LPASS out of reset, when this property is present.
> 

Can you please elaborate on what you mean here?

When this property is set you assume that remoteproc is used to boot the
LPASS and therefor some clocks should be handled differently?

This needs to be written in a way that someone outside of your project
can understand the purpose.

> This is a cleanup done to handle overlap of regmap of
> lpasscc and lpass_aon blocks. As a part of this, remove
> the "cc" regmap from lpasscc node.
> 

"regmap" is an implementation detail, the binding change should describe
the changes to the representation of the hardware description.

Thanks,
Bjorn

> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml   | 6 ++----
>  .../devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml         | 7 +++++++
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
> index 47028d7..633887d 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
> @@ -36,13 +36,11 @@ properties:
>      items:
>        - description: LPASS qdsp6ss register
>        - description: LPASS top-cc register
> -      - description: LPASS cc register
>  
>    reg-names:
>      items:
>        - const: qdsp6ss
>        - const: top_cc
> -      - const: cc
>  
>  required:
>    - compatible
> @@ -59,8 +57,8 @@ examples:
>      #include <dt-bindings/clock/qcom,lpass-sc7280.h>
>      clock-controller@3000000 {
>        compatible = "qcom,sc7280-lpasscc";
> -      reg = <0x03000000 0x40>, <0x03c04000 0x4>, <0x03389000 0x24>;
> -      reg-names = "qdsp6ss", "top_cc", "cc";
> +      reg = <0x03000000 0x40>, <0x03c04000 0x4>;
> +      reg-names = "qdsp6ss", "top_cc";
>        clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
>        clock-names = "iface";
>        #clock-cells = <1>;
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
> index bad9135..5ccfb24 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
> @@ -41,6 +41,12 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  qcom,adsp-pil-mode:
> +    description:
> +      Indicates if the LPASS would be brought out of reset using
> +      peripheral loader.
> +    type: boolean
> +
>  required:
>    - compatible
>    - reg
> @@ -165,6 +171,7 @@ examples:
>        clocks = <&rpmhcc RPMH_CXO_CLK>, <&rpmhcc RPMH_CXO_CLK_A>,
>                 <&lpasscore LPASS_CORE_CC_CORE_CLK>;
>        clock-names = "bi_tcxo", "bi_tcxo_ao","iface";
> +      qcom,adsp-pil-mode;
>        #clock-cells = <1>;
>        #power-domain-cells = <1>;
>      };
> -- 
> 2.7.4
> 
