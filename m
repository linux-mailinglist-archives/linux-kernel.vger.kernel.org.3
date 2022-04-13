Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6494FF424
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiDMJxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiDMJxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:53:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C76045501
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:50:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u15so2753486ejf.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dQ79/goDpalmrbKGWpHc8ywC8O3UUFFwBvKk2izyfhA=;
        b=HKJvC+OdVBCwI7M8r8Xl6sxXN0w04siBjjFHRXajIWeUnZ++BwzVeawAx+IU2VniZG
         JHWh1QpLAN97RwdzZOrsS3ykAG3HevtNNJqVRoCPZySG3b14ePxfhH12ScyYCLigp9qU
         yIDBhg/AY6lsa2qhcifwSwvx+aPkur8PbjPdYQwPyq/PBXYEIKjbi+t+P1NozM3UO84z
         P0vI0E+xKJp9kVYJzpvBmy/6dLqSUKcewo9extQzU4+etgnpatnxdogss7ykoKiBszJo
         bhm/wrHZrjKCia4x8SAgUBwvDc6j5DhWBRAtQVRkArrO/FTuE+MeqgYHAU0ssZcsrj3B
         jDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dQ79/goDpalmrbKGWpHc8ywC8O3UUFFwBvKk2izyfhA=;
        b=iqax9zjvSpovzYGxb18fzhEqAmZRJSEUwzsHeTx0GPJId/zJb/yRnROYf5atkgszQu
         EOGVh6rT+MprXJKsfyqdcH8wTEbuMxpkARwvZM1mVgG3RJ+g8RGlLN8nyIqQM1LchXam
         H9QHKlH5EBAdD1cMk5YmKmvRUuXBywsUHoqAR9wgcYaEphQXuQ1eL8g68/9ixEKXToe7
         LHlSLct72UhxYdIui5n8LRqTTGPZc+CH+WWGiTABOZ7J1xrPjpghvhpdgu7iYw5+OMAI
         lTlgJ9Lakt/qIrUBJkYDyZxbwwNqwoRW/Wvf0ee7z3MPOeN/GU3bVYsANJws1Sk1zCl1
         L3QA==
X-Gm-Message-State: AOAM533B8V5KEj4vN9je/dCGGPmE4hfTZL3K8pY8flCs9qJphQ+II7ls
        rVt0ul22tbnglCIOZPZdY5xdXRCf9RfjHk55
X-Google-Smtp-Source: ABdhPJxH4jZNxf6EOHnhmswZgJE1d+1HZ9QArSUCchB2wd85R8TVgbEuXtHUVs2tSoObzRPfHfDXCA==
X-Received: by 2002:a17:907:6d9d:b0:6da:7d4c:287f with SMTP id sb29-20020a1709076d9d00b006da7d4c287fmr36966336ejc.741.1649843441859;
        Wed, 13 Apr 2022 02:50:41 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l19-20020a1709067d5300b006e8488d9a80sm6205530ejp.59.2022.04.13.02.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 02:50:41 -0700 (PDT)
Message-ID: <20428012-f164-c03b-fcc5-d3d8df812aff@linaro.org>
Date:   Wed, 13 Apr 2022 11:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/2] memory: omap-gpmc: Allow module build
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, krzk@kernel.org
Cc:     linux-omap@vger.kernel.org, nm@ti.com,
        linux-kernel@vger.kernel.org, kishon@ti.com, tony@atomide.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com
References: <20220411095516.24754-1-rogerq@kernel.org>
 <164984299612.34759.11981181842672620752.b4-ty@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <164984299612.34759.11981181842672620752.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 11:43, Krzysztof Kozlowski wrote:
> On Mon, 11 Apr 2022 12:55:14 +0300, Roger Quadros wrote:
>> These patches allow OMAP_GPMC config to be visible in menuconfig
>> and buildable as a module.
>>
>> Changelog:
>> v3:
>> - Remove not required MODULE_ALIAS
>> - Mention in commit message why we need to remove of_match_node() call
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] memory: omap-gpmc: Make OMAP_GPMC config visible and selectable
>       commit: 656d1be692be78b825954e0a2a47fcae81834633
> [2/2] memory: omap-gpmc: Allow building as a module
>       commit: eb55c7180be67774aa728a3c450de441e0dedb5d

And dropped. You have a checkpatch issue:

WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module:
Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
#127: FILE: drivers/memory/omap-gpmc.c:2664:
+MODULE_LICENSE("GPL v2");


Best regards,
Krzysztof
