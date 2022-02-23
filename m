Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8157B4C111C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbiBWLSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiBWLSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:18:07 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C463B6B09E;
        Wed, 23 Feb 2022 03:17:39 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id z22so43563169edd.1;
        Wed, 23 Feb 2022 03:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z9M1ryJc1sezXeZas0y4b6iOkouebmDu8wCXcz+Etrg=;
        b=S2sZPGi73IE4AWT39prT6q4nx2SmSB2TTx0ZBt67y9Ajbrwzd3TzGEttQaeSs2Jd70
         3ULkIpM0pqjx8uQI/5AcO1N32GC8dKJ9jaU198guBp8TY3fS9i4Q6rqpMpp1kMJcei6U
         Sv665nmuzHCiajOUrJg5xU4ptB57Oorn7xNzbyygi9yiM5ZDhQ4MtlVj32ZEDIoePMI+
         bMoogWRhQtdQ1gdicUNjHiIt6QdzOMR+hrMR8anPFFQA0V7aVfpDhjsMhYp7PUSEElxq
         hZauwFzOBX7W+rUKMc3kkO70mZawkHPK/Bro8jJdzfhTTHv5Ll89D1zlX5oQSXk6/TYL
         b/LQ==
X-Gm-Message-State: AOAM531LjFjDm38wrzfQN8NTQZFQWf8qyyCuSQyWdYc2uIy6DmvEJXZm
        h+E7NaRWG20jcRBaYC1Wos8=
X-Google-Smtp-Source: ABdhPJzuE0jkbsdcau6gHGq4StyNhBXCOTJsN4439VeS5atdmF4wV71O2xFVps+cmZtcVPcnxPFbMQ==
X-Received: by 2002:a50:fd97:0:b0:410:c0be:f4c1 with SMTP id o23-20020a50fd97000000b00410c0bef4c1mr30437571edt.313.1645615058122;
        Wed, 23 Feb 2022 03:17:38 -0800 (PST)
Received: from [192.168.0.125] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id i16sm4050917edu.52.2022.02.23.03.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 03:17:36 -0800 (PST)
Message-ID: <fff14463-2cae-c540-e23e-f894a4b76d2c@kernel.org>
Date:   Wed, 23 Feb 2022 12:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3 1/5] dt-bindings: clock: Add imx93 clock support
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
 <20220223064358.4097307-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220223064358.4097307-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2022 07:43, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add the clock dt-binding file for i.MX93.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/clock/imx93-clock.yaml           | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
> new file mode 100644
> index 000000000000..a4c3ae23b8c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/imx93-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX93 Clock Control Module Binding
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +description: |
> +  i.MX93 clock control module is an integrated clock controller, which
> +  includes clock generator, clock gate and supplies to all modules.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx93-ccm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      specify the external clocks used by the CCM module.
> +    items:
> +      - description: 32k osc
> +      - description: 24m osc
> +      - description: ext1 clock input
> +
> +  clock-names:
> +    description:
> +      specify the external clocks names used by the CCM module.
> +    items:
> +      - const: osc_32k
> +      - const: osc_24m
> +      - const: clk_ext1
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      The clock consumer should specify the desired clock by having the clock
> +      ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx93-clock.h
> +      for the full list of i.MX93 clock IDs.

Skip most of this description, it's obvious. Leave only reference to the
header file, either here or in description of entire file.



Best regards,
Krzysztof
