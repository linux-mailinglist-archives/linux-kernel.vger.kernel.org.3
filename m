Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3638475E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245182AbhLORNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:13:52 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45525 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232113AbhLORNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:13:51 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 50A573200AC9;
        Wed, 15 Dec 2021 12:13:50 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Wed, 15 Dec 2021 12:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=dKRYSHsF8+MVBLgEseJB8cFej/V7
        MP+0uhIqkNY7WMI=; b=bJgfJAdlDCqUBgq9g2oiU57tlA0+hScIj04XCisjqupL
        2EFSkRJ50qXYW8J4Ilxlur0NrlcozCwms/q1nTTwEJS5duaEgE2H4bUgBd0OaeVV
        8g9QcQpp2bbLjYCHd7gFViZewrsgsoZf8v/w1atSoIrEkcdy4K2ketFWNnmmlQA1
        ghJ54fljN/gh0DgoldQooQ/HmaFTwJI4ozI0ClfVm9fH8R5e3AlJakmTild0kOmB
        TL+4Vp8K0ifRUJI2fLZPt0gu4tx77RDq2a5ikR/+b3wY6fRMeIfMja3UpHmVQOTO
        t1ehMSzscjqo1FZLujTRiBBrUcrWBNX60zTLqprbyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dKRYSH
        sF8+MVBLgEseJB8cFej/V7MP+0uhIqkNY7WMI=; b=EsoeJj9Gxpdv/HXJExFCBl
        uA52qywq5cnOiWtagZK8+qExY2EoioozCu5ooJfOV1gvtH3Kdr3DmDZB+TCUz3vM
        gjOPxlxdpBkuE5CXCtXyd1bxmsYxiDOCLS5cznjNy3ajG6KuVph06ezjJaIM1Vui
        BzBhMOS31mWeE4cN2P8be/XdmKoMeeN+6W+/P/ov++3B+9GXZjyFWGEj9hCKI6zE
        Vb8UcR+Hw3/kdO5H6m4Z9WqVLFdt2tjwg3Sy/mVpT5jIGP8MUcZtkVg0/Nb3amCP
        5GRlMF44FTtcOQDg8gAPbMcLqRMBRd8kgZGUxUXOmgUQVd6ZkuoYjY6hqOqLl9PQ
        ==
X-ME-Sender: <xms:TSK6YdEIDcwNOLO14YcWzWo8mLWI35meg941SqUO3NAAL7wrDhqHBA>
    <xme:TSK6YSWjGj5BZ9K9PzJJt1htb35HwtTzLaxHPtdf6a-sdwMvoVSBVcXE6kwjNXdN8
    SifEMr2yo4AWzzFonw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrledvgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:TSK6YfIMZ9NL9RhRfr89A9JwXtW9G6dtV2yRrBsfqepEl5admrLvDw>
    <xmx:TSK6YTFbfagZGKvcEaShUhdamJ5uLTbnzus7-aYrOmIIuZWti2V_Ag>
    <xmx:TSK6YTWevSjZ2FTRhGjeADzmZkb6K5vfp9n3x3dBSEGUbDSbkLRzng>
    <xmx:TSK6YZe1Zb5B_ppw6GIicjBoLNAOWFBgvAR-WHJCA7koK_QiB__6Fw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4178D2740372; Wed, 15 Dec 2021 12:13:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4524-g5e5d2efdba-fm-20211214.001-g5e5d2efd
Mime-Version: 1.0
Message-Id: <65364b7f-0c09-4cc2-bbb5-bcaaebbfea70@www.fastmail.com>
In-Reply-To: <20211215155527.36775-3-marcan@marcan.st>
References: <20211215155527.36775-1-marcan@marcan.st>
 <20211215155527.36775-3-marcan@marcan.st>
Date:   Wed, 15 Dec 2021 18:13:29 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mailbox: apple: Bind to generic compatibles
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Dec 15, 2021, at 16:55, Hector Martin wrote:
> As with other blocks, we intend to have drivers bind to generic
> compatibles as long as there are no SoC-specific quirks. This allows
> forward-compatibility with future SoCs.
>
> No upstream DTs instantiate this yet, so it's still safe to make this
> breaking change.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
Reviewed-by: Sven Peter <sven@svenpeter.dev>
