Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08055B03B6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiIGMOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIGMOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:14:45 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D7E1D337
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 05:14:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bt10so22140366lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 05:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zZzqtufc9pXumP3kLw1eVRjMAlOw/BriOOcyNHuUsjg=;
        b=Ltdq21ViB9l+MyMWGdX9+o4rZDgUZXtEyBbotztaRlm02W37Q9qmyAps0gEGDKPYCY
         g1M5Vgk6P9JxSSGOmPMhHFF+8rzT/kzjZVQG2PHuJ6wWoA8017XVen+8cTxd6iycs7HO
         SvVCnEm9Bj5VBvyPei3r/kLA9Ys5HRH2y5+UfVZXGAvm+VD+eDKBNSnLoB87jO+g89gE
         1fk6cz05WR/HVBLLZDxc2/oUYwQnyuDHXRXjpmXmXsOnG0FS7ViNwTrHARIMgh4D76q9
         hSY+XXEea664pPPkwaYRkJZgDoK0rEnkjmghzNxxBkUGiNClXXO9v+VzEnNiwDOi9fDf
         db0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zZzqtufc9pXumP3kLw1eVRjMAlOw/BriOOcyNHuUsjg=;
        b=K+nQ4De+THdm7fUXWSHPwb3j/2OLMqNLqSP0tu//M01r9e93webukGr9Ryx/y8aWRb
         H8s47iWXXxL6KhOiJK/gDTvf7WwuWiTJPQ58p3MQRgaUMFpcz2LFNJqXKAL62Okrr0Tt
         ROIaDazjvxtNON0AKzJKm8NDCDTRzRYjD3DI1LElXEl0eenL83HpH8PLcnkW9Vyfc+Bn
         Cm0eihxcnsvLRwBFrYSluWBUYrjIbJ5XtJOzWXRqzWct5XtDsGZ+5TCdU7IWRsumiYd3
         6qxaZYkOX8O6acwRmptbAhL88+gN9B0zFYPaUoFqpiCZPHU2nvJGadtOP3pwFD5mBuQb
         GRiQ==
X-Gm-Message-State: ACgBeo1Utrh/Fd9MIJfTcGKNuRXzq+KOmuXoMYH23UWe73C7Hjcfnv4K
        3lHKTIUy/2C6wnjaTJTHqJT6sA==
X-Google-Smtp-Source: AA6agR5aK9jdLoFGwjPAeb2yNhm/clrv4Ru2F09dJXwQnidxUHmd9cz+E8BxX9OwpKd8nInK5AsAUA==
X-Received: by 2002:ac2:41c1:0:b0:494:65a7:43ef with SMTP id d1-20020ac241c1000000b0049465a743efmr1127115lfi.592.1662552882549;
        Wed, 07 Sep 2022 05:14:42 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be11-20020a05651c170b00b00261800f0e02sm2597096ljb.26.2022.09.07.05.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 05:14:42 -0700 (PDT)
Message-ID: <bdc11331-04b4-3b98-00f5-90e2db0bee94@linaro.org>
Date:   Wed, 7 Sep 2022 14:14:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V4 1/8] dt-bindings: mfd: syscon: Add i.MX93 blk ctrl
 system registers
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
 <20220905055915.3878000-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220905055915.3878000-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 07:59, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Document i.MX93 BLK CTRL system registers.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
