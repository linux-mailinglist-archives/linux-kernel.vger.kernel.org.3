Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3483546B0A5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243751AbhLGCg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243541AbhLGCgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:36:25 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D7C061746;
        Mon,  6 Dec 2021 18:32:56 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id p19so12866690qtw.12;
        Mon, 06 Dec 2021 18:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QQzMbHoCIHQcabSUmv+A+cuD+7qIgSkwyMRvoh0L3Gs=;
        b=h7KB6b3EX6ARdK4WUecjmEHeiKvtwdiOJ7RqH4PFeXYLLgP5MFzWNcJCmTMsW2Qo9e
         CxdPOqBqWoCHISCIxvSQ0ZrXeU25dZarYGcdEbiNY3YIS7IRhpvfPclamQsoo72hliNM
         +Sf+15JVxmE7F4MdCgG+wpcrZYcyr+er6kzGOCYufjK8QdcK1QuGeKaeK7+Rl6/hoFYn
         Zx9vsSuzXJGAnzjB4Up5+6FxQ/U6XwLVENAv2jdmqWeuqqGNg9lTY7V2yNtCAJYSXWu5
         f9mlC+tPdrnFk+OSsHHemX5Z6RX15/hRvxG4cphtCyNBmT758Co+yb2EabAy2C14lxym
         TVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QQzMbHoCIHQcabSUmv+A+cuD+7qIgSkwyMRvoh0L3Gs=;
        b=AJVlwyi/l52Rxc/dq7la/vfuB47U1gG2PUIBPSDmB5VZB9qDfQ7nRBpTfLNRmfpLBg
         74Rh9OGWS2MsUkkaV0n7V/R1VXEdy8rz74iOJdtF+SPpDCj3hQAvc8iIi8mQNIpYSpf2
         eBLTT2NkxVlpjNHVtblMOR8IJzuK/hEfIM01wsefCPytcdPpjymFvKTC1ODgK1LA2a5b
         JNwpYjWhetsQigwsywCxDzGIIvoErwSzmP2ecoTZhnbS5tBltTe4vDOrH6TEwVfocpDu
         GLCZtQ1sHNk1pg+lMyy+BYOZfRH2Vh32bw89+kkJKHDCsN29KsOes7+Vt9Jr/ZYBZxT8
         OZUA==
X-Gm-Message-State: AOAM531ykmHq3HWf8fFYTuQD156CVLtZh/b/76fDA9rYw8pCweHRyI04
        3nwFdKmKzBMuaNFEfZBarDf1tlIkOPc7jw==
X-Google-Smtp-Source: ABdhPJz9gAnjJaTSLqSBU8V1XbG1Ba11WfK8eAbaVVjxdKkz3fPB9mJLRZ4pHrpc7sQIC5T8EkI3Mg==
X-Received: by 2002:ac8:4a0e:: with SMTP id x14mr45094726qtq.345.1638844375373;
        Mon, 06 Dec 2021 18:32:55 -0800 (PST)
Received: from [10.4.10.38] (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id t9sm7520523qkp.110.2021.12.06.18.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 18:32:54 -0800 (PST)
Message-ID: <9dab64ca-0d91-3bea-f873-3c2da6ef1645@gmail.com>
Date:   Mon, 6 Dec 2021 21:32:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 06/13] dt-bindings: clock: imx: Add documentation for
 i.MXRT clock
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, linux-imx@nxp.com
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        ulf.hansson@linaro.org, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, adrian.hunter@intel.com,
        jirislaby@kernel.org, giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
 <20211204061042.1248028-7-Mr.Bossman075@gmail.com>
 <20211206223849.554F6C341C6@smtp.kernel.org>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <20211206223849.554F6C341C6@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/21 17:38, Stephen Boyd wrote:
> Quoting Jesse Taube (2021-12-03 22:10:35)
>> diff --git a/Documentation/devicetree/bindings/clock/imxrt-clock.yaml b/Documentation/devicetree/bindings/clock/imxrt-clock.yaml
>> new file mode 100644
>> index 000000000000..8af48c59ff99
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/imxrt-clock.yaml
>> @@ -0,0 +1,67 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/imxrt-clock.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Clock bindings for Freescale i.MXRT
>> +
>> +maintainers:
>> +  - Giulio Benetti <giulio.benetti@benettiengineering.com>
>> +  - Jesse Taube <Mr.Bossman075@gmail.com>
>> +
>> +description: |
>> +  The clock consumer should specify the desired clock by having the clock
>> +  ID in its "clocks" phandle cell. See include/dt-bindings/clock/imxrt*-clock.h
>> +  for the full list of i.MXRT clock IDs.
>> +
>> +properties:
>> +  compatible:
>> +    const: fsl,imxrt1050-ccm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 2
>> +
>> +  clocks:
>> +    minItems: 1
>> +
>> +  clock-names:
>> +    minItems: 1
> 
> Why minitems vs. exactly 1 for osc?
because i don't understand yaml yet.
I'll look into this.

>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - '#clock-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/imxrt1050-clock.h>
>> +
>> +    ccm@400fc000 {
> 
> s/ccm/clock-controller/

This made my day!

> 
>> +        compatible = "fsl,imxrt1050-ccm";
>> +        reg = <0x400fc000 0x4000>;
>> +        interrupts = <95>, <96>;
>> +        clocks = <&osc>;
>> +        clock-names = "osc";
>> +        #clock-cells = <1>;
>> +    };
>> +
>> +
> 
> Nitpick: Drop extra newline
sorry will fix.
> 
>> +    lpuart1: serial@40184000 {
>> +        compatible = "fsl,imxrt1050-lpuart";
>> +        reg = <0x40184000 0x4000>;
>> +        interrupts = <20>;
>> +        clocks = <&clks IMXRT1050_CLK_LPUART1>;
>> +        clock-names = "ipg";
>> +    };
>> -- 
>> 2.34.0
>>
