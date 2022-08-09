Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3DA58D6F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbiHIJ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbiHIJ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:58:09 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91246237F8;
        Tue,  9 Aug 2022 02:57:59 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id m10so8164691qvu.4;
        Tue, 09 Aug 2022 02:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wYVKsyzdVgI6ayEi/3tCAI9Uw2HWYBeVodpJMGXc5f4=;
        b=qRj2x6X8nJhUOOSQhxNai5AF7mc+KJJwMem3j8Yeyf9ykVdbAFIcMHhdZ0eG6b9VU3
         ypjudl+cNi2jPZNwFNjJl7+xSFyjJTYPo8GtaN9IHcY9QgiNhgT9huNkYi51wTTmxtSi
         +AzGioMBu8uxpBUMIytJcnDtlWPCpxAFMwrCof+5KWW8SDt4NC158FjkHit70q7UJ9pk
         mGLUh8KBCfuQ6hGmMOaa7chyOi/DmcuRA1kfkgjShdy4otjoKA0Eo2XKFKtKiYPhGS/f
         okNJ28E+wAK/FlCQbo+z8ocrN1uIMK+WTBF3+0VujNCPL0Zt/srJOb41oP8w8SkLLM5v
         A6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wYVKsyzdVgI6ayEi/3tCAI9Uw2HWYBeVodpJMGXc5f4=;
        b=EiOJrp3aD7sTGaiysI0BNZf8zt8vdiBfR4oTNm0nAeQSmqKjl4oL2LUo9WGsfbP5Wu
         5yJx/kWtajr4b4KvGRRMNPVwbAP/KlaYkIGZang3xx3IO11n2V64F3+aFP6DwtTiHZdo
         UPEagVhyyGZMLu3YzTjc6O8EvujoGpOKKr4l1HctSQFpmlLxrT/TP4IeZbITuaFUaiEj
         FTCc3L0NMv7UWR+mSGq6LHqm/PSL8CKLP7WKr3CtwPOeyxYPP39sXF9hc8L6IBAcxFrF
         /sBo3AvJWYhVUBd7Ul0uB76YVrqIYG3YacSeFlRrF8M/ioJCtLSLMSl/PWHmgl1AsGo+
         p4SA==
X-Gm-Message-State: ACgBeo1JIzzOn8KiPF6LSJHX2P20GMPFEPG9Yz+3L9v8q7pOfF3BtEGS
        wmyQAXhIX2+LTNEFw4wRUH36D+6nq9FjtFl+sF0=
X-Google-Smtp-Source: AA6agR7xLq/uD2LEyUOyCnXa/G976dZLAY9oOrytVO8f6iM3TT7lY7cnc87d5Q/rCPg6SHG4bZqOd+GE45joOD75iXM=
X-Received: by 2002:ad4:5baf:0:b0:476:6a9e:b5e1 with SMTP id
 15-20020ad45baf000000b004766a9eb5e1mr19175614qvq.64.1660039078699; Tue, 09
 Aug 2022 02:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220809073648.167821-1-marcus.folkesson@gmail.com> <20220809073648.167821-8-marcus.folkesson@gmail.com>
In-Reply-To: <20220809073648.167821-8-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 11:57:19 +0200
Message-ID: <CAHp75VerfFgNKRbE=f0LnpRBr1o=qNwSnUkzq69BeECJFY9Vvw@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] dt-bindings: iio: adc: mcp3911: add
 microchip,data-ready-hiz entry
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 9:32 AM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> The Data Ready Output Pin is either hard wired to work as high
> impedance or push-pull. Make it configurable.

...

> +    description:
> +      Data Ready Pin Inactive State Control
> +      true = The DR pin state is high-impedance when data are NOT ready
> +      false = The DR pin state is a logic high when data are NOT ready

Wouldn't be better to move " when data are NOT ready" to the main
description text:

      Data Ready Pin Inactive State Control when data are NOT ready

In this case it unloads the list and moves focus from the part of "NOT
ready" to the real part of what you pointed out here --
"high-impedance" or "high".


-- 
With Best Regards,
Andy Shevchenko
