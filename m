Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B186530FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbiEWNKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiEWNK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:10:29 -0400
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4763454185;
        Mon, 23 May 2022 06:10:27 -0700 (PDT)
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 23A0520158;
        Mon, 23 May 2022 13:10:26 +0000 (UTC)
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 9A1CA200FE;
        Mon, 23 May 2022 13:10:22 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id 8D02A3F203;
        Mon, 23 May 2022 13:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 81A6F2A384;
        Mon, 23 May 2022 13:10:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xRHO4Msw78f3; Mon, 23 May 2022 13:10:19 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Mon, 23 May 2022 13:10:19 +0000 (UTC)
Received: from edelgard.icenowy.me (unknown [59.41.161.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0A57A4010C;
        Mon, 23 May 2022 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1653311418; bh=tCctaG9lD2zZr9aAnMweZ8VtB5FmvJDDCVIR2dwhiCs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tRLM43pIC2yfKKJHo3qlEzTagk6+uyxU63u5TDAZSqr8UH0/qUAC6YkzqLh4l3Vbl
         OPF42qDhNsnkbu02SqvDqdxFTzKSlvyvGcxO64mHyt2vhuwu9uebOiqfC+Jtknf3M9
         jSZP+HgNm5aa3QPBl25NebIs2VAsIB0njuwI+o3s=
Message-ID: <265770e7055837fee26a7a66ce1fcbc7989eaf99.camel@aosc.io>
Subject: Re: [PATCH v4 0/2] ARM: sun8i-r40: Enable usb otg support
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Evgeny Boger <boger@wirenboard.com>, qianfanguijin@163.com
Cc:     andre.przywara@arm.com, devicetree@vger.kernel.org,
        jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, robh+dt@kernel.org,
        samuel@sholland.org, wens@csie.org
Date:   Mon, 23 May 2022 21:10:09 +0800
In-Reply-To: <ec5f7fe8-d47d-ce7f-0e0a-2bdf41a88ba2@wirenboard.com>
References: <264cb004-677a-13df-cc68-676ef3c2e7d8@163.com>
         <ec5f7fe8-d47d-ce7f-0e0a-2bdf41a88ba2@wirenboard.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022-05-19星期四的 23:54 +0300，Evgeny Boger写道：
> Hi qianfan,
> 
> As Allwinner A40i user, let me first thank you for your effort for 
> making better upstream support for R40!
> 
> However, I would strongly suggest *not* to add USB support to one
> more 
> Allwinner SoC in this particular way.
> The problem is, this approach consists of a number of carefully
> crafted 
> hacks in device tree to make current drivers work on Allwinner
> hardware 
> without modification to the drivers.
> 
> a few examples:
> 
> 1) please notice how ohci0 and ehci0 nodes do not contain reference
> to 
> usb phy. It is done intentionally, otherwise EHCI will reset musb
> mode.
> Of course omitting phy reference here is also completely breaking
> power 
> cycling in case of usb error and otherwise messes with a power
> management.
> 
> 2) one must always enable ohci, ehci and usb_otg nodes at the same
> time. 
> If one forgets to enable ohci/ehci nodes while enabling usb_otg node,
> the system will silently fail to work as USB host.
> 
> 3) For host-only mode we still have to enable usb_otg node despite no
> role switching is needed. That's because phy reference is missing in 
> ehci/ohci, so the ehci/ohci driver won't enable the PHY.
> Also I might be wrong, but I think phy won't be routed to ehci/ohci 
> controllers is this case.
> 
> 4) musb host controller is initialized and present to hardware though
> never actually used
> 
> To summarize, not only the resulting device tree is not describing
> the 
> hardware properly, it is creating device tree configuration which
> will 
> be very hard to support in future, once proper driver support is in
> place.
> 
> 
> At Wiren Board kernel tree we tried to untangle this issue [1-6]. 
> Unfortunately I didn't have time to prepare it for kernel submission 
> yet, but I think I better submit it as RFC to get a feedback from you
> and others.

Please cc me in the following patches because it's me who makes the
whole dual route thing hacky.

> 
> 
> [1] 
> https://github.com/wirenboard/linux/commit/359abbbd86ddff4d3c61179c882c286de32bb089
> [2] 
> https://github.com/wirenboard/linux/commit/6327f9d7972c21b229fb83457fdde643b31553f9
> [3] 
> https://github.com/wirenboard/linux/commit/f01f4c66758bde460a4d8c5b54ecee3b585c0232
> [4] 
> https://github.com/wirenboard/linux/commit/c27598ad601e5a46f624b73412a531d6f1f63d37
> [5] 
> https://github.com/wirenboard/linux/commit/5796d6eebb86b32a3751b2038b63af46f94954b3
> [6] 
> https://github.com/wirenboard/linux/commit/0928a675d875f9c2849fd3a9888f718bbb673bda
> 
> 


