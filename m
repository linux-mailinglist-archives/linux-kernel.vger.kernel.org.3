Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27A259CFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiHWEJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiHWEJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:09:36 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF6258094;
        Mon, 22 Aug 2022 21:09:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 94B285C0182;
        Tue, 23 Aug 2022 00:09:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 23 Aug 2022 00:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1661227772; x=
        1661314172; bh=3iYVwXs2ZaQeRDzt5GIWfO2EwoODMlIdh2IIQdfaJPA=; b=d
        Chl1V6zNcUEdRSQa5E4Po55JmarqA/l3c4yUWqFWXjK44UbNLJKlgtXXtuTfc2q1
        Ot/wExRoHlGzQjIAn5PTa5OapTYw9fUznjrbgsRcZZg+1S5BjXXN/4+ZeWdd3ha8
        qHvDIyC/zCJNOENzzw2ccJefs935uwYfwthi5+ij1V8XZ3Yu/Njv1CmqImaLlMco
        u6iN9jhZU0GM7L4NXuVwJN1EigfNyrXnOpwCnEtLiZEwGtNZqnSv3Jmp5PfmbtHr
        yus5W/sH0Le+edoJWcRQIberIyI8RAsN8xpMijIk/a7VV69mxNHu1KKQd6w2aqPs
        ZmDvUgUu2PG4+CJ7eQ4Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661227772; x=
        1661314172; bh=3iYVwXs2ZaQeRDzt5GIWfO2EwoODMlIdh2IIQdfaJPA=; b=p
        HQ6XEhfoZYGjGcXcLtZPLwMOjESOaSSD3oCFXmqgZRGd/7PlV4WZjgGbA3hbXRN3
        LOXQ1LyXTdOtKY7O/6Va3L/A1PM1Rkn8Qd1mZ9mcelqDSJJzBnkw0a0X6uNKTSvN
        vPVwbdLgOBScw43jHjP2y4ajcJJtNb51K6Jh2236ox88qOnP9TEb/JXN5MOJIxLq
        8ZY96c9IgC9tGZAMABzv6Xz/SagTml+8RLZeu08QhN/XUlufvSN5nZYH2f6Y95pG
        K4jpRFRAnt80iKz0rZlpqVbkuaDB580NdsNUd1FO5HhgUlO6MWNqxReVoEFmEbOZ
        zRpkYp99+48r2+Mg5X8FA==
X-ME-Sender: <xms:-1IEYySi-ZnrFDFViivbgcDFKv6n__zU952PfXKSEpoGipUcusVvVQ>
    <xme:-1IEY3x9HNA8rTJjV-PYLI6uDqvtozR9iuZpOglWFSKBalbHbMdOiUORpkiS_pAPL
    Aw7rGC9Ie5mURPsHg>
X-ME-Received: <xmr:-1IEY_0tj2L6z2w57R01YjyPpdayRPzC8HNVv3cq14hU6jnCwEhUgKWF9aBpToC7Wnhewn76STk8JlwMlM4JEJK0tkOtcOSVZ-qpwjpS_9rhV6rHfdsr_MVTBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeikedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:-1IEY-BOZ6oik9UxcOXs0_qRl8psZq-1Mvoxxse2dklCUkisUOTL0Q>
    <xmx:-1IEY7iZnZES6vbs5SSNo-K-q-1_Q0RNJV5wUjRxKlyW1qTGkeBqNQ>
    <xmx:-1IEY6pfvF5CfvMs9lVMAljOX3Wz9rVlAAI3BSV5BJXWVGyBz1UMUw>
    <xmx:_FIEY7he0F4Llmvb7iB1iJxbfeh2Ol7DtVOOV0onKbq-2ZPoTqYltw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Aug 2022 00:09:31 -0400 (EDT)
Subject: Re: [PATCH] pinctrl: sunxi: Fix name for A100 R_PIO
To:     Michael Wu <michael@allwinnertech.com>, linus.walleij@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, mripard@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220819024541.74191-1-michael@allwinnertech.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <9d389ff6-5601-7a7b-3341-eb624d624ff9@sholland.org>
Date:   Mon, 22 Aug 2022 23:09:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220819024541.74191-1-michael@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/22 9:45 PM, Michael Wu wrote:
> The name of A100 R_PIO driver should be sun50i-a100-r-pinctrl,
> not sun50iw10p1-r-pinctrl.
> 
> Fixes: 473436e7647d6 ("pinctrl: sunxi: add support for the Allwinner A100 pin controller")
> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>

Acked-by: Samuel Holland <samuel@sholland.org>
