Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112B657287C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiGLVXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiGLVXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:23:09 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEE6CC7B3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:23:07 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bn33so11339195ljb.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n1ZO8TXDHj3NsRlYlgOrOAr4N9XXMzuVm8SErIjEja0=;
        b=G0DVQSIdqHZsCsaIpwrgBp9xO7Z9fBrXqTnXm35zly+Y2omB3PNW30Df/fy2YCFNzT
         hDPe9xQaP9GAZYOzC6trs+pVFPhnJuPDS17m5GnLbbfCp96wTbij+KYWAWpxfvmAgO3F
         6BnO7GKZsa9/gEqXo61az4GaB97Sa2Fa8OyfME3TKqNdrE9CyPTj534e66EuEdqyEgoF
         bjkiggsOtqz2/vVvh/w3DGXsJCBvVabmzSQ91yA7OA7hzq9139Aa3ex79AWBfXGo2xX1
         Xl9/OzyAK2m7y5/pevJmeJQ6y5s3F95Quew8QXi/JAPW3PH1UKgakCHrNQZRzQSmJjNR
         ew5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n1ZO8TXDHj3NsRlYlgOrOAr4N9XXMzuVm8SErIjEja0=;
        b=JfNECUr199mRIqtJ1ykpMNU+O4bUKw5m74Q0BtrsxkvZUmeu0EvAZyXjKKlhG100Yd
         JKKIfnD9PdxqPpVdKAzHHaBlZJDC7lV62fGw9tdvm2/J2MKBha6WDkfowJr9YffDBg+i
         nMWi5d1yDq5H4ZPfboq0U6Rz1d64Z++WwBNPo7k21WkuPcrp0QElT2FvY2hqtaLI73gQ
         P/q4XQLqwvOF1MaC9NxEUCA21f/dH4uo9Da0D0uO8Yq8KXw5JonVVPGPGbDaBCrPKq06
         SQ3qgTbKZKMHUmunJHruxWOlM4N88f1usqV6EczADD9MYdcu0mKzvGapwGefOxv6w1NC
         hE9Q==
X-Gm-Message-State: AJIora/QAkSWolW5lE7NkFte3FRd289+WLbU4Uo5pnQBUVV7nEbA+RF3
        z7jASqrgjm9ocP3KKGM9wUkENw==
X-Google-Smtp-Source: AGRyM1to15pqtVLZPOLGpxX3l4iWMrE8kKqgE4uwbm35HVvBXfvAgzeYWcrKDc9+GtNgEUnP+M8V2w==
X-Received: by 2002:a2e:bc18:0:b0:25d:735c:b57f with SMTP id b24-20020a2ebc18000000b0025d735cb57fmr11742ljf.118.1657660985757;
        Tue, 12 Jul 2022 14:23:05 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id z18-20020a056512371200b00489da512f5asm1770549lfr.86.2022.07.12.14.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 14:23:05 -0700 (PDT)
Message-ID: <7aca3568-aeea-478b-caa5-d1a7d9e72f3d@linaro.org>
Date:   Tue, 12 Jul 2022 23:23:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/5] dt-bindings: gpio: stmpe: Remove node name
 requirement
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
 <20220712163345.445811-4-francesco.dolcini@toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712163345.445811-4-francesco.dolcini@toradex.com>
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

On 12/07/2022 18:33, Francesco Dolcini wrote:
> STMPE driver does not require a specific node name anymore, only the
> compatible is checked, update binding according to this.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
