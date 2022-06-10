Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41175467C6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349481AbiFJNzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349396AbiFJNy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:54:28 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510AA53E19;
        Fri, 10 Jun 2022 06:54:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 435505C01B5;
        Fri, 10 Jun 2022 09:54:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 10 Jun 2022 09:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1654869263; x=
        1654955663; bh=gFK/HQH8p53JQi+NMpZBU5/teK5gD22vCfFoZtEMGWY=; b=l
        hjlFSZGo1QV32MYM6OA2gTInVFxds4H+FZhyZ6kmsadhbTBpsz3OEMSpw7yoYg4L
        CRRCaMJdPjDV0sk/C28EFZF73i42kngswxEMPSnHQZU0xU9HGntzU2QX3FVl8Q6A
        bBQ1YlNGBUm1/AteVlrxkyrcqah3+Xg7pc/T2U2jIo2FO0DrsAD7I7E9Fm38COEP
        SZiu3p3VXV7ExHSoNLSEkKvxgp0YZUPxWSeNrMNX1vo9nNmM8SwWP4sHrOOron4n
        YyK6SQ8qnzZNs0Ds55UPD/88dolkmBUyMgZA9tU4CoAK4i/SGwdcYCEJcVF14Q00
        BpvPay/My7WiZ4gp2q/KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1654869263; x=
        1654955663; bh=gFK/HQH8p53JQi+NMpZBU5/teK5gD22vCfFoZtEMGWY=; b=W
        xnD0qhX9oS5RCKGLsOaYVvoYcjcL1q3LEOYU8HrfO2kMRs+dwAvm+/SP7hgSVjEa
        UX+IKAXsg6q9L3/T1Rha3uhBgGvZvtsYygxt9Jm79PaA39s1gul+WU3Xx4GtwpbQ
        iYCtmzhfgHO5tO8JKC5dHOmrbZs1i2ppFO9D56TsfktN2DXlazcBCcS2XLz9OdFz
        QHDT0K6JxOujSjLfO4p22i7/4AH6VFxGEj0dTgFYDHiAGrKOGTcE8KvsKu7jRyDI
        cWo82M4QeJ1oAfbFgXnFb8LFydIHn8zH2GCxM8oskMk2LEtaRrfVue4Bv800FaSo
        LCDcLLDZCSAKkN/GDUeLA==
X-ME-Sender: <xms:Dk2jYkYXNqLQj16Lh7eiqeMOReBrD8MPBgQfXGtfeTUAJgOX-cEeAw>
    <xme:Dk2jYvbobhpuOsmvsyMgBZ6WJ0jJgsTgBmpNv665ZqcBRYvIHO9IFheFVwcKLXXC_
    9RGNNymBhnBSD_erQQ>
X-ME-Received: <xmr:Dk2jYu-MrvRzBYuoKwznpSarHSSE7JMc4KLcEoZrK7rwBJjYgqUPMffqO3xbWzKFHAYAGNDRcY_5aNwHwi1dKtjw9AeUMyQsBvhP6KHKRcz2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudduuddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepffeltdeggfdufffhfeetleevueduuefghfelveeukeejleeu
    heevgfevieeiudfhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:Dk2jYuonKHTrEI3XjaSRSekBqDQdfceeH4Q2p2UZ_QALEmDQZRY53g>
    <xmx:Dk2jYvr-8HxMMVNepX_vo3Oki7psr7i4WAbX8iBrGoHmmNDfUqN84g>
    <xmx:Dk2jYsTIDxNK0PNrvfbepsTaHIeKUKjGexQFu-1bMcmZzXMTr2F1uw>
    <xmx:D02jYgA15cAch015OI-yy9n3WL_PzPJ1B8tDeNDWGof5qio2jLs8OA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jun 2022 09:54:21 -0400 (EDT)
Message-ID: <b094a60a-dd11-6202-631b-4b5b254b9a81@flygoat.com>
Date:   Fri, 10 Jun 2022 14:54:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] irqchip/loongson-liointc: Guard uses of
 cpu_logical_map
Content-Language: en-GB
To:     =?UTF-8?B?5p2O5a6H6bmP?= <liyupeng@zbhlos.com>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, caizp2008@163.com
References: <AEEAewAYFO3qveOnRj7or4ox.3.1654844307199.Hmail.liyupeng@zbhlos.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <AEEAewAYFO3qveOnRj7or4ox.3.1654844307199.Hmail.liyupeng@zbhlos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/6/10 7:58, 李宇鹏 写道:
> thanks!
Hi,

Could you please correct your email client configuration[1] for proper 
inline
reply?

Thanks.
[1]: https://www.kernel.org/doc/html/latest/process/email-clients.html
- Jiaxun

[...]
