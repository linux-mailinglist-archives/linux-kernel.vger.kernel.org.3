Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F4D599572
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244112AbiHSGlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiHSGk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:40:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB55DABA4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:40:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s1so2138794lfp.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=GYmIScs4mfZnnjadeyNqjbuAo9aXiX5S9q/mWekMvwo=;
        b=oePyxO4oEX6xk6fav01I5vbNrZmR0ZxjmvJxpzG7j/fhw5AQsmMivprlTFsvMNCNBv
         Fr13vfWBVK8AyfWyS16INk1lTBeqG2aZKWXMKSGrNJ980Zh7R+kUtZTNLA7ETS2oXn/Z
         ZWNnjxUqOEknJp/RlXLQ9MztayQFPXFoFQnZQARR19zgZY5BtxtWeS7Y6w5jjclNHbXA
         +crZTAVzAeI+K/4vF7XgTTGPEwVPvTCpRAH8t2SGwobO6HUosJ/NMSHKV9Ikt0Ls9NPr
         +uDa+7U1zcBhhDmKyEvuNbJfnukQQuc2Z2K1fV1NB3mKytyN+hlSkdD7T9UVBqzRBU2p
         ESjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GYmIScs4mfZnnjadeyNqjbuAo9aXiX5S9q/mWekMvwo=;
        b=O/ObndGo/mp5hBKXLEVhuJVwSJL0aWTKDOXWAZN85FGx8ZZDgXfC+XbegC3evcWLEz
         ijEZ2xYY7PA2PFrg177+OrDzp/G4Bt2k74MJ4W0+iWaSI0yYAS3ujUXzVC8ZDYOHuNS2
         YBP5l/E2krk83wSmw6/StXT/bpPS7XC1/3oV2I2G3izXnP9vEmpE+Dvems7lYa1m2Hi3
         neoAXzkOJdL8rldN+BzYQIi6r1zJsoZuvps4gx66hxIyopDAUGAlrOvIt4cw/NV4yiSc
         87/xEjdIIz8PaQXshTUutrAoVrgOW3LPW8GK9Udlg+GiphIlHUUTkPo2e4oxPVXnnJk/
         nsuQ==
X-Gm-Message-State: ACgBeo0D2Ny1BD0hb98n36NCHOhk8+gze3sVk2Ki7D23KR48GvJ7cM2e
        Q4zwdWzSba98KOrkNI8gWmMXOQ==
X-Google-Smtp-Source: AA6agR7TbniMzGwqPEfAjokSet4E3Ix7OoannQIA8Ey+MTO2YQhuDAuk8GmTtGzWzCEm4xbLb4qHGA==
X-Received: by 2002:a05:6512:238c:b0:48b:132:8392 with SMTP id c12-20020a056512238c00b0048b01328392mr1877371lfv.658.1660891254460;
        Thu, 18 Aug 2022 23:40:54 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id m24-20020ac24298000000b0048d1101d0d6sm517427lfh.121.2022.08.18.23.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 23:40:54 -0700 (PDT)
Message-ID: <360087ae-50d4-3902-13bd-4752ddc80865@linaro.org>
Date:   Fri, 19 Aug 2022 09:40:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8 1/5] dt-bindings: mfd: qcom-spmi-pmic: add support for
 PMP8074
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20220818221815.346233-1-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220818221815.346233-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 01:18, Robert Marko wrote:
> Document compatible for the PMP8074 PMIC.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v8:


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
