Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E93049B690
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388495AbiAYOjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:39:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49728 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238093AbiAYOea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:34:30 -0500
Date:   Tue, 25 Jan 2022 15:34:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643121266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VoqfDBHhTAJ/th+5DzPwXrFiDr1q3BUP6gebHBO03j8=;
        b=SawjJMZ/l1V8fmswZt/7lMaYWbYT2Kk6D0t5WhyefjCr32Ybk38NN/a9Cu6ufQm5IQDUqj
        qnWSyKFB/6Rh4nf0s4CgokALBQ5lkMzaRT4s1So0iEAv2SE+x6NiVstbM66FSUxjg6Boec
        ikH7Qhpm0+MuRVhQTkKHn7bnWNB9Gyt/mJZS6+NBpUBinwyrLlw+JwV7+ZoNH4PLgkiHkv
        QrNGOoP8SreVCzHlB+GpQ2SY7SPD22ewjqRCQVhf7EDwj+ZnkBmZOcpGT3SLwuWhCjZEaw
        mwEPBTee+bcwWVwwjPkQLhQde3+fWBJ8qUml9YZCiX2uaesBZLQl3r0A1K2pFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643121266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VoqfDBHhTAJ/th+5DzPwXrFiDr1q3BUP6gebHBO03j8=;
        b=cjQh86pyNGNSp/dlgktgCQDVV3Wm0RrYyt6S1ejk3GSVeaIwzL/6PACzr4UR3vv2ayrQrB
        Rwva4YQd/2pz+hCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Wander Costa <wcosta@redhat.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/1] tty: serial: Use fifo in 8250 console driver
Message-ID: <YfAKcI8APsJmVgFp@linutronix.de>
References: <20211222112831.1968392-1-wander@redhat.com>
 <20211222112831.1968392-2-wander@redhat.com>
 <Ye/1+Z8mEzbKbrqG@linutronix.de>
 <CAAq0SUmdGinqdWXrHztx8g9hb+5UF5rDJJjVeVMj3CQ=Fw3kJg@mail.gmail.com>
 <YfAFAcYmJ+Zrontd@linutronix.de>
 <CAAq0SUkuG2uyouBhT5yDiq_KbOGUCO=9ondq6dkt1QZLN_C4uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAq0SUkuG2uyouBhT5yDiq_KbOGUCO=9ondq6dkt1QZLN_C4uA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-25 11:26:03 [-0300], Wander Costa wrote:
> I will check on my side if I see something similar. Do you still get
> lines lost as well?

Yes. The output is garbage for a while and then it fixes itself. Setting
"use_fifo = 0" works.
Thanks.

Sebastian
