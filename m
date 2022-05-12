Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E213524FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355223AbiELOVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355231AbiELOVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:21:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEF02C139
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:21:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l18so10543322ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gwwa4KEdZsBSVIiZ/u69uGht/OG8CUxR+7OXw5afM9A=;
        b=kKpsHtTMFWb7QKuSduAjkuTKGuBKLnVZAlGB9pHwkmj6zu0GHNa1piAzog2sZfXWVq
         SsykJv5I7rqCnx2C5Vu+umu7lKGRXsEEwkCZL/JpNSj4vKZqhHYvD+GCPOpT7Gz+O9s3
         q4fuVJINtOwaBuGubVBqax1UabAvSVWiKKzHEC8/DAxcE/UURqPoKahqVCtEETIT8bIC
         ihn0OOTZ0ZjHgcIdy48yrBvSKR47PW/NMP/fMPcqiTDqbdGlO51GtijSmARDMsuhyuwN
         00ADURgTXmcFTpeqM56tT/7R/tGxRxrjRLwpe59SIX+gbavbR9GvxVGJ534dhRomN8wR
         fy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gwwa4KEdZsBSVIiZ/u69uGht/OG8CUxR+7OXw5afM9A=;
        b=mAtDjvOSoYwyy5tllqfHGqRPiXJl/obFCuZ+Z8g/BROQia6OZP2h+KbHe4OUcA0pI2
         Oj/P8EPUV9AZzwQ4mG5OynsahuSWVOa8xKNlkQTvqFhNsE+CBd0SC0OdrOR+yXvYYIas
         i5fJR+NsGcvXNf0JgOvwTMODOOJ28g3yOl/ddkmMa1wJAe30pAc4B5tg1gqu1YdgNA28
         EF5Ihd8O86bHv2YijRRU3dYj/7IHnY3gku1sFjz3mT7r6MJFJcMfpsrvRQE7dHir8PRe
         SsVpICzmP+bzobqKSDL5tqfRplp7slwvFFbS35Satb7PopvrR2xj+Qgu8tDUixOpzBFd
         4tgg==
X-Gm-Message-State: AOAM531+qdvF9Piy20sBYp2ltIkGO1By40la/zeu5zbWHQ2Fm5LarOoU
        WEJZGml8KPWb4KJ5I9aXidf1yg==
X-Google-Smtp-Source: ABdhPJy6oM6zHB6ogbyacVZojXHJSVoOXoEbk7yyqF8wbuQPWR8uijnU02sDtFjZFSsAMWEdcDB8xQ==
X-Received: by 2002:a17:906:58d2:b0:6fd:daa7:3a6e with SMTP id e18-20020a17090658d200b006fddaa73a6emr176871ejs.0.1652365265105;
        Thu, 12 May 2022 07:21:05 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ws20-20020a170907705400b006f3ef214e5bsm2150543ejb.193.2022.05.12.07.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 07:21:04 -0700 (PDT)
Message-ID: <82a89be7-ea69-992b-ec66-3fba0c0103e1@linaro.org>
Date:   Thu, 12 May 2022 16:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 1/6] dt-binding: clock: Add missing rk3568 cru bindings
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220511150117.113070-1-pgwipeout@gmail.com>
 <20220511150117.113070-2-pgwipeout@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220511150117.113070-2-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 17:01, Peter Geis wrote:
> The rk3568 cru requires a clock input and a phandle to the grf node. Add
> these bindings to clear some dtbs_check warnings.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  .../bindings/clock/rockchip,rk3568-cru.yaml         | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
