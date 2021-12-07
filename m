Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B4B46C530
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhLGVAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbhLGVAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:00:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE0AC061A32;
        Tue,  7 Dec 2021 12:56:31 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:56:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638910590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y73CmgjIRQmWm9o7zHsQQXaxLdlPjT3UChEH40OcxoU=;
        b=b7tuO+0ywfuQKYi4Mn3KktToeXF/MhmAVCKpJo1okuQ6SXY610kfRA9ip9kpOvJa5uXm4U
        FHdIV+esLSOCA6Vip9cmrVe4vqcMbSn+MnDK+UG1OXh8zi/5/+waiTVYL0zHmo6GgSSLed
        EreoqzrT5Yo1fmJj+xS5LsWEHyZ9d8hYB0bB6LAj+TrOxlLtqBfPR/BDDwCCTDOD6sT2Dz
        +sro72M7lhh5/+0/SUIW8Cz4bmRDLdVQ7yAByiJelVgUJxrc8WuAqeBCdg8hogx8dt0G2l
        igrXdqUFM1FXNmM06psvYTNEEuktsSODLSLHW2N+EbuWIeGSZt1w7cTsW2lldg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638910590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y73CmgjIRQmWm9o7zHsQQXaxLdlPjT3UChEH40OcxoU=;
        b=VjbkOKFFvssGYHOrFJT6iSZeC/K8zQmS+TbvHA0Mmu/Q3nJbA7aQfFIEzEgSRV+gk6knlL
        QV7r6cxQi9O6EUAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>, carnil@debian.org
Subject: Re: [ANNOUNCE] 5.10.83-rt58
Message-ID: <20211207205628.auc54rwl4duuisah@linutronix.de>
References: <YalDQe/lyXqAxB0K@uudg.org>
 <20211207201712.7yqbksbba3zgu7u3@linutronix.de>
 <20211207152049.1013e1ce@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211207152049.1013e1ce@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-07 15:20:49 [-0500], Steven Rostedt wrote:
> On Tue, 7 Dec 2021 21:17:12 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>=20
> > On 2021-12-02 19:05:53 [-0300], Luis Claudio R. Goncalves wrote:
> > > I'm pleased to announce the 5.10.83-rt58 stable release. =20
> > =E2=80=A6
> > >   https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10=
=2E83-rt58.patch.xz =20
> >=20
> > Any particular reason why every patch has "v4.9-rt" in the Subject line?
>=20
> I'm guessing because he just took over 5.10-rt and did not update his
> scripts ;-)

It seems to confuse ppl. Is there a reason to have it?

> -- Steve

Sebastian
