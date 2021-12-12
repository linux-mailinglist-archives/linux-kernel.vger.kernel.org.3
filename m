Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A0E4719EF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 13:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhLLMCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 07:02:40 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41367 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230297AbhLLMCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 07:02:40 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 65E435C0073;
        Sun, 12 Dec 2021 07:02:39 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Sun, 12 Dec 2021 07:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=/5Cz2BtO3DUvFunQHjzibS9cJPEw
        pZM6BahZA6i/oBo=; b=pNvY6T3TyLHET1Rib1o9CXV3w6imu1fBgc2iwcMc9D29
        QZf3bEpwX7HwU1BjLIY4RqEo5DvlgyacF5g6OtzHiLRpiW/tRlBCd5V8W31+5Bqw
        yfnsKqf35pZ9x5FuL7I0jnftQ4sH6rZIfGdEcnKpfwxdeJhatqjW+hUNsN7v/9MB
        FjlnYP4PYUiKuj9HLqGmC4R5cyGUVf7Q1eV9iw2pBLlEvhzAl8Cn5SCQoUfmkq6i
        wnaPSYkjEoQy1Zrv9+PACsjc3+wNdP0ess/AjwUWiqHfTE5VMw0gijptsHKezGm9
        /qbVTeKfc6tEnb0D7WaCc4DKMjv8jxHZG+4E7cRo5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/5Cz2B
        tO3DUvFunQHjzibS9cJPEwpZM6BahZA6i/oBo=; b=FJU20sev640LMexpGW8ypz
        Xc3U1y784ZU937mm6Vzd4wsmJ3bXbSixKpTWV0s9Wm2hcb13ucnqNnZFW6kZMei2
        Ph8gADLgAbZy37gPNhK47HYxP3rDOYP8X4j4tchaZOYGLSDKYlFIaWLHKRzjkTkU
        omSSqx0ON/LKu/2znMlYc+nqy3LJDC/auc4mNW8eOIKFxh2U7FnOUQ4iglXFyuwB
        qwT11oIppE/4AhVvG42tKNr/kdXfdlj8Iihr/E4zxVlXQ+45p6yUFRVWKDIoAkSl
        y2ewopHkhnrl/EKh6WUQAEVpXggVpP1FbqX9ZdIgOn7ac34yJtpFSnWm3xSASElA
        ==
X-ME-Sender: <xms:3-S1YWeB67usrc2tdyD6E_hS3NwjWB-wVA4t0AVnfMSyOveWLkuXXA>
    <xme:3-S1YQO_cn734gMLsCaPl142xvbqiwZfVLEV-A4gE3vgwvi_Q6Xg6j0ogyOddLMjV
    4Oq0IEMgH0KPZ8FYKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkeeigdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
    keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:3-S1YXhenJYz3CwsM2mgM6mm0Yljf66SN1VoZCGrBrsFSktlWys_Mg>
    <xmx:3-S1YT919wjFLFBmQxGSBup9flN3OZMOZ5aGW5jAd01nrrL201f79g>
    <xmx:3-S1YStKCxlz9wUwrOLjp3Bs4TnLRSnupwPr7gWmmyNxv9KvjZudEg>
    <xmx:3-S1YXVJKgickXgoRcHFalc4YjD6yboHnkGHKAa0QkP3wuwgUq0AFA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 376F627407D3; Sun, 12 Dec 2021 07:02:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4514-g2bdc19e04f-fm-20211209.002-g2bdc19e0
Mime-Version: 1.0
Message-Id: <1ee0879c-f35e-4223-a8a3-a7ec016d2cfa@www.fastmail.com>
In-Reply-To: <20211212014346.69320-2-marcan@marcan.st>
References: <20211212014346.69320-1-marcan@marcan.st>
 <20211212014346.69320-2-marcan@marcan.st>
Date:   Sun, 12 Dec 2021 13:02:17 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: apple: t8103: Sort nodes by address
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Dec 12, 2021, at 02:43, Hector Martin wrote:
> We decided to keep SoC nodes sorted by address for sanity; fix a couple
> that slipped into the wrong place.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  arch/arm64/boot/dts/apple/t8103.dtsi | 56 ++++++++++++++--------------
>  1 file changed, 28 insertions(+), 28 deletions(-)

Reviewed-by: Sven Peter <sven@svenpeter.dev>
