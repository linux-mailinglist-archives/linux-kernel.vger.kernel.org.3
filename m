Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E984831A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiACN4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiACN4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:56:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C32C061761;
        Mon,  3 Jan 2022 05:56:05 -0800 (PST)
Date:   Mon, 3 Jan 2022 14:56:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641218161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqKZZ+ljUNVf1aTbkbenLLudzqsUvVwUVUrwoLCM40I=;
        b=jJ9yLz6AWWWhGReceaeZtyKZY4XcXM9ys23f/LZaxWmjWZu1u18sFhU3EeonFpa64DIudk
        35JUtOnJEsz8B7CiflXsUFBlktKD8L6EUNF/WXBiVLI/p2jOouhPO5BhbJkzlH1w45dfNh
        f3PlaskXcWeBzfwDl9M4/1De/s75/tZhf7YIKk0xCds5aUSBuIrUXUEnJx3ysPY7Ye+9jg
        Tp3PpujpidkwWgqZlT/no9qeO+mFDKomIHaXqn2yfLKY8HU0PlWXKPGO0wi5ukKXsqNcoq
        Nl5I1US537tWqZ4uGoq5N5jvzJdWbbH8QSx1x4frDlZ3PvvSIh1WUH3KzFrngA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641218161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqKZZ+ljUNVf1aTbkbenLLudzqsUvVwUVUrwoLCM40I=;
        b=4Z/GfZIeNQMsc+8OqD5hAgBrSUy9D64owNC8g/yktjPsj1S+v1NxZJHmSScK5MeWgl8O29
        aPPlKs+Yj58nCXCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.16-rc6-rt12
Message-ID: <YdMAcJGoUMuaSHKb@linutronix.de>
References: <YcSgQY8lzb6MkQPx@linutronix.de>
 <64294bf40ace6be86a295099b895a7d1f6a5c49f.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <64294bf40ace6be86a295099b895a7d1f6a5c49f.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-25 03:16:57 [+0100], Mike Galbraith wrote:
> On Thu, 2021-12-23 at 17:13 +0100, Sebastian Andrzej Siewior wrote:
> > Dear RT folks!
> >
> > I'm pleased to announce the v5.16-rc6-rt12 patch set.
> >
> > Changes since v5.16-rc6-rt11:
> ...
> > =C2=A0 - The "Memory controller" (CONFIG_MEMCG) can be enabled again.
>=20
> FWIW, LTP testcases pass on rpi4 and x86_64 boxen with no gripeage.
> Full LTP with maximally bloated config was as uninteresting as one can
> hope for.

Okay, thank you. I'm going to add an reference to your mail in case
someone asks.

Sebastian
