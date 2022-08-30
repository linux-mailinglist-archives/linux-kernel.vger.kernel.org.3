Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5385A5A5FB1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiH3JpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiH3JpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:45:07 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A44A1FCDC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:45:03 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bn9so10732855ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=N4LheGfogZwAoz4Rv/ngvYZ5qgXotWdDTgd++DbmjE4=;
        b=yMR844Oy9Ze/yRFGOhG2S6WZEqMvDZZHFlHeR7wdxfjeHJF+5QfyF0dGuHL6yp4fOv
         rdvMTpaNfQOfuWbxl/n8XZtzDwbHrmQL4gAMgF5UsOQAskIfHOw20OGjIwCE9Fa+DlHK
         DeKJg7zSZ220l4BZbyyAbdYz/9b/pIjRCMPTRWI0NHt9eTAOlnRwcf52BjFzEi6noU2L
         9cF1NkvS72kEfqAO9URotrJ4ea9X7yvpIEzevtnnb0t0h+vMwo6wSKE8uw8s5BLFUCEn
         p91Bb0oubgM6vyWgbqwV1uY9oeSlN2se9vAVKn5rjiFcdjWyRWsxxsNLQKnutsIFuPBI
         qewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=N4LheGfogZwAoz4Rv/ngvYZ5qgXotWdDTgd++DbmjE4=;
        b=RDtqQbi0MmAyfkOiwds4JVF+pqdHTAvLM2JeVHlZURBeJTRGqKheDwUw9LwiBYXQlz
         VvMXjmSFJrYeU1nk1bTrWnqCHn8wqAknZXtcJnLygUiUems8+cX5DsSnm/J/WzVlBwf4
         UNVRO+2bPvMaOjqwFhPBcpVKf91SbB2BgjpMzKNI9kt/LB2bIsS+q/Zpbpku3Q+BaPYU
         NWhSWlx0rkxgmEGSte927Ri4k2B7tBmFWCMKVtwMDW4qQvJCzlV/WdlTfyMQaDXLGeLw
         ESlEkTWj1Ph6VTJF87EihImT5WC7/A5/AChD3g/veRu0s3Aa6hUeqqVeyVL3JQzrYhTI
         CbHg==
X-Gm-Message-State: ACgBeo0nLm3FSSPieLz0R0akL9b+yl0K9eV5F8b4Qr+sTdxjIK7C5s/U
        dMsSomNnFKMKg90aA/mdcegCPg==
X-Google-Smtp-Source: AA6agR4jn6kVx3JsJKuIGOtqSpsDxFV6XeVfQe6nNwKELDQnsJHDnsIDeT+6VZnDMYThKJJoXi2+FA==
X-Received: by 2002:a05:651c:88e:b0:261:b5e5:8622 with SMTP id d14-20020a05651c088e00b00261b5e58622mr6375100ljq.99.1661852701925;
        Tue, 30 Aug 2022 02:45:01 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id f10-20020a056512360a00b004946e72711bsm552290lfs.76.2022.08.30.02.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:45:00 -0700 (PDT)
Message-ID: <9bbce65a-b955-cc76-ebba-266675c95964@linaro.org>
Date:   Tue, 30 Aug 2022 12:44:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 1/2] doc: dt-binding: mxs-usb-phy: fix
 fsl,tx-cal-45-dn-ohms max and min value
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        imx@lists.linux.dev
References: <20220829153124.2791210-1-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829153124.2791210-1-Frank.Li@nxp.com>
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

On 29/08/2022 18:31, Frank Li wrote:
> According to spec:
> 	0000 +19.95%
> 	....
> 	1111 -21.68%
> 
> 45 * (1 + 19.95%) = 53.9775
> 45 * (1 - 21.68%) = 35.244
> 
> Chanege fsl,tx-cal-45-dn-ohms and fsl,tx-cal-45-dp-ohms range to [35-54]
> from [30-55]
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
