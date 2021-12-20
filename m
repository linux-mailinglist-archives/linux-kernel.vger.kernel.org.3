Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C9847AA18
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhLTNEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:04:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231933AbhLTNEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640005472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Uw2hq3iAjpq8hIf6+BklVmIQlQKg1K+ytaSfYhsv1as=;
        b=SzOVeYvIaSK5eLWy9EKPIwNfyAZwPY+49h+xTenMRGIJsTlhUGOCa7/3/9U1qs+ZigjjAG
        MFowOUgXIRI4rO6RgGKp/ccN5aeG7Z3VKjBOYf3iFWknoardlysok2f37E3JxntJpGJnYp
        nm4p9NIp3+b33QkrQiFgh3Km5xiTqRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-ZXcEsGfkOm-6VOWOMie8tg-1; Mon, 20 Dec 2021 08:04:26 -0500
X-MC-Unique: ZXcEsGfkOm-6VOWOMie8tg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7654E801B0F;
        Mon, 20 Dec 2021 13:04:25 +0000 (UTC)
Received: from wcosta.com (ovpn-116-93.gru2.redhat.com [10.97.116.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D716C12E04;
        Mon, 20 Dec 2021 13:04:20 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v4 0/1] blktrace: switch trace spinlock to a raw spinlock
Date:   Mon, 20 Dec 2021 10:03:56 -0300
Message-Id: <20211220130357.8790-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version only changes the commit message as suggested by Sebastian.

Wander Lairson Costa (1):
  blktrace: switch trace spinlock to a raw spinlock

 kernel/trace/blktrace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.27.0

