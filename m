Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8F452A556
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349366AbiEQOvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349402AbiEQOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:51:41 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6E819005
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:51:35 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q130so22067003ljb.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fItPi4WH6eFny62sNLwk0x/dSWz/KeliSihrZvDBGCI=;
        b=SKZXvVEkhFni6NzylNm4G0Pn98ecOqHdH6IY3kqNwRU5BDemhZl6Sv2QTHDZ0+a3xG
         3sHhiJ5rmPPO3CKqKQ+qHC+LALgxaG8MIqca3q6NaME1w9oWFnt/T+GbOubX0JaGfbVo
         I14YjlrOIt8p9CeG7NNfLtfQyn7Wnnutw46/dJDMRe72Vm5F3esQbw5nNu6drp7I4XmU
         GGF7duSC0YFVk5pOpwxrXEATYaGLxRMYwkyZOLlSvH/0pTPrgcbN6hd8ihEWvtLRpivt
         OKirjfEO/QElSePc92GOVlV0B/ybygpT8Kr5aP6WO14zg4+ZQbcPb5rFNiDmwhUncKBh
         QPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fItPi4WH6eFny62sNLwk0x/dSWz/KeliSihrZvDBGCI=;
        b=Np3z46a6tpSHqdXuFFxPcfRjgq1dCcDrDq+ZMwV3eVZek0W1x8XZyXVrdxb039s/rH
         YlXv5P8DYKREWV6Fn68swLjcZyOSRsUqgLtPni1feia/N0TCpAZT0i8srW9e5e0RayMw
         7c1ZoISjIMr5BwEiG7EqrTRy6zJx+0WTM7wpFO67LS+Ku3nxdERqB1bt6BEV/WlaBKb9
         YkYwyI2Yvn+UG3rm2LpVfdhN8XzlJwlrcvEpJxYaTxo5T8x87VRX0JJQiPC2Qnsd8ZHw
         v6cA/S+cxKF9ZCHBTsvJpg+Ck/kVuVEjMhbwvWfPZWAlkAvr/oTgXl9aaBgUU6hVJxmF
         /mBQ==
X-Gm-Message-State: AOAM530XoFbQaDMvg38XxgGmnnkZ/fRQFt1FO5lSYaGk5RTFNPRKl5Dw
        W9Ppu3VV8HL6JtJAmrtYMQbTQQ==
X-Google-Smtp-Source: ABdhPJyWm2Zl9OZhnOZge8xJaNB/lSejMQtbBHoeyzWsyXYfqc/xhWPGsDcU2RUdb22zZ0kRvGkOIw==
X-Received: by 2002:a2e:8e84:0:b0:24f:1d40:ceb0 with SMTP id z4-20020a2e8e84000000b0024f1d40ceb0mr14890942ljk.292.1652799093975;
        Tue, 17 May 2022 07:51:33 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d7-20020a05651221c700b0047255d210f0sm1607514lft.31.2022.05.17.07.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:51:33 -0700 (PDT)
Message-ID: <0f9398aa-ab7d-44e4-033a-e13bf57f88d2@linaro.org>
Date:   Tue, 17 May 2022 16:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] riscv: dts: microchip: fix gpio1 reg property typo
Content-Language: en-US
To:     Conor Paxton <conor.paxton@microchip.com>,
        conor.dooley@microchip.com, Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Lewis Hanly <lewis.hanly@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220517104058.2004734-1-conor.paxton@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517104058.2004734-1-conor.paxton@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 12:40, Conor Paxton wrote:
> Fix reg address typo in the gpio1 stanza.
> 
> Signed-off-by: Conor Paxton <conor.paxton@microchip.com>
> ---
>  arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-

Pressed send to fast...

Please add Fixes tag, unless fixed commit SHA is not considered stable.


Best regards,
Krzysztof
