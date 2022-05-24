Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802155326F0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiEXJ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbiEXJ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:56:13 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1391A38D85
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:56:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h8so20240433ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TNrztLGI7YmluKNlO8mQvCDSwLHT2q37DR0pu3wOwMc=;
        b=bqvCUGJAQAzLwY3sfu1hbgOSI+pcfdQAwtt01ZRg7d6FXrdv14i3c6V7VthX2NnZVo
         onXYiwgJZj1ydS1utpVk1BTcqiUNMjiYwvA8Cx2NiqpgQelMQPvIWQnSfR32Q2hexpRY
         Hf0pgJ+TdTcfVH9uyqE4FQCz6Q1AVtEiFyIH7dnG3sjGVnw/UA1vU4od1jqPrKSQx9H5
         24cMcqUL63dp3SLHwRkMAjo4mkg8zm1+B9lC+/x4WkeuecgZReWPwYV8wDEgdoK3YrN6
         wo4ACh6sSfdaBjU+dZWa+ReWcC24f3W5rVIq5PBwAwA5a0xFEGs6DDycoEMP8kjOmxie
         ZlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TNrztLGI7YmluKNlO8mQvCDSwLHT2q37DR0pu3wOwMc=;
        b=fmRylgKzLgj2Drstw6MVl7FC2kRcOulwR+RMoK2KUlRFVewpNb9W+3uXG2qyAg8nFE
         mH/SK59KLuEF7V07TKl9ngPTz8qtUkz+8Ev4c1cTL2QxxPxQ4ZJ9sTII3zK3Dc1ntJ12
         vRBnzYiBAIli7lS64wDsB2kkFZoCaG/01+NT2vYQNjZwLnLES2TkgyngjI2s5F/Se3WC
         If+Fe/zZxidtgsrsd3P+WWTX8psQcUqafnVc6gd/V+N9JcNOfIZgH55ZPGv3njqybmzy
         Ig5Q4uZ8dtePbLSU8tcbKz+IVB6qLYrDf0H4r6yYQ8UV0fARf23nW2CbuWxZCM0NCXiE
         JAPA==
X-Gm-Message-State: AOAM5333YbsZaw/ijmGMORrH/kAQUipcgQJOKBZpy508aaBaM3J33ea7
        oTGgvBzy8MV7p//bIIHEqPBPtQ==
X-Google-Smtp-Source: ABdhPJxlLaugH14+WpTAZ8MmbT2RoFjMZQ35niE7QMkyFmwOWotHwAsSlzZKvQdJTQZo0h/iFrNSrA==
X-Received: by 2002:a05:651c:ba4:b0:253:dfde:d7e with SMTP id bg36-20020a05651c0ba400b00253dfde0d7emr10774791ljb.436.1653386170432;
        Tue, 24 May 2022 02:56:10 -0700 (PDT)
Received: from [172.20.68.48] ([91.221.145.6])
        by smtp.gmail.com with ESMTPSA id y24-20020ac24218000000b0047255d21184sm2449009lfh.179.2022.05.24.02.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 02:56:09 -0700 (PDT)
Message-ID: <e7014cdd-5865-90b6-54f6-b0594839603a@linaro.org>
Date:   Tue, 24 May 2022 11:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/4] dt-bindings: regulator: Add bindings for MT6331
 regulator
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, lgirdwood@gmail.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220523154709.118663-1-angelogioacchino.delregno@collabora.com>
 <20220523154709.118663-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220523154709.118663-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 17:47, AngeloGioacchino Del Regno wrote:
> Add the bindings for the regulators found in the MT6331 PMIC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
