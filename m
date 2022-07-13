Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D877757311A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiGMI2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiGMI1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:27:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCAA974AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:27:12 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d12so17856148lfq.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EaV/rroW+dQe7iYZ/YnJOFxdJwgnAadz2Ja67j4jgO4=;
        b=LUjO5qhY2tjcEVKD8B+TSFWdlzTe3qW3jv9SO0ESq+AaRaqyZo9jwoKTjgvGVBtPcZ
         gNg0xSHgT7thnoelrVnS1Xn1K+vhF6otpZxgQUK4KMe3fUXybjhpAT1yQY0G4ow4TFae
         sQFwM/2rP7RZJTNeoUyYEjyhTQcQro9OR8DuMJ58wGRXRuDTa1hh0HMIR7Pxcy3ohpQE
         6MXRIN22NRjho9MsulkMWHqv2hJBYhTy+ieUmE1TqxD4ilRpKrCiKtg+0htwzCQ/sVBJ
         Y0POU828ThNwL0gsAxoQR9KcPAoa6E7XF8rWmRS1fYDQSAV5ZY7HoiqZ+5bNdM+votAi
         fTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EaV/rroW+dQe7iYZ/YnJOFxdJwgnAadz2Ja67j4jgO4=;
        b=r3+UdO8pxruXj1n+8Ez/5fOEJwfo36OflcTdxrP7Z8HckOLdA01dO3k7OpLK8GWVVE
         NEfUgyiACz0mk5b2Hy0YoY9YQTh6m4O8IoJVvOiZ+lvQ2pE1hDhAT63GQZu8bYH6yS3z
         K3iA+w0u3QX1/9EE/vxHmih8L8WXnENQjEC3tiI7HR/CV1nalN9CUHmLZRSDxlVi4qPR
         YlQKzUa2jAG9TWdXz4yvKOvQqKv2dPBWwPgigQwbbMEFEPZmsu35PWsCjniYUPlu2mp/
         RSAvGLwh1w3V/Vkb9nAc/Ln5VVKB9tj7h81T1O6B4DKYEPlguorulhNCZUGPkcTEH7Gb
         LUPA==
X-Gm-Message-State: AJIora9r8TLVbZ5hZpR80M3EQjT7keF2132bIJxF99C/w8z8qD6cCu6H
        GBAibKq7T7iCzGZFw/W0dE7g+Q==
X-Google-Smtp-Source: AGRyM1s2gLKEqx6vWnMmnxpoB9EkV7fOAVI0KGdYbPRp5LroYG358skPN2ZCi8n4aTuU1JBI49oMmQ==
X-Received: by 2002:a05:6512:220d:b0:488:c3ba:acc4 with SMTP id h13-20020a056512220d00b00488c3baacc4mr1339256lfu.196.1657700831281;
        Wed, 13 Jul 2022 01:27:11 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id f14-20020a05651c02ce00b0025d754ba5f4sm1336234ljo.99.2022.07.13.01.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 01:27:10 -0700 (PDT)
Message-ID: <86fdd777-3c68-1f1f-3515-50426430bd85@linaro.org>
Date:   Wed, 13 Jul 2022 10:27:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: npcm: Add npcm845
 compatible string
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, j.neuschaefer@gmx.net,
        zhengbin13@huawei.com
Cc:     openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220713070517.172852-1-tmaimon77@gmail.com>
 <20220713070517.172852-2-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713070517.172852-2-tmaimon77@gmail.com>
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

On 13/07/2022 09:05, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845 ADC.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

I assume all properties from NPCM750 apply here as well:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
