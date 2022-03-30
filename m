Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0865E4EC639
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346627AbiC3OMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbiC3OMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:12:53 -0400
X-Greylist: delayed 916 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 07:11:07 PDT
Received: from mickerik.phytec.de (mickerik.phytec.de [195.145.39.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A52811CF6A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1648648547; x=1651240547;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PdBqd/DBbSKFTM+e0wpYe4vp4KlWFxTw6lHBjS1gXmg=;
        b=gMldqlETprNSg9ME83L3vRo9O44Z5nL0Zi1Zg1E/8PR/uwuv4AMzCAi9YIDAs9Oo
        jllxlbD6H6A88TQN3jn+d+IvG8w7wFPjRkFfI48xg05saZNLOfWYwL7pd3kHAgkv
        1HCD4aktlwb9NC60U36XMXZNEmuW6KQ991DfVntpDC0=;
X-AuditID: c39127d2-9112070000002a63-03-62446162c7a9
Received: from berlix.phytec.de (Berlix.phytec.de [172.16.0.117])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E1.41.10851.26164426; Wed, 30 Mar 2022 15:55:47 +0200 (CEST)
Received: from [172.16.5.104] (172.16.0.116) by Berlix.phytec.de
 (172.16.0.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 30 Mar
 2022 15:55:46 +0200
Message-ID: <73a4a16b-193a-3075-61e9-82bcf21fc7d2@phytec.de>
Date:   Wed, 30 Mar 2022 15:55:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC] arm64: dts: ti: introduce a minimal am642 device tree
Content-Language: en-US
To:     Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220321155417.13267-1-bb@ti.com>
From:   Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20220321155417.13267-1-bb@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.0.116]
X-ClientProxiedBy: Berlix.phytec.de (172.16.0.117) To Berlix.phytec.de
 (172.16.0.117)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42JZI8BQqpuc6JJkcGUXq8XcNwdYLeYfOcdq
        sfzzbHaLl7PusVlsenyN1eLyrjlsFm9+nGWyaN17hN3i/9kP7A6cHptWdbJ5bF5S73H8xnYm
        j8+b5AJYorhsUlJzMstSi/TtErgyPp9qYyt4x1Lx78taxgbGj8xdjJwcEgImEo8uvWXsYuTi
        EBJYziTx5fIZJgjnAaNE6/tGVpAqXgEbibkX97KB2CwCqhIbfnWyQ8QFJU7OfMICYosKREgs
        2zUVzBYW8JDoO98PVsMsIC5x68l8JhBbRKCFUeLXyRKQBcwCOxglTv1cBdYgJKAn8aylgRHE
        ZhNQl7iz4RvYYk4BfYm7k98wQgyykFj85iDUUHmJ7W/nMEP0yku8uLScBeIdBYm5vydCvRYu
        8fbUb+YJjMKzkNw6C8lNs5CMnYVk7AJGllWMQrmZydmpRZnZegUZlSWpyXopqZsYgbF0eKL6
        pR2MfXM8DjEycTAeYpTgYFYS4f140DlJiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/9HqZEIYH0
        xJLU7NTUgtQimCwTB6dUA2OI/NK7k2MEGjOWzkqYsHrtT4a98a4GZ3YE/D1eMX39/R1ua5x/
        7fi4/V3HLOPHvFKKNTfjT10p3G6y+9L6TxUn+kJWBy2VlmxqOrV7t1vx852nrKM8o566dp87
        y5f08VXbmktWjHJa37+t+7aVe3l7VtOm/sSZ6TudCjk3Hs9r6pSsipGufCutxFKckWioxVxU
        nAgAGLUOYZMCAAA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

> +/* (optional) for console */
> +&main_uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart0_pins_default>;
> +};
> +
> +/* reserved for firmware */
> +&main_uart1 {
> +	status = "reserved";
> +};

k3-image-gen says UART0 is used as a debug interface. See

 
https://git.ti.com/cgit/k3-image-gen/k3-image-gen/tree/soc/am64x/evm/board-cfg.c#n81

So it seems that you can enable uart1 here. But people may run into a 
conflict with uart0 and k3-image-gen compiled with ENABLE_TRACE=1.

If I am wrong, can you please clarify why you mark uart1 as reserved.

Regards,
Wadim
