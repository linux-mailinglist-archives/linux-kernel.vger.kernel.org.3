Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBC05796B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiGSJwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGSJwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:52:32 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC4F1C902
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:52:32 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u15so16712598lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i4F6Wk8Wez3M9pBfPO1WuQ9P4fNtL3S/Xk6zBT24c7A=;
        b=rmar7Gg3UBw7oQJex2sityWWY/Yd9tT9qcgcI/xUl0jlCkVw7rJRx6WVnsHx88J4Ud
         kWxuezCAtZ6A7EiBMfG++rF/O15SdxKKOviJKN7HTzDLgoCAy1d8/XkJCNaPZNrn7rxv
         CUyGkw+isVAQ7QDm9qcXSTod2cPlDYb/TTWUVL+cNiB25AgXUcC6uaMW8A37r8wYhEss
         SJdPppqbWMLl6gqd3UkOnpAMRzi1OAj27Kk3vuF+Iutldz2tr2q5Fgmrej5DxgYTxC94
         pbEebJ+mkavhZ5NRHCMzpLY1wVSINOPoHJhwTlZ3D3USD2zuhQKdsHG6q1HZUXGLLVDz
         XeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i4F6Wk8Wez3M9pBfPO1WuQ9P4fNtL3S/Xk6zBT24c7A=;
        b=X2zmR/v8Jxa7ovAy+W8SGsGO6itLgH6Xx4dUzEOve1AXOvVaGyJB0o3viZFMQG1k8C
         WzQ61Vvj8WvnytYHu5IcQN4jiCLXUGjjofeNNLE5/qWRVmzAH0Fq1pYr7ucwe6MuSzfk
         3pzGDLYr5Ck6mQZfTCGfZ4wenwed9QCaIvTDV4gaS8TxjjPzDQcZPdKiqccdymw6LWoa
         LPVPkq92hXEbl74YkBgQWMFH+6simF7z557jWpocNYhtoJFg7r6Cq3wgtbvI6ZerMg3/
         dq+Ykc8RZaMM6JwbWknVYMMchuJiv8CFcCsKOcLl5xx2tunP5E1n/QeL8HX5DCM+gzo1
         t+aA==
X-Gm-Message-State: AJIora+BBSwbfa4XiHHJHe2BFtVKF5iijFBP93qWY/eHWhlYyuZNOziP
        AqpSrKFbq6W+1zELT2+2nsJI9Q==
X-Google-Smtp-Source: AGRyM1tnFNAbx9EsHdzGZsswnazSROj8KBMEvBkYQgRGv1a3kOI2QorJHqM5xVMdm/PiRlHGSNIp3g==
X-Received: by 2002:a2e:b538:0:b0:25d:881d:a10f with SMTP id z24-20020a2eb538000000b0025d881da10fmr13312563ljm.65.1658224350412;
        Tue, 19 Jul 2022 02:52:30 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id h32-20020a0565123ca000b00489cfd58ef6sm3133340lfv.88.2022.07.19.02.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 02:52:29 -0700 (PDT)
Message-ID: <1f1f8d60-7242-4d7b-d2d8-294c660018c7@linaro.org>
Date:   Tue, 19 Jul 2022 11:52:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 2/7] dt-bindings: soc: imx: drop minItems for i.MX8MM
 vpu blk ctrl
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
 <20220719055054.3855979-3-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220719055054.3855979-3-peng.fan@oss.nxp.com>
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

On 19/07/2022 07:50, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> minItems and maxItems are set as the same value. In such case minItems is
> not necessary. So drop it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml    | 2 --

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
