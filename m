Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B8B4676AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380530AbhLCLqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:46:00 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:33271 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234517AbhLCLp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:45:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A71953201C40;
        Fri,  3 Dec 2021 06:42:32 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Fri, 03 Dec 2021 06:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm3; bh=qoZoq
        Zi5f6O1ZE9VN5Lkcc62PAK4WSBYtHV6+Z3ybsU=; b=EiPsUowdywIY4PSsz8Oh8
        eTusZ3zAQDjVwsG7eTzmEo2BFd9p46JATi5IQ1uiUNUcPwAzyIfZtJO1UTMZGNnp
        doyhSmdsuge5mTGJp/U05tZWDzffguFQhcOnozaJepryTjJkMeuSYrRdAuXncUhV
        ksglf+e478n+xdetwoqm8Q2ML4tJML41sBGRTeYGShw5MS66CqWtBKJjOkcZJakm
        PlbjHOyfixzmcjDMueVrpu4c0UzY90gRFGKIK0yiHoi/KlF02Qrv9lb4Mo3r073A
        EiK8WZ0XOEn/FQ1mVmqn7PP40hemcEyaFzsRKSQJ9OBYiC4HJZTr+/3DgalGDMmm
        Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=qoZoqZi5f6O1ZE9VN5Lkcc62PAK4WSBYtHV6+Z3yb
        sU=; b=e6lWcl2pigcyNlLyuQgXN1p6eag2PNnImA1bJNHnQSxyhNX07nQkprZ73
        iwWo22pTh+NDzhlfhqqejnnF/Ss0fJrv8SK6pDHVj0iXeGAnlyf7BoYMgKJBiRqj
        ueiUcqPo8LruaIvy+vWnpsU3vSKpotjXrjSLbX+mix8ID0WIXGg5URok7IoWfFEI
        +8EPdPz4075I9xzPmb71h66AyuLVBL4MVQPZINrMVw0GjSz1bWGNyQ4KRjoxJfoX
        qeGiHYhvUDcckn7JEH7fBeNSqM1ksnQvaknPkTSAwjWLd8VEAHSjJIwWqAEmyJ4Y
        Go93TuoiOwHDB6j3avDFzJxrte90A==
X-ME-Sender: <xms:pwKqYZwHc7sKSsCoYLMFleCi_FnWqbQ13zoee93JX078vJ9hiSY3JA>
    <xme:pwKqYZSBlrxgeytMx-zFAW4-r5pJ0oLF1GmbR7zMx6enH3tLTPwn7fmgGbwn63g1E
    MpHVA3xyhzJSpJSFxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgr
    gihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeefteegkeevfeethffgudehgedvueduvdeifedvvdelhfef
    heekteefueektdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:pwKqYTV8UEiI4MBNFsvzyORzly9hSJfWGOp5OJgPudyOHuSOGk6mnQ>
    <xmx:pwKqYbjsm9VsflxmoC9zCZWJ-wHDlPC9DGzBPgMwz-c7LuSXEeV-lA>
    <xmx:pwKqYbDe9A_zVWI8ii7vYtFa9vXgVj2G3xfLGW119QJmQFxXBxVW0A>
    <xmx:qAKqYd2LYRyEFO840Y5zh33ptvf27MSsKBTrD5bymHVJ_G5jxKhvqA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3092EFA0AA6; Fri,  3 Dec 2021 06:42:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4458-g51a91c06b2-fm-20211130.004-g51a91c06
Mime-Version: 1.0
Message-Id: <e249390b-6f87-47f6-8676-fa727b2fa932@www.fastmail.com>
In-Reply-To: <d7be6ef4-f73e-923e-93b7-ef254bf347c0@intel.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
 <822ced92-f165-3c5a-e0bf-dafa6f808b76@intel.com>
 <27b6387f-fa93-484e-a56e-12452a82f069@www.fastmail.com>
 <d7be6ef4-f73e-923e-93b7-ef254bf347c0@intel.com>
Date:   Fri, 03 Dec 2021 11:42:10 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Dave Hansen" <dave.hansen@intel.com>, x86@kernel.org
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] x86: Allocate AVX512 xstate ondemand
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82021=E5=B9=B412=E6=9C=883=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =E4=
=B8=8A=E5=8D=8812:58=EF=BC=8CDave Hansen=E5=86=99=E9=81=93=EF=BC=9A
> On 12/2/21 4:45 PM, Jiaxun Yang wrote:
>> =E5=9C=A82021=E5=B9=B412=E6=9C=883=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88=
 =E4=B8=8A=E5=8D=8812:40=EF=BC=8CDave Hansen=E5=86=99=E9=81=93=EF=BC=9A
>>> On 12/2/21 4:36 PM, Jiaxun Yang wrote:
>>>> Also we are going to have heterogeneous processors that
>>>> only some cores support AVX512, it can be helpful when
>>>> dealing with such processors.
>>> Really?  Which x86 vendor is doing that?
>> Clear lower two bits of MSR 0xAF on Alder Lake give me some suprise :=
-)
>
> I honestly don't know what you're talking about.  Does poking that MSR
> allowing AVX512 instructions to be executed on cores where it was
> otherwise disabled?  That's entertaining, but it's far from "supported"
> or even support*able* in Linux.

If it's improper I'll drop the statement in commit message :-)

Yep, I'm entertaining with kernel hackcing.

Thanks

--=20
- Jiaxun
