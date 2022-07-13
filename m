Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDDD573227
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiGMJL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiGMJL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:11:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E7DDA598
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:11:56 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bp17so10199283lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=saO2Vm+/KyaP+id6PNz07neSMyog2NEC8zLvu+tIFmM=;
        b=OzJImiJoAdCFlMCkcZjWWKX+Nr+zXuJYdDbRkrnViyRoiXtNb4r8yzK7RRQx+xzR/S
         jQgOn/ZR5XNLERq7zzE7yFxrmXVWodyd7Medkc+OH5NG0y4PC9Ie5wc6/vzT4XTgnoGN
         cAGAJQ7HoJmvMcbRvEZdOTxzTJSILaylDXxZNjJaj8d3BtgmB/HFjAozbnCbCtDOHUEp
         WRnJvLBpIMLJO2T/Pw7onHKfvP1mBejdWGwnnXXr3Qdr7SFiQ1G+JmT+P9I+cGp2hOnp
         nlOeQ973l0qXlLUzwtUr8VAR5CUAv+a+Bb1NBXZKBXh4wqEhG0pVK9CHR7ZlS9RkE/9a
         mYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=saO2Vm+/KyaP+id6PNz07neSMyog2NEC8zLvu+tIFmM=;
        b=mJrLXm4MZVmmqTMao95P16LLkss0tFKZDN9+BiAhYsHrH8cfYTf27SIkpXJ0p2kLVB
         MtBPuzbb61317X0sqA4JHyDGTPYC2fHike4tNtWoEJqnHhcVc485fdF2aZ7SA3Ynx1i0
         //oave+tmmwPSgOTmOykny9m87yjfoH0ArFlDQvxOUHnxDVSnWuT6L9rsDOFOjcfuZmP
         DQDub66aaSe6doMBuDT7F4SP8hTA71hyFTL24M0HCKDmd5cz9X4QeSCLC9a5ec7/fOID
         FiP6sPeSvF7XLgfVP5ZwfeOMNOnzfPJM29XXZTXfbxsuqYFAE0lk0NSCnu4yWNT6dL1M
         QtkA==
X-Gm-Message-State: AJIora9jil5yiakXGmruKBYaz0pvZrOxMokM6NrRGn5xHb9xajlInO5g
        7tNbego42l0ORN6t60pp606hkg==
X-Google-Smtp-Source: AGRyM1thb1RspXQrd9rr8p+Xg+Flcp6pMnFUTlW/oaoUlJ1Ds/9A2MeXytLAnYoXFEVBe5Q6Yt1dIg==
X-Received: by 2002:a05:6512:3daa:b0:489:d1b2:8b29 with SMTP id k42-20020a0565123daa00b00489d1b28b29mr1509727lfv.218.1657703514591;
        Wed, 13 Jul 2022 02:11:54 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id r14-20020ac25a4e000000b0047255d211c7sm2684080lfn.246.2022.07.13.02.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:11:53 -0700 (PDT)
Message-ID: <9ed772a9-ad01-55c9-fda5-5b3f8082bc7e@linaro.org>
Date:   Wed, 13 Jul 2022 11:11:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 2/6] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
References: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
 <20220713063653.2584488-3-peng.fan@oss.nxp.com>
 <52c0d236-49c6-7c31-abd8-2a083ca7ef8c@linaro.org>
 <DU0PR04MB9417D42EDC6FD08C10C164CB88899@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417D42EDC6FD08C10C164CB88899@DU0PR04MB9417.eurprd04.prod.outlook.com>
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

On 13/07/2022 11:03, Peng Fan wrote:
> Hi Krzysztof,
> 
>> Subject: Re: [PATCH V2 2/6] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
>>
>> On 13/07/2022 08:36, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> i.MX8MP VPU blk ctrl module has similar design as i.MX8MM, so reuse
>>> the i.MX8MM VPU blk ctrl yaml file. And add description for the items.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>  .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml      | 93 ++++++++++++++++---
>>>  include/dt-bindings/power/imx8mp-power.h      |  4 +
>>>  2 files changed, 86 insertions(+), 11 deletions(-)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-
>> ctrl.ya
>>> ml
>>> b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-
>> ctrl.ya
>>> ml index 26487daa64d9..d05930f61f95 100644
>>> ---
>>> a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-
>> ctrl.ya
>>> ml
>>> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-
>> ctr
>>> +++ l.yaml
>>> @@ -28,24 +28,15 @@ properties:
>>>
>>>    power-domains:
>>>      minItems: 4
>>> -    maxItems: 4
>>
>> This is not correct. maxItems must stay, but you could drop minItems,
>> prefferrably in separate patch.
> [Peng Fan] 
> 
> Ok, I will only keep maxItems. For separate patch, you mean
> separate adding description for i.MX8MM to one patch, right?

I mean, a new patch doing cleanup. You currently have minItems and
maxItems set as the same value. In such case minItems is not necessary.
You could remove all of minItems (when equal to maxItems) before adding
new device support.


Best regards,
Krzysztof
