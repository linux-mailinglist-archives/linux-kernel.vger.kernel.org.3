Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C40D54D5D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350314AbiFPAKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349105AbiFPAKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:10:41 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64F2201AC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:10:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s135so12819416pgs.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=smnI5/KZqn4T0Y3acDrDNmBdZdDmzLTUeEP1PHT9fv8=;
        b=CVH3RAAQOIA6kzUiBlfSmaNCh9ufVONPcY13uY0Am43u8ecNsTqxBlYpa192bLQgzr
         xhsvTR8Acc/42MtTzLoajZL/QHfUivV063RDMYiNFQmklgBQ0jTgzI73DkQLZoatDCgy
         f7LEhcgp+mOYHR19ttNbLNACGvsEfVK31nq757OxgrxU6SeSIRCpUqm+WNp/QdTASa9t
         K303mUBVpWjjJ61rM671VR6NbTnLYDdko0RiACe1T39px7k9Vozk5Eg+4FfKIvmDptQu
         aBs8aDVuq8doVS2CMsm4Q9j4gWCFXgfX9+E+yuxvuIlnlszRnZ8UX7uL25S40/2+4/U3
         KZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=smnI5/KZqn4T0Y3acDrDNmBdZdDmzLTUeEP1PHT9fv8=;
        b=HGrzhPRHgrK3luhV0/6N9oUxxDNPMHdf7McvSUNpo6N9rh6lVgLU7TfZ7LPX99vUCk
         mWelP0bdXTmyxGUSdFy0L9p/Orhv1zq0TT/W2MCCUu9ChMnaDzYnV8vIFxqh2FDRl3zP
         MkE8uJi+EJBEYqkZzAg5gMBmQ0YVhi03tPBEmuqt2D0M7kN802O0GAqmYY3i3hCxG/l9
         SYVqFMSXxO3MEYVfk46MzQid2Gr2rfJmvxAqept8geKt1miDPCrddIlPdwhnSZmwdIVM
         KuTIzCNMD5fUpyEluY9owQpx/++0KY05dAbiXD1Wy4sBzkwCHl4oy22ms94E6F7ZCd0V
         7y5A==
X-Gm-Message-State: AJIora/8MOO3tL0BM2MaOATFmcL7qawgPRg7yWInmHn4cMZZDj2yyFVc
        dhM9K9RNkVY5/vpziu+DzlQjFg==
X-Google-Smtp-Source: AGRyM1vipDuzSEy2Gjkm1q4yLpq8N5RIlLCuk0RCGjNdr9B65OgpnHP5mq4ZOzmR5jDBis6XpUtkXQ==
X-Received: by 2002:a05:6a00:10d3:b0:4fe:5d:75c8 with SMTP id d19-20020a056a0010d300b004fe005d75c8mr2004836pfu.6.1655338240227;
        Wed, 15 Jun 2022 17:10:40 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b0015e8d4eb242sm209308plg.140.2022.06.15.17.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 17:10:39 -0700 (PDT)
Message-ID: <693d4263-680e-5332-6374-3edf35c69fd0@linaro.org>
Date:   Wed, 15 Jun 2022 17:10:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: rockchip: Add Radxa ROCK Pi S
Content-Language: en-US
To:     Sjoerd Simons <sjoerd@collabora.com>,
        linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com, Alex Bee <knaerzche@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Levin Du <djw@t-chip.com.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220614064858.1445817-1-sjoerd@collabora.com>
 <20220614064858.1445817-2-sjoerd@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220614064858.1445817-2-sjoerd@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2022 23:48, Sjoerd Simons wrote:
> Add entry for the Radxa ROCK Pi S board
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
