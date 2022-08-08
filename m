Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F46658C506
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiHHImm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiHHImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:42:40 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CF6B858
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 01:42:37 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u1so11656037lfq.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 01:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GH1RTNvYltddRQxOqOLKUQpIVt1WCGJQQLNGxCMK7OQ=;
        b=mXenbGDo9bRNDtEOPVQu0RF4n4RJmJUOGuPf8+Ji11hejTu+YltiW7jOc6CacZZJ3K
         ++onYF5D45cuwq7aFFBQCfBMe7f8UuGC1yfEIHcpuOvg46FLKm2Mg7gHjlyOTVE/A4pE
         alfOdj2kJ3fCVsYAPVz2yUWMJDB2NqET8ZdUTsSSySW4l4pTWC6014VWjedDyySetJ/W
         lXQgw3E4rhzQoiEA7W7bArsIOf/DqVCFaVYZMQusOCNtBLuZfgRG0uklvGuHNbDY1qvq
         SNUCaw+HiyZ+XRfgMHSOFzrDMjIFgQxMgfAe+n4fMm4Y+lSj69hVecGr2984x6Nm1NDP
         +c9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GH1RTNvYltddRQxOqOLKUQpIVt1WCGJQQLNGxCMK7OQ=;
        b=494YhXmnP9l1yNxLxRC9o3wUlqQJEqdNNtb84yI+7xfEU32GR/ghVpI4D1BqT8yLlT
         yH+zqO0XUXrSsqvSIy8RBOBRlAApIxPfqMHgRWuzs4trXgoe6qpQPnvxJjGVNAR3nhu2
         u8g6ml00TZjjTrIywCqwDKajnpwMZBPwxKyLvnQ35iAUwKOBxalHM1KPy0W0pC2ZcYhc
         7Ems1UOKxFxDZZQN6udS3V1dlUPCxc1+5TiFLEYKQ4Fc1S45Mss2X8B0Vto4CGaYB90g
         lmWNQgia+z8mpR9UiJfLo/RZahgAHgGKt/KpZ+zVfcyqB5640yEO9CbkUjZpcEnNVCYV
         3a1A==
X-Gm-Message-State: ACgBeo35zdZ9oT6f/V/2M0J0lSoXTmdEhYRdGAiEd4u7TeIHVhhsDzUd
        HSwSVl853c6lICITlOYPeo+r8g==
X-Google-Smtp-Source: AA6agR7uQdUhuZnAdiC5tKssODVVFuEx+vi//6BMEw7GMy7C6AlLLIZm1wj0fY3KlYnhtYrXSRrvvw==
X-Received: by 2002:ac2:42ce:0:b0:48a:9d75:b733 with SMTP id n14-20020ac242ce000000b0048a9d75b733mr6480370lfl.510.1659948156065;
        Mon, 08 Aug 2022 01:42:36 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id d23-20020a056512369700b0048b18d65998sm1352612lfs.38.2022.08.08.01.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 01:42:35 -0700 (PDT)
Message-ID: <dfaf7a35-25bb-8201-42bc-73ca280fcb69@linaro.org>
Date:   Mon, 8 Aug 2022 11:42:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/8] dt-bindings: power: supply: Add DT schema for
 Qualcomm SMBCHG
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220808073459.396278-1-y.oudjana@protonmail.com>
 <20220808073459.396278-2-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220808073459.396278-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2022 10:34, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add DT schema for the switch-mode battery charger found on Qualcomm
> PMICs such as PMI8994. Due to lack of documentation, some interrupt
> descriptions might be inaccurate.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/power/supply/qcom,smbchg.yaml    | 205 ++++++++++++++++++
>  MAINTAINERS                                   |   8 +
>  2 files changed, 213 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml b/Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml
> new file mode 100644
> index 000000000000..d825a9c10b3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml
> @@ -0,0 +1,205 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/qcom,smbchg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PMIC Switch-Mode Battery Charger
> +
> +maintainers:
> +  - Yassine Oudjana <y.oudjana@protonmail.com>
> +  - Alejandro Tafalla <atafalla@dnyon.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pmi8994-smbchg
> +      - qcom,pmi8996-smbchg
> +
> +  reg:
> +    maxItems: 1
> +
> +  monitored-battery:
> +    description: |
> +      phandle of battery characteristics node.
> +      The charger uses the following properties:
> +      - charge-term-current-microamp
> +      - constant-charge-current-max-microamp
> +      - voltage-max-design-microvolt
> +      The constant-charge-current-max-microamp and voltage-max-design-microvolt
> +      properties must be set.
> +      See Documentation/devicetree/bindings/power/supply/battery.yaml
> +
> +  interrupts:
> +    items:
> +      - description: Charger error
> +      - description: Charger inhibited
> +      - description: Charger precharge safety timer timeout
> +      - description: Charger charge safety timer timeout
> +      - description: Charger pre to fast charging switch threshold reached
> +      - description: Charger recharge threshold reached
> +      - description: Charger taper threshold reached
> +      - description: Charger charge termination threshold reached
> +      - description: Battery hot
> +      - description: Battery warm
> +      - description: Battery cold
> +      - description: Battery cool
> +      - description: Battery overvoltage
> +      - description: Battery low
> +      - description: Battery missing
> +      - description: Battery thermistor missing # unconfirmed
> +      - description: USB input undervolt
> +      - description: USB input overvolt
> +      - description: USB input source detected
> +      - description: OTG regulator failure
> +      - description: OTG regulator overcurrent
> +      - description: Automatic input current limiting done
> +      - description: USB ID pin changed
> +      - description: DC input undervolt
> +      - description: DC input overvolt
> +      - description: Power OK
> +      - description: Temperature shutdown
> +      - description: Watchdog timeout
> +      - description: Flash failure
> +      - description: OTST2 # unknown
> +      - description: OTST3 # unknown

It seems you listed register interrupts, not physical pins. This should
be interrupt lines.

Best regards,
Krzysztof
