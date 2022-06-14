Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A0D54AE85
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356024AbiFNKgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355785AbiFNKgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:36:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C4C49688;
        Tue, 14 Jun 2022 03:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E74BBB81853;
        Tue, 14 Jun 2022 10:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F8AC3411B;
        Tue, 14 Jun 2022 10:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655202989;
        bh=rwLTNV8FtkV1nVo+pSkSat5md/4dvMxUVJY4Yqt7PS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lNUD21J3oMZVICFV1A4umZXFSuY+r0Wbjc32YEh6ZLdW2Wben/pKmyyhjS6Eph/2/
         OsZTd+oDTvOrTYlE+ppEMzYey9QEzsJ8NntbGuMguSthXA0PaRS1dKLzMs7hNuPttV
         hQhjK7yHq8a2Bo3rxKWoYw05J+gs/+mlzQnMxG4SMnSfCYtEZLXCsiMX50etKdLpTK
         0X64Scn+oWJP8P6pvdtQQQns+1Ynb9Ukc3toxAFzzOa6o+GbZMRtulZm4UOXHWMQ74
         ciUjOlEgG7WTKfOXj6AvMmKeGeJ9EcpDp/5s/wiI33xlz+/9idZqw6noxu6ubL6u35
         R6HPMQENRNP4A==
Date:   Tue, 14 Jun 2022 11:45:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v14 04/10] dt-bindings: iio: adc: document
 qcom-spmi-rradc
Message-ID: <20220614114539.45598cc3@jic23-huawei>
In-Reply-To: <20220429220904.137297-5-caleb.connolly@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
        <20220429220904.137297-5-caleb.connolly@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 23:08:59 +0100
Caleb Connolly <caleb.connolly@linaro.org> wrote:

> Add dt-binding docs for the Qualcomm SPMI RRADC found in PMICs like
> PMI8998 and PMI8994
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
#to let Lee pick it up via mfd if he prefers.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/qcom,spmi-rradc.yaml     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
> new file mode 100644
> index 000000000000..c8cbfd3444be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-rradc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm's SPMI PMIC Round Robin ADC
> +
> +maintainers:
> +  - Caleb Connolly <caleb.connolly@linaro.org>
> +
> +description: |
> +  The Qualcomm SPMI Round Robin ADC (RRADC) provides interface to clients to
> +  read the voltage, current and temperature for supported peripherals such as
> +  the battery thermistor die temperature, charger temperature, USB and DC input
> +  voltage / current and battery ID resistor.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pmi8998-rradc
> +      - qcom,pm660-rradc
> +
> +  reg:
> +    maxItems: 1
> +
> +  qcom,batt-id-delay-ms:
> +    description: Sets the hardware settling time for the battery ID resistor.
> +    enum: [0, 1, 4, 12, 20, 40, 60, 80]
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmic {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic_rradc: adc@4500 {
> +          compatible = "qcom,pmi8998-rradc";
> +          reg = <0x4500>;
> +          #io-channel-cells  = <1>;
> +      };
> +    };

