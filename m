Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23182590FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbiHLK5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiHLK5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:57:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F3FAA3CE
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:56:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f20so837069lfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=mChUjQTtXHpc2A+QlFmH2j/MWN0EZMkc2lSHpOXeQrA=;
        b=Y9ftosvW+/lXOfo2DHn/iOKLY+DKnzGTJ/du2uR/xcqHW5eEuf/MhEfhmLloPHjwCO
         oBbJry4O8PjVfaJ5FODDfz5T+LNbcxuJs5Gd0cZfk1nKVp8go/D2FeOtJU+2sXQ3rJLv
         NDSu+WYXb0U/rhC1Ph+3m/FOizpJlCkHFVx5wsNrFRYQ3UkbZpmeNGHh8sIoAnLenkh+
         vndZxXrtL+c/XXlsiLfZSyuiYiQ0KKvZJLZJgwiuvEr8HjkHJSwgAJa2LemBKUlEWxtd
         xISOy5mUZ7ESoOE8vzF8bHvZ0mY+jnuLvpJC3CsD/hI21t4DKdjdnRBgIcmxkgPQcgQU
         a5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mChUjQTtXHpc2A+QlFmH2j/MWN0EZMkc2lSHpOXeQrA=;
        b=4p0r1TPjIpjK6w0vs7gbw6ev1kNb8Y88Z/d47FhPPWiy0yG5dB1Wp1IZAUwLn+Sgge
         arKQRIF/Qi7PN9GgH7gOmNvchX/i4wzgAL8j6BBffeljUynaMAzRor17SbOJkl43Es3T
         TxER6Wsx4R+pySFD9FnRw1hBfO5/FS5MyY42eDL8EYy1j+IDGEDnAcgasvN6R6pPaamw
         Kk+wT5YwNNpoW/2lH6iP6QZfF2sGmWSBzneSYCFVCa2m8sCKC9J87G2gccmM1hfDJif5
         ZyUpYCVz6OazufXT9KnpmXzqVeRawo9tpxYYAZ0/NzTaVnOP5mLTVIOwj7ouLrHOpSYM
         LVfg==
X-Gm-Message-State: ACgBeo1D4dbX4cR+8ASGvnKDEGhzx76AFd8aNED/6NJ/RpmFvXtu4YfP
        8tep+px0WpXZp+8KBye0eO/raw==
X-Google-Smtp-Source: AA6agR4c+dqcuuneKDezG2XNuToIgmi+wQmcMT9vCnGaJvx1lSq90f0pUvfTgcx6kKuGrwL9SZQRYA==
X-Received: by 2002:a05:6512:3fa8:b0:48c:ffd1:625d with SMTP id x40-20020a0565123fa800b0048cffd1625dmr998883lfa.251.1660301817252;
        Fri, 12 Aug 2022 03:56:57 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id f7-20020a056512360700b0048b0f2dc35asm178317lfs.75.2022.08.12.03.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:56:56 -0700 (PDT)
Message-ID: <3a26be5c-04c5-cd67-1154-dfd7d99fb5d0@linaro.org>
Date:   Fri, 12 Aug 2022 13:56:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 0/1] Mediatek MT6366 Regulator patch
Content-Language: en-US
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, eddie.huang@mediatek.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, fshao@chromium.org
Cc:     sen.chu@mediatek.com, hui.liu@mediatek.com,
        allen-kh.cheng@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220812092901.6429-1-zhiyong.tao@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812092901.6429-1-zhiyong.tao@mediatek.com>
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

On 12/08/2022 12:29, Zhiyong Tao wrote:
> Add mt6366 binding documentation
> 
> Changes in patch v3:
> 1)change patch title

Where is the driver?

Don't ignore feedback:
https://lore.kernel.org/all/YuJsDI8rqkHuysIT@sirena.org.uk/

Best regards,
Krzysztof
