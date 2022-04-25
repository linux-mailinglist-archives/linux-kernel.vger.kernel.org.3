Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A1C50DAA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbiDYH5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241648AbiDYH40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:56:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD652A706
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:52:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p4so1744140edx.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G1EEwSPV9OR3PwrucirkIopsjrE2Zt+VuxuH1o+sws0=;
        b=g4oAlia2jlJQAi6qpWUu/xsE6u6TzsW6fzAmcXqSR/a0DZEdffoSguPFsw2/59X1JQ
         GhxsVbccqmFL8GVI3lNN5/thcSv+hm4AU2JDKDO3P5ooYDuRddd7CmD37OHUgMYcTzfV
         19fp2um13sYkYrwR2LF4CJfEy0zY2mH7PtX2q4C2a9+aRWTf4or1/zDQ5UaHK6y6ddcv
         t7IyseTxXOyTIPHVo0fWC7dCTd88BRteCe57eoT/5jlNaCH/ZTKyLb0pssxspCLRuhPv
         JVi4QPs/MT/GKoSPvyL2b8gp/CqFKmycYR7Jmq9SMrWSHvJ97dC5dfl9tQmH5xBOWPKx
         OBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G1EEwSPV9OR3PwrucirkIopsjrE2Zt+VuxuH1o+sws0=;
        b=07Z77fceRx+zrurs0jDUsjjaH28aerR9O+YarL7aG4h9MOAfUCZyNAthbOP4L/bw95
         tlylSKhD1pqGNR89E5SFYRf0kQb28vSPTUgcQVE29GdV9e/Z7HshmUx0SZMR14gaDKHw
         Wgc3xPGRW8xFiSGb0mVyzN3NRAdOMMZmWBbjCZnKO5qAhnCjYaVZw4M48rnu+QZ4Rly7
         eDkTKKCPbfUC++/jZAE9v8x6GJz0LFd4yjUWx4omkutwqeUkHFN2wdPA5VCiauqT8N5A
         X5NqSWtJuXXjh3K15LObB8VofN+kiPRSBvwXXlfaNtdLbaQenpxImt3FolXLmmFTCcUG
         bzgA==
X-Gm-Message-State: AOAM532XfuGifRJUsPhIBr8X3nzKc39C7pZdK9BHseNYnXApIpHFjjtn
        bKen50oG77V/Dx2lgqsNNizT9w==
X-Google-Smtp-Source: ABdhPJxz3kWZkDl6FSThVokLJ4bTIeDew2DPyUD21w07yOl/NVskqg/AQ1XoobmWhZKSghrmtLVXmg==
X-Received: by 2002:a05:6402:1148:b0:413:11e0:1f58 with SMTP id g8-20020a056402114800b0041311e01f58mr17119200edw.113.1650873162160;
        Mon, 25 Apr 2022 00:52:42 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n16-20020a05640204d000b0042062f9f0e1sm4154445edw.15.2022.04.25.00.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 00:52:41 -0700 (PDT)
Message-ID: <418c5f0c-5279-41f5-3705-345ec9a97ea2@linaro.org>
Date:   Mon, 25 Apr 2022 09:52:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 12/17] dt-binding: mt8192: Add infra_ao reset bit
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?UTF-8?B?UnVueWFuZyBDaGVuICjpmYjmtqbmtIsp?= 
        <Runyang.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
 <20220422060152.13534-13-rex-bc.chen@mediatek.com>
 <e5b18654-ce83-44ee-e4c8-4cdfc4ceaa1d@linaro.org>
 <5ec37a01b0b84140a7d171b9a5cff7ad8f9fbe87.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5ec37a01b0b84140a7d171b9a5cff7ad8f9fbe87.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 07:01, Rex-BC Chen wrote:
> On Sat, 2022-04-23 at 18:28 +0800, Krzysztof Kozlowski wrote:
>> On 22/04/2022 08:01, Rex-BC Chen wrote:
>>> To support reset of infra_ao, add the bit definition for
>>> thermal/PCIe/SVS.
>>>
>>> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
>>> ---
>>>  include/dt-bindings/reset/mt8192-resets.h | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/include/dt-bindings/reset/mt8192-resets.h
>>> b/include/dt-bindings/reset/mt8192-resets.h
>>> index be9a7ca245b9..d5f3433175c1 100644
>>> --- a/include/dt-bindings/reset/mt8192-resets.h
>>> +++ b/include/dt-bindings/reset/mt8192-resets.h
>>> @@ -27,4 +27,14 @@
>>>  
>>>  #define MT8192_TOPRGU_SW_RST_NUM				23
>>>  
>>> +/* INFRA RST0 */
>>> +#define MT8192_INFRA_RST0_LVTS_AP_RST				
>>> 0
>>> +/* INFRA RST2 */
>>> +#define MT8192_INFRA_RST2_PCIE_PHY_RST				
>>> 15
>>> +/* INFRA RST3 */
>>> +#define MT8192_INFRA_RST3_PTP_RST				5
>>> +/* INFRA RST4 */
>>> +#define MT8192_INFRA_RST4_LVTS_MCU				12
>>> +#define MT8192_INFRA_RST4_PCIE_TOP				1
>>
>> These should be the IDs of reset, not some register values/offsets.
>> Therefore it is expected to have them incremented by 1.
>>
>>
> 
> Hello Krzysztof,
> 
> This is define bit.
> 
> There is serveral reset set for infra_ao while it's not serial.
> For MT8192, it's 0x120/0x130/0x140/0x150/0x730.
> We are implement #reset-cells = <2>, and we can use this reset drive
> more easier.
> 
> For example, in dts, we can define
> infra_ao: syscon {
> 	compatible = "mediatek,mt8192-infracfg", "syscon";
>  	reg = <0 0x10001000 0 0x1000>;
>  	#clock-cells = <1>;
> 	#reset-cells = <2>;
> };
> 
> thermal {
> 	...
> 	resets = <&infra_ao 0x730 MT8192_INFRA_RST4_LVTS_MCU>;
> 	...
> };
> 
> If it's acceptabel, I can update all bit difinition from 0 to 15 for
> all reset set.

Bits are not acceptable, because you embed specific device programming
model (register bits) into the binding.

These should be IDs, so decimal numbers incremented from 0, so:
#define MT8192_INFRA_RST0_LVTS_AP_RST				0
#define MT8192_INFRA_RST4_LVTS_MCU				1
#define MT8192_INFRA_RST4_PCIE_TOP				2

And what is 0x730 in your example? It does not look like ID of a reset...

Entire changeset look wrong from DT point of view.

Best regards,
Krzysztof
