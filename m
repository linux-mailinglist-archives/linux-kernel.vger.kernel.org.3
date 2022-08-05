Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B39258A88E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240545AbiHEJN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiHEJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:13:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CAA78226
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:13:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq11so2582505lfb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=1YjciTp42v6B8MpUc3bNVR0+p597jmP1NofHHP0CW5A=;
        b=G+mXJvAK1kPPno2wsq/kuteBFt9rHaI3XejdqGG+vSGgabb/tWi6KkiARj4ncVr30H
         ozH8qcFU3E/N7VoT6+mvc1W/5DSc5mJ3pS7J4NaXRpqM1Oozjfa/1quzdWqRFH3xe00M
         Bl5gXBKCSD88+0dY5qYrxekCNmIS7ndOGQilK5JC9XTE0uX7rqY1w9JKmyaCUSkAHcHD
         04CX/swFSCUCtv/wQbqdwNTzIzRLXvrGb6vesKSkdIZURhGXwcGsqTlObd8sobGh0+8F
         N6wOp9h/YH3NZHAgbZKWG8vPOhoM7SrHQh5fIgFWsTda0l9RaJpgRE92Pvq5cvqP5+6Z
         nlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1YjciTp42v6B8MpUc3bNVR0+p597jmP1NofHHP0CW5A=;
        b=KoXkXlKSWEiv8a8iuxJHCjGM896Y7lrz7zWSfd3xVGoMg8VumKLBn12HBekkuDcy6b
         e1OMHTdV5j0bo0rcegpl58SpSqgLAqrwpwnxeqxVv+QYocgdrxrvaG7H6hQi5IhIggio
         sNv7OJDD0mkAN0w3vmuErlO9sds9X3uGkNzh1ORzP8WJov0e8gTKFTeoSQdgat0WumGK
         IBZs4yglQU8HF80o/x60yFnurp8K7Lbzjz8bQCN8XgUwjwB/3TnIVl3nGDdH7oymWDaz
         zbXSKpOHqYZoJYQ7GTU/LMPWokg3vQew+U0sz60Oio7dcC9ZDZ+DT8xbps/67P9AlEJ2
         Ppgg==
X-Gm-Message-State: ACgBeo0QIYZklt66KGZFr2Dm4+Z0FvqwMSz4ObIr7fskG6+qBYT/RKMk
        XSd2H/grZZc/W5B/Qm1nUQoeBA==
X-Google-Smtp-Source: AA6agR4bULYrPCXU3n8gQGnJBTOftjBg7+4i0kVjoCT2OP2w4PZcyJyxhpxAhpaVtFgNcT5U4DyRxw==
X-Received: by 2002:a05:6512:3b8e:b0:48b:23c6:9b0 with SMTP id g14-20020a0565123b8e00b0048b23c609b0mr2164925lfv.470.1659690795468;
        Fri, 05 Aug 2022 02:13:15 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id q1-20020a2eb4a1000000b0025e6d665a3fsm409199ljm.18.2022.08.05.02.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 02:13:12 -0700 (PDT)
Message-ID: <370378a9-4341-30fc-79b0-57ccfa7f3def@linaro.org>
Date:   Fri, 5 Aug 2022 11:13:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3 1/6] dt-bindings: clock: meson: add S4 SoC PLL clock
 controller bindings
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-2-yu.tu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220805085716.5635-2-yu.tu@amlogic.com>
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

On 05/08/2022 10:57, Yu Tu wrote:
> Add the documentation to support Amlogic S4 SoC PLL clock driver and
> add S4 SoC PLL clock controller bindings.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  .../bindings/clock/amlogic,s4-pll-clkc.yaml   | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  .../dt-bindings/clock/amlogic,s4-pll-clkc.h   | 30 +++++++++++
>  3 files changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
> new file mode 100644
> index 000000000000..079ae905b69e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/amlogic,s4-pll-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson S serials PLL Clock Controller Device Tree Bindings

s/Device Tree Bindings//

With above:
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
