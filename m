Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CCB539EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350482AbiFAHp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350467AbiFAHpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:45:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB5B9D043
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:45:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gi33so2001947ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 00:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=icaxq30mttf79C4R9dYRsj76DdZgYPdfcBXzW0d+jXk=;
        b=qhdsg4Ya4YN7Vaxx4KRqhrWlzhNNHdf0PVdqfG2J6C64ZYh4eb930sm0pQWNlvi5fz
         e8MtDtNaaVfEvSo2ezzPWrRLXro7Sqa26fIPFSbaCr+rJ0K5llS8sj1WuXS0ZDeTRMW1
         Lla3hXfeN1OxJw12hVjMokIA+Gg3SyEJ/1OccTNwV4hxjUV6DOmLxRNU0yqHr1WBheJA
         DKAN/4VPGv+Rrlo/v4AXp1Snc9fqApNwGr7Sp7dRydFF6Uesn3rngsZOtwm7jmbM10Py
         IXF8drlRGeO2+SbhjYcSN+V7StztXVXY7g8jUAjlpSxc7L9HE7C7byGXkP65BsiWnwF1
         DWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=icaxq30mttf79C4R9dYRsj76DdZgYPdfcBXzW0d+jXk=;
        b=RHdlzO/OwDjWQtrPU9z6TiZ2sMhwgy7uHwlQiaFnj8HS9sCbQJ/mgVt3TRdmdhSUsl
         AS/QVZbZGuqbwEQ04DUyFeYYBwH1EwU3YZdPWKsgrcwah8nCMApzdf7msJ1vPRodb1Xg
         aLe29vPdv3RHbq2e6iL6UCkK8sIQI9puog8NmMD7Qu9Bsp/scRQeUiJhUGeQJuUIe5QU
         bwZvAXyy49uLAowxgdQ62uccZHh4Dc/79N0QtfJNgjQi0fzM/DwvqZ9QFVY93Ztxj31y
         gLVYjTsWt/xRgy3t8K87qC/7KNFC8jnS3HvHRWqRM0p0mfpZbA0AoxB24zCAprWfUktb
         IUTA==
X-Gm-Message-State: AOAM533/4UM82wMKqlB9yNZ7RwQ0RY0F9/Ks1E/Oi4tu2bBITwU9Imiq
        ug//ZsvQD7shlVcnxOCFZmtt1Q==
X-Google-Smtp-Source: ABdhPJxtNxlX3e7jclB2CRDTCFsHDIgFhYwHQFha34skmH3sd1hturimO7g/4A+a4S/XrA/j28pXsQ==
X-Received: by 2002:a17:907:7f06:b0:6fe:b81f:f885 with SMTP id qf6-20020a1709077f0600b006feb81ff885mr48271947ejc.621.1654069537754;
        Wed, 01 Jun 2022 00:45:37 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e20-20020a056402149400b0042bd75c53casm517464edv.83.2022.06.01.00.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 00:45:37 -0700 (PDT)
Message-ID: <c2f1621e-21d0-3836-6bb2-c1fb038856c5@linaro.org>
Date:   Wed, 1 Jun 2022 09:45:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/5] dt-bindings: clock: Add AST2600 HACE reset definition
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-3-neal_liu@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601054204.1522976-3-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 07:42, Neal Liu wrote:
> Add HACE reset bit definition for ast2600.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



Best regards,
Krzysztof
