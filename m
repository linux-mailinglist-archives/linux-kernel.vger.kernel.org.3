Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1010753CB56
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbiFCOI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243091AbiFCOI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:08:27 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB081A06A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 07:08:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5EAB95C00E4;
        Fri,  3 Jun 2022 10:08:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 03 Jun 2022 10:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1654265303; x=1654351703; bh=KAAWDaYR9D
        AAjcCE8MtwOQmv/iLpTKonhaACeihg1sk=; b=k1mSP4WHfLJKp82LjdQztgZUO3
        vVH+Edh/Y7pF1XZT9h+XroJQh0d1sPOjZ/per8O+Cg252ShUljx/1yA7v3YA9w2i
        4nqa0RnJGqZ5ZWVPz1pAXlq3+M+d6FBNPI3Q4rF80Hbglgael7x91sGfhm++uGFx
        h4WIDpsW43oUOjGzjBhp57fNmHw51kN1HzHPuPPFId3hSVBJ2dqL3e6lPryKkSNR
        VRekWxSUVKJwzNB1nwCOXheY62cZoc3Qnf4fAvFlY2Mn8X+u+IMZiwzYu2OEkkA9
        blhLywwLPldibgZPhIvn0lzVXKZCA7FwofouNN98HSJ64U3EtNGnAlUWJ7lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654265303; x=
        1654351703; bh=KAAWDaYR9DAAjcCE8MtwOQmv/iLpTKonhaACeihg1sk=; b=f
        /DgesW4PIfMEQewKlQa/fbrSMgjMexdVSBt8sdufq6mv6Oe/VYZX+/rYYDAdBMm9
        X/G9V1WEUE5lMGEz8Ap4jCr+e2sJzvGv6fU3EiCU+126Ru5d90UFzNZwD5uXRCL3
        PtKSMmMYKkOx9TDXfNcK+DpMykxbrUwoeQdx9CuFEaLsE+pxC36jvDI9Vu1jbmIf
        LfnRQOR1kTaoyt9N3gg2742c16eB+3agDgOWdv7sIrjhSVFYHVxPXxJ/5R9fXxpU
        OehYHN6V3uX2y3BMDd6A0xTqGRG340PzdwJRCSDDX/Ewubhh0rlaKfh0e5FeCBKJ
        G83y60FMFKqU8DOky7pJA==
X-ME-Sender: <xms:1xWaYlYSBwHEKh9QJr9QZBQLKEsH4_jXP6QGMqO_buphseP4jYohfQ>
    <xme:1xWaYsYuuo2Qc33cJl0VmJtaEBxP5g3DLFxxqfV_PRWPwy_p8juXYH4W6g8ku4dR3
    15dnpd9YB_6o9p2qw>
X-ME-Received: <xmr:1xWaYn8mNGhhWCjXvXKPlhN0BaVxm4GTXpAlul6Geq-Vz8uqPdQvJHhrBW9u3oLsIM4Pl3BH8M5YKRBJnPFGlePk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleeigdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepvfhomhcu
    hfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhkqe
    enucggtffrrghtthgvrhhnpeekueeijeefueffkeekteegleevjeeiteehiedvtdejiedv
    vdelvdffvddvtdeugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:1xWaYjrqwRwfgp3BTMWXgtSPn5UsDBdQO9xioQjK3LsrsBJpAn3how>
    <xmx:1xWaYgqbvOwVoW4ilYyIJnqLhNe2dxKNqXFSG5iwFJ14WYFUMxMPXA>
    <xmx:1xWaYpSbt1lD22VolxYqjdCOmZyiytjw00mYYP2ejtmFW18NBHe8MQ>
    <xmx:1xWaYtgDCCbv6WuTzh1M6n1Og7-bX0_UZn9og4SwUpRR867thaGT-g>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jun 2022 10:08:20 -0400 (EDT)
Message-ID: <3210537d-9591-ed28-605f-3802e4e1597f@tom-fitzhenry.me.uk>
Date:   Sat, 4 Jun 2022 00:08:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mtd: spi-nor: siliconkaiser: add support for sk25lp128
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20220603135933.143372-1-tom@tom-fitzhenry.me.uk>
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <20220603135933.143372-1-tom@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I've just noticed that this patch fails checkpatch.pl.

I will fix this and send a v2 shortly.
