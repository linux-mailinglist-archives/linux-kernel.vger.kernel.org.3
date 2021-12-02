Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEDF466BEC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbhLBWJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:09:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230017AbhLBWJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638482764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=7k9NAT51bqzJ5YbHuv7Ujc3TJL0g+29BxG+D9YetdSU=;
        b=hCSIuZV4mY58OVYn8VJfDaLw8Uc9zSwQvLTB1nLPrYZVZV9bZL7oEo/cCXZ5TWyocSD6sP
        B7t5WQqiVfhqLrhdey49/grWQv7aW/sJxvNxmM/JV25B2J7Qzk9k1uznulnhb6SUGtSYJb
        OgfEnAhxl99BRpdelcjMOx4XgOV4jmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-GT2GT0iMMCaKwwGHuQOfsw-1; Thu, 02 Dec 2021 17:05:58 -0500
X-MC-Unique: GT2GT0iMMCaKwwGHuQOfsw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21F7684B9A6;
        Thu,  2 Dec 2021 22:05:56 +0000 (UTC)
Received: from lclaudio.dyndns.org (unknown [10.22.32.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 534955DF37;
        Thu,  2 Dec 2021 22:05:55 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 898C63C023B; Thu,  2 Dec 2021 19:05:53 -0300 (-03)
Date:   Thu, 2 Dec 2021 19:05:53 -0300
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
        Mark Gross <markgross@kernel.org>
Subject: [ANNOUNCE] 5.10.83-rt58
Message-ID: <YalDQe/lyXqAxB0K@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.10.83-rt58 stable release.

This release is just an update to the new stable 5.10.83
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 63bd813e523a6e08bb4bb04b71903d252cbcae80

Or to build 5.10.83-rt58 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.83.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.83-rt58.patch.xz

Enjoy!
Luis

