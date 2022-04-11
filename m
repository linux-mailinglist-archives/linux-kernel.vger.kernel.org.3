Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC5B4FB3D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244981AbiDKGj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244976AbiDKGj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:39:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7161322BD7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:37:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g20so17045461edw.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vzNjZUXGyvh4gu1a5eskzN2ZgAinNkq/VfowbMZKkRY=;
        b=n9tsVChRT1PVIqDW/MqDK2AAvs1Dzp1foGwlobVRiFihFy4lvDQG/DlNcqT7KZoBCw
         /b0cTlbdft9bB57n7QmxErwXwdW+oCBAIceQdsZl1SynUBR2d2DXQNpiSfUpWL2gCTlM
         fEnbLQP3oAeReSQqM8w8+/1LIrkSqlPl6XswAialCagtaqmTvdnjBRXvZt999cniBbYb
         wEPBtVWY0mWdCo4YIFofSwnP/9RtCGySUqGg5iQC8PKIhQCaoLUdc4bz/3ZoDPrZrE/W
         XCKJcdVDAII9iJRM45lmMEExa3pTLJOklS953Ygoc/KbNDSItyZ5i4FkcPwI3lOEQepa
         JTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vzNjZUXGyvh4gu1a5eskzN2ZgAinNkq/VfowbMZKkRY=;
        b=djCwMA7d+nSayhFQoRvtmT2SYiyrvliYH1UXY7Do6qAFIg5qpFtovRzXJu3pCG+XhR
         0plFkTLFy6ridMHJRB3lRfy9sMtxMKfL6TAR7dGfQ4OcGPDWnQLCR2OdhhiavdoJ1+8e
         aqcZ5PXYlY/1t6k3qX8tyc8vzLbK2wsmIqsPFgW0ghqj2fw/kqWIbeMwYuHThDX4fMpD
         01R2n9H2/nrgzWk6j1skZn3wobNH0BM+M/8X0fMQw20GEvnZSrNVhMSEhqyiNZoQ2Al+
         ti0mjhKfZACbQ+VBQmV6+6gmEHa0o3UZSql4PsdXz+nFAHbqFUWYhELdhlT1xJLNkOxz
         Jg0g==
X-Gm-Message-State: AOAM531rE1n3u5GSWY0E44wAB7xV4+shRVszUcYbrnivyBY89dDhd/bi
        sCcRlPXs5zWNM2GXC0gtZDgQz/hyF93bB0nn
X-Google-Smtp-Source: ABdhPJyxeX5ahiPnIwsYZpijDZ2+BJKM+oobLR5YazSI/pEHlQhHy62TVXuI5C0rQe+zdN6vXT8dmQ==
X-Received: by 2002:a05:6402:1c1e:b0:416:5b93:eacf with SMTP id ck30-20020a0564021c1e00b004165b93eacfmr32015436edb.302.1649659063100;
        Sun, 10 Apr 2022 23:37:43 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id z11-20020a50e68b000000b00412ec8b2180sm14586743edm.90.2022.04.10.23.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 23:37:42 -0700 (PDT)
Message-ID: <ba417ad0-a263-77c4-a7bd-a1e7c43fe6b7@linaro.org>
Date:   Mon, 11 Apr 2022 08:37:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/10] dt-bindings: display: Separate clock item lists by
 compatible
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220411043423.37333-1-samuel@sholland.org>
 <20220411043423.37333-2-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220411043423.37333-2-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 06:34, Samuel Holland wrote:
> So far, the binding and driver have relied on the fact that the H6
> clocks are both a prefix and a subset of the R40 clocks. This allows
> them to share the clocks/clock-names items and the clock-output-names
> order between the hardware variants.
> 
> However, the D1 hardware has TCON TV0 and DSI, but no TCON TV1. This
> cannot be supported by the existing scheme because it puts a gap in the
> middle of the item lists. To prepare for adding D1 support, use separate
> lists for variants with different combinations of clocks.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
