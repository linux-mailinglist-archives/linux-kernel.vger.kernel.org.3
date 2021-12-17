Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B60478CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbhLQOAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhLQN76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:59:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DACC061574;
        Fri, 17 Dec 2021 05:59:58 -0800 (PST)
Date:   Fri, 17 Dec 2021 14:59:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639749596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ulut3Oae1WTXpyC3Q+QPKjLe0yqmOTzHpdVAA+9Qn1o=;
        b=ueiYqYjhDGV+ltjGMHHYoT+SEb4QBrdwnRktcLIN8aDOtmcJsXHaNV6IuddrtiXlGEnYrP
        Z8dJ3u0X8nb7r9XS2zgNbmSJ17pxm3vQJFTCEz5+jo9uNooYj5ngU5YN7zNLRNpFBov4IK
        zRqVsVEc7ZpteiLhTFFnWJXIqbMO+jJ8+TmOuPncIR5WzV/e0x8YCw19xlpjQwS5SLJynF
        ALJK9I2JUy9t3SiuyMUFbJ3TvVNT8J99oDsKvo8EnKb141R6bd0M+xpDqZQofTi+GuO6w4
        MN4MoeBVy4uhdEt9Voe+LxRoqrNI8+IlaW3DIq/6RC2IRqJR3RpwZGKClXHOYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639749596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ulut3Oae1WTXpyC3Q+QPKjLe0yqmOTzHpdVAA+9Qn1o=;
        b=4Kjdk5QzdvsXROFI8Meekp9c9MKML/zjiDKb7nsOf97En4VYhuWUelPN5eDomujHd3j0rQ
        DjGUv4Lli7cUypDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: [rcf/patch] netpoll: Make it RT friendly
Message-ID: <YbyX2gAsLFrq+mMG@linutronix.de>
References: <20211118163405.adczki7ibk22bw7e@linutronix.de>
 <773fd8246a1ec4ef79142d9e31b8ba4163a0d496.camel@gmx.de>
 <YboSe4NfbCeoqF1j@linutronix.de>
 <254513dc01188ca3ff161fcb456bc96a610821a1.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <254513dc01188ca3ff161fcb456bc96a610821a1.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-15 20:54:40 [+0100], Mike Galbraith wrote:
>                   In fact, I had already taken the silence as a "Surely
> you jest" or such.

No, not really. netpoll is currently the least of my worries and I
wanted to finish my other network patches before I start wrapping my
mind around this in case something changes. But I have currently no idea
how to do netpoll run/ detect and so on.

> 	-Mike

Sebastian
