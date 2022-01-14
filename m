Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C8448EF4B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243910AbiANRjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:39:39 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:36398 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230300AbiANRjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1642181978;
        bh=JdsUGUUKmEd5jQvS8fN5dkon4a1934IBBuFUHQPqYtg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HmgXAK4PfwiG+ghvLZtu6MAoirwUAhgkyDSvY6M+7gz4dy6tyR/khnoDYvz2RLrEO
         5ipHVEQ5xeeQZr8wUi/WFtsmfyiqUpjll1JRnM2UsVfy3lMH6IaW9JzAFQNE8HaQnK
         9AGxvKMenqgpYa+Fg7YW2RzbCixmEFdjtISB8LMY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D0D2D1280639;
        Fri, 14 Jan 2022 12:39:38 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C3-_Nm4Kcfcs; Fri, 14 Jan 2022 12:39:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1642181978;
        bh=JdsUGUUKmEd5jQvS8fN5dkon4a1934IBBuFUHQPqYtg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HmgXAK4PfwiG+ghvLZtu6MAoirwUAhgkyDSvY6M+7gz4dy6tyR/khnoDYvz2RLrEO
         5ipHVEQ5xeeQZr8wUi/WFtsmfyiqUpjll1JRnM2UsVfy3lMH6IaW9JzAFQNE8HaQnK
         9AGxvKMenqgpYa+Fg7YW2RzbCixmEFdjtISB8LMY=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5301F1280636;
        Fri, 14 Jan 2022 12:39:38 -0500 (EST)
Message-ID: <04ddb0c8f6bcaf67e137ee758d56d4482a382c49.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.15+ merge
 window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Jan 2022 12:39:37 -0500
In-Reply-To: <CAHk-=wjx_q9Aa=o5kiiSpCC_4U+H2D1=H3umFOwVMUbFmdQjGA@mail.gmail.com>
References: <31f8716fbb4f1e2a332b2b3e3243a170e8b01145.camel@HansenPartnership.com>
         <CAHk-=wjx_q9Aa=o5kiiSpCC_4U+H2D1=H3umFOwVMUbFmdQjGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-14 at 14:46 +0100, Linus Torvalds wrote:
> On Thu, Jan 13, 2022 at 9:22 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > Adrian Hunter (4):
> >       scsi: ufs: ufs-pci: Add support for Intel ADL
> >       scsi: ufs: Let devices remain runtime suspended during system
> > suspend
> >       scsi: ufs: core: Fix another task management completion race
> >       scsi: ufs: core: Fix task management completion timeout race
> [...]
> 
> You seem to have forgotten to fetch my upstream tree, so your
> shortlog (or diffstat) doesn't seem to take the various fixes pulls
> you did for 5.16 into account.
> 
> The only actual new commit I got from Adrian was
> 
> Adrian Hunter (1):
>       scsi: ufs: Let devices remain runtime suspended during system
> suspend
> 
> and the same for other fixes..
> 
> Not a big deal, but when the shortlog and diffstat don't match what I
> get, I waste time figuring out why. So please do a "git fetch linus"
> or whatever so that git can take all your previous pulls into
> account..

Sorry about that.  We actually have a merge in the middle of the misc
tree this time (commit: 87f77d37d398d92a9963890b14f336dc394f6fa0) and
the scripts I run to generate the shortlog and diffstat failed to cope
with it.  I'll investigate and fix them before next time.

Regards,

James


