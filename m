Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D31475E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245213AbhLORPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:15:41 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56543 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245165AbhLORPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:15:40 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B6DE63200B25;
        Wed, 15 Dec 2021 12:15:38 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Wed, 15 Dec 2021 12:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=kfnX5edf5f3mfD00V7kFxnR+Owd2
        RE5fLSxgGCntQtE=; b=NWNNynu7p4l5Ju+cMb+ZIs5z1SPXgUHA6XPrqLe7yEZE
        N45y+XaXezCECS127ATmA3cinm8RDwVuurtF8LzepJnp7doMfZLSTSPUUPC+R+KI
        jRx9tqNl6VynGjUXwmBg6URYCSMSsLD6GjirZxUUoDnZU8PGjXPV6Y9rjY28aESK
        fJDeYYk4Ti2uWVzW685Rg0GjpdLzK7qv/LW/6pPS2eUyn8sWRW/AeK748xzD2Fw7
        P49+8Dfn0RWZw9NOK68KgWynTChwMCs92rTPm1xZyU5vByHhvujvpPiW9HA2LO4w
        DGRx7OOSnPwp8pgr0n3sAZr7bfSEhsaM9lXUu+aN2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=kfnX5e
        df5f3mfD00V7kFxnR+Owd2RE5fLSxgGCntQtE=; b=iAlLDKqFlqWvKUT9b+vRvM
        jyfjfW+l1O2ljgrdy5Siqme3ono7mQFH3uQmVIM5fRdbTTEmkqRxwxoJeA08Cw+B
        9sjH43LxKGMBCyp3EXZ1qABSGXYFrX/Uz7U1U0Nol8DJsqPn+PTCqAitc3YT5seB
        Uuo+FKbjTSZjtwaOvvExkVttr0/5zKPR9oP/6F1yT0xXHOKOe3kLOc/IzQ6Dztjh
        EoV76IRsW9fA0cVCioGD6AIsW/rXr+Av2OgxCuXS6UZZnp0MsZL909XPaLZ1AH1W
        fNzaoOqV7clsWHRXuDbGvr3KWmeEEdpeeyYscPO02wg+U6G5zT5HVjPvd60tSMUA
        ==
X-ME-Sender: <xms:uiK6YVCKXG3sQuPFJJdcSGXBnkWNZb_HX2MvqV_F4lnEmMQJPFXdxQ>
    <xme:uiK6YTjgYN45Q3N-FH-ucuWFjhfOoeCTg_4XzjLHuwLoNroCh2XJaXLUAJano1nGL
    O6xle2zELVZyDG8vPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrledvgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:uiK6YQkgsvM4z320LIDNg2xi6_gooebo1qrHrFDSZwTLARfvoxgT5w>
    <xmx:uiK6Yfwlz2Zrk4hh-mxZ1Qtl25Lqui_JFEQQNNeyZVx9dtkoHQmNSA>
    <xmx:uiK6YaRY56pjrkih0cGP_cPmaiFo8J7yRSHEJ2iJawFdHPlMfELQlg>
    <xmx:uiK6YXJ2OmVM38tblrf2XfijPuOu3XHBIv3EyFSl1EdlxD7tVxqYGA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EB3BE2740372; Wed, 15 Dec 2021 12:15:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4524-g5e5d2efdba-fm-20211214.001-g5e5d2efd
Mime-Version: 1.0
Message-Id: <adfe92e4-8df8-4bc2-a4ea-0c65a4bd6210@www.fastmail.com>
In-Reply-To: <20211215155527.36775-2-marcan@marcan.st>
References: <20211215155527.36775-1-marcan@marcan.st>
 <20211215155527.36775-2-marcan@marcan.st>
Date:   Wed, 15 Dec 2021 18:15:17 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mailbox: apple,mailbox: Add generic and t6000
 compatibles
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021, at 16:55, Hector Martin wrote:
> Much as we've done with other blocks, let's introduce generic
> compatibles so drivers can bind to those and still work with future
> SoCs, as long as the hardware remains the same. Also go ahead and add
> compatibles for the new t600x SoCs (we group those as t6000).
>
> Note that no DTs instantiate devices with this binding yet.
>
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
Reviewed-by: Sven Peter <sven@svenpeter.dev>
