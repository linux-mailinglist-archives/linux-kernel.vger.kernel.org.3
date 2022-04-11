Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE004FB3EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245007AbiDKGpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245027AbiDKGo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:44:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C093E28999
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:42:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k23so28747354ejd.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oeGY+i1594VzqaZYPeCwfNtowmuuBm84SvUo17g7pww=;
        b=UxJIcbi+k0bsNmAhFdx5LRRsGrLtn1cxDTlmkQ6rEecQxLd3ZlQzxbbXpBXlqGMqW2
         mcunz3PDYykTTMlJMvdGv4Pf0VZ+tO4dhzuj3cMkad/CJAfyQhY44MenyyiMs4zO9B4i
         GgLx+x1mfFRfOJwLXHFGacQUj38rWDNNamcoR+5tizxZXj1+kbnd3Qmg0bDStwp2AELF
         QqXJYc0ZMuaOkHcF+9nCkY+rzYgeOnqB7VcYdHcQu8MS2yal6THrzsFfHG3elJfIqqwH
         8iYXRWblSPgVH+ym5mLkJORVDKtpdrp6EtblUZ8AZZJcoxXKvneyiS38Xhy4kI7VZY80
         ABHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oeGY+i1594VzqaZYPeCwfNtowmuuBm84SvUo17g7pww=;
        b=VFuxT42cOTLC3Cu7+cKho7sRfHrmxegjoKCvmU27Ib1f4od9LUz2UYVfRNh2udxFDF
         b2Rq3dWtPm/wahC5Z9I79pu66HATQUsbwGAbjz8RM/gRPSifN9PEAZk0PzSHVBYN8nHc
         9INkgVlsMTF+7IpbCh39uiHlGS+sbV8EIDLvcLxr1CvAsAsc69JRT32f7FKbsz0t0ctK
         dKZhq1fUjPZJhuaKQslSYYzF5orsmnVpSQa/aK8AEhUay72pZpT9tF/DY4ZjsQc/F3hO
         3/1NJvw17Y0UgwElJtO1IAAHoa26VWrABTmWhPzKtPzuUqulo7z9hI9D/ll4KFwwe/1C
         +uKg==
X-Gm-Message-State: AOAM532hj+nunpOpUbz6QAuWlqiadPX0CFoRMFz76Y0U9jnEN4hGKIwA
        yKvHVFm4OnvZgKEgiWeEUtc0Vg==
X-Google-Smtp-Source: ABdhPJxWQegr0c/5XL0ZzwCad1TzFMKBUFGyQOBP0ER/rivBmSCr6Xyxq34fdHrUvtNT/lD5OtP94w==
X-Received: by 2002:a17:907:9705:b0:6e4:b769:286f with SMTP id jg5-20020a170907970500b006e4b769286fmr27845750ejc.728.1649659364246;
        Sun, 10 Apr 2022 23:42:44 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id r29-20020a50c01d000000b00415fb0dc793sm14810681edb.47.2022.04.10.23.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 23:42:43 -0700 (PDT)
Message-ID: <6c4b6eac-86d8-eb93-37a5-d0fa9bf2a7d2@linaro.org>
Date:   Mon, 11 Apr 2022 08:42:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 1/3] dt-bindings: mmc: imx-esdhc: Update compatible
 fallbacks
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>, linux-mmc@vger.kernel.org
Cc:     aford@beaconembedded.com, haibo.chen@nxp.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220410193544.1745684-1-aford173@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220410193544.1745684-1-aford173@gmail.com>
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

On 10/04/2022 21:35, Adam Ford wrote:
> The SDHC controller in the imx8mn and imx8mp have the same controller
> as the imx8mm which is slightly different than that of the imx7d.
> 
> Using the fallback of the imx8mm enables the controllers to support
> HS400-ES which is not available on the imx7d. After discussion with NXP,
> it turns out that the imx8qm should fall back to the imx8qxp, because
> those have some additional flags not present in the imx8mm.
> 
> Mark the current state of the fallbacks as deprecated, and add the
> proper fallbacks so in the future, the deprecated combination can be
> removed and prevent any future devices from using the wrong fallback.
> 
> Suggested-by: haibo.chen@nxp.com
> Signed-off-by: Adam Ford <aford173@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
