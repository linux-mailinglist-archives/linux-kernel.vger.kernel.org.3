Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E18E46F2C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbhLISKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:10:39 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56667 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238065AbhLISKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:10:38 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 24C075C01EA;
        Thu,  9 Dec 2021 13:07:04 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute4.internal (MEProxy); Thu, 09 Dec 2021 13:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=lL6VdIXJOg3vF68H3FdIVLlhpXBofGk
        iKJid5sNfDXc=; b=jOSKc2lYHIvmkzuFjWPFbxu+DZ5/Knsuv4i+pFWcT0gRLTO
        8keXzGrOgbKlZhcGb2jeYfUrFB6I5R1GlXkJKgiZGVZ4L87uV9qclOKkSXbcuQkn
        ZpXAzN7nMUFn4AMyHgU9Bt/cYMCk9GbDf0t192k47YfNb/QMezW54cURwR2EDeiu
        Z7YpBg8w+KoxdVVLZsdyHuqiXx7THugyDvnAcH5Xfm9Mm6Qez0OKMIVYz/vE3nxS
        PsJNWBmCSiK3FnRhImHLFaZAxigCevhM2FdlEqnNqSliIEHlctoCNmTu0HNjlLPG
        j4TCQ7cayef/FTJcOy+9+9kqWqMUycpY6Jk1kEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lL6VdI
        XJOg3vF68H3FdIVLlhpXBofGkiKJid5sNfDXc=; b=dFIQyFv7RTWYUiRzEkZ0/n
        Oid98HPKIVIlkK2i9RSyZLIo0EBR//oH9goAo94lidus9I1TKpLdylaxh4LjGPSe
        EbStdm1V6vF6txqhO/t6/wMCFlCEwmk5qpZqozpXoR77I9mgIZclp6qVndUOTcQZ
        uR62gTi1o+szbywWls4jBxHBsTG9kKZ1Rfu3Ko2CG675nWhetg6i2gWdLFpq54sZ
        MnhTK9Pb7356YOqM4GXKetqmxIWBkmewoFDCgW3LwgN1P1lqYf2Ix+avCD7WqbXc
        NI4Ws+KCDqQD8jXpqnBPC4z3zz+fTngG4mrP9dbQ8jikkG0P/6wcX5Nyu+8FP/EA
        ==
X-ME-Sender: <xms:x0WyYfs-D3LZu2QjnkSsEwjdiIhEoCdL9UKN56C8WQ6LLd1rcYpZAA>
    <xme:x0WyYQdvbUTfmI7Osco8EAy0mktE982Mlj6xkaBFX0PjI386u0V46nb1QmHMfTBYD
    -y2QvI_6b7-K5MK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkedtgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdflohgv
    lhcuffgrnhhivghlshdfuceojhgurghnihgvlhhssehsvghnthdrtghomheqnecuggftrf
    grthhtvghrnhephfduudevveefuddtveefveejleekfeevvdevgfehvdelteehgffgudej
    fffffeetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epjhgurghnihgvlhhssehsvghnthdrtghomh
X-ME-Proxy: <xmx:x0WyYSzoLNjzWI-TxkiQxOhgDrP_R6pFPQRw3vJhha-jruuaX9eykA>
    <xmx:x0WyYePOKdmM0Ik3RC_dr-CDWWG5JWZTTWW6MceticiQTjeOlq1i2Q>
    <xmx:x0WyYf_MNNZlpS-U7KTWXzzobgQyhSINp7W8fqRs_VhjwEZXmZ8zLA>
    <xmx:yEWyYZmzCPUTjDye44AP8rBEPzitd3bkl9tPUakWLcgHj_PJKeQ68w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EBCB9AC03DB; Thu,  9 Dec 2021 13:07:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4506-g4374de3f18-fm-20211208.001-g4374de3f
Mime-Version: 1.0
Message-Id: <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com>
In-Reply-To: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
Date:   Thu, 09 Dec 2021 11:06:42 -0700
From:   "Joel Daniels" <jdaniels@sent.com>
To:     "John Stultz" <john.stultz@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Stephen Boyd" <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Time keeping while suspended in the presence of persistent clock drift
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My email client just stripped all the newlines from my message making
it unreadable. I apologize and am resending it using a different
client. The original message (properly wrapped) is below.

=========

Hi,

I have an x86 laptop whose CMOS (RTC) clock gains an extra 3.75 seconds
per day that it is suspended (S3) or off. It keeps time quite accurately
while awake using the TSC clock source. I use the machine about 1 hour
per day with the machine in the S3 sleep state for the remaining 23
hours.

The machine is not usually connected to a network and I do not run an
NTP daemon (though I do not believe this is relevant). When cold
booting, I correct for the CMOS clock drift using hwclock before making
the filesystem writable. When resuming from suspend-to-ram (S3),
however, I must either use hwclock again (causing the system time to
jump backwards and potentially upsetting programs like make) or use a
large slew rate (absolute value greater than 1000 PPM) to correct the
system clock.

As far as I can tell there is currently no way to inform the kernel of
my CMOS clock drift. Is this correct?

I am considering writing a patch to make the kernel compensate for the
drift of the persistent and/or RTC clock(s) when injecting sleep time.
The patch would require user space to inform the kernel of the drift
(probably via sysfs). Does this seem like a good approach?

Regards,
Joel Daniels
