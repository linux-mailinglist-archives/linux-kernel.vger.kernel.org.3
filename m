Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3139C512D60
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbiD1Hz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiD1Hzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:55:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B58113FB3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:52:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id g6so7903872ejw.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GdFNh01KnHdXyUQY0UlCve+IbfOnTdZcZpTYbx0W6OE=;
        b=GrUVXhq2FTHXUqJvn8n3SHTfwmAFU7hI3tCHKNBCJLCgO2uxtcnJg4Lcbe/7bm8OYB
         7PMBQhploWlCxc4klm662G9P0eJfsh1JaAHm2dwPk66A9jDhCRwNfIgDXuBaysN0VP4q
         1a4voEZD8Qd2rh/XrdTa2FsurAgY64rUww627XFliVs5gaqL7Qzb9DLfhpbHR11lF+22
         b1SJP3RfQs2Dmk12mTzLT6mZxe2Rg1woXiC/J0RQYSRNG8Cb1QZQsCKFEjhZHPlFZcPj
         GzROVpNJtiDqLWU9DbRdbSWhij5mgLh7LiZwDF/27Q6IocXz/S7r8Mxd4NcJC/4pAsNx
         3ajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GdFNh01KnHdXyUQY0UlCve+IbfOnTdZcZpTYbx0W6OE=;
        b=nUhx3cOZ4Ko8XuWaMosATjvqJrncbG/WvEufIMREXAacZWXVEZanb6PBhc89VSrR8v
         FfOZx0EdIQpLhh3HfmTJrJdqzABt8Z0W/X3DngZZkdN1NqwHUzrGEmkkWBjmH5j6lKLc
         /Si+jzRFSCUIIgecoUvvyQfyvFGY5gJlv0Cx2sZJSCs7ivlWCNjEkuqyVjlaoLAkxAIG
         vxYEyeIEcjqX2FHpDJSljyL4NU9lVNcrBySt5zlolwwIFcikdz77Oy9vvh9VIQIL33Mf
         Xq+Hhs6yBzWUGjBSIBuX0L2+2CCjuKqm5JSxSJU3pwK1z1ZnFs5nf9Iu0Bapn1TEurLD
         3LTw==
X-Gm-Message-State: AOAM5336ctbFMWBL1tzI1dBEVu7+7pEmYTQaGMHj44HHU23zI9xas1cc
        wpoPBq12yP7ILhWUCSiG4SKTmA==
X-Google-Smtp-Source: ABdhPJzKwH/FP2+g3iINJG8WBh0TBUXz2SIF9TozPDC3AqbgBpsu/3QYG4F4D103gYPQyA4lMnuMlA==
X-Received: by 2002:a17:907:3f0f:b0:6f3:8e24:e9e6 with SMTP id hq15-20020a1709073f0f00b006f38e24e9e6mr20150538ejc.128.1651132359706;
        Thu, 28 Apr 2022 00:52:39 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7d40f000000b0042617ba63b9sm1108780edq.67.2022.04.28.00.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:52:38 -0700 (PDT)
Message-ID: <eafbfa2d-ed2a-8b5d-5366-5f8b10c1ca98@linaro.org>
Date:   Thu, 28 Apr 2022 09:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/4] dt-bindings: net: silabs,wfx: add
 prt,prtt1c-wfm200 antenna variant
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20220426073511.1160119-1-o.rempel@pengutronix.de>
 <20220426073511.1160119-3-o.rempel@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220426073511.1160119-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 09:35, Oleksij Rempel wrote:
> Add compatible for wfm200 antenna configuration variant for Protonic PRTT1C
> board.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/staging/net/wireless/silabs,wfx.yaml     | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
