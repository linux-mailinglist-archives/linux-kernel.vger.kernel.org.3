Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31969551691
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241233AbiFTLGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbiFTLGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:06:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AF113FB5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:06:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id um5so5401849ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=so8sDrLioUFy7cOL3aS8tAl9RK2+NGzjPv7D1JAQDqc=;
        b=u4+Znx6db0I1JIgKEtGzH7OPNIWp0RlAyfziZK61G7HLQXtKDmi0Zxo+Bi+wfiR/KD
         FEIbLQ2dQ5i/LOnmBPY+8bWjgkGzi81qd+XxzZGYBnmCHPfK2tQfln5FUbnvER/7fYnz
         Xf0z5hPHp3btaGed1cWbHZet8ft74tE+V/rzl+xxTSoKECBQzYh3vechswvdCqEtIyC1
         lWd4r5c5ka8n4ivrhcvum5+oEW8M4gcVlqIuHs2aoXL5DHkoRKobgS1+b0+pfyejVNs0
         IJAO81M44MsKVFwolQJsC6a0OWl/kZcXA+yPgrZnb3k2Phn+Miiyo25DoxyzYL3RRu/R
         j/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=so8sDrLioUFy7cOL3aS8tAl9RK2+NGzjPv7D1JAQDqc=;
        b=rFvZoZ0GCUQVjt6orz2mI8DDSm2qu/Ctm55dkKEEs6SGp6MOgDK55RxWJ1nDOezUmL
         r7YwGZ7uKcVXjDGP/OpXOGhCkeMxXN4in0P0WT4yYZyc6g3UGhugNgqQhCABMxBbUoNv
         bSdrJlDetRxg+PkS1HWo85U4VaUHP4465mBbKDc+tW3jzrOSHqhwrl+kCTotej3kIyKM
         hFyvVVZMeUCZen/gwtAOenbrg7yX/Ul2BuaB4oLWQcbawBGMtk6riFH2RRSnYN3dDuOy
         P30czAWxoDe3d+kPaMJ18E3VQaV+3mp1fBi9EhtNHoKkAUN8cupeohegxpKDwTEnPl1i
         veFg==
X-Gm-Message-State: AJIora8Q6t2WQehLjw2PIP5V1niCSdwgffvv3oOfT/hTSMvVSIkwO/Vn
        JPqbc43AvewET6ghnQbeXcN/Ig==
X-Google-Smtp-Source: AGRyM1utaO1T4vO2p3+cLvVRr/p5V5NSZLwsZ5AVyieVsZkGXMqZnNV4gEgHvCEdu8Bh1P9TQOyRnQ==
X-Received: by 2002:a17:906:58cf:b0:711:7acb:821f with SMTP id e15-20020a17090658cf00b007117acb821fmr20292050ejs.588.1655723199682;
        Mon, 20 Jun 2022 04:06:39 -0700 (PDT)
Received: from [192.168.0.209] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090630c600b006fef51aa566sm5797606ejb.2.2022.06.20.04.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 04:06:39 -0700 (PDT)
Message-ID: <0207c2fe-7c01-7852-3cd1-74297cd4857d@linaro.org>
Date:   Mon, 20 Jun 2022 13:06:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/7] dt-bindings: arm: aspeed: document board compatibles
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        David Wang <David_Wang6097@jabil.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Steven Lee <steven_lee@aspeedtech.com>,
        Ken Chen <chen.kenyy@inventec.com>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-2-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220529104928.79636-2-krzysztof.kozlowski@linaro.org>
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

On 29/05/2022 12:49, Krzysztof Kozlowski wrote:
> Document all compatibles used in existing upstreamed Aspeed AST2400,
> AST2500 and AST2600 based boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/arm/aspeed/aspeed.yaml           | 83 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml

Joel, Andrew,

Any comments on the series? Rob applied only patch 1, so the rest is
supposed through Aspeed tree. Shall I pick them up and send to arm-soc?

Best regards,
Krzysztof
