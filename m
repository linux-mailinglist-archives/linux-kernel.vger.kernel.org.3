Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE4049B5CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578112AbiAYOOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:14:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49588 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385495AbiAYOL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:11:27 -0500
Date:   Tue, 25 Jan 2022 15:11:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643119874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h+wE1mLTdMlmWkAW7/tM+Umy8zPTuE4e9hSvnL89+pw=;
        b=ftU/JGCC/X8WRV7lYnZBtY1zN4pqHDeQnAa2q4koZBBXCPqPUy921Vm9xmjYUp7HUo87AN
        jMxXR6Y9oqJrP5tJ+DyEs/PhRR/LXve1RkiyXutaMCT/ooHNnPT1iXGzfSq3vSGDDMlQCf
        RvitRXpRh0yoiZGdx6g8Ebtl2NxlcK2Q4phPUzoZdNb0rUg8hV/rhhp9s9ETMNfFS9klIT
        b9kF/pA6PSpVTsQNEvdFBAWKHJkGI+M4ANyMF5eLTtkOSmdHNMKB0haSgarvqIGOP6pa0O
        v/DVlRoESDFueo7cFZGSChgtDLkK0by5YTIa40gdMfVKkYWxu7r8fNXuqJ3Wyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643119874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h+wE1mLTdMlmWkAW7/tM+Umy8zPTuE4e9hSvnL89+pw=;
        b=FelGQCJ9DU5ujDud+PuIKWVMqiR1OA2veGCDfpMU/zakW6DjMoYVUZEXg5x7X5AgMy1IwQ
        bbuoU6nTltnyRwAw==
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
Message-ID: <YfAFAcYmJ+Zrontd@linutronix.de>
References: <20211222112831.1968392-1-wander@redhat.com>
 <20211222112831.1968392-2-wander@redhat.com>
 <Ye/1+Z8mEzbKbrqG@linutronix.de>
 <CAAq0SUmdGinqdWXrHztx8g9hb+5UF5rDJJjVeVMj3CQ=Fw3kJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAq0SUmdGinqdWXrHztx8g9hb+5UF5rDJJjVeVMj3CQ=Fw3kJg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-25 10:15:04 [-0300], Wander Costa wrote:
> There is another thread[1] reporting some issues with this patch.
> There, this diff seems to fix the problems, could you please try and
> report if it works for you too?

Nope. Still there.

Sebastian
