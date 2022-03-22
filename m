Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1936D4E3D22
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiCVLGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiCVLGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:06:12 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B297D2BD9;
        Tue, 22 Mar 2022 04:04:45 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so1669408wmj.0;
        Tue, 22 Mar 2022 04:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mvvlFkEN/DsC17H+AQBLEAD8Y8PP0Iw+Q8j7hJjOCTQ=;
        b=mp6Vp+tdPau70tKYoybT2xo1cMJ/5hDlC7V252cAvNX/VZuM+VkzUgi6veKpk0oltb
         sCOxJ2D6gKoCUB8llScO9oW8b3VuxC6aruf5m4U2tL7GgSQomeOzYjSV0RjNRwTcgsuy
         AFxqmiAcCSjODW6ZjRW/+CU/ipUWeh/lcpBvit8Xwf4f2I/xYqPlVl11B7q23vhlqPkH
         6Io9tLeoNta8tQN/tyfAENpP0Pg79qK7xUc5i78btdyXooh5Uu0XoRF0G5Qp8oY01Eha
         0Sa3G0URvhYyJTLTwIFjQsXsH8WrhkitKqpi8pvsFe2ITIkmHWOpzedR71jMThHpu7J1
         uimQ==
X-Gm-Message-State: AOAM530d8tg/H58grneufbKHve0jxhDBQSqtqNfh2f0BP7OUnxM9GuWa
        Xs9r4UGwX4k9Jfcw+5rzzo8=
X-Google-Smtp-Source: ABdhPJxuCH8Z9PTSPbFFW8KpTaaQmfCuymARb1qmutYtTbeZXsihRbaFDTA1CSPdosK56J2+k3PKow==
X-Received: by 2002:a7b:c115:0:b0:38c:b045:6969 with SMTP id w21-20020a7bc115000000b0038cb0456969mr3242738wmi.45.1647947084274;
        Tue, 22 Mar 2022 04:04:44 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id e10-20020a056000178a00b0020414f27a58sm4774621wrg.35.2022.03.22.04.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 04:04:43 -0700 (PDT)
Message-ID: <a7194fbf-8423-9b49-1443-68dd33e23783@kernel.org>
Date:   Tue, 22 Mar 2022 12:04:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 2/9] dt-bindings: reset: Add bindings for SP7021 reset
 driver
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, maz@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <cover.1647928315.git.qinjian@cqplus1.com>
 <55db801055793f43678e902395913330ecb8fbbf.1647928316.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <55db801055793f43678e902395913330ecb8fbbf.1647928316.git.qinjian@cqplus1.com>
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

On 22/03/2022 07:16, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 reset driver bindings.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  .../bindings/reset/sunplus,reset.yaml         | 38 ++++++++
>  MAINTAINERS                                   |  2 +
>  include/dt-bindings/reset/sp-sp7021.h         | 97 +++++++++++++++++++
>  3 files changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/sunplus,reset.yaml
>  create mode 100644 include/dt-bindings/reset/sp-sp7021.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/sunplus,reset.yaml b/Documentation/devicetree/bindings/reset/sunplus,reset.yaml
> new file mode 100644
> index 000000000..c083c821f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/sunplus,reset.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/reset/sunplus,reset.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Sunplus SoC Reset Controller
> +
> +maintainers:
> +  - Qin Jian <qinjian@cqplus1.com>
> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-reset
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - "#reset-cells"
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rstc: reset@9c000054 {
> +      compatible = "sunplus,sp7021-reset";
> +      #reset-cells = <1>;
> +      reg = <0x9c000054 0x28>;

I asked you to put the reg after compatible in all DTS code and
examples. If you do not agree with a comment, please respond. Ignoring
it is not cooperative.


Best regards,
Krzysztof
