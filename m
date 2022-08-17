Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282C7596A16
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiHQHKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiHQHKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:10:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A9B580B1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:10:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id o2so17938964lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=mQIBDWQrbW6aJttTuVaA+q9WmwS0+Cm5tvawjfR+BGA=;
        b=RlRJrDhBOvdxdnDqyfALO7W/6W+qZkPR/3fG1qR/kgdZfpypB2ngBhq79koNYlwDdI
         hA2g8x4hOzRHD1QVdoiO/63TSj/m8/x8zS6G2yoRVwa2QEcKssNJSjIqTvJYxC3YLO5g
         jisWUGBb9RPplaSYpZc0rUdsXf1My+ydwycM7dnvXEHHuEUUuSjC/fqyIgnkQMTWm658
         JfoSCUmqG2LTExVID6GqJULJLPWEnaqiGqMt837+kbXh3sPXBWsRsaLbp9Jb1ovYCmDq
         Egz/6UMX/SUcuiXZWWZHnpmHLCrNeQJ3WA0NgvQbmVvzOnvHSJU2Z0xTaxteBMwgeQIZ
         1Hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mQIBDWQrbW6aJttTuVaA+q9WmwS0+Cm5tvawjfR+BGA=;
        b=swwfzfWcwDTQzjMhOR/DnttnCa0w+5uPac+9G3UHUO7kK4N5Nct55YCMfk4dZAPWAC
         eo+TzIxfL0mLxxnvzj7ceAkMvw5ORBbJ1Vu3711t7GZOB0ATPdM3sC5hbhHq19ZEQNWR
         7+tAYQmNnXhczcIgW5rQK/RLHvYcv8l7wqzRk7vz8l3h3SmKZ4hPfxw0SbkOv5rat8ki
         VysF/RNxkMae6/eyt3DXHSrY43uzTZIn/qT1ZsHLzI8ofjRjb1AxivvmzHYiJd/+2y5m
         HSvF5C/EG+YODu7krSUYS8u0FQVwn3j6RGWlntmIJH9iluyaY2dA4Yi3aj/J4At7JmEn
         2Q7w==
X-Gm-Message-State: ACgBeo35EN1IuIvf5jc24++x32A8jvVRyeMvUd2L/w63Mb5fwEGsjM5J
        11wdKtIrTB1TBDddTcW83IXz1g==
X-Google-Smtp-Source: AA6agR7dsLUKD20bSQscM2N94MIbIs69NzWDIN5D+imJ//4K2xLI7HJcN0bnp69QKoNnM+lpHrLQYw==
X-Received: by 2002:a05:6512:68c:b0:492:2f73:6135 with SMTP id t12-20020a056512068c00b004922f736135mr5680881lfe.480.1660720210162;
        Wed, 17 Aug 2022 00:10:10 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1b1c:14b7:109b:ed76? (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id b14-20020a056512070e00b0048b97c7260csm1588802lfs.222.2022.08.17.00.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 00:10:08 -0700 (PDT)
Message-ID: <17b5d8e5-7d5b-05f3-e960-8a87a1183f71@linaro.org>
Date:   Wed, 17 Aug 2022 10:10:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: memopry-controllers: fsl,imx8m-ddrc:
 restrict opp-table to objects
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220817062519.20010-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220817062519.20010-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 09:25, Krzysztof Kozlowski wrote:
> Simple 'opp-table:true' accepts a boolean property as opp-table, so
> restrict it to object to properly enfoerce real OPP table nodes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Typo in the subject.

Best regards,
Krzysztof
