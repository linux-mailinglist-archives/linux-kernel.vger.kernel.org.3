Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8164719F0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 13:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhLLMDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 07:03:19 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35489 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229648AbhLLMDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 07:03:18 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B29FA5C0073;
        Sun, 12 Dec 2021 07:03:17 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Sun, 12 Dec 2021 07:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=npkiZPxRbSsbH8w8a+eeH2xuAjWw
        Up6N4n32YxdWRoY=; b=MO57nPBacHf2oezqLw0RD1Mu/tCYQPqC20KDvihaYCRR
        q3pDpBeSQIvTsLcAsI7Mb2IDCXZDjMPtyh8kaCSDeoIchBqhyeNFAXfnyAU7RUXj
        EACW1qkJW7e4XxPbqHWRpkfvbeeTY4kOaHc5FNgCohq56qHjwZjnCIGJaPILsu71
        DO7tMuELhoxBAL0oWZpSv3kGI2KGrP40n+nj/Gp1nxvCGEbOnzRVREe1jknhboQB
        PgArj1bblrfXR0J7p3QnlcW7Sxbhhnmn9Ul+ZDjKqGSnO47fno43+/XcHGGsS0Aa
        UwYC1QZeHxNtOu/b7d72N5UuQs00ZV/Y0FqzRRUSiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=npkiZP
        xRbSsbH8w8a+eeH2xuAjWwUp6N4n32YxdWRoY=; b=WQe0Bm66RF+CziMbhnavq+
        6eckcI2qpyp8xiRDkfxLmHu5uJZ+HFagH9L0WclhousRnOqIXjgs048f1juZtwDw
        V+rVUjMIn6rkAp1XNgf4wDiJ00Tx+pL9UAfWUSX0uPPwQQvgWe/CJo6HcFMLcBfO
        RwtMRxu4QS1nrWlbvwABfspq+RGA4pzRBF8ABTdwgMxDeMQ6jlfBz6l7sF2o7Now
        smoCC3gnSydJQjwQdfppkFgWTZjty/VZ5q6MG2r1isCPEcnp8owVLyACi+thk7SD
        Xxopocii53Mocks9/RrQobt3rEiZ1UsoRkGBiUqNe0qraujSoEirfYDsnSnSH+dA
        ==
X-ME-Sender: <xms:BeW1YVhPEQuLeJxq8D_9LhC_94-_BNw4rO0qOdUNJHBQ-gSNc7s9gw>
    <xme:BeW1YaD0vQBQvMYiA9Mzh3EZkamE6skuOG-xkRZMA609Az4_vCdylT6RdmRVjkMsm
    Zi0rDQg_ENGzjx-XYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkeeigdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
    keffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:BeW1YVFAiTVAi0haE1f8twzbXryYgZb1lzceaFL2UVGP4skuJyjNbQ>
    <xmx:BeW1YaSUyOhbks-U-tBMrzrZ319HeTDnbBVEOLvNL_QWXiYU3S_Jkg>
    <xmx:BeW1YSxmZs7gsWHHN844vFw3Ztr2TRARKZ-MLhK-pHDrTdFyPtl8Ag>
    <xmx:BeW1Yd-Mzwm35LuvysIysIYrpPca9C5hHKYawCYDRnp3vFPbpdOLeg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 854CE274050D; Sun, 12 Dec 2021 07:03:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4514-g2bdc19e04f-fm-20211209.002-g2bdc19e0
Mime-Version: 1.0
Message-Id: <ade9dadc-a816-47aa-8033-256abf3a54c7@www.fastmail.com>
In-Reply-To: <20211212014346.69320-1-marcan@marcan.st>
References: <20211212014346.69320-1-marcan@marcan.st>
Date:   Sun, 12 Dec 2021 13:02:56 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Mark Kettenis" <kettenis@openbsd.org>
Subject: Re: [PATCH 1/2] arm64: dts: apple: t8103: Rename clk24 to clkref
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Dec 12, 2021, at 02:43, Hector Martin wrote:
> We now know that this frequency comes from the external reference
> oscillator and is used for various SoC blocks, and isn't just a random
> 24MHz clock, so let's call it something more appropriate.
>
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---

Reviewed-by: Sven Peter <sven@svenpeter.dev>
