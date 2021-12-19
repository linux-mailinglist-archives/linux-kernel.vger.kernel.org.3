Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D4847A25E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 22:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhLSVbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 16:31:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235403AbhLSVbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 16:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639949478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=oeuOfy7w1Bn2/9PN+4DSmhs+A21q2OJr3897xOXYyUg=;
        b=HWyJMmBvfuDy9cIwkJDwGFqXnE93kLK0aOdxpMuPhztMB2gFtTrqTPCTTGjnAYtZU53G0K
        IsVJxJ364guGxu+Q694CjmhdYL3QEH/YWJL6S+bhkde3S4ditxg5iAYeYvEKSapZUsgbXV
        +p2/KAmc7yD5XXcOUB8fpsLPvIJJnSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-Xl6F9W9rOeiuOL9f1naMkw-1; Sun, 19 Dec 2021 16:31:14 -0500
X-MC-Unique: Xl6F9W9rOeiuOL9f1naMkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D1C4100C611;
        Sun, 19 Dec 2021 21:31:12 +0000 (UTC)
Received: from localhost (unknown [10.22.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E50B5BE1F;
        Sun, 19 Dec 2021 21:31:10 +0000 (UTC)
Date:   Sun, 19 Dec 2021 18:31:09 -0300
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
Subject: [ANNOUNCE] 5.10.87-rt59
Message-ID: <Yb+knVcplj4DC6HP@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.87-rt59 stable release.

This release is just an update to the new stable 5.10.87
version and no RT specific changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 1da83851f3be599ed45a029eab03838f21c76656

Or to build 5.10.87-rt59 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.87.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.87-rt59.patch.xz


All keys used for the uploads can be found on the following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git


Enjoy!
Luis

