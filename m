Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2EB467AA0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381894AbhLCPzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:55:25 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56239 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239659AbhLCPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:55:22 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DEDA25C00FB;
        Fri,  3 Dec 2021 10:51:57 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Fri, 03 Dec 2021 10:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm3; bh=9uXKT
        NTFwNUMkkFUnSNU9TUuwmcKuxNb8o8jMDAx9cY=; b=maNAGVDAcqelMDOqnp99w
        UxuAEulLor/6t8WynxH6GRzP6Rg/3TAbqmvP5DZVe8MgJPg5V/o20el/XLOQEejU
        GKzui0gSH2hH7eNb4SfFzLfjOhMqz0Gcp1UJIdkJLWi3gJxBKY38EcbQv4jIbOj6
        CAHCzhYpFdLyW+mVQmjgZGIS2poSvQ4JwaH4iIc8rvPqXOHCzyLLRvuO7j3PJm2B
        qth1bWHY7+WqFjmPPu3aEE+OLteJINlVSisvNvsmtwayVqA1UgpymfaEHP7BbWkT
        uSNQUB3tfKwsDTZJ3hqZyE4Xo/kFhastb1c3jlWcy/LAuzCjcFpVIkuDIcX0W4a5
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=9uXKTNTFwNUMkkFUnSNU9TUuwmcKuxNb8o8jMDAx9
        cY=; b=JJoEzhDLFsGyAqrrzb7RrleBPsxQy5sSMQolmtBOu5J8frmVVN6CKwfjt
        ECuut8hkZLGW2m6BMk+20paq/iXojHlpuxTaENbOspz942ILmG/DirHusiYXmoZM
        bg8CDliR5MhQ1NRMMeIh0btBWE4CuCRlzgCthLad30/OaJJdYvyrhgOKJgMKAtby
        qea3JzVufaySL4VtZoZHYsBLQnUEzv9iPsjH6xWIWd6fHYaKJc+fUEMeLAekI6qT
        dxc4Ouxqby7Zw1ZpnwM8B3bWODTgf3LPKKk7/aDNJCRyOSx9wUX9twpHz5+MRpPd
        XP9VDrzuwZwfA88M3ChjBtKSdetfg==
X-ME-Sender: <xms:HT2qYQQvHvRTlCqphHbuV-3zFQsZ1hPT5Ch__RCv9mWxaWYd8RUTaA>
    <xme:HT2qYdy4vSZyiwA-bNFjEbXceJ4M40E_ld-pvLj4gzWtyhYGkwn_H2qohJ5mCbahm
    2z_ThRkhHrg0f6bQwk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgr
    gihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeefteegkeevfeethffgudehgedvueduvdeifedvvdelhfef
    heekteefueektdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:HT2qYd21DR1HKJK6NTLScrfHr6Yc6ilhFw6jLy6RCZDysgA9DAH_bg>
    <xmx:HT2qYUBp2kKw3GVO8iI1Y-WHUCNFRo6bVyhiZgyJlyNnf2oeeYniZw>
    <xmx:HT2qYZgU0nTRj_gw7EhU-cp5OJzqIA_3acg3ygfdvi0lnTxAqSHlKg>
    <xmx:HT2qYRgyt4fQ_asHpS-faLsfblWGUYbEYZaG7NIuAbe6PuyMYRexog>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 21B43FA0AA6; Fri,  3 Dec 2021 10:51:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4458-g51a91c06b2-fm-20211130.004-g51a91c06
Mime-Version: 1.0
Message-Id: <d662bbd4-ed39-47ef-b2a4-012c765ec4ad@www.fastmail.com>
In-Reply-To: <e4d3d685-eddd-a240-eea5-949637809fed@intel.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
 <20211203003636.11417-8-jiaxun.yang@flygoat.com>
 <343c2c64-4d0b-6e21-80e0-834d0b7147aa@intel.com>
 <57665273-e56e-4b66-9dbd-003d592eb65d@www.fastmail.com>
 <e4d3d685-eddd-a240-eea5-949637809fed@intel.com>
Date:   Fri, 03 Dec 2021 15:51:26 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Dave Hansen" <dave.hansen@intel.com>, x86@kernel.org
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        "Jiaxun Yang" <j.yang-87@sms.ed.ac.uk>
Subject: Re: [RFC PATCH 07/10] x86/fpu: Rellocate fpstate on save_fpregs_to_fpstate
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82021=E5=B9=B412=E6=9C=883=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =E4=
=B8=8B=E5=8D=883:18=EF=BC=8CDave Hansen=E5=86=99=E9=81=93=EF=BC=9A
> On 12/3/21 3:39 AM, Jiaxun Yang wrote:
>>>>  	if (likely(use_xsave())) {
>>>> +		xstate_update_size(fpu);
>>>>  		os_xsave(fpu->fpstate);
>>>>  		update_avx_timestamp(fpu);
>>>>  		return;
>>> Have you considered what exactly happens when you hit that WARN_ON_F=
PU()
>>> which otherwise ignores the allocation error?  Have you considered w=
hat
>>> happens on the os_xsave() that follows it immediately?  How about wh=
at
>>> happens the next time this task runs after that failure?
>> Thank you for the catch.
>> This is a few questions that I don't have answer, so it's a RFC.
>>=20
>> I thought it is unlikely to happen as kmalloc has emergency pool.
>> But in case it happens, I guess the best way to handle it is just
>> send SIGILL to corresponding user process or panic if it's kernel
>> fpu use?
>
> We've thought a *LOT* about this exact problem over the past few years.
>
> Intel even added hardware (XFD) to prevent the situation where you land
> in the context switch code, fail a memory allocation, and have to
> destroy user data in registers.  Without XFD, there are also zero ways
> to avoid this happening to apps, *other* than preallocating the memory
> in the first place.
>
> I don't think there is *any* viable path forward with this series.

Hmm, actually I can come up some ways to workaround it.
Like we can have some sort of preallocated emergency pool
with max_feature and utilize them in case of allocation failure during c=
ontext switch.
We'll get some chance to fulfill the pool again after going back from in=
terrupt context :-)

But maybe you are right, it's not for me, a first year undergraduate stu=
dent,
to comment on solutions from thousands of brilliant brains at Intel.

Appreciate for your comments to let me understand the nature of the prob=
lem.

Thanks.
--=20
- Jiaxun
