Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AA646ED21
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbhLIQhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:37:12 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:55357 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235038AbhLIQhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:37:10 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E79AA3201E46;
        Thu,  9 Dec 2021 11:33:35 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Thu, 09 Dec 2021 11:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=iUWoNkDex2mUJJmI1wEexloUl+w0
        4ME3+8fgziEwZek=; b=YY4l9hJtcy4EZ06XtcieVJ+48heVMWFwTWHSlt8LrOyJ
        L5448WmCOwCGtHRbbuET9nqR+esz4A7iCaFP4f2l1sTmO1UC7d5P7XGCW8YfQzUK
        bQxRJWNVJJIzEZJZBq9nRUEld/Lyzc6M/hWPFZbcG8QJAXIsrgw1AXChMjAa6r4p
        KP6+ARfkALimXrhrnJYhCdHbgDhUoYZrsQOvQsbQx7c4AU252ouLHeTeDa1Ll9AM
        As0Zc3/8Qi5/nfNb/QdRmy6C+mP+eD/KrjWLHRSYN7iGgRlOd1xF/jGnbQ2e72zE
        8KpzJxdMfgkPpmwKwSuPgdgZ2Q/VcBqJVLs9j4mnEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=iUWoNk
        Dex2mUJJmI1wEexloUl+w04ME3+8fgziEwZek=; b=Umv4YMSG2SIHbU8A2Kwmth
        H1pB/OeTI3DSCalNRCqn5CWGkVsvgPo6RCBPOCMeOSrN5hKxIyuHm5mkybT4YV9r
        TDlvxOL60pz8y298ufT+bWJH4WPq4goHPxcQ0uFeAIJGJYTzeJPjm/RoqHBJNJHP
        YnyObGQanb2s0i18e79R4DwG8a7syTNqKwJS70SN6cpYwXtPnfiqOwhR/zgJFz4R
        PAv9KoS8EJyruEFnrays+U46hyBbLwyg73FJXEgcx9gfH7+QpnZiQlSqtVzVbIAP
        6Hpl2nrUUCAXDzxhcts7RiejYHelloV+/8634Ru9nQhUQd1XK7Z3/kSdYRY4Oodg
        ==
X-ME-Sender: <xms:3y-yYY60l1X6kb71rvFxg_tFejAcdszwhNSw6LDSEhm19QKa5c8CQw>
    <xme:3y-yYZ6QrZzWez1mFwqUab64ypqzhEw5z9lDPwlpbP2ZkqNEpSsS_ykP-sLnHLGjA
    zkBbACe4vIbY5LqLVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkedtgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
    keffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:3y-yYXff3PIBLiXD0k7AKmt879JbppDLGh1YvG231HR3gSrXy25pkw>
    <xmx:3y-yYdJ7Z1HmC5-eLE2ytuXCl_GeLkf_nj49l94o9O-m0_PdwrJL0A>
    <xmx:3y-yYcIoKiAi5Cu8HAk-CID80qwNzws9Q1OK0wuPsDpPNpkHE-Yylw>
    <xmx:3y-yYWjE8KiNMFxkRKAH_CbE-j40hOSUV0DBunxk4K_iD_fW7zcAQQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0ED52274050D; Thu,  9 Dec 2021 11:33:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4506-g4374de3f18-fm-20211208.001-g4374de3f
Mime-Version: 1.0
Message-Id: <3fb087c1-2d67-4527-ad63-1f8ce54e6965@www.fastmail.com>
In-Reply-To: <20211209055049.99205-1-marcan@marcan.st>
References: <20211209055049.99205-1-marcan@marcan.st>
Date:   Thu, 09 Dec 2021 17:33:13 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] Apple mailbox fixup: switch to generic compatibles
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021, at 06:50, Hector Martin wrote:
> Hi folks,
>
> Just a quick fix for the Apple mailbox compatible. Similar to [1], we
> intend to use SoC-specific compatibles only for potential quirks, and
> rely on a generic compatible to allow for forward-compatibility as long
> as things don't break.

I vaguely remember a brief discussion about this and I think we thought about
using "t6000-asc", "t8103-asc" in this case since this specific mailbox hardware
was only introduced in the M1. I think Apple calls this variant ascwrap-v4
and m3wrap-v2.

Doing it like you suggested is also fine with me though.


Sven

