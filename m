Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C52F48B3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244420AbiAKRWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:22:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238268AbiAKRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641921751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=r+yC4hEgN269opLBx7nLXsP7O007gMpSwFuaPmq+JHk=;
        b=G5dter25+aDuSeVdEf+CMJ1MsIt5adfqmzwrSDMSPl7vh9BuUulHlIyWK60uut7JRD+2Dr
        Db4FsiXIdo88xQxplo5bMsrqj6dy2NeUZx2nk91swSXpeWh7hf96Qu7sWlsGrWq1vnBb2+
        zx0pLiWF3KqmGsmpUl0GQuNpQvf7Fas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-BMLtguKxMDKJVnHrv0-oQA-1; Tue, 11 Jan 2022 12:22:29 -0500
X-MC-Unique: BMLtguKxMDKJVnHrv0-oQA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7BCE8042CC;
        Tue, 11 Jan 2022 17:22:28 +0000 (UTC)
Received: from max.com (unknown [10.40.192.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEE2A106C07F;
        Tue, 11 Jan 2022 17:22:16 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Various minor gfs2 cleanups and fixes for 5.17
Date:   Tue, 11 Jan 2022 18:22:15 +0100
Message-Id: <20220111172215.1149791-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 changes for 5.17.

Thanks,
Andreas

The following changes since commit 5c623c368933f22fcf77e040a0ad83f90c4e39ac:

  Merge tag 'gfs2-v5.16-rc4-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2021-12-04 08:13:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.16-rc3-fixes

for you to fetch changes up to 74382e277ae97b4bcfac6f8b61df7a500d392500:

  gfs2: dump inode object for iopen glocks (2022-01-11 16:52:44 +0100)

----------------------------------------------------------------
Various minor gfs2 cleanups and fixes

----------------------------------------------------------------
Andreas Gruenbacher (3):
      gfs2: Fix __gfs2_holder_init function name in kernel-doc comment
      gfs2: Remove redundant check for GLF_INSTANTIATE_NEEDED
      gfs2: Fix gfs2_instantiate description

Bob Peterson (2):
      gfs2: remove redundant set of INSTANTIATE_NEEDED
      gfs2: dump inode object for iopen glocks

 fs/gfs2/glock.c | 4 ++--
 fs/gfs2/glops.c | 2 +-
 fs/gfs2/super.c | 8 +++-----
 3 files changed, 6 insertions(+), 8 deletions(-)

