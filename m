Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1FC58E822
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiHJHsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiHJHr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:47:56 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4736E89E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:47:55 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id j3so8089342ljo.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ws3xDmWAM6yboeXN1KDvG4lH4Cj9ukWxfaS0mjDB9TI=;
        b=DInQ/feLe7M5SaGVz//m1f7wJx8FFBjFujTtxG6gQNok0dAnXF+QgSnbgfRwOVpfIk
         B/i6MmVeIWkRHByz0kwb7Xj7b+tnxluDhjzQbhAoDP5D445Zp9cOX42+4a7TGx8fFvXG
         SbTW9CcXA0j4AwInxrywN40hRQnMHsO/inB5aJM0VNrpzshXhdbqa/b4ApqOajOn9BYp
         nTLJkp2IqqZ+y65dlrANSyZsrF4XPuWDXqbaqn49KdRxN6hNNghFO4oZsI+VOlS4ewTk
         rF/n9hlp86GYoY+dEkY6iwG0jb64mxu8drCe3jCq1y+YJZ4J4rC/xYXokdSVkfAPOHrB
         eg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ws3xDmWAM6yboeXN1KDvG4lH4Cj9ukWxfaS0mjDB9TI=;
        b=WXUAPDRM+iWxyksn9AujVSlOowmWgvEIP9kleG0KSX+KvlznlO85S4wPVTNxpmLoGu
         tJKUq4t7ZUXrxjNNmUPKM3J2CXkNaqyWwUGl015wCfLdI1tZColQ1T9P9I5dDYgy5Omn
         4jbGHQX+OxxzBcz2p2eg26Ri6pbtV4m1Wd0L01x8fNWlJtjdeVBQatSnIdgduB3M6D0B
         7naFOjpg0o/0OsCluZH6sdU4Uil1FBbTLkkXrw7ZPSW7Zu1Y3SOzQuUaFbHbmplkzeow
         r2JSBssYeLq/nlQKTuhVwAqwTtXZJmyWWfxjs8IiL3eV15Rh8d4FVK/yIlkp33Auuna/
         0cOg==
X-Gm-Message-State: ACgBeo2D7JjOmdCoRpIuLBQe98zvk0FSb/wsYa8pUCig5bhNXCz0udQz
        vYHVCjw4m6qDK2WuCXJQMDqbKL5L87NsMcC3
X-Google-Smtp-Source: AA6agR7qeW+xM7yDL4T6bfOZz3EvFkzr5m3lpWkyVtIYGJrOIdftBw2e8h3zgyiOQ8uI8cpU2lr0JA==
X-Received: by 2002:a05:651c:1990:b0:25f:ad63:490c with SMTP id bx16-20020a05651c199000b0025fad63490cmr4479688ljb.63.1660117673812;
        Wed, 10 Aug 2022 00:47:53 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id l21-20020a19c215000000b0047f7722b73csm243780lfc.142.2022.08.10.00.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 00:47:53 -0700 (PDT)
Message-ID: <b0b0fcda-e60c-fff5-7784-5dfbbf0141dc@linaro.org>
Date:   Wed, 10 Aug 2022 10:47:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] ARM: msm8960: Add Samsung Galaxy Express support
Content-Language: en-US
To:     Rudraksha Gupta <guptarud@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, david@ixit.cz,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20220808234723.5184-2-guptarud@gmail.com>
 <20220809000300.6384-1-guptarud@gmail.com>
 <20220809000300.6384-2-guptarud@gmail.com>
 <27f83048-ac75-97eb-c9f0-0829de30e1ad@linaro.org>
 <479a6fa3-7214-2cca-14b0-b9b335146168@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <479a6fa3-7214-2cca-14b0-b9b335146168@gmail.com>
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

On 10/08/2022 02:57, Rudraksha Gupta wrote:
>  > OK, I'll abandon the review. This file is really not matching anything
> 
>  > in the upstream. Please start your work from a proper upstreamed, recent
> 
>  > board.
> 
> I based it off of qcom-msm8960-cdp.dts. If there is a dts that you would 
> like
> 
> me to model off of, please link it to me. Otherwise, I will find another 
> recent
> 
> dts and model off of that
> 

From arm these look good:
arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts

Best regards,
Krzysztof
