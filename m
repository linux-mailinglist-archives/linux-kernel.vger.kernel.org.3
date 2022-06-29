Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A4955F2C3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiF2B3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiF2B3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:29:52 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6961FCE6;
        Tue, 28 Jun 2022 18:29:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B2926320029B;
        Tue, 28 Jun 2022 21:29:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 28 Jun 2022 21:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656466189; x=
        1656552589; bh=AXEjIB0EunPRYPNTHnXu/72xIuUpwUBfefYv+LYFhKA=; b=G
        qmrtRLhA4dXBrq+GXjSdXYLVvdTsnxe6CLbANT1451bjElKSxLK11IXY0uRLIbwP
        cfg2RKlM4yfrWt7dL3WhyFY9fZKKqMw8sr2ILiJnb8sAm3iZTUjaaP3V6Ioh+846
        NzILxCnTTsjB/s5qdZKS0GpWpLsV1zZf2T/01lvw7p93BFfjKD90YyGoKvIaTx0P
        1bBCAI3aOjKhsRI+dKWZHxeebyEAgqBW9nke8BqhNET0sSDNDDxfJJgmVBAtwLE4
        eA2ciHiSXa5jCZPX4tSDpTbomuQj94vbCZ2CW/7u5Xzjps3TmR8AWJAgV7N6x5ZT
        W2cKtbc3fn6y5T9wAO76w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656466189; x=
        1656552589; bh=AXEjIB0EunPRYPNTHnXu/72xIuUpwUBfefYv+LYFhKA=; b=f
        mcCBtXyXfdmZo3feQVsHY4E/QvrGAvwhz4IAkrWTqkPJAB/FypyoujxIAuPLehhh
        wzjfCRFjLKvoHYtku6Zz+a2CE+ts8czt4lk+AuRllNrTX9HNSlCynQHO0Hcsu8Xq
        D5VoNxQeGYHSZEGtn+aoLqGB8f5tHV723vMpntBSUCs0nWwzkSr3fgWsqWTy3cAf
        WZiOselO/ClHzYd7AcVrVf2Pyjzz4jZP46afmfTVpyb5o1vlYSV++LPa/9kDModL
        UP1YMb2pzBtpJVpxpPGrrQE/Bh6iOOfoW80IWomdncYIahu3J9D1s/sqj8f8HkuV
        hdT/3bA9g3JmR1ZfJZpqw==
X-ME-Sender: <xms:DKu7YmFNpE1ktm_1qYXghOYTYU47Y8DAfiOmABj_e6VCtd0vF2CI5g>
    <xme:DKu7YnU03GeAJGhYaElEuJR06jV4pxpuOZdd22fkLuds_bym7Js_gEbk_joHAPFOJ
    MYATC1Jdz08iTB4_g>
X-ME-Received: <xmr:DKu7YgLMH9lTGLIVg8FifbKnmKgakpCUI6Uv_UZm6kHWgOsrZBKGIuHu-n-8r9Fp8ll9IDO4Yu3CMuKuHSbyAPybfKwDPnMBsX0hdU-7ChScZUB-2HuMBDpjBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:DKu7YgEVjxZHp2j4ARZQOHI-r1HLCxH-nPLYor_FYVswAVFerghlOw>
    <xmx:DKu7YsWb-p6XTrc22Fj4WsdXNk6Wd3Hs0_b2SOV2MStiJcZXJHM_ng>
    <xmx:DKu7YjPtKcn0Qx6Uv0QHeK_G0zGZMkMXRbSugStTFGNzlDaQ9GEMzg>
    <xmx:Dau7Yol6fhnxWH4uw6PG7GccnI1YZIHY-MT2x0EtO2kaluaenoiLLQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jun 2022 21:29:47 -0400 (EDT)
Subject: Re: [PATCH 4/4] riscv: implement cache-management errata for T-Head
 SoCs
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, robh+dt@kernel.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, rdunlap@infradead.org
References: <20220619203212.3604485-1-heiko@sntech.de>
 <20220619203212.3604485-5-heiko@sntech.de>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <3ea5c3a7-8b17-18d5-9f38-bc0dcd79497d@sholland.org>
Date:   Tue, 28 Jun 2022 20:29:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220619203212.3604485-5-heiko@sntech.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/22 3:32 PM, Heiko Stuebner wrote:
> The T-Head C906 and C910 implement a scheme for handling
> cache operations different from the generic Zicbom extension.
> 
> Add an errata for it next to the generic dma coherency ops.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Thanks for the update!

Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org>
