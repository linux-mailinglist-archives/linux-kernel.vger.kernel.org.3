Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD0E50CE67
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbiDXCPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiDXCPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:15:42 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250E3B8980;
        Sat, 23 Apr 2022 19:12:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EAD735C00C4;
        Sat, 23 Apr 2022 22:12:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 23 Apr 2022 22:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650766360; x=
        1650852760; bh=d5V+nt7E5ITm5vT0iO+QXQjdBcEjDfwSXY/0u6QYCgI=; b=w
        zb6oI7dx/gVnlSw6FJo9WJ3J04XhpPBExty31LO0MJJRuEZix+yPFwkJYNyyQxFN
        RZsOOxyqhgpcIOjdtow5W8LwiWJGdP/0CRxi4+BDKPmq40eesSOjayNV04hDz/a4
        DMLJZI2G0Dqic6iAWECIbuj5iHDAuRjef0A1TBEZkDeYBV4TZ2lHRFX0JZunGOsG
        ABs8z0vLnaQ8fSVYYtEdEQR4ZmubpiwWkow2mgxhqw0Ie/ZdgPz8EV6fbEzcaOVa
        Dvq4ssuKY+R6HVLYePiEqSAwvO4QQ0f2i//+hT43foItN6HpETvYhE+q8LiMHWyL
        Aa+c7WnYIythQ/PeK489w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650766360; x=1650852760; bh=d5V+nt7E5ITm5
        vT0iO+QXQjdBcEjDfwSXY/0u6QYCgI=; b=Rm7ka/b9oCpcyqN6/gikFclufp50p
        GAIZqtnhUC1jG9JM6U5lKZU+sDwhD6v1y9Ig6YBrzxCi5P7gdTcaRoRTH1egVdsj
        FtsySReTuhJOv4zHw6POzqZ2clik5oKFzGNL5hVeqkDtRvpxcxKo88BU2BLjl74N
        qSIxiumTpV9i/h6YJU4ILpRtwQy/UIAVct0kQ60co8wMx6yi36rTLGZ49pwgF93c
        XcCcuQOoJvOS/4HVy/oC3WOAFntJa8VhSTvxpBMJi38VUl+p2XX+qYXNiyc17xRW
        0CXMCMmFT+0h7kOJfjXXqFdzyTmJ8tFN98KI2afZ6h1leZLvZnMCp+dFw==
X-ME-Sender: <xms:GLJkYo2c8O2Ce10V7VEQXgbEeP6ssH27j_Wry-c2qOJOc4--TxUHVg>
    <xme:GLJkYjFyC1zz0aAuG__LJvE6AHAkTZZvks2Wo0JS4IMWhQer1DL1VQ7QlcEJs_JtS
    Aihx_Qp6wb-BJVnug>
X-ME-Received: <xmr:GLJkYg79AzSJeOKyecAMpsjQzh6iGy3hWIe50n9UNJpoqv6RAUi-Enc_zQrLBWJGxDR-PKr-rGVY3EkRXQ3NDNnuU15gz0wuzRCCjS4aCZHIsTlsz4Kw_QLgFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdejgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepleetjeffvdegheektdekveeuueetffetffehudefueejvddufedu
    teeiieejveelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:GLJkYh2_2GylcTYYYs881XF-pxngd-LqDxQkuNT3Awjgng_vl8r1kA>
    <xmx:GLJkYrEx_aQom2nmu97nUi0j7DCs8HbB8PaiMXUe8Pe4vvkjkE20yA>
    <xmx:GLJkYq_KhYjc5Fj2h8jF1wwbzxaBNeN0jcp457InwgMwf7rR3qXK2A>
    <xmx:GLJkYj-SR1OWPk-NbtUY1NxrSD0io_5KoCVTJlM-Vgdx-gnf0qT8cg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 22:12:39 -0400 (EDT)
Subject: Re: [PATCH 06/12] clk: sunxi=ng: add support for R329 CCUs
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
 <BYAPR20MB2472930AAFFBDC0ACB9A7487BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <c858b944-d72f-4e59-6a1a-329b5b8949c4@sholland.org>
Date:   Sat, 23 Apr 2022 21:12:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR20MB2472930AAFFBDC0ACB9A7487BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 10:41 AM, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Allwinner R329 has two CCUs, one in CPUX and another in PRCM.
> 
> Add support for them.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

There is a typo in your commit title. = should be -.

Thanks for updating the driver to use .fw_name and be loadable as a module. All
of those changes look good.

There are still some missing clocks here compared to the BSP, and a couple of
other minor issues. Please see my earlier review:

https://lore.kernel.org/linux-sunxi/99a74950-fdc0-ecfe-e5f0-ba4a7d8751f0@sholland.org/

So far it's been consistent that any settable bits in the CCU registers actually
do something. So I would expect all of those bits to have an index reserved in
the binding, even if we do not model them. I want to avoid having to go back and
add gates to the binding out-of-order later, like we are doing for H6.

Regards,
Samuel
