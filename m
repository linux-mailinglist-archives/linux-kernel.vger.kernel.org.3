Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019F8590ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiHLKMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbiHLKLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:11:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FAFAB1B0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:11:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w5so720528lfq.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Efu/CGbKWLuL1Oe01pB0RYSwFNW/cJjMMoDyXY2YB+8=;
        b=UovoUapPrLkcqnkkaewW2fA9sa7b0agJjyYN2uN2fyGJ/+5GXbV5mfm3DhIrXDv+TY
         bpYDRc4LEA+jkTWpDhNcFyZMxQhAN0XQorBeXLN/sxLMTBpm6fD2h9CNWCxvbhosu5Ew
         aQC8zR0DyaqoF+R6W1hrq3QUX+gGInRKpZIfpm+D1/pJxjKEvPMzQi89IqXkx0j+h/UV
         paWLdEDGCJ67sHBITh361Z6JVAR6cgDyKNUneB0HY8ZCqN/xl+qMt3yxHMET8g4vGPWn
         BQhc3GuptxmB3HdG+FlU105IEyDOmtk4o3ehXiqfu3DVnrbFKhe9yVl/OxwY0Iy06dkm
         f1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Efu/CGbKWLuL1Oe01pB0RYSwFNW/cJjMMoDyXY2YB+8=;
        b=qrz+3wq18kd+AzcMrJM1hPUN00xlA/o3hPvta5TJzaJvW+1l8hTeDJcOo3llcdFuyl
         av6dXTYf4N8diQz0RQQKCs9b3/lTYRlcU36UkwJWNLhJKuicTzPCwTnPFjWCSfDoZz83
         HjmHiU9cxA7WGbdxr6ADY3t/kVeXwXvpVkG0H/aYnVId1uxhxGdhlUuSuvdYmvFRxIgc
         ECz2adU+9SM5S9avLZ/QQhbIlQOSsLFax52Hp+Kxl2OANMGqHK0X5dZiDwMO4kpcJ7kI
         k3ZBA3FohwjS7htm2aINF71O+UsH9csNeWj6qR0hAeuzEETUQ9/lEVkGRy7cumR9ILnK
         kQaw==
X-Gm-Message-State: ACgBeo0IrOSuS3+JHE23mnJ+p2xEsDGXMV2zSJzYBWdqNTVPKBMEl1wr
        1XpZ0SaPi7y6xj8ZQJNxBlWNYA==
X-Google-Smtp-Source: AA6agR6OCwgKtAvaUtyDKb4jwrDWlW1JbYl8B3jrWJdzx5BDw4hWWiPHrUmCEc3VuMH3EXpbXKwoyw==
X-Received: by 2002:a05:6512:3050:b0:48c:e580:4421 with SMTP id b16-20020a056512305000b0048ce5804421mr1129450lfb.34.1660299090986;
        Fri, 12 Aug 2022 03:11:30 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id 25-20020ac25f59000000b0048b05882c28sm157345lfz.271.2022.08.12.03.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:11:30 -0700 (PDT)
Message-ID: <1153cb3a-4f1c-5a54-cd3d-13a1ca9992e9@linaro.org>
Date:   Fri, 12 Aug 2022 13:11:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/6] dt-bindings: i2c: i2c-imx-lpi2c: add ipg clk
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, aisheng.dong@nxp.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xiaoning.wang@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20220812043424.4078034-1-peng.fan@oss.nxp.com>
 <20220812043424.4078034-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812043424.4078034-2-peng.fan@oss.nxp.com>
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

On 12/08/2022 07:34, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX LPI2C actually requires dual clock: per clock and ipg clock, so add
> both.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml | 9 ++++++---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
