Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3AD4B2B51
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351903AbiBKRFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:05:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiBKRFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:05:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2CA73B3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644599138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UDk1zAMKdbmY1e5sy2VAX1LIyapo0Bn+bNb2SHhF21Y=;
        b=Rbq7CtYLEQ2XnRp4h0QSaLU6wbZT90Gr8wXruQBzh0Jjqen9J7u5TF6JnS1Gds1djwQs9I
        xt29nvKTMzjQpXQ9lZfftGTgXckPC9wrzpZppb0CLjpxFhSX8d4NpsDiSnVSMy3QITf8JS
        n2kPQJqHLPpYV/uo1qZZjKZBF2Rzfqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-K20vU1hmPKaLnnofJn1FPQ-1; Fri, 11 Feb 2022 12:05:36 -0500
X-MC-Unique: K20vU1hmPKaLnnofJn1FPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 014C43E744;
        Fri, 11 Feb 2022 17:05:36 +0000 (UTC)
Received: from max.com (unknown [10.40.195.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19AC22DE97;
        Fri, 11 Feb 2022 17:05:23 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes
Date:   Fri, 11 Feb 2022 18:05:22 +0100
Message-Id: <20220211170522.348999-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following two gfs2 fixes for 5.17-rc4.

Thanks,
Andreas

The following changes since commit 74382e277ae97b4bcfac6f8b61df7a500d392500:

  gfs2: dump inode object for iopen glocks (2022-01-11 16:52:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.16-rc3-fixes2

for you to fetch changes up to d3add1a9519dcacd6e644ecac741c56cf18b67f5:

  gfs2: Fix gfs2_release for non-writers regression (2022-02-11 17:44:42 +0100)

----------------------------------------------------------------
gfs2 fixes:
* Revert debug commit that causes unexpected data corruption.
* Fix muti-block reservation regression.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      Revert "gfs2: check context in gfs2_glock_put"

Bob Peterson (1):
      gfs2: Fix gfs2_release for non-writers regression

 fs/gfs2/file.c  | 7 ++++---
 fs/gfs2/glock.c | 3 ---
 2 files changed, 4 insertions(+), 6 deletions(-)

