Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03EF53FE15
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbiFGL5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243258AbiFGL5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:57:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29C6B6418
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:56:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v19so22647650edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 04:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9yUA6xZ+TgF7E05GHOHfVerF3dIUaRPmpzkb0SqFslg=;
        b=yZF938OJ/O7+VlTfOCAPvgavpyjTL2l5Dn0Tn2nIwpSe55xG1IS+57nq5ALnIDLec5
         79x4zkTiEbOgwCtHLa2fhZ6iEu7D/lMorP76inFutqBeQJldod8/6UKADExabiSlqIZq
         7rJDPGd5+1ninnZI67YT6mdGZGLaV7/tQ/7ZzIF7BwPODSUOM1S9QaAQK6gUDp23lTd9
         gKGU3+5H5GU/ValDpNcmAVHC/SiNrjA+eDInhSLCfU/8aPrUi7hryXGpr/h7BVjHK6AI
         Chjo1f2a4t4ZOsYIOaYc+aElJ5n6uhyYpsQWQsYJQ2JhdcqiYa6bvS4vcxEwwON3K/Nu
         euzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9yUA6xZ+TgF7E05GHOHfVerF3dIUaRPmpzkb0SqFslg=;
        b=12QrmgC88CjkthAz5pXRgltgq9Gc8a65KfJouSnMibLSn/+vrAlwc1APBapYxQTU6w
         d8OJKoXRDCV/m94D9MnZ2Aow7PaDFim3+LGemImKXGalJvblF6WuRFSwt+w1jJSlko9v
         MagVCOXwZaF+3nmlZXj0FIcqSK3zv6eT1/OM/i1/tqJXxIAJFscR8FxiYHtvQeymMRoT
         /qgIxb6lKCULeJM71uGE0XpyiCPkeg/BZKSEDKTQr1DktjMnWeYnEEqC2ewbs0Zrjutn
         AOQ+OKF3SzwBF3nksoKG/Cyr9yLzqkRhHlSY668vmGmpDbHPdZbxpkhf8vBx5xxKRvpg
         I5OA==
X-Gm-Message-State: AOAM5339URpInqUyz8TL2PZhJIaVfNhrFw8lhJh4URm4Z3I0f2FmKQKY
        D7Wm4uYDnEJdyav7aoKPHwYRVw==
X-Google-Smtp-Source: ABdhPJyDyZBQOke271JtAgNt1hSBlmSVUkFbj2ZmbW/2KkYdQf3mrTIq3KxTSW9YKCe45nHpZbAZ1A==
X-Received: by 2002:a05:6402:438a:b0:42e:985:4944 with SMTP id o10-20020a056402438a00b0042e09854944mr31974058edc.283.1654603017338;
        Tue, 07 Jun 2022 04:56:57 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906601600b006fe8b456672sm7680363ejj.3.2022.06.07.04.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 04:56:56 -0700 (PDT)
Message-ID: <5a604d43-92f3-2709-bf3e-098a9d2dfa54@linaro.org>
Date:   Tue, 7 Jun 2022 13:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v17 01/10] dt-bindings: arm: sunplus: Add bindings for
 Sunplus SP7021 SoC boards
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>, sboyd@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, linux@armlinux.org.uk, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1654565776.git.qinjian@cqplus1.com>
 <2b3d1c0f7b83f9e317ecd68965b6cbf7d7f3d13b.1654565776.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2b3d1c0f7b83f9e317ecd68965b6cbf7d7f3d13b.1654565776.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 03:58, Qin Jian wrote:
> This introduces bindings for boards based Sunplus SP7021 SoC.
> 
> Acked-by: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>

This is not a correct address in the tag. I never used such. Please fix
all reviewed and acked-by tags (mine and Rob) to what you received.

Mine was:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
