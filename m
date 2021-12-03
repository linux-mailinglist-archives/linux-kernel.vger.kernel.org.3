Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343974676DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380630AbhLCL7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:59:48 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:39913 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380634AbhLCL7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:59:31 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 718773200D18;
        Fri,  3 Dec 2021 06:56:06 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Fri, 03 Dec 2021 06:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm3; bh=P1JnN
        uOJBaEFcRxzCTmeX1soA0TSx1mKmYgCyg0MaC0=; b=h2ozRM++TDYySVKq6ir9o
        ixVDLSBihIDC8Fh+BPHH7EZQFQQ89GYA2tTrzWnYxjef0qQaw1dKKjUGh9rhNlb+
        X6UmgyWd2XBlqmL+0fCBFeUAxa7XX2PY7lMHdLk9F6qT10Cj1BkgqxGYS5vYUfcS
        ZzvSLYVr7dQLC1WZA5pf1MrkmijqFMsv7mDj8bVWoCH6SGYsAGlg8HJ/6KcB7NmG
        1kiGl3QzhPAbaZjj9WOFNxMYVCTS5nTOy3EFihML1DXo+oRJ2Yh861WpHVdnMPFJ
        2aa+BM9OuSXnX2dKKPtbP/nZTOY3XvlbxqS8KgbFS7wH1GMIKej9/ZgFsgrJP4xJ
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=P1JnNuOJBaEFcRxzCTmeX1soA0TSx1mKmYgCyg0Ma
        C0=; b=gY3fpsSy9a+AXRuPbpBE0t7tEUFOHGZa90si+wggOcZDuTvc2c9M53Ktz
        75Oop4TcMEt0E4z62Bl6s1J7m1LEl+bISB6QERPFOp9QYeIE76LNkMeSGx2tJrrL
        Eys5qi5mR2u7V7WEVAsFaPPAOL3Acb1XPjpV6JSrBdYTzp/kuC9xEfFTPQ6J5er+
        OH68Ieln2TDaWADKbCAHoNk7o2n4yZffVhTDyZB4LLHHbe4hApJNv2Fpg99WnZhk
        VeZzu33oDPYj+jAkxIeDsACX1FlXsbRmiVeHGmK3aoxHBQt5OSIt27GDvwcAABXi
        KyrFvWNaBXEU1zL5oOsJTRez3qXQA==
X-ME-Sender: <xms:1QWqYYq3qMU5N3vtGf7vBIvMymp4TYxV1AnGI-qCdQoldVSI0mwH6A>
    <xme:1QWqYeo96uQ73sVxVHHOQnvjgZZb1tAtf7R0xugowwGYAS0oKuecxQ9Yr5r5tOTrv
    4-9poWGAnZG6AyCdJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgr
    gihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeettdejvddvtdfhgfehueejtddttdfgkedtgefhledtkeel
    fefhhfelledvjeekffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:1QWqYdPwdOLFjVRqtjLC2MGrpbSoj9VUStAVtIr4aXQe_J8Qg3JZpw>
    <xmx:1QWqYf6Hj73bXShaNaTC16dIVwqXnnlQkVV26dWswmclUyu6iGNfnw>
    <xmx:1QWqYX7ftohda9o2tAmSp1NwTMBZcCDOzg4vZHEZMy0i1k8Z_O2iEw>
    <xmx:1QWqYUsTOxfMSmJ3cB9dLGAKg6ev0nqDh8SON8ojwQPkS3QsSZ7vpw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4ADB6FA0AA6; Fri,  3 Dec 2021 06:56:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4458-g51a91c06b2-fm-20211130.004-g51a91c06
Mime-Version: 1.0
Message-Id: <8aa8ed78-5c78-49c2-b100-607a8f4e8eae@www.fastmail.com>
In-Reply-To: <YaoEqpNkuAqSlPaq@zn.tnic>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
 <822ced92-f165-3c5a-e0bf-dafa6f808b76@intel.com>
 <27b6387f-fa93-484e-a56e-12452a82f069@www.fastmail.com>
 <d7be6ef4-f73e-923e-93b7-ef254bf347c0@intel.com>
 <e249390b-6f87-47f6-8676-fa727b2fa932@www.fastmail.com>
 <YaoEqpNkuAqSlPaq@zn.tnic>
Date:   Fri, 03 Dec 2021 11:55:44 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Borislav Petkov" <bp@alien8.de>
Cc:     "Dave Hansen" <dave.hansen@intel.com>, x86@kernel.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, dave.hansen@linux.intel.com,
        hpa@zytor.com, chang.seok.bae@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] x86: Allocate AVX512 xstate ondemand
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82021=E5=B9=B412=E6=9C=883=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =E4=
=B8=8A=E5=8D=8811:51=EF=BC=8CBorislav Petkov=E5=86=99=E9=81=93=EF=BC=9A
> On Fri, Dec 03, 2021 at 11:42:10AM +0000, Jiaxun Yang wrote:
>> If it's improper I'll drop the statement in commit message :-)
>
> Actually you should answer his question about what happens if you clear
> those two bits in that MSR.

It made AVX512 states available in XCR0. I'm still doing some experiments
to see if AVX512 is actually enabled by this.

Thanks.

>
> --=20
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

--=20
- Jiaxun
