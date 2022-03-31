Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EF84ED4B3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiCaHVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiCaHVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:21:52 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [195.145.39.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AA31DE582
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1648711202; x=1651303202;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9xpnGYsEgO0Tx2QUjhqJ8ilWQrfzORn0eYCwO12KfNg=;
        b=iEoQ7yzIkB9rHs84qjv0gif+rDU8on7hXq+dvLzMTTDTodINONXllj9ZNpEYFgtU
        mFS0wW1MR4vnKHPlQ6KXK/7ZUXShXeEQBbocmhAnuszXsLoAiNhEmjppwtBkr9PI
        ZC+DZDdbqam0FqClzi7gJQ4V8+fzoZHVy6Frm8NQoIQ=;
X-AuditID: c39127d2-93d2170000002a63-7f-62455622e59f
Received: from berlix.phytec.de (Berlix.phytec.de [172.16.0.117])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B5.47.10851.22655426; Thu, 31 Mar 2022 09:20:02 +0200 (CEST)
Received: from [10.0.0.42] (172.16.0.116) by Berlix.phytec.de (172.16.0.117)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 31 Mar
 2022 09:19:58 +0200
Message-ID: <f9f8f08d-4d49-11cb-484b-b5b1a434b0a9@phytec.de>
Date:   Thu, 31 Mar 2022 09:19:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC] arm64: dts: ti: introduce a minimal am642 device tree
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220321155417.13267-1-bb@ti.com>
 <73a4a16b-193a-3075-61e9-82bcf21fc7d2@phytec.de>
 <16ad1a82-1e99-2957-720f-08d1238edcf4@ti.com>
From:   Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <16ad1a82-1e99-2957-720f-08d1238edcf4@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.0.116]
X-ClientProxiedBy: Berlix.phytec.de (172.16.0.117) To Berlix.phytec.de
 (172.16.0.117)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42JZI8BQqqsU5ppk8HmersXcNwdYLeYfOcdq
        sfzzbHaLl7PusVlsenyN1eLyrjlsFm9+nGWyaN17hN3i/9kP7A6cHptWdbJ5bF5S73H8xnYm
        j8+b5AJYorhsUlJzMstSi/TtErgyXratYSm4yllx9Gg3cwPjPfYuRk4OCQETif3zWxm7GLk4
        hASWM0nsfdDOBuHcZZSYsWMmK0gVr4CNxMvZ25lBbBYBVYkfyzZAxQUlTs58wgJiiwpESCzb
        NRXMFhbwkOg73w+2gVlAXOLWk/lMILaIQAujxKbJhSALmAV2MEqc+rmKBWLbREaJlocHGEGq
        2ATUJe5s+Aa2gVPASuLjq1mMEJMsJBa/OQg1VV6ieetssIuEgOwXl5azQPyjIDH390RmCDtc
        4u2p38wTGIVnITl2FpKjZiEZOwvJ2AWMLKsYhXIzk7NTizKz9QoyKktSk/VSUjcxAqPp8ET1
        SzsY++Z4HGJk4mA8xCjBwawkwvvxoHOSEG9KYmVValF+fFFpTmrxIUZpDhYlcd77PUyJQgLp
        iSWp2ampBalFMFkmDk6pBsbKKkV26c0bX8vN9Jm3lqHGoDsj8dxGteCEtTYTPbuNV9ZzTeOv
        lLY8byz3529OQMIqpa1dNSefhq+ew9/CzFU1b1+PQEdeYke7cMe0Deb6B6rYs98vKNMOd/u6
        fedL4elCvx31t+hPeMj6J/CdRNMZg8W2avvCrokEtX7eOGPWy/hXV5/edlViKc5INNRiLipO
        BACBrzPblAIAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 31.03.22 um 08:58 schrieb Vignesh Raghavendra:
> Hi Wadim,
> 
> On 30/03/22 7:25 pm, Wadim Egorov wrote:
>> Hi Bryan,
>>
>>> +/* (optional) for console */
>>> +&main_uart0 {
>>> +    pinctrl-names = "default";
>>> +    pinctrl-0 = <&main_uart0_pins_default>;
>>> +};
>>> +
>>> +/* reserved for firmware */
>>> +&main_uart1 {
>>> +    status = "reserved";
>>> +};
>>
>> k3-image-gen says UART0 is used as a debug interface. See
>>
>>
>> https://git.ti.com/cgit/k3-image-gen/k3-image-gen/tree/soc/am64x/evm/board-cfg.c#n81
>>
>>
>> So it seems that you can enable uart1 here. But people may run into a
>> conflict with uart0 and k3-image-gen compiled with ENABLE_TRACE=1.
>>
>> If I am wrong, can you please clarify why you mark uart1 as reserved.
>>
> 
> We just seem to have same macro shared across multiple SoCs,
> BOARDCFG_TRACE_DST_UART0 means logs are also directed to UART. Instance
> of UART used for logging is platform specific.
> 
> On AM64 SYSFW logs are directed to MAIN UART1 (MAIN UART0 is used for
> linux console). I will work internally and get SYSFW documentation
> updated to reflect the same. Thanks!

OK, thank you for the clarification.

> 
> Regards
> Vignesh
