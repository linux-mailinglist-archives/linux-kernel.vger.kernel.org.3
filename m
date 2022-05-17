Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAB952A42E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346447AbiEQOEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348386AbiEQOEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:04:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831A04CD59
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:04:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p22so2153253lfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HxevckGVY6484BDcCMWwYM+P+Lh2VVUYP1tDRnPQllY=;
        b=UmA6TUUe8O9+iPvqZ9lo899YQcmXeuocGCH2dwLlLprVVobAErQ9shCQc95jRhzSfw
         8YSg76gGX46QuDj0xF5mDZmoiIYAaNgZBFaJadAorojQsyTgdy5SGveX35f0t6zioVq/
         CycPQFhzltr82H1EJ9gJ/1PsGl8LOAqb+71rjlzYdRMA55K0T4ocDUWuIGACy9WfdlEq
         cUvYowSxcUbNBlZJvF9lPvb4fJUexPVl1lYetCTnSbQogKg7kDeVxsBzW5Wk2O09nWEv
         OIjmEuRzMsLDboh7w2yhUw1sKiu5HAqv0/XVND8xYkIGFsmcVz91t6uKtyFANxF2BhY5
         8TYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HxevckGVY6484BDcCMWwYM+P+Lh2VVUYP1tDRnPQllY=;
        b=3g8I9saTQzmRW8To0HO3ntqXQ7DSENWFexefCGXIaAqDwI2TFlKPW745Krdsn86Cyh
         tyLPW7WfuL6hwdtiftlFePStUFGQYil2UrDPQBeV5BnNpKzS23c3auLMqnrDuskaRknz
         CYk3iNYg5xFJpOuAggLV6aIyHEmoPjvzlTqOZQujslgeCICqH8ntQuIOxYsawqtpaRmO
         xMBf1XzlSQN7dYGlduaodiP0UWc5Qx+5I8jFwz6oPeUCpGIiXIA5MEdoAz/PmHBwIIPx
         dfhNGR33AIJ8/Qr5ZeOqWHYj5hGLY4W3LE5XqMI5o7za/9vjMFQZiVgdqw2nHDK7wYDt
         mU7Q==
X-Gm-Message-State: AOAM5303Dp67VM01LMiLaEv59UX9GA5GiHLBz5v8m3acjpTJ1igCRsba
        QSfJF78hJLIU8n4Aq0ESO2uZxQ==
X-Google-Smtp-Source: ABdhPJy+tyMS3HM225HxfOU5Ksranc+y83SOvuoAIRBZum36K0pUiei5sRYqAd+BViUCgfknOuW4gw==
X-Received: by 2002:a05:6512:228e:b0:473:dc4d:2a52 with SMTP id f14-20020a056512228e00b00473dc4d2a52mr17089184lfu.413.1652796267537;
        Tue, 17 May 2022 07:04:27 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w21-20020ac254b5000000b0047255d2112asm1601570lfk.89.2022.05.17.07.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:04:27 -0700 (PDT)
Message-ID: <b7dc85c5-acaf-95f4-2409-3c25d9fd8274@linaro.org>
Date:   Tue, 17 May 2022 16:04:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 17/20] media: s5p-mfc: Clear workbit to handle error
 condition
Content-Language: en-US
To:     Smitha T Murthy <smitha.t@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com
References: <20220517125548.14746-1-smitha.t@samsung.com>
 <CGME20220517125648epcas5p22201053e8a71dcd5ccc8d0566511b635@epcas5p2.samsung.com>
 <20220517125548.14746-18-smitha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517125548.14746-18-smitha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 14:55, Smitha T Murthy wrote:
> During error on CLOSE_INSTANCE command, ctx_work_bits
> was not getting cleared. During consequent mfc execution
> NULL pointer dereferencing of this context led to kernel
> panic. This patch fixes this issue by making sure to
> clear ctx_work_bits always.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>

This looks like a bugfix so:
1. Send it separately please.
2. Add Fixes tag.
3. Add Cc stable tag.

Best regards,
Krzysztof
