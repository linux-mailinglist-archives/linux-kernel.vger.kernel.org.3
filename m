Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633E155160B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbiFTKjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240977AbiFTKjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:39:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A871409B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:39:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id um5so5266772ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wu7OjQauT8VsAEcCNOR8tTiMvlUSYPeipgtsHwYY4Vg=;
        b=m8op4FixOAAlfFZ7egA7dw9XYWx1MedsRDNb/RiDDswivswf1dRO3JJr8j/dB6U8b0
         wG1V5eA/LYFuOiUxauvTX1kFoE58uC+7lIApV24t1QqUfrlEdBkeiYdRYVgO8VVV5B3m
         jPlzFxqwsU7KOcgnyBRxDPuMzMxryRAXpnoBnH906aLguQ16CafUqTcdhR8ML9FBGAsq
         Q3XTgGHED3qelMs+zISNTJBb66zeIDaCzP4HIuMXZM+Sya3peej5uQ8Sc35IWTB8xPqo
         eFNjunF8X1gBRtP5rVsjNvLSjMAkbL6VLJFinF/mlNcaldTExFi/tx1RsW2mxCD2Fic4
         GftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wu7OjQauT8VsAEcCNOR8tTiMvlUSYPeipgtsHwYY4Vg=;
        b=2KQm2s5vVJp86JNjo142hTSJDxUVJMPwp2xcyTjteWc3+3XvNM6bJChYHQFLTEytHn
         nVb7pHKzF3LEtVoakHDJpZwnQU6wshlkT1uJgpo9hNyLkW7GJxMMH4LnVhvEb5QZLMM+
         Rw07Gb/iF3fqAqFTcK8Oxm8Xlj4O/LJw0UqfayjHCBNOFDi5RNafL/h8y/+XjnX3xfff
         Xv3SD3b0gQ+H0E8MwoVSx3KrDyRTVh+vak2VXCJ1p7DJUL/AYoRXmGnXTz7ZnaNn2q1V
         7SIhj77Imqkw5S1r/qHB88WyJGfT/y7ae/B6zTmihZwOWAJR4NwnD6shckDGLdeRPq5m
         zz3w==
X-Gm-Message-State: AJIora9hopY38k2Zuk4YdEIymkHHWPg7kjzsVUpBOBdLi3Z5XmKZnGwJ
        zjzTrCJaLKioRrnoIhi6IWqj2g==
X-Google-Smtp-Source: AGRyM1sOCeciJIgUmFsu++sl3HilovcjqIj6UVBWntWzocHHiukB6fjy1Eq8qCfxMertj/cHx6/Q/w==
X-Received: by 2002:a17:907:7f8b:b0:721:9c02:37f1 with SMTP id qk11-20020a1709077f8b00b007219c0237f1mr9006305ejc.211.1655721566494;
        Mon, 20 Jun 2022 03:39:26 -0700 (PDT)
Received: from [192.168.0.209] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c18-20020a05640227d200b0042617ba6396sm10335480ede.32.2022.06.20.03.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 03:39:25 -0700 (PDT)
Message-ID: <6e9f17a7-677e-e4b6-54ae-77ad07bf5204@linaro.org>
Date:   Mon, 20 Jun 2022 12:39:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add prefix for
 Mixel, Inc.
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
References: <20220620034533.4108170-1-victor.liu@nxp.com>
 <20220620034533.4108170-2-victor.liu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220620034533.4108170-2-victor.liu@nxp.com>
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

On 20/06/2022 05:45, Liu Ying wrote:
> Add a vendor prefix entry for Mixel, Inc. (https://www.mixel.com).
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
