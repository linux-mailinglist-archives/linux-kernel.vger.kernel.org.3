Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32A6594F29
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 05:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiHPDpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 23:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiHPDpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 23:45:07 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8990832CA8B;
        Mon, 15 Aug 2022 17:16:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B801632006F5;
        Mon, 15 Aug 2022 20:16:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 15 Aug 2022 20:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660608998; x=
        1660695398; bh=aoST6YOZ6PDdCieixstTPtUnoofjKIkv3U3vVtPuCBU=; b=W
        n6i3GsbCD3i2+eWaAbryXhrR+MXC4Kf+mLqwwIy50ccUyfxp3FUkbFH/d16Wpt7r
        rbnfMiYmQH0F03Sq9xjs+RuicAsTLwZCHG/iU10KgaP3wXpJVKj5RJQ23QhRyz3X
        PblUb7KdhsWpJMguc7J+R/b9Zd7Gry51+FrVpXNbVcPlFbN+uAlCZO5juNqOZtGP
        gM5l605TlYbDEmODJzz1W0BDbsSc4/ztoIp/Qf4kObSFfZ4i3+6CLSVxOkhLoPtO
        aJ0WGJBSGrQQH6OAO9U5pPaWybzFjlFYbjBd4mIoWw5kbZhUbmDMnpQlsAjRUsWh
        AOEDsWWkgd7Vz/TsYt5UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660608998; x=
        1660695398; bh=aoST6YOZ6PDdCieixstTPtUnoofjKIkv3U3vVtPuCBU=; b=I
        uui4JHE2w3Q5aOtlS0mJKHkX7E3CT7lnKnzYPp6XSx2+CRCwvyc9iLrRvTqnxH3g
        q0V/PfNb/50q4r3ouPsGXbuK9asqWXl4/SpDSz5s7oQEFFpyn4vA6aIV46fjC+9w
        6xh0JtlgiZLFzZNlHpTDmhagX1Mnxaq7EMYWCL7J4gouPsHrg9rhp0qNdJfpswts
        VYQ6Uj5g35qNBp1qT85DGMxIM4txN7xv0cbLZA79tMHZwGX8B+jr10uI/8axHwkq
        W22zELSdxB1okRINLhWsBA0V44ti/cn5HWFZWB1nk8ispa7wnt6jwkHb/L0YAoWi
        HYJ2NSebG5G2nwG/5Wz6Q==
X-ME-Sender: <xms:5eH6YvONICDQc3jEqN1H12KHSiW24R_J5FV4yzFj57TRwP-xPCM3zg>
    <xme:5eH6Yp_eXssUmZlZGH-tucU9uragBTdF4KppXThhDknuu_ko-MA4SOqG-Vn3qLOUu
    X-QeoTCbAqw6rugTw>
X-ME-Received: <xmr:5eH6YuT7W-f_VyPsDB9-513rqOevdKJhVVvgkqiOPt42inDIUdbP0TGAuFVRvEjw3_LFk1bvEfDP3FqtrYBL4wjXomSagprBmBv8AlfUGKKRlDBA3gcMXRAxwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehfedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvefhheehgfdvkeetffeludeuudehudeuvddtveelleekvedv
    uedviefhkeeuheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:5eH6YjuEjFmLlpIQmlRo-gm1_wCA5zDQVSSHyunBlzQn47fchITiKg>
    <xmx:5eH6YncTSayEm20ncq2nqlD8BfdXW1O36HKOmyareyUBbcqjoivGfg>
    <xmx:5eH6Yv3PNKfyVvWJKMDPVmovDG0uu9hGYOGqyL4ejp011xThgs0uGQ>
    <xmx:5uH6Yr4ph_1XG2n3O6LSwtGbHT-Wo3wTX9I0mQPWaOp3rNId1FW6fQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 20:16:37 -0400 (EDT)
Subject: Re: [PATCH 2/4] nvmem: sunxi_sid: Drop the workaround on A64
To:     Icenowy Zheng <uwu@icenowy.me>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220814173656.11856-1-samuel@sholland.org>
 <20220814173656.11856-3-samuel@sholland.org>
 <197d58ed8b674d622e5c6a049905cd88e40659bc.camel@icenowy.me>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <dd9d439d-06a8-b25c-9cea-9065f67a628b@sholland.org>
Date:   Mon, 15 Aug 2022 19:16:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <197d58ed8b674d622e5c6a049905cd88e40659bc.camel@icenowy.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

On 8/15/22 3:37 AM, Icenowy Zheng wrote:
> 在 2022-08-14星期日的 12:36 -0500，Samuel Holland写道：
>> Now that the SRAM readout code is fixed by using 32-bit accesses, it
>> always returns the same values as register readout, so the A64
>> variant
>> no longer needs the workaround. This makes the D1 variant structure
>> redundant, so remove it.
> 
> Is this really tested on A64?

Yes, I tested this on a Pine A64-LTS. You can see the difference easily with
md.{b,w,l,q} in the U-Boot shell.

I verified that all three of the following are identical:
 - NVMEM exported to sysfs with the register readout method
 - NVMEM exported to sysfs with this patch series applied
 - SRAM dump made with md.l in the U-Boot shell

Regards,
Samuel
