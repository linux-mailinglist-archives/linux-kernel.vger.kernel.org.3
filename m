Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96389588750
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbiHCGZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236832AbiHCGZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:25:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8977751419
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:25:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z25so25031634lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3K6h/YOYCCWw9kAlWjAOBOB6ZuuzFpv4znwzHvvtW4w=;
        b=fVtRciBIn58GN8cGxH5kyQfk6enef1alabis1DCnj/wCSa7sVD4y+UUdeWEORYizoC
         +n+LTvYNgNTH9n2DD+qjJjzC0eTnV1ako23N+wpfq9wC3bKvfFYpVgGnfn+6MPYyqbpO
         1a5GtYgj9mZKk6dWvgNAtXgYdxDxqG6my8grPBeBwQdHpbTf7wNJ0fjm/vsmkfJ7lXx6
         +xCYev+c/0s8WZsXGS6NRW6GplulluNf0FSFZywX+Nv3Q8KsQYlZZGtG9wSsZTJiHf5n
         3G26OMgG8VeYoZ6VhgboXwf1tuLN0ECZTt+dh2HdURlRcvftjPgz4pc9/atd4B3s6/sA
         uVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3K6h/YOYCCWw9kAlWjAOBOB6ZuuzFpv4znwzHvvtW4w=;
        b=PyAL1nNQQtg2P1lpZI2nEPyU59PREyAA7t2J0QCU6s0QtiphUvYWxWAWjbCfO3QNBn
         rs8K2n0vPgeT39QfCsKwsi4TTY1x62DX9b3qXEK+x9SxbQ2kQyAYJc1jDboiUriwRHMI
         XwSUKtK753hbdnNM3Ui01jyANL8kNFbbZROPKkSyG0fNrzoLgtbYLiHYDh+2Rrk7oqf/
         U4XDouyBqZq7xtxkeAZENcieme6iFdK5DnJ3VqBkgiEOziEB8DTTfjtX82iUw5pxNgKI
         07o9q7/9VI5MMYLllKwOpfafBGykOcj2Q6Mlqv7YKAHXgznk4ydCWTWc+eIOH+sq7HaB
         O4eg==
X-Gm-Message-State: ACgBeo3LBRY3p3qi8HBBP1E9KD4dtEQN+vud148nh+lu5K3Aoi1FUa42
        SlkhD1aQSwWDbuVUnmn1qbSYUA==
X-Google-Smtp-Source: AA6agR4WeafjdprO3HCDuzZ13w+TlqcfYBSqcnjO5bmjDsudRBFKMrhsanZ7tktSRgTI2JJ7uxSkQg==
X-Received: by 2002:a05:6512:200f:b0:48a:ee15:929b with SMTP id a15-20020a056512200f00b0048aee15929bmr6779135lfb.614.1659507900854;
        Tue, 02 Aug 2022 23:25:00 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id o14-20020a2e944e000000b0025dde220a94sm2118102ljh.109.2022.08.02.23.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 23:24:59 -0700 (PDT)
Message-ID: <7f999d5e-ed95-65d1-f748-d14d8caf36f6@linaro.org>
Date:   Wed, 3 Aug 2022 08:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: FW: [PATCH V2 1/2] bindings: fsl-imx-sdma: Document 'HDMI Audio'
 transfer
Content-Language: en-US
To:     Joy Zou <joy.zou@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>
Cc:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220524080337.1322240-1-joy.zou@nxp.com>
 <AM6PR04MB592501ABD3A369F913137E1FE19D9@AM6PR04MB5925.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AM6PR04MB592501ABD3A369F913137E1FE19D9@AM6PR04MB5925.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2022 05:58, Joy Zou wrote:
> Gentle ping...

You already got review, 1 hour after you sent the patch. Long time ago.
Instead of pinging, please implement all the changes I asked in review.

Best regards,
Krzysztof
