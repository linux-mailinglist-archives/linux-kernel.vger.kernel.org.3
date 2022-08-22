Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FBE59C608
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbiHVSYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237419AbiHVSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:24:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87E9186FF
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:24:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m5so5796172lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=YUkvI1ao2/nZxDR/89eZVr7JU17ee6mwpioKOX/GLZY=;
        b=HMioaNJm47OPAgL2VVemQ/2Eh8rwyzmTnehI+gSZsKON0/Ef92tGqc/kO4FOnxLWaz
         nTgPQ9Fb3VCTZZfFGr59o/4dZLg9WLSQrgGgvCnWy/sqDk5Xh3Sznulj2UB7gmyP4yNB
         3OcmfFOQ0D7OcPj+MqWYKsMotG8eXQ0PhGpVEchXDC/QkBINwWSiaE7bjoGyWEzO0qs2
         weXEuVzxB2GdIasi9mZp7XX2x1LLViIX3WsUctS+E4Eyczf2wp8FGw8vEdLNdErpwJxH
         kdH6CXK/QKB/5hE+6oivPTJxqtULEBZmyJPrL2NXAyi8PzQkvyKv7EWNwgq5WIGeX00R
         9RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=YUkvI1ao2/nZxDR/89eZVr7JU17ee6mwpioKOX/GLZY=;
        b=SnREM6WMuitYn5ZXy2AAty14fySJhG3cZORs6zJGXZh1V7mgVEJzf0mXVVYIFV47rv
         /sbS97tKqzMjJN0n+nWUj/dAW3Q6DB+p/nxbTV/ftA6jcdWf3TBq80jvfXNT+816e2b0
         he5+0YRkONxv93BTEflVqiuahI8zcpXRVWlflzPEXw5M6nhaFlSyjinJkNEXXENPHcRS
         Z8LdRzDKoVagEqx7BXs0lRlwLE2RfaHEY9yUdAt32825uBiVhFK+Oc6rQNKjuKseEwLM
         vs5F71SsnP4RShuM8ml1nPS3qlE5zch6yiMegIcmt1NYvdOKHXU/NnhFxIBd0iWHKS5/
         KJpA==
X-Gm-Message-State: ACgBeo0KTj4NnIEI+4+Q1lTC49Vz/6DISWmWKkXf2W1ipEZ2pHXN6l3w
        uv3A3hEknTGGbKRXJKaafzAvWw==
X-Google-Smtp-Source: AA6agR4uFLXZY0ERbKcHpfiocsUDUUbWcub0EKPrxynySnRHxbQNoNycvPcmDV3IZvEETskrA5XK1w==
X-Received: by 2002:a05:6512:260f:b0:492:8e9f:c647 with SMTP id bt15-20020a056512260f00b004928e9fc647mr6944753lfb.443.1661192640110;
        Mon, 22 Aug 2022 11:24:00 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id g13-20020ac24d8d000000b0048af92aed6bsm1440151lfe.175.2022.08.22.11.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 11:23:59 -0700 (PDT)
Message-ID: <565960af-2c16-b066-c846-78fcce73c070@linaro.org>
Date:   Mon, 22 Aug 2022 21:23:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 05/17] dt-bindings: mfd: syscon: Add
 amd,pensando-elba-syscon compatible
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, blarson@amd.com,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, ulf.hansson@linaro.org, will@kernel.org,
        devicetree@vger.kernel.org
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-6-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220820195750.70861-6-brad@pensando.io>
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

On 20/08/2022 22:57, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> Add the AMD Pensando Elba SoC system registers compatible.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.



Best regards,
Krzysztof
