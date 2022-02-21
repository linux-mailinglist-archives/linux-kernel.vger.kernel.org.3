Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154F34BE0D3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351422AbiBUQaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:30:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiBUQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:30:00 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841D81D0F0;
        Mon, 21 Feb 2022 08:29:36 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id c6so27700208edk.12;
        Mon, 21 Feb 2022 08:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r60LnpBKJemDpAD/NBoDJDG4Dw1WSf5xzL3nTkd2VXM=;
        b=Z5hAvtwhcv3gs3Ui4C6fc32tugM1jxPvTAAwhtougNdZuhyS0oBGFRrTJj78PtRye9
         BHae6b2NKO1M0NrufK66BugjNI2fB/n5/6aGxk5aPo79u1xq+/rwGOBHmdazPz/Wj36K
         D5EGXZXFCXXSM3x06XI7tRZJSobXLyg1GLxk5eF5gmqsH4c8hgvbqz3E7Ys6C7ZB8dVC
         l2uAyygYnEz4jziksX9BzlLwDQtKfpHDpfowIwuty/NDRAITTeX4N4Fr+cHgpas1zMNW
         erWtvFG4XaiwR6idQWS49kFWIGjFIFqvfXBMNgMxVBvVKbQRjNO1YHZDfVt/Kmr7VwCu
         XraA==
X-Gm-Message-State: AOAM531ICcDwqzlYb3lUoQ9EtUduveJrMLKCdlpPyem+x3WApIlR755T
        BDGhqUB31KyDsGtwoO9uGBU=
X-Google-Smtp-Source: ABdhPJzs6plXAxsbWbLwuDo6hS7fX3fNn/Ze3hNH7xJcp6TT2yB/K+N/T9b7qA32oQipw5gnSo3ycw==
X-Received: by 2002:a05:6402:268a:b0:410:cc67:e792 with SMTP id w10-20020a056402268a00b00410cc67e792mr22259826edd.218.1645460974857;
        Mon, 21 Feb 2022 08:29:34 -0800 (PST)
Received: from [192.168.0.122] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id m7sm3835023eds.104.2022.02.21.08.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:29:34 -0800 (PST)
Message-ID: <141c1b3e-b116-a0eb-78ad-dd9263880e9d@kernel.org>
Date:   Mon, 21 Feb 2022 17:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 02/10] dt-bindings: arm: sunplus: Add bindings for
 Sunplus SP7021 SoC boards
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        broonie@kernel.org, arnd@arndb.de, stefan.wahren@i2se.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com, Rob Herring <robh@kernel.org>
References: <cover.1645413746.git.qinjian@cqplus1.com>
 <87cc20bb3ef747c4da89f9e60c0847532bb0a679.1645413746.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <87cc20bb3ef747c4da89f9e60c0847532bb0a679.1645413746.git.qinjian@cqplus1.com>
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

On 21/02/2022 04:29, Qin Jian wrote:
> This introduces bindings for boards based Sunplus SP7021 SoC.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  .../bindings/arm/sunplus,sp7021.yaml          | 27 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml b/Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
> new file mode 100644
> index 000000000..5b9985b73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/sunplus,sp7021.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SP7021 Boards Device Tree Bindings
> +
> +maintainers:
> +  - qinjian <qinjian@cqplus1.com>
> +
> +description: |
> +  ARM platforms using Sunplus SP7021, an ARM Cortex A7 (4-cores) based SoC.
> +  Wiki: https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: sunplus,sp7021-achip
> +

You did not publish DTS so bigger picture and context are missing here.
Is it a SoC compatible? A board compatible? Why only one? Against what
does it validate?

This binding looks incomplete.


Best regards,
Krzysztof
