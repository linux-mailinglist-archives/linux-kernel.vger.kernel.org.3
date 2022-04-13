Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9074FEFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiDMGjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiDMGjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:39:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF48B527E0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:37:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id k23so1918874ejd.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L2+K9dFepGLkCzuE8Vegw2gTnmbd7yYcc2wcM+3tE6M=;
        b=TMWlkGyDuqZPBlzzAUi0m0kmdT5srlS9slVSloQvgv5BjHG2OdUUF0qlHHQ0+VfAZx
         tBsIXiOvuAmhaEL9Ezrq8hog2fP/n6rQn9JMBJprPOOzCWIeznXyaZAxLGLtmhjZ8wm+
         DObenLbe+4CZ2ulGU65S8g7iixGQEtRFF/HtLDTEVyPXryuCY/v2OtnZO86xBPjyKRLu
         mSbIKLr3dLZv1CEfyVKGZ7IZXRLA1MDLfwaWFfDYpJyBwnBKB4/XCyuM5+N1w4w9TMb8
         TxO5j+Vtb8rd4eSU10an66HKJ2GBCxIU3ajXe2PL6FIkQlFfCcNzA+fCHuASm9ZO7yHm
         6fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L2+K9dFepGLkCzuE8Vegw2gTnmbd7yYcc2wcM+3tE6M=;
        b=U/TfOdusOr/wpvO1P99gshtyHXw8tYlxpMloJ4fy9Gh4FFuoJ5AsKdXOuqwBuBpinw
         QxQDp3qJ/hINTKnheVddkxgZAxit9wBNSGon3rctYUA3LmKSgsvScT6U+cD9/+Xly/08
         bnMBrxrpgSDHdTRDDmbjSI6PMugC96Um6CyWG8qYGvWPEFphW1ScLheTXrnfWJsaFthB
         /BBh94XtacVet/0w7jt+v8nZ7XIrj2uLxX2ogXO1sJRNZeBYYkRuGBXjgY5oaeDvHXw1
         YfRX7nKFVj2c25rn54gKCU7OG2+ijn35vg0XbCz821FOZoPzCDnmETc/2lhG9Ws85fAG
         zPCQ==
X-Gm-Message-State: AOAM5315ezuR2f9M0j9xR+umLg4G5IYlPCNoycceDHTtuY/O+fnGIVPS
        XCBSaALcLLRTJUpA0dxf83VIsA==
X-Google-Smtp-Source: ABdhPJxxfRfaX+I00TqE1PWHzu+5jBnSTb9E9ARm5cWpaGhCyvb0c2Wf2r6TMuae4ZkJn+WeWD7+bQ==
X-Received: by 2002:a17:907:96a9:b0:6e0:db4a:ba8d with SMTP id hd41-20020a17090796a900b006e0db4aba8dmr38877725ejc.87.1649831845519;
        Tue, 12 Apr 2022 23:37:25 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id r18-20020a05640251d200b0041d1600ab09sm802488edd.54.2022.04.12.23.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 23:37:25 -0700 (PDT)
Message-ID: <c2a7f2e0-1a21-bb0c-9221-c184cfaa3626@linaro.org>
Date:   Wed, 13 Apr 2022 08:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v13 4/9] dt-bindings: clock: Add bindings for SP7021 clock
 driver
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, maz@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1649659095.git.qinjian@cqplus1.com>
 <f8d5675d1bc32962af6379f78a171ed35b181ebc.1649659095.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f8d5675d1bc32962af6379f78a171ed35b181ebc.1649659095.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 08:49, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 clock driver bindings.

(...)

> diff --git a/include/dt-bindings/clock/sp-sp7021.h b/include/dt-bindings/clock/sp-sp7021.h
> new file mode 100644
> index 000000000..de8ef5601
> --- /dev/null
> +++ b/include/dt-bindings/clock/sp-sp7021.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (C) Sunplus Technology Co., Ltd.
> + *       All rights reserved.
> + */
> +#ifndef _DT_BINDINGS_CLOCK_SUNPLUS_SP7021_H
> +#define _DT_BINDINGS_CLOCK_SUNPLUS_SP7021_H
> +
> +#define XTAL            27000000

This looks like frequency which usually does not belong to bindings. Why
do you need it here?


Best regards,
Krzysztof
