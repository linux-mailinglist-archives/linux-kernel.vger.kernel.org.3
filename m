Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C5659F315
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiHXFdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiHXFdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:33:31 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEE17EFE7;
        Tue, 23 Aug 2022 22:33:30 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27O5XMGM125374;
        Wed, 24 Aug 2022 00:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661319202;
        bh=YlOmRucdsm6VdSMoXbTqjqPNGJYziMTxO/67cO+VbRc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=HEujJQmi3BfdyCVoO0muOd/d67T7EkV+mzr3C5WPFHz4jE09Gj35CX8tPrKrJ8J8S
         Lrc6uNi5fewxMK7iP1TZGOE5laK4Wo9NMNZROsJD6lr8rlBSKCOyyiYVSbeG5wiA8i
         wcH5tMvL3+0pFSrxuAvZSDDo/S/h+61sKB5CN15Q=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27O5XMmj042231
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Aug 2022 00:33:22 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 24
 Aug 2022 00:33:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 24 Aug 2022 00:33:22 -0500
Received: from [172.24.145.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27O5XIur093181;
        Wed, 24 Aug 2022 00:33:19 -0500
Message-ID: <734b1e1c-2416-0684-287e-a96b86a416a2@ti.com>
Date:   Wed, 24 Aug 2022 11:03:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] arch: arm64: ti: Add support for J784s4 EVM board
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Hari Nagalla <hnagalla@ti.com>
References: <20220819190054.31348-1-a-nandan@ti.com>
 <20220819190054.31348-5-a-nandan@ti.com>
 <6c89f254-185a-4046-2bf0-a9f85713858e@linaro.org>
 <20220824050627.nh7d4blrsfbxrvuh@clicker>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220824050627.nh7d4blrsfbxrvuh@clicker>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 24/08/22 10:36, Nishanth Menon wrote:
> On 13:21-20220823, Krzysztof Kozlowski wrote:
>>> +
>>> +/ {
>>> +	compatible = "ti,j784s4-evm", "ti,j784s4";
>>> +	model = "Texas Instruments J784S4 EVM";
>>> +
>>> +	chosen {
>>> +		stdout-path = "serial2:115200n8";
>>> +		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x2880000";
>>
>> earlycon is not a property of hardware. Console is defined in

earlycon is helpful for debugging early crashes. How is it any different
from "console =" property as described in
Documentation/devicetree/usage-model.rst?

>> stdout-path, so please drop entire bootargs.
> 
> We will probably have to cleanup elsewhere as well - point noted.
> 

Whats the alternative to pass default bootargs to kernel if bootloader
does not pass bootargs via cmdline? I see quite a few dts file use
bootargs = "earlycon" at least


-- 
Regards
Vignesh
