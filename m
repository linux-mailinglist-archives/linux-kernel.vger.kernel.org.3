Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC6A4B8B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiBPOUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:20:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiBPOUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:20:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58FE1B71B8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:20:00 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso3853258wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mSFzl3/wzkj8B4robF+rT58JmUNz8Bt1vcKE9GcyCwE=;
        b=qWaQazsWcyxf1G4B6EGDrfsseJJosl/k0UfpvosPf6n+J1HV/HjfQpC0Tom0QNZ1Rz
         1v9XhQsgMTvBE1hc0NKX6ff0Vc3EGOAkOuzxz8vVh8tYle4CSk3lf4zCHb/fe/0/c3uY
         sHS6/fw+6GxVTVwPcrUEmHOk9T2XIt3eovIQzFqFHEIO/6UpK+lOqvVl5Bg1aCo6cZD5
         f0PjcuFcRCBMvDWALKKIIQjtfgu6hxMo5ZleypdxwtmnEhRZDq7G15vHWYelkJVlzLfk
         kZYzjuqFAcsGE1UPH7jhvEtoFDxhP9CsSsTM/2cxWL/wybeup0lt+DZjHBgaIPaBTfbH
         baLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mSFzl3/wzkj8B4robF+rT58JmUNz8Bt1vcKE9GcyCwE=;
        b=zP4FHIIHrmNYVVmTrlWTd38/32o4AGm1iG2b8QDTN3Rdq8aCkfbKA+jo4/rqV5oAS2
         hK7WgQv6qJJXZMfLw1Mjd3BO/ExrYBofcNZxrh1xPqp+ZAoA2l8pW6SaulGY9wjsHfi1
         NqjodITYUasctab0wioHYrW6N5Y6bGTspAa2d5ICYaNeA3Aduw+oIBLTK7j0uO2K96T0
         LU3G8ywm3K5c/WLLelQ2ed3r31ZEiLQ8ZvVa0FpJntXmaxyEnNEIGAL1AatU10GsJyD+
         GU6rUQV2WQ7WjfuWH0MVAZzHbZBZVXzSU7jIja5tVpAqIQn8EXtijYaWMkjacXMXPJS3
         XlVg==
X-Gm-Message-State: AOAM533JWSsFUrzIpd53y6YZrcoF10cmWWKdcRwprHTOru+1LYvUqWUT
        G68xH4F5r4wDrxJ+wMtaoxiCYw==
X-Google-Smtp-Source: ABdhPJyU3J3lvMMCNLF0N2wQe96ZdbZH9SCrjsnTaZ2jPrJRpnULhe9FgIb+nWQxNkhcR+80fRpI5w==
X-Received: by 2002:a05:600c:3b04:b0:37d:342c:3696 with SMTP id m4-20020a05600c3b0400b0037d342c3696mr1899249wms.62.1645021199445;
        Wed, 16 Feb 2022 06:19:59 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id k28sm20051554wms.23.2022.02.16.06.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 06:19:58 -0800 (PST)
Message-ID: <e0d6678e-51a7-9c93-bcbc-abfbf38a8633@linaro.org>
Date:   Wed, 16 Feb 2022 14:19:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 6/7] pinctrl: qcom: Add SC7280 lpass pin configuration
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644851994-22732-1-git-send-email-quic_srivasam@quicinc.com>
 <1644851994-22732-7-git-send-email-quic_srivasam@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1644851994-22732-7-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 14/02/2022 15:19, Srinivasa Rao Mandadapu wrote:
> +module_platform_driver(lpi_pinctrl_driver);
> +MODULE_DESCRIPTION("QTI SC7280 LPI GPIO pin control driver");
> +MODULE_LICENSE("GPL");
> +
New line not required!

--srini
> -- 
