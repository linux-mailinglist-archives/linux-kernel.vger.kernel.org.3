Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7754F03E8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbiDBOYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbiDBOYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:24:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754F613CA0B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 07:22:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u26so6019394eda.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AMgcOOw5r9mv38XuA+c8CRwaFDTkeUsZRRq+V0PdcsY=;
        b=ndRjC0RhMOJGBf5NZc9mOkR/bHebZ8B8V39sgXEZvBTOMKfN380968Na2TPAfrha+l
         ZI9WodBoHES0w0Bp3iahPcQvrSvLGyEdKN9nzlOXYAno8LFwZbSXtL+Lc/tAJqOwEg1l
         c+zclPub3nlJoZhvRhuCtyRf+bRdwySxsoovuLIJFRXx6ZDcMEoTBdzqNo267URsQr5J
         7Sf8LB6qW65GLnhp6kQmzqluNbDqQxS41UCAI/nSNGTt8Wgzg19qt+gXBvZEupBKpxYx
         IhHDskUw5bYaqEZWs8fz0XJt1vP+kkRC7pCQCmYequPos6I4Ouk9G9NfRueZhZHJ7Lq8
         sFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AMgcOOw5r9mv38XuA+c8CRwaFDTkeUsZRRq+V0PdcsY=;
        b=h02Zic20NEBXBUOte1FhJ6Qaj3vGrqT0Hiy3jPQshdXBVkwoC/4ybUrf6YSUTy95Cc
         2I5JdS9geI6zT5qZNgoeS7v6LvOCyAsqq7pOzbiUZ5wFuHWDxS/FfkRyc8vKh0vGgB0q
         fbGwj1/JX31Mdck1qnFqF/iN1QkWep2BgJyFPIsIYjKJUs76sNI5rg2+bzXp/lLTndb8
         ys6KoEBlXTUdw8wWJi7Gjarr18B6irE89Q7OF7wkuJ5XOczEw5opPIJgn1NCnEjcZi2u
         jGzK564xsJSHGCnLsHuZaIpsdrs455eYY6bCR1MLF7VWa2EJyv40AWoNbtfw/vWv0nx4
         tayg==
X-Gm-Message-State: AOAM532D7V1AbZi6V+byWMz/LoURZfuoy16He0nNKtCFwkDSYjSing0z
        qcZ49Esym1svWJcapRGQUyhoBBZlciGS/Ade
X-Google-Smtp-Source: ABdhPJyO41m5nOt35fQMdoxrpqwQOe/Hbl42lUbDUic9chKbI6pE3cOvTVsoxLEMtoeouWLa4B+qbw==
X-Received: by 2002:aa7:d517:0:b0:419:16c0:f313 with SMTP id y23-20020aa7d517000000b0041916c0f313mr25542499edq.379.1648909342042;
        Sat, 02 Apr 2022 07:22:22 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id h30-20020a056402095e00b00412b81dd96esm2461485edz.29.2022.04.02.07.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 07:22:21 -0700 (PDT)
Message-ID: <f737fd47-e557-45af-035b-af29a88e22e6@linaro.org>
Date:   Sat, 2 Apr 2022 16:22:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/6] dt-bindings: power: supply: qcom,smb2: add bindings
 for smb2 driver
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <20220401202643.877609-1-caleb.connolly@linaro.org>
 <20220401202643.877609-7-caleb.connolly@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220401202643.877609-7-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2022 22:26, Caleb Connolly wrote:
> Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
> drivers.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  .../bindings/power/supply/qcom,smb2.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml b/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
> new file mode 100644
> index 000000000000..1bea1fef78b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/qcom,smb2.yaml#

Hi,

Are you sure "smb2" is a real Qualcomm versioning? IOW, is there going
to be smb3 in the future? If not, better to just name the file according
to model, so like compatible and like other existing schemas from Qualcomm.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PMI8998/PM660 Switch-Mode Battery Charger "2"
> +
> +maintainers:
> +  - Caleb Connolly <caleb.connolly@linaro.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pmi8998-smb2
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: usb plugin

Just maxItems:1 (description is obvious and matches names).

> +
> +  interrupt-names:
> +    items:
> +      - const: usb-plugin
> +
> +  io-channels:
> +    items:
> +      - description: USB in current in uA
> +      - description: USB in voltage in uV
> +
> +  io-channel-names:
> +    items:
> +      - const: usbin_i
> +      - const: usbin_v
> +

What about monitored-battery? How do you configure the battery
characteristics?

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - io-channels
> +  - io-channel-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    pmic {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      #interrupt-cells = <4>;
> +
> +      smb2@1000 {

Generic node name please, so "charger".



Best regards,
Krzysztof
