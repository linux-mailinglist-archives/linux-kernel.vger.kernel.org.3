Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2552653A464
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiFALwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243564AbiFALwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:52:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653052F3AD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:52:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id rq11so3240057ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 04:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KrPBM8TYY3bOnaJ5976mXy/QINopFncMpgKZedtLopc=;
        b=FQ+Fc7v+kBGL/TcfPo0SfM0ECaf+R1RihcQJVHo+fqR/oFIXxBAsdTm1XLQExF9nK/
         rzunFmzcK5442KjBts5zAj3OIog/EkJIgEaRNXIDYMuN5OsMrQBYS+uazHJkTVz5YEkM
         Ap9ws9imrcR1nS+uES2BRFwIKHvKddodmZMFv6av4rxf8ZHRwXcKBk7OD1HF9L6UF4b1
         Y6aWfaZcy/XxOcUimzjDuoPMiv56Tug06FStSmAqsMG6Ckmr80RwIdSVu5KotfC3GT7S
         21Hm6Gs3Eh3cY9qy/jgwhHlHupg+ktmtgmtJ/tJ5vCjPcFzomaIhy2yp9XXnh6HZMLpo
         Rhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KrPBM8TYY3bOnaJ5976mXy/QINopFncMpgKZedtLopc=;
        b=m9BV6T4pitBBqwjRWEmpdZyvBK7s1pUYiIp0x5TUr/8/BQRZdSefgYl4SS+NofZb9K
         8lC+lC9uennajAwVjmhY1/HEhk+IsJmzUp+9ivBmBxkmKJhLLdHk+XJcETWZonECvh6j
         qy5wPZNB68p54iCpeOhequPB71g2k1htlJpeK9FFEBMCR/J3sf0FRIOzsuZlI0w/XpZs
         JstOjX8dLCcIsgITtMFZcC72+l1L9LSFaYCVLEM9ti5kGQHAYicnMofhBPN7iSFFEzVr
         /kBcLCgSsb11hIIZ1piaajO8gwA3uLckckrLvhCPfwAFcL6FVTBajv28+QPArChtNbLP
         D+0w==
X-Gm-Message-State: AOAM533h/G5QevCffA9mdBc/obhTTx7sSNBBKjGoZzeZiV5ZOkcEJTIq
        XAW4g8oFoTt4zvNjQfHOkxOwzQ==
X-Google-Smtp-Source: ABdhPJwL1AUUvBQLimLQyXaFTsUziUCg3CoLrAXDhVRFfvyOZhsYj8MqMY20SyiEIfDtXrnSFGIL5w==
X-Received: by 2002:a17:906:39d1:b0:6fa:8e62:c8a2 with SMTP id i17-20020a17090639d100b006fa8e62c8a2mr59097373eje.487.1654084358250;
        Wed, 01 Jun 2022 04:52:38 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id vz22-20020a17090704d600b006fedcc56b0bsm621280ejb.170.2022.06.01.04.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:52:37 -0700 (PDT)
Message-ID: <361c60ca-5c13-7437-46e9-b4b7cd78682e@linaro.org>
Date:   Wed, 1 Jun 2022 13:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/8] dt-bindings: soc: imx: add interconnect property for
 i.MX8MP hdmi blk ctrl
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, djakov@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abel.vesa@nxp.com, abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
 <20220601094537.3390127-3-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601094537.3390127-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 11:45, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add interconnect property for i.MX8MP hdmi blk ctrl
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
