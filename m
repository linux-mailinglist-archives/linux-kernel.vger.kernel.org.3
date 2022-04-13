Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6734FEFE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiDMGhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiDMGhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:37:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E70831924
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:35:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l7so1925521ejn.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nHozlyZgApPoTh4m5wIyFuBKBguRcJ5lguy2Gn/96+U=;
        b=Ekj30wKjfsZPLwckVPcpm3PbVUQWKAaOCkOwmj7voUniwIOS3Zh1JmlDQWnPs1W6cD
         aFfpLwWKsLumVa/eOswIYAeTN0SPolT3mS/We/9YlB1zEje/T64PvdVJxbeeHcTZ0/nx
         SiYftxNYntYLINvZ9K2/vn4eGXMzPjsolO0FDsvGkcwtHekq8QFrcjKJ3KybSZbMS3GW
         z9NSOXbKR7B6Te5+1PEQRRVQbzS+d8zRnqoVw9o+cfcVb4lSNvkDcpGlHFCHCQRrswgl
         E2qgk0oPxCyvg9ShCShXZ6s9JKRpGZt2oNjvt41jrCVf+L1ZrfA8hIdn8+DM6X3av6J2
         /wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nHozlyZgApPoTh4m5wIyFuBKBguRcJ5lguy2Gn/96+U=;
        b=S8hR88mhoBz0Vld09kg5HQPZ5EXzJNibkQFlV0qdF87pZe+8oaawBc/lUNqN2BwhGL
         bCki1viA/+6z6Ut0zo+UGKPMy8Fyx3oJRkEHUkMdNGwaSoJlol06sMnKTqMJfTIgVkCs
         99YTXMghwYRXcVujmV878WxekoJFRKk53IvtJ0uG7IgnSj4BlPKNsTgEe/GRIM6w7nz8
         9HtiJL7BsjqMgOTPivyC4LjlPjJ/xvoXFTNwP81dfdoXVhx8rxLdkCnGGdQySSmojFKY
         /mbrhdeBfYvTP/s9zJ1SGVa7G2uv2UAKyXLWEQQSGXztzS0h9K27ts0ZZ/z6R02cfxbe
         v44g==
X-Gm-Message-State: AOAM530iN/HuUhrxmzlegqyXDRC9t3ILs+I3V/2DDOt6fYuA/+kk4ROO
        /t1mvM+ptuehNWQYUem3yqQMzA==
X-Google-Smtp-Source: ABdhPJxsBQxfnY0nU7wbr7a8DqG4+vez5xl2Ri9fVBpj76nlBEtpUYuFPwxSFnr57UUnlKtNcLdOMw==
X-Received: by 2002:a17:906:8497:b0:6e8:89e1:e4f0 with SMTP id m23-20020a170906849700b006e889e1e4f0mr13673990ejx.61.1649831732867;
        Tue, 12 Apr 2022 23:35:32 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id dd6-20020a1709069b8600b006df08710d00sm14091202ejc.85.2022.04.12.23.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 23:35:32 -0700 (PDT)
Message-ID: <7d2128bb-2d60-ba5b-bb70-6a2d5116e20d@linaro.org>
Date:   Wed, 13 Apr 2022 08:35:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v13 2/9] dt-bindings: reset: Add bindings for SP7021 reset
 driver
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, maz@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1649659095.git.qinjian@cqplus1.com>
 <11b8f60a7f19f25d2fdaa7a2ed770e9383cec3ba.1649659095.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <11b8f60a7f19f25d2fdaa7a2ed770e9383cec3ba.1649659095.git.qinjian@cqplus1.com>
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
> Add documentation to describe Sunplus SP7021 reset driver bindings.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
