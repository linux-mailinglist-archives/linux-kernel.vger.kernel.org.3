Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1F157A6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbiGSTIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbiGSTIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:08:17 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DE748CB9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:08:16 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id w17so18526677ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nZ4qNxokp8Oym010tUgpXEtM8QhLNYwGcy1jrounDNY=;
        b=J2Era1ZRgZZQpzGvrd1VjlSxTixMGB0BWEy5BYEfE2PltYFcIoomXRy50m71S/cJhY
         BDGA8PB16da1QVvk9+gzn8gIHEO1fOpa8TcIrAnteKEe+Hc0BbCLu5iJVb9e1CCE5S6K
         f01QKTMJvbJeDEnU62uqNJMa430OlUXAlcwB4aBMpiCwDnHk7W4vKr7HDP1M46tSfqwG
         xwOOOqGBy5iwqd9+vxpnQDuORKavWQRHHV55i6ia60Ty7ql5NG5FqZu83nKrnXdfqwif
         3m/LDxrAicfSs+DhvZ3CMoGPsxy9fXtvS9drfqgYPyuAr8b9bmfV1a4mamM7Y8ydstQ5
         VQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nZ4qNxokp8Oym010tUgpXEtM8QhLNYwGcy1jrounDNY=;
        b=f/oiOrh/+FeFaCN1T5OzR07NahAkeZzguDRxo0IXpwsQu7VgB3IIkcCxbbiT00jwDP
         WJIIHhz15ZrDvybjcf3SuE0jtC112EoWOTbwxnCW0r1ckzmTXMc25M+kxiw9NjWa9dIG
         dIsIjTil1vIKdtJaiYOukHnXA37vi4t1H10hNV5RFKWlD0vydX0d3FmbnyR7D1yuadq7
         I8IgVCXNeoHdqVQGqmqgLGMOg70biKNhAoZIPcyAXyZ7YyFpkueudnlAXp0OPmCk+cDq
         bPFNAi+REsaiPDUm25ootxcf0bev0k7+0zkTjKqEBEwn7j4i3jvKF6JR65u50I60kMV7
         0FAQ==
X-Gm-Message-State: AJIora9vE/c9grglFQNi2RP96LVBwsDYRPdZyLV0DgE2m/U3+nOn1qJR
        NwwPVMXnapsUpUIGGRQopIDhAg==
X-Google-Smtp-Source: AGRyM1tsm/rd8/uNsLQNtDlH5vnafFeHRttp8CRT/ZcNrlz+aYtZstlK05xqQWtZz6ihy48TcXrQVg==
X-Received: by 2002:a2e:870c:0:b0:25d:6833:e64d with SMTP id m12-20020a2e870c000000b0025d6833e64dmr15555680lji.71.1658257694449;
        Tue, 19 Jul 2022 12:08:14 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id h25-20020a056512055900b0047f79c636f7sm3340153lfl.167.2022.07.19.12.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 12:08:13 -0700 (PDT)
Message-ID: <9c1735bf-3f29-4bf1-f7cf-f9e211c505ac@linaro.org>
Date:   Tue, 19 Jul 2022 21:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 3/7] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
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
References: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
 <20220719055054.3855979-4-peng.fan@oss.nxp.com>
 <27ab24ec-61c7-cafb-6665-a16c58808649@linaro.org>
 <DU0PR04MB941796A54DC4932E5A58F4B0888F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB941796A54DC4932E5A58F4B0888F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
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

On 19/07/2022 11:58, Peng Fan wrote:
>>> +        interconnects:
>>> +          items:
>>> +            - description: G1 decoder interconnect
>>> +            - description: G2 decoder interconnect
>>> +            - description: VC8000E encoder interconnect
>>> +
>>> +        interconnect-names:
>>> +          items:
>>> +            - const: g1
>>> +            - const: g2
>>> +            - const: vc8000e
>>
>> Include interconnects+names in list of all properties and disallow them for
>> other variants.
> 
> I not understand well about 
> " Include interconnects+names in list of all properties ", could you please
> explain a bit more?
> 
> And there is already an "if" to check whether the
> compatible contains " fsl,imx8mp-vpu-blk-ctrl" to make sure the interconnect
> valid for i.MX8MP, so it is not valid to other variants.

Defining properties in some if: clause is not really readable and
maintainable. The properties should be defined in top-level properties:.


Best regards,
Krzysztof
