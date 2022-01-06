Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF542485D30
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343824AbiAFAcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:32:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343810AbiAFAbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641429105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=csY0xQkbTlH3U/FWpRiwb9k561geNDd80dW+afPDJzw=;
        b=Jh2NTz8ocP2LZYa37ZT0BJ59KNg/HJUE3FzHOlMRAtHZAEJLiqib4dgulA6Qz4km1eRQtf
        9BX8uJII+wA1H3eCwQZkpe6+nKajvGGlb+JwAeKQ2Ycg7fpbbZr3NysVPAXfjF49cBXK5r
        Peqv1rFkDSlIqvFqBFlT8X/ftDKFGy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-9QbHZVpxNUe3EWw_Mlft4A-1; Wed, 05 Jan 2022 19:31:42 -0500
X-MC-Unique: 9QbHZVpxNUe3EWw_Mlft4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 474E8185302A;
        Thu,  6 Jan 2022 00:31:40 +0000 (UTC)
Received: from localhost (unknown [10.22.8.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAD0B108C7;
        Thu,  6 Jan 2022 00:31:38 +0000 (UTC)
Date:   Wed, 5 Jan 2022 21:31:37 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.90-rt60
Message-ID: <YdY4aTWXU1mlwsZI@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.90-rt60 stable release.

This release is just an update to the new stable 5.10.90
version and no RT specific changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: b4e833b63931f1d9fe1f23b44ab8e37a25b1b03f

Or to build 5.10.90-rt60 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.90.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.90-rt60.patch.xz

All keys used for the uploads can be found on the following git repository:

  git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git


Enjoy!
Luis

