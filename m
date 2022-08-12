Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111E7590FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbiHLKs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbiHLKsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:48:24 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC96A59AF
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:48:22 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id j3so603488ljo.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=EhxaKIEh/wAXZD6zcgeSWFyzI2lF/EihKd+2aYnlgHc=;
        b=qrboJ4rIHDgzbJmvJnEP89NnQo6aFutdcDE5sNQAQF9N0kPvOHxHpe+7iifkwnVHAY
         GKtnzTp/S07plKrH9tAy+EPSNK1E1Jqytc9ICOewpsLe/Tpb9ZnFt53jQaZGJ8vOBpUq
         gUCKPuKboCZAgM+DTijUvInr0ErC00/On0jdKw/Sn2MKhJFR+nkryt9fRjPgrMzQvkBZ
         vtnXlFjZ9M4iHXDA8Oq0cRfgj89y5k5GOkHGCMW/P6bbVrA4HW7O+4wnHneBk8FBgeoF
         QztIC1Rkxr7KAdR0UYavxZKc8j5nwWdDdv7zu1tRCj5G+rkOJ2KEbQId8brD4EHyd8m0
         te4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EhxaKIEh/wAXZD6zcgeSWFyzI2lF/EihKd+2aYnlgHc=;
        b=tOmFkBKJDD0/mnzaeuIFKjVUv7bSj7TlutvR2EWaQ0N7cv7EODteaPimj0OR3igC9K
         r2hbuZ2QYxpzWJhsR82gmyuVUufff1JGSel2G6GRUlAvWPFJCidMqBwtKiYHhNYlhSln
         NI4CzuMptMTRlOlPeXYZvHwy9YtVIHs0aXHZf/D6P+R1nuZVcyLtANvAWTj6UviPLtiR
         o7P02Knrfo1bucy1fj4WszjJvenvR7U915Mm54WAaJTXXNGaJ6EPC5pHC85BGaS5hM5o
         mIIwB2WEwPo3UQatgPobQLrzBhoy7AHMIiOMysy3/cykQ19BkGmC1fMzI7QhukDAvHrM
         ORtw==
X-Gm-Message-State: ACgBeo0ertG0q9rfido/kt0zfConofZ5DLNczxM0Gw1h5TClHbv13Dp9
        cSS9vMwyEfQhG7+B7FvhMhOWbg==
X-Google-Smtp-Source: AA6agR57MBAVpGC8ueukuB2CqRdXwkzjd3ZbWTc2T0r/j1Wf9Z7xAWiR/BSI7OSqtlG5F26ix5qbIg==
X-Received: by 2002:a2e:a552:0:b0:25e:6fa1:a6c4 with SMTP id e18-20020a2ea552000000b0025e6fa1a6c4mr949196ljn.90.1660301301259;
        Fri, 12 Aug 2022 03:48:21 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id 14-20020a2e154e000000b0025e53413b6dsm313231ljv.2.2022.08.12.03.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:48:20 -0700 (PDT)
Message-ID: <bb69c593-b355-a080-0ab9-334ceb5eb036@linaro.org>
Date:   Fri, 12 Aug 2022 13:48:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/4] dt-bindings: display: sun6i-dsi: Fix clock
 conditional
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220812074257.58254-1-samuel@sholland.org>
 <20220812074257.58254-2-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812074257.58254-2-samuel@sholland.org>
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

On 12/08/2022 10:42, Samuel Holland wrote:
> The A64 case should have limited maxItems, instead of duplicating the
> minItems value from the main binding. While here, simplify the binding
> by making this an "else" case of the two-clock conditional block.
> 
> Fixes: fe5040f2843a ("dt-bindings: sun6i-dsi: Document A64 MIPI-DSI controller")
> Signed-off-by: Samuel Holland <samuel@sholland.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
