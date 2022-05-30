Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B3C53759A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiE3Hkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiE3Hko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:40:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76CF12ABF
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:40:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so5916679wmz.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yJvJHo6WigzGU+Bo8i27kFyA2o+86owNrCMmWJXdlE8=;
        b=W4BYSpqDTbHV+hbVi3/CpOCs7LKmmS1CEMqy5HUoFQCOguVArLULseXhFL/JULV4Vd
         Eo4VFd7b4x+y2HN+FG9NkKGbKnnzYv9OIxXTL73azJ7lf89e94vesObKZKJ6SiG28DiK
         yX+4TIXLGGNm4CbOsTeKyIh47cM0N9CAap+ck58AvLb4fOle8nYEtBohBK/A1//lcRCg
         j95vXrzs4gziXs4px9y4DJmEmCUvdTKEtn5YAjT5DF0RGNJdwZdXKibwfo3O9KTu/GT5
         F4vQzdeZy57g3bAEEENQ6e+tuf51A/HCUSKII8ir1NYFCbgLQPvxpmiXfZQFoTkLpec7
         8hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yJvJHo6WigzGU+Bo8i27kFyA2o+86owNrCMmWJXdlE8=;
        b=xpqCbjwYo86t+UxI4/6NZabGKWzjwtXpmkH/6yBL//xQ3l9GQVHg0HDgbB/DU6FR86
         DHKwRDUH6C/3JYI/+AvP8cOujI0WEzL3GPiNjALr0fqcOkLLzqGRUM85bSXSZGah3E69
         rO54udhCzupL1QPfwgz7FSBsdxfrycOK8HOp8O8TKGAhoZzddBK/TRfxEDpIyY1QsDQk
         DlfWjBXYq6C4cJn2tORWaO5xckGUQkK5KcNwX7sZ5cFh9w0vOThrbrTs5OYwP290zw4K
         84qN4LJn3Dtyyg0Sz6Aw0b8DRniIZXQE6sli80qPdYilQsjgp2h91bumDJ7fz5YQ0ho3
         je3w==
X-Gm-Message-State: AOAM532YLp5rXsQVEp0DqFWFVHWM5CkRWukZMc4zhUyKEVi9sRwTx+o6
        T/zq1HsY6NDZo3PrRhYc0mrJtw==
X-Google-Smtp-Source: ABdhPJzWZl/XXPcljunVWHqjNPh9NxSE5LyrBrelvogQHAI/oaz8TISreCp2+FfVSpBlEvS/xcf15Q==
X-Received: by 2002:a05:600c:6015:b0:397:54e1:8279 with SMTP id az21-20020a05600c601500b0039754e18279mr17451068wmb.100.1653896440461;
        Mon, 30 May 2022 00:40:40 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g13-20020a5d64ed000000b002100e86319asm8647487wri.78.2022.05.30.00.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 00:40:39 -0700 (PDT)
Message-ID: <9f40d587-bfaa-a3cd-d261-a10d1740610d@linaro.org>
Date:   Mon, 30 May 2022 09:40:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2 1/7] dt-bindings: soc: add i.MX93 SRC
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220526123411.270083-1-peng.fan@oss.nxp.com>
 <20220526123411.270083-2-peng.fan@oss.nxp.com>
 <2e6c2995-9204-61fa-0aee-f4ea4cce084c@linaro.org>
 <DU0PR04MB9417353FE7BA649887E7C5B188DD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417353FE7BA649887E7C5B188DD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2022 08:57, Peng Fan wrote:
>> Subject: Re: [PATCH V2 1/7] dt-bindings: soc: add i.MX93 SRC
>>
>> On 26/05/2022 14:34, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
>>> resets and power gating for mixes.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>  .../bindings/soc/imx/fsl,imx93-src.yaml       | 96
>> +++++++++++++++++++
>>
>> Still wrong location of bindings.
> 
> Although it is called SRC(system reset controller), but actually
> it not functions only as reset controller, it also supports power
> gating of each slice including slice's memory low power control.
> It also includes some system general configuration.
> 
> So follow your suggestion in V1, I rename it as system-controller,
> but I not find a directory for system-controller.

Therefore I propose "power". 2 out of 3 functions (reset controller,
power domain controller) are related to power.

Best regards,
Krzysztof
