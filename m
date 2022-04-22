Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76A50BD26
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449716AbiDVQeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387216AbiDVQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:34:22 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796C45DA79;
        Fri, 22 Apr 2022 09:31:28 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5D9918393B;
        Fri, 22 Apr 2022 18:31:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1650645087;
        bh=npaA7nQE0jiwRUKroXrJtuWWNquvHEJSFhCg7Tme/2Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zrlOZLsbRDI4hjjBYxdokgfqY7vrd31TzSkQK0sh/ftx4qc6//bihFJ6WBk3cjL9m
         HtgZ6UqBhwTItSo05TdG99cpBKc93gYhPJoRALfIDMQcbwxSiOtxq5TxQMNHGVSVEP
         W0b0tknx/zfSyUY8CU67xGojcmDoUgpeHfX2LOUdPBcsB0VLQv5QETRDS68+uhUgX6
         rote6I1R+GJbe2e9fqT+U+ADgshslQ4pHPxjYJWAeiHKJCqbD2AiPEUtzLBwo0fmuT
         tYGvD3CZEnJ3fcRJ6noXNyN1zpbjy4gz3CgN5OaZL2sdkEjmG+FCcHGyLtd1feB7XV
         O49zIhZNbcCKg==
Message-ID: <dd48a7b5-ce08-5fb2-8236-8802ac91d827@denx.de>
Date:   Fri, 22 Apr 2022 18:31:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/8] dt-bindings: clock: stm32mp1: describes clocks if
 "st,stm32mp1-rcc-secure"
Content-Language: en-US
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>, arnd@arndb.de,
        robh+dt@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        soc@kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>, etienne.carriere@st.com
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
 <20220422150952.20587-3-alexandre.torgue@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220422150952.20587-3-alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 17:09, Alexandre Torgue wrote:
> In case of "st,stm32mp1-rcc-secure" (stm32mp1 clock driver with RCC
> security support hardened), "clocks" and "clock-names" describe oscillators
> and are required.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> index 7a251264582d..bb0e0b92e907 100644
> --- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> @@ -58,14 +58,8 @@ properties:
>             - st,stm32mp1-rcc-secure
>             - st,stm32mp1-rcc
>         - const: syscon
> -
> -  clocks:
> -    description:
> -      Specifies the external RX clock for ethernet MAC.
> -    maxItems: 1
> -
> -  clock-names:
> -    const: ETH_RX_CLK/ETH_REF_CLK
> +  clocks: true
> +  clock-names: true

It looks like this should rather be a property than a compatible string 
-- the compatible string is used by the OS to determine which hardware 
is represented by a node, but here it is the same hardware in either 
case, "st,stm32mp1-rcc" and "st,stm32mp1-rcc-secure", it is still the 
same STM32MP1 RCC block, just configured differently by some bootloader 
stage.

So why not just add one-liner property of the RCC block like ?
st,rcc-in-secure-configuration
