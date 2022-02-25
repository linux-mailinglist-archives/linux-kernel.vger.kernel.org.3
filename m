Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D504C4E03
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiBYSsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiBYSrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:47:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EB41AC2BF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PZHpSdMN9w0rcNlZN/RM7ulvKGH6eRZjhIQ04n6/lYY=; b=qeSNDh+GSF0GyrT9U3gmNvNeWd
        Fd1V52KEa+XNHpmKeF4IVJO7keAuqy/GT/ALv2OjUS/BceYBJQB55WQAPjE95vDds0ifG+T3ymAa4
        ic2C4H0joEKI6PTcx7LsmDy0/yAQWt89qidPwChfEjcM1mlSUYmTfpqUfn3JIdSBTr7Amm/gMGeDb
        O/HOr9RR9qKU+UGrwW5lAJ8HSh+6uHo+1QTlzmdterWrEgb5eACutOdIFrFg9xUnX+LLJxBxCXRsj
        5UtihNtxBOKGcsnTW6sl+QYI7CfBsmgg2mvNQkEfDNpQTR5INLBuL6/wY5XMF22R9UaCuWsT4uei6
        YnIM62nA==;
Received: from 089144202139.atnat0011.highway.a1.net ([89.144.202.139] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNfcT-006flO-OT; Fri, 25 Feb 2022 18:47:10 +0000
Date:   Fri, 25 Feb 2022 19:47:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] configfs fix for Linux 5.17
Message-ID: <YhkkKzBxKql579HU@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 038101e6b2cd5c55f888f85db42ea2ad3aecb4b6:

  Merge tag 'platform-drivers-x86-v5.17-3' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 (2022-02-21 09:10:53 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-5.17-2022-02-25

for you to fetch changes up to 84ec758fb2daa236026506868c8796b0500c047d:

  configfs: fix a race in configfs_{,un}register_subsystem() (2022-02-22 18:30:28 +0100)

----------------------------------------------------------------
configfs fix for Linux 5.17

 - fix a race in configfs_{,un}register_subsystem (ChenXiaoSong)

----------------------------------------------------------------
ChenXiaoSong (1):
      configfs: fix a race in configfs_{,un}register_subsystem()

 fs/configfs/dir.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
