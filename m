Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B1847193C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 09:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhLLINB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 03:13:01 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:50259 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229772AbhLLINA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 03:13:00 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 13E475801F2;
        Sun, 12 Dec 2021 03:13:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 12 Dec 2021 03:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=KPcBI0VsCIpDPCKPoMMXiKiHUmJ
        WKP12ZNGBmezXZ1M=; b=vpEH1IUfexZlXob36Oa0cmY67JOPNZQD0PM+knZvFFR
        9ZVqepMfl8f8sJDQrLWi8U9Hwavmwxah485QL+8Lq4EZBjCq6dxnDLNuvmaqzrSq
        +lHel9sfDWCEcSWmYmzYRzuBMnwQhDuv5V3R9s6Ztt14pVfOus10eUO9yHyYDCHW
        To5xeKkDrVulsuPzz5tWrm/IFIIL2O4wXjxka9RwEvhhOeETJNtqZyJsVblbgbDM
        3ZjgQeYGzRoZxbWlWqKaTtMWX5RBdrO1RzYQ5Ce+U4UpXapYm1MJlWyARaF+SQJK
        Bs7qUcKhqKHPKvqdKPfmguMdhK12wrqu3AdOy2yo1WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=KPcBI0
        VsCIpDPCKPoMMXiKiHUmJWKP12ZNGBmezXZ1M=; b=CnDqTB3OQgrYOV3npq4Rfe
        coky0mxuC5ELvhX2jjnB8MmnAytwZP7PO2za/yhStTXNDlPmBBiZcuhcQDhdbgBe
        AyHr5UTpwwqQERv8Zbmr06X3oLUdTenqd8Xc8jeZZr7yo84s5MZ/FMn2qsElWWBd
        b91p5R5Z7xgi9uA+43jSlVNDE6z+OexrnZaR+xWef5s7OWNs5z2U6aWQ5gqNqsbR
        LMPipsNW1OoFmAxFwieZFbEAQbqMtEbsb0xQgUDLvufS6fXSHE75wXdAb18oYVnW
        sFZDYKBiRiIcFxHOwS4b5HHPrpVDx8A0HvkBWDOeT9VlPtO4P48M4c6dlZdmveVg
        ==
X-ME-Sender: <xms:C6-1YZGjZj83yg1viHTk2hIIBJ1HTQdcefAd3fxW3x51nEUTodiy6g>
    <xme:C6-1YeUGSgVrzLwyldcUjLhQPVKGWQcIN40LBEON6B0DCiauGuf1jX3ASC5UjN4x6
    odKMcTUqjRV1w>
X-ME-Received: <xmr:C6-1YbIFM6saeRMHWKOuhJgwZrK1hZ8dtq9F3ULRs-sjrW5Zmt3499tJZQr8a_ylKvzWoTjtgCY1padDI3-9tOKlwnIJf3tO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkeehgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:C6-1YfHE0pye9FLevG24PJUhEceq3rkKYJ-wP7KD-t1IIRh9jgFhtw>
    <xmx:C6-1YfUkHutHUa4nXtMhg9EgY_sv5jHQlYSub-D9XAYyfELgukKg7g>
    <xmx:C6-1YaN2zDlezzv8COSQtCwokVndnimi3BxqIF5gg2poyci04BiNuA>
    <xmx:DK-1YYscRpIymPle3GwgCXhiUFKmt3e3Ls_h6glP5yFGKgiMw3u6Kg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Dec 2021 03:12:58 -0500 (EST)
Date:   Sun, 12 Dec 2021 09:12:53 +0100
From:   Greg KH <greg@kroah.com>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: X86 : system call
Message-ID: <YbWvBQNYYUga9JAt@kroah.com>
References: <CAHhAz+iKepmJGRKzLe+B_XFOax4CzVzeeAB_T5YtZrPgeX8o6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+iKepmJGRKzLe+B_XFOax4CzVzeeAB_T5YtZrPgeX8o6g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 12:34:54PM +0530, Muni Sekhar wrote:
> Also, could someone please point me to a document which explains about
> "how to add a new system call" and the "system call flow from user
> space to kernel space" in X86 ARCHITECTURE (32-BIT AND 64-BIT).

There are many documents online that show both of these already.  Have
you used a search engine first?

Both of these are usually questions that students are asked for
assignments, good luck in class!

greg k-h
