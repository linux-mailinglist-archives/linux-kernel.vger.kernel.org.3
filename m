Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B23486DDF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245644AbiAFXkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:40:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245583AbiAFXkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=snfAN0ArrPjFN7o3z+hAO2zHFv1mtZb/ukDqj+26TZQ=;
        b=F7jjXeLXWDn/8/utgdff7e1xGbocVig+kGYLAIll5fHqI1axeT1aAOQcFSXIFXfmgdyedf
        7hL+PKLcJ9O/EQO69bYB+KnCGg19J044K8/VarZHlN+mD7yUb+vypEw7YeEYh05YWI6gpx
        EMgz60v0R1vhnjAmUzafUYnI2sllMnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-Qh24qR7gOLWqCBPV1rCZmw-1; Thu, 06 Jan 2022 18:39:57 -0500
X-MC-Unique: Qh24qR7gOLWqCBPV1rCZmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B82188015CD;
        Thu,  6 Jan 2022 23:39:55 +0000 (UTC)
Received: from localhost (unknown [10.22.8.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6588F104F6;
        Thu,  6 Jan 2022 23:39:54 +0000 (UTC)
Date:   Thu, 6 Jan 2022 20:39:53 -0300
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
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.14.261-rt127
Message-ID: <Ydd9yTTun4Wzcka/@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.261-rt127 stable release.

This release is just an update to the new stable 4.14.261
version and no RT specific changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: f0e3531534b936c7cc2a171dffd21ee5c95edb44

Or to build 4.14.261-rt127 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.261.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.261-rt127.patch.xz


All keys used for the uploads can be found on the following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git


Enjoy!
Luis

