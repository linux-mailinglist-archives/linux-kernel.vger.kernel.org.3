Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310DD53C624
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 09:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiFCH2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 03:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242336AbiFCH1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:27:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28CC1B7B1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 00:27:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z7so9022814edm.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 00:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Jd76VtmSmClHv3XW7dO/sxlgNNXfb30aONvGxgcGGRI=;
        b=Zt+rmusfmV4beR/soXDl8zQNiCFLUMHLCPLDU2AeYa/025zuOoAhv6LPQ0cx1TDaY5
         ovTBh2TRD6f/liL88kp8mJCDm34n1mUo41QwseyGgva2bbdym6IMCYCzkO2a5rt5GLxI
         ikfKR6tg//+261a7w0HYMvj3D+ttxOFn+dt2aQ8LeKlOfCprDHuJyG/PXspOTvPHa6yt
         WV5FTwt7EGiC9IRleSEITM7EYVVQQW5Tw7/vK66+01w9t13ydKPFJZMnLex1VKchakZv
         Wa9GEQk1n7LcLE5Z0Q+xgZ3NrQyZ4O3BT7YI5/w1m0apMP/iRnQbPS4OAfvMa1soP6cJ
         m3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jd76VtmSmClHv3XW7dO/sxlgNNXfb30aONvGxgcGGRI=;
        b=ZZCsJXmqTgwmJqXoj1XE6hGGthbHBjlyo7KPwx/kfemiCV33ohIPa0cOOpa/n6jblo
         U7dMoVWwdvujyMdbo65MaQB3GW9VbYDqJp0WTNXILlAj1VEpdOIengXVMtDdxBdyJLQV
         MK7jrlZ++hhBLlyS4tX3oD0Dqo1nF0PJuIEIrEsRgyN6vllv4X2C93B+DCwnxnroruhs
         FJ97IDypd4OyUcp0Oj9mVdYgjV2TyQPvpyZFa5KLGNioLS4gtk9bHuvt5xD2L321fqMw
         5QYQubZmJSssBFBJbvQ6xUzZ9nF2expkkWX6mf8LnAXwRuG4BxZ8hrI3I4JTLA8YplOD
         aGjg==
X-Gm-Message-State: AOAM530ig2PQXtGYzh+jStYQTbdF/uYIqrKTmbW2Zo2kJTDEbu5KlmPt
        BfbN8CduQyXz03kwgYNGTEi8ew==
X-Google-Smtp-Source: ABdhPJzAwOGfSTL5m0VOdLgRjc1LkQSJY2TUpxkHqaWXjpO8cwztVtqFIt97bovXMdlmpLjNsmUPOw==
X-Received: by 2002:a05:6402:241d:b0:42e:8f7f:3188 with SMTP id t29-20020a056402241d00b0042e8f7f3188mr1093395eda.78.1654241254461;
        Fri, 03 Jun 2022 00:27:34 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n24-20020aa7c698000000b0042bb229e81esm3526495edq.15.2022.06.03.00.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 00:27:33 -0700 (PDT)
Message-ID: <225fec01-9775-6ca9-8483-15474b8a1563@linaro.org>
Date:   Fri, 3 Jun 2022 09:27:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/5] ARM: dts: socfpga: Move sdmmc-ecc node to Arria 10
 dts
Content-Language: en-US
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amstan@chromium.org,
        upstream@semihalf.com
References: <20220603065816.87952-1-pan@semihalf.com>
 <20220603065816.87952-3-pan@semihalf.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220603065816.87952-3-pan@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 08:58, Paweł Anikiel wrote:
> The ecc manager is a part of the Arria 10 SoC, move it to the correct
> dts.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.


Best regards,
Krzysztof
