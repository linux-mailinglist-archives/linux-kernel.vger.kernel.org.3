Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C81455A014
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiFXR1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiFXR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:26:55 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A821B34650;
        Fri, 24 Jun 2022 10:26:52 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id a16so1918127ilr.6;
        Fri, 24 Jun 2022 10:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Hcu9Y5I2TimI6GlhyMhgQe9uEC4LVq7xIAa/nAEPBC8=;
        b=Ks9Kxud5Ef+I3tMy+o1ZwmojUgWitXjhm+aOI+TAM+04nwtxS5Y4ixfMDKV45zMDMl
         xNr1C+I4tmkK2aqyAf87mcOULKZoq/ZX+XVgrrHr79686T5Id6dKPPAJQEhY2saPyaT0
         Eh4KnkR0cjXYld71EopeDXFBiXWEzxKQ1GQou6rUu7UkJx86rkRFnT7f5cWwGyS/adKS
         8a8mJwS9Z89/1ewYgwN+LPvw0nSLJG3FqhEYsIU+FCOJ8Db48beet0FsB5bLV/GnQuaS
         VNqFZUUf+HcYiqUzeZc4FpzVnq8TfTQgw358aMvjRadnfv39OXfqAaKqlGaY6k9HuL+7
         BmUg==
X-Gm-Message-State: AJIora9rzcVhj4Zz/mVgjnyCbuBakjjT1gUQ3I71b7tklDn+Q1JyVQjq
        p/Aw5+PyuA7RuZi/2HLdRw==
X-Google-Smtp-Source: AGRyM1vzAHHR7MUdvcHbYB9plvLeB5pijXtWczq677bgA2sQBUma/I2wqLWx2WXMYorxt26CDMLDSg==
X-Received: by 2002:a92:a041:0:b0:2d7:7935:effa with SMTP id b1-20020a92a041000000b002d77935effamr44849ilm.222.1656091611881;
        Fri, 24 Jun 2022 10:26:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s12-20020a92d90c000000b002d92c91da91sm1344610iln.77.2022.06.24.10.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:26:51 -0700 (PDT)
Received: (nullmailer pid 146334 invoked by uid 1000);
        Fri, 24 Jun 2022 17:26:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sricharan R <quic_srichara@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, quic_varada@quicinc.com,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, p.zabel@pengutronix.de
In-Reply-To: <20220621161126.15883-5-quic_srichara@quicinc.com>
References: <20220621161126.15883-1-quic_srichara@quicinc.com> <20220621161126.15883-5-quic_srichara@quicinc.com>
Subject: Re: [PATCH V2 4/8] dt-bindings: pinctrl: qcom: Add ipq5018 pinctrl bindings
Date:   Fri, 24 Jun 2022 11:26:34 -0600
Message-Id: <1656091594.356132.146333.nullmailer@robh.at.kernel.org>
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

On Tue, 21 Jun 2022 21:41:22 +0530, Sricharan R wrote:
> From: Varadarajan Narayanan <quic_varada@quicinc.com>
> 
> Add device tree binding Documentation details for ipq5018
> pinctrl driver.
> 
> Co-developed-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  .../pinctrl/qcom,ipq5018-pinctrl.yaml         | 145 ++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:72:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:73:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:74:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:75:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:76:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:77:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:78:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:79:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:80:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:81:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:82:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:83:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:84:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:85:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:86:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:87:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:88:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:89:11: [warning] wrong indentation: expected 16 but found 10 (indentation)
./Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml:90:11: [warning] wrong indentation: expected 16 but found 10 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

