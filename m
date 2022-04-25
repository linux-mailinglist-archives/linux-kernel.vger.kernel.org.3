Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A64450DDD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiDYK3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbiDYK3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:29:05 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C8A5DA24;
        Mon, 25 Apr 2022 03:26:00 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6C5E1810FC;
        Mon, 25 Apr 2022 12:25:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1650882357;
        bh=gXw9wbk3lFJ9g4L4B5F3yY9pXLjcZ/owkMTe5ZZCa0o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dgMcUi0GQt8nE0WH0AGCxbOzQ2uuSYSHeELx4TvjT+IWv+1SU9KXo9B/pdVY0lH/J
         1+oi3EOMyMQhPRjB35uJRr2ir3prdwPQY3RKpr4lhNNlnQ7OZdpCUvucwWAFJSGvKy
         aDz1l0nTTYM873Qck3SFEruHonUDYnwHioshjwVVL5cAgw+3G7vFXItRGK+fT8zx4F
         5qklaoVmnu0qg5WcSJ2a1vqCxZofuxxcHkXRoCic37VlLg5/HIbdFKe+dxikxfmiLa
         kQUBY70C8jE7IcQxuPe3Jfv+D+AQUWGxLq7pZjWlwJrVoc2xwCMt4ZxVKBpCOnwxJP
         bawPT+pWtWsUw==
Message-ID: <71c0dd94-8cd3-9ca0-f06d-ee13ad063618@denx.de>
Date:   Mon, 25 Apr 2022 12:25:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 6/8] ARM: dts: stm32: enable optee firmware and SCMI
 support on STM32MP15
Content-Language: en-US
To:     Etienne CARRIERE <etienne.carriere@st.com>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "soc@kernel.org" <soc@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
 <20220422150952.20587-7-alexandre.torgue@foss.st.com>
 <174bea56-3e99-e01c-4133-f1350d34448d@denx.de>
 <PAXPR10MB4687B8C3DF485E814AE8158BFDF89@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR10MB4687B8C3DF485E814AE8158BFDF89@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 12:19, Etienne CARRIERE wrote:
> Hello Marek,

Hi,

>> From: Marek Vasut <marex@denx.de>
>>
>>> On 4/22/22 17:09, Alexandre Torgue wrote:
>>> Enable optee and SCMI clocks/reset protocols support.
>>>
>>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>>
>>> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi
>>> b/arch/arm/boot/dts/stm32mp151.dtsi
>>> index 7fdc324b3cf9..1b2fd3426a81 100644
>>> --- a/arch/arm/boot/dts/stm32mp151.dtsi
>>> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
>>> @@ -115,6 +115,33 @@
>>>                  status = "disabled";
>>>          };
>>>     
>>> +     firmware {
>>> +             optee: optee {
>>> +                     compatible = "linaro,optee-tz";
>>> +                     method = "smc";
>>> +                     status = "disabled";
>>> +             };
>>
>> Doesn't this TEE node get automatically generated and patched into DT by
>> the TEE ? I think OpTee-OS does that.
> 
> OP-TEE OS does that if it gets passed the DT from early boot stage which is not always the case.

Shouldn't that be something to fix ?

I think R-Car3 does that already.
