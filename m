Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DA95A1C58
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbiHYW2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244448AbiHYW2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:28:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FF2C650C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:28:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u5so18475479wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:to:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4fJHGv3iaXn4YrsOEQKhsYHb3/IZjZAWjZREh6NdvLM=;
        b=AviMwmVyHueb2yt/m7DqKT8DZG4byAQE9sd+7THE7FRIrfFPbf2B1ZByaaUs4NVCIu
         QHqTxA9jT8/Bdd28oqodpNA7HXzlcxKnKMm/h4JxM+oXQPabAjM0KRHLhENNHO819SjX
         3u53j83uHtYU9eq0jcLACGXbkvJKswau8hvRK8Ksh2pkkE2cmyeW1HPnPRJeHLFP93S9
         VTwW82FDyu4WuXZn9jIFpOZSqwJn35IE2FHmixZ2M6G5vAjDqs+V3d7P7H/HlOwYDK9W
         BfAUKejlYmXSK4IwkG/kYLrBUuvcPhWjmZp05wfNH5PVBEjjd8ZwngGzzpj4/iMk8bJt
         4BUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:to:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4fJHGv3iaXn4YrsOEQKhsYHb3/IZjZAWjZREh6NdvLM=;
        b=lCsezyNnyxfRqityVqN+KHHgLStJV6G9H6Jcv34o2TA8u8/+3FSvlpUMmkA3PZHbow
         oEddoe2cXNy2SMSbxnLVAqatUEyqO4TiQ/xMecwh8QP11qsd1Rsn68w1eZWQnV+LQpoZ
         6eH+tJwsd68vyyQMXf3Xi2ZYbed/mYhv1VpZQFRf4P3g334uSe+LGNGNdSWFpcwL+Wsk
         pjdDXpdbB+qcMUSSdhElYDln+dgSA9toGwHXgFeya3UduN4Tzp0l/NTtE8Wn5/XeyEyE
         DA2UFIyDe4uvhqo4ZefvJpIH+2du18whF/Uiu/AFo4jJf2mGcsK5GFnmA9y4iCIpAc04
         pgmw==
X-Gm-Message-State: ACgBeo2kt42vAfc01foNLNpZbVcGIHsTIZjJ+LKcpcNTQB3tL/0FMeux
        qztG53cXH9k1uV8vcEZPYClnXg==
X-Google-Smtp-Source: AA6agR7IyaFg8Yjm2moL38WXZFoirIsIlMt7atLbpRul+dRGylh3lOoC/WxECD3W9ZrfaAaN3FNjvQ==
X-Received: by 2002:a05:6000:1867:b0:21f:f2cf:74a8 with SMTP id d7-20020a056000186700b0021ff2cf74a8mr3424635wri.344.1661466513360;
        Thu, 25 Aug 2022 15:28:33 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id y15-20020adfdf0f000000b0022589d133f0sm302537wrl.96.2022.08.25.15.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 15:28:32 -0700 (PDT)
Message-ID: <17d09638-01e6-038f-c3db-cbe02ccb9327@linaro.org>
Date:   Fri, 26 Aug 2022 00:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] thermal/drivers/imx_sc: Rely on the platform data
 to get the resource id
Content-Language: en-US
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220818082316.2717095-1-daniel.lezcano@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220818082316.2717095-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 10:23, Daniel Lezcano wrote:
> Currently the imx_sc driver is reimplementing part of the thermal zone
> parsing from the thermal OF tree code to get the sensor id associated
> with a thermal zone sensor.
> 
> The driver platform specific code should know what sensor is present
> and not rely on the thermal zone description to do a discovery. Well
> that is arguable but all the other drivers have a per platform data
> telling what sensor id to use.
> 
> The imx_sc thermal driver is the only one using a different
> approach. Not invalid but forcing to keep a specific function
> 'thermal_zone_of_get_sensor_id()' to get the sensor id for a specific
> thermal zone as the self-explanatory function tells and having device
> tree code inside the driver.
> 
> The thermal OF code had a rework and remains now self-encapsulated
> with a register/unregister functions and their 'devm' variants, except
> for the function mentioned above.
> 
> After investigating, it appears the imx_sc sensor is defined in
> arch/arm64/boot/dts/freescale/imx8qxp.dtsi:
> 
> which defines the cpu-thermal zone with the id: IMX_SC_R_SYSTEM
> 
> This dtsi is included by:
>   - imx8qxp-ai_ml.dts
>   - imx8qxp-colibri.dtsi
>   - imx8qxp-mek.dts
> 
> The two first ones do not define more thermal zones
> The third one adds the pmic-thermal0 zone with id: IMX_SC_R_PMIC_0
> 
> The thermal OF code returns -ENODEV if the thermal zone registration
> with a specific id fails because the description is not available in
> the DT for such a sensor id. In this case we continue with the other
> ids without bailing out with an error.
> 
> So we can build for the 'fsl,imx-sc-thermal' a compatible data, an
> array of sensor ids containing IMX_SC_R_SYSTEM and IMX_SC_R_PMIC_0.
> 
> The latter won't be found but that will not result in an error but a
> normal case where we continue the initialization with other ids.
> 
> Just to clarify, it is what the thermal framework does and what the
> other drivers are expecting: when a registration fails with -ENODEV
> this is not an error but a case where the description is not found in
> the device tree, that be can the entire thermal zones description or a
> specific thermal zone with an unknown id.
> 
> There is one small functional change but without impact. When there is
> no 'thermal-zones' description the probe function was returning
> '-ENODEV', now it returns zero. When a thermal zone fails to register
> with an error different from '-ENODEV', the error is detected and
> returned.
> 
> Change the code accordingly and remove the OF code from the driver.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> The changes apply on the linux-next branch:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next
> 
> I don't have the platform, so I was not able to test the changes.
> 
> Changelog:
>   v2:
>      - Clarified a bit more the changes description
> 
>      - Fix use-after-free and add a couple of comments to reflect the
>       patch description
> 
>      - Put back the error message in case there is an error with the
>        registration
> 

Is there any comment on this change ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
