Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0863536F2F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 05:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiE2DVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 23:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiE2DVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 23:21:15 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE96BA57A
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 20:21:14 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8EEAB320029B;
        Sat, 28 May 2022 23:21:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 28 May 2022 23:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1653794473; x=1653880873; bh=uclbEBUpCx
        RExA33Ae2eWgh6Stc1AgnMH8FnX2UkQ5Q=; b=WiBqo/7KQYB/fnqA6xRFZz//Cd
        4xG9k9z+H5OyXxB4CMppo7uUw8K1mlw+I1KUZbt1w0iA8RAnboXrtBRJPW2KbSEJ
        ly02ftNRYP+VGZKU5oofI3zZ7UB0PfISB0MSuE7vWiZX04MGlCU1tLnz8LNfPFMy
        g1fkDX9W9g+Dz/rJp0fWby+c4oJdLTKA5yEjquxNUNP+it2FVl++S99IaCmAQm9V
        3R+JWkIqjK5cDxkXujbDwu0IdqxRV1/lSzMMqPq/jtjNiiG+VpShSYubXOWCOf6H
        +dGK/LitYzmh8ghDjER0d0rNwFRo6IH6EDl4Ry9fO51gYIivuPeHIrMyV5/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1653794473; x=
        1653880873; bh=uclbEBUpCxRExA33Ae2eWgh6Stc1AgnMH8FnX2UkQ5Q=; b=E
        QmIaBSoma8dv3+UEj2OlkmAFs//4KIUVCm5euDCG1YQtGp1+9wpKRMlmT2MqT9rB
        WW5YxeaPNh7UN7d2NyCZVO1AUVeNXP+ZS6sXmLeOufutaEzGch0Us/IQbqy5AdtK
        tM6qDGO+kKKeGlH4B3bHp8oTYGNBvwoHFIw3z29lJJ3F4oaFYodrhdvUq+5k4bfM
        n3itvGLx1VgTcy0j7BeIVP7V7g4bVN8BzqDSmXcJ7147vESEbQ0NspQgneqmLeua
        leeU7lQ2o4u4ngqTVkAkHFQf9OFQyxiKYJ77YR24pUrBOqO/SOPiu6i08Ty1JleJ
        0JuzWoZdDbB0EfySAbH2g==
X-ME-Sender: <xms:qOaSYlk1RW8DqMuTfaCx8fe-Q3a3N2uG99ztwMrRcfFmkrYo9g6llQ>
    <xme:qOaSYg3JZzIGGda2GHATZ86Ko_cvK-ewqPB_omjTjI5Zg5Rx9HByWFIUxmVqpGv9q
    VGQMqksMQIRCi24CQ>
X-ME-Received: <xmr:qOaSYrqgLkr-NWg1lvpzVdlIyeF-Z6FiJS5LFdP1FXiOKfzTFHK08tsCC2RurYszXf2ftAxEQvHpKTQYeVqu7spU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkedvgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfhuffvvehfjggtgfesthejredttdefjeenucfhrhhomhepvfhomhcu
    hfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhkqe
    enucggtffrrghtthgvrhhnpedtjeeltdevgedthedvhfekheeutdethefhledvheelledt
    tddvjeefffeludelhfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhomhesthhomhdqfhhi
    thiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:qOaSYln3nDYvRrhCw2v6CzYdJddPwOLwvCkmNW-ckWEShyeMvo3iWA>
    <xmx:qOaSYj0LX7eGqbWO_NKFyYgyU0wyVYgeC6RnySuNNJn1EsuG8TXk3A>
    <xmx:qOaSYkszszqoacblbk_CzbS7bdQEVgW5ocV4s3y5tE8pZO-X2wx8sQ>
    <xmx:qeaSYsuueOpERZ1Kj62jaPVzvq2bwqL0nKobZyQmBSGi1GZ2tpaF5w>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 May 2022 23:21:09 -0400 (EDT)
Message-ID: <23811367-3180-32aa-56d6-355e679a304e@tom-fitzhenry.me.uk>
Date:   Sun, 29 May 2022 13:21:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: ...
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Martijn Braam <martijn@brixit.nl>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220523055541.724422-1-tom@tom-fitzhenry.me.uk>
 <65339d49135ffb578b5cd5ae459cea8a@walle.cc>
 <28d3925a-983a-fcb8-19af-6e6baf892d53@tom-fitzhenry.me.uk>
 <10c2bc96821e9a907e54ef1675dc4c60@walle.cc>
Content-Language: en-US
In-Reply-To: <10c2bc96821e9a907e54ef1675dc4c60@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/5/22 08:30, Michael Walle wrote:
> Yes that would be great. Could also be one of the other
> 25h vendors, usually the continuation code is just ignored.
> I'd bet it some china SPI flash.

Physical inspection of the SPI NOR chip shows the chip is a 
"SiliconKaiser SK25LP128" on it. Thanks to biktorgj[0] for finding that.

Per 
https://github.com/Yatekii/jep106/commit/caa92b6f811609d49b46777fce0d1f84a3550c31, 
SiliconKaiser is a vendor rename from Chingis introduced in JEP106BD, at 
0x25 in bank/continuation 8.

Unfortunately I have been unable to find a datasheet for this chip.

I will add a siliconkaiser.c file with this chip "sk25lp128" using the 
SNOR_ID3 API, and submit a patch once I have tested this.

It's confusing that the chip's returned JEDEC ID has no continuation 
codes to reflect being in bank 8. Does this risk collisions if another 
25h vendor uses the same JEDEC ID?

0. https://github.com/Biktorgj
