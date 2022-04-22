Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0321650C57D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiDVXxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiDVXxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:53:35 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EAC13A4F2;
        Fri, 22 Apr 2022 16:50:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C9E0E320187F;
        Fri, 22 Apr 2022 19:50:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 22 Apr 2022 19:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650671437; x=
        1650757837; bh=JTmfJSoBxmkYutkVl8SbHqIqpWLHfszZQf/Bky78BUw=; b=Q
        3oEU4+dAhiRsgGY/yqjcz/SNuzpKZs7F0rBJ4of1XHv2NgEjm3xQbdvt2EaD70du
        2znxkfjerkhvzM0c0LtrbwlhcofCt05U8GdbpIRATUbciRyg9VnFKZvzJxH9tHAM
        lsdEJAhZ1zWc1W4OreH3lYupHaHNc6P3uRW4+kJzJbzGBs7/1XS90l3mAJQ+sbTp
        932cgeLvIHE/4Mj90U4H/Rb13zfRR7Q6eAwz1HHQ6tda/n5sR/YLIoGc9yhy/v+x
        F9WuUgIsEhw8XGqD+Mm+GswFV/DoHZVNkWF9g5gc+OIM7d53Bz92Pr4zmhMjrfj/
        s1khZI/6j6J+I9bFabxjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650671437; x=1650757837; bh=JTmfJSoBxmkYu
        tkVl8SbHqIqpWLHfszZQf/Bky78BUw=; b=O1tVusST0IwPSKIFoNUXc7v8+zDzS
        eSc7DzTJBup2BHe68ktXVGjKcSN5i7kV03q0eWn4V+4DUZJT0+moqrO9MbKf3/I5
        bm62MhKuE76XlaUj3+7xSDcQuAzc4bXIl6+4HgJ9GlJt4AWvNQ+kkAJSFza0ATWw
        kEPdlkoK3miIUCFVuiuSkpxaftXmhXdoYd25sTMsc7hH/SuA3GEu2b+gvut7yE6i
        N6SbHCG1uAfDDRTIT6Ct9PP3KZfYCYTZoSbk7qVx5SZ4N2ZIRDmpiSWq45ujG8v4
        UGRtzVRlm5FItHt4IaHSlL3BJmVO92rQhDgKOyIfSt/lhJjYYJ0xTAOvA==
X-ME-Sender: <xms:TT9jYgAzLY8FgpToDVv3-tzYXCe4i0fbLZa3NJgZN9HrYW0zx6zqag>
    <xme:TT9jYijTBt72XsVcN1rAagjh1dfbfdVmKzQLZWa9t892yV-7JoCf15hWQKfr_gjFG
    PgDhLmRTBQdgjB2ew>
X-ME-Received: <xmr:TT9jYjkw3vo8QKb4xv2GYU0agPDqFDNF8-v0R32fRWnOkzSWfb9-eFH0Y6jjvkuT1Jj6m3XzWsA1yJcPomLb0jO4ngl7H2pucl7j9LT21thCkM_rhXbRmFRm3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdehgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:TT9jYmwqXZeCAV26RZNdkP9eD7pURixf6AwBnQgqlurQLRgSYLioqA>
    <xmx:TT9jYlTcmyZUD98vg0eGnYzd2-QQqf4KkHyteCJIGvuDwaYCvcAe5w>
    <xmx:TT9jYhbkpu5l66EoEkyb9r-gWFjGgUoakbnU8PhN5n0UCY0OumN3Eg>
    <xmx:TT9jYi--Af9oPO7fYc76mHgfTYGsl01QxH_KZXH3w1EVKfX24t11rw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Apr 2022 19:50:36 -0400 (EDT)
Subject: Re: [PATCH 2/4] spi: sun6i: change OF match data to a struct
To:     Icenowy Zheng <icenowy@aosc.io>, Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
References: <20220422155639.1071645-1-icenowy@outlook.com>
 <BYAPR20MB24722F3BAFB536A8BFEC733ABCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <ccb1fcaa-640b-d485-6a6d-744398e4e130@sholland.org>
Date:   Fri, 22 Apr 2022 18:50:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR20MB24722F3BAFB536A8BFEC733ABCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 10:56 AM, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> As we're adding more properties to the OF match data, convert it to a
> struct now.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Samuel Holland <samuel@sholland.org>
