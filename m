Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B6B4EEEF8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346730AbiDAONt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346724AbiDAONs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:13:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E393A276826
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7qXUV1K9Op/j8npAXAJ3agF8mojHu5afWajGVxmZFsY=; b=jyFRysLGyyY4WJarzJG9x35Yle
        Sm31dI74uuCJycr/SD457s2nE98uYSw4/vWNclS9DdvMI4X2zq/2RlghFrogDBFxqa4RnIBwfe3KM
        efU5ooRBFD75ITkY56p8pFFen6xlQOBSny9QxM1TZVAreQzybvZ1gvuP+FI8QBaPaSmHxBHyFxoxX
        r37HDgm4F849FRTR9ILK16b3NmWrktLf9nw8cAK6YScLbZa64vd5zhq8kj1d0ogdZ2yFCaJFo5kOd
        UGh2glZJRRuiG6dKCAYRqYPaPc+NQ3E2Y9eUNVgEC9CXQQAujDzBeua04Ud1/UmvI+FiilliAyPto
        B7HJqO2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naI0I-003GB9-NV; Fri, 01 Apr 2022 14:11:54 +0000
Date:   Fri, 1 Apr 2022 15:11:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [GIT PULL] XArray fixes for 5.18
Message-ID: <YkcIKm6hb4jWf9dx@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 1f2cfdd349b7647f438c1e552dc1b983da86d830:

  printk: Fix incorrect __user type in proc_dointvec_minmax_sysadmin() (2022-02-03 11:27:38 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/xarray tags/xarray-5.18

for you to fetch changes up to 3ed4bb77156da0bc732847c8c9df92454c1fbeea:

  XArray: Update the LRU list in xas_split() (2022-03-31 08:52:57 -0400)

----------------------------------------------------------------
XArray update for 5.18:
 - Documentation update
 - Fix test-suite build after move of bitmap.h
 - Fix xas_create_range() when a large entry is already present
 - Fix xas_split() of a shadow entry

----------------------------------------------------------------
Matthew Wilcox (Oracle) (4):
      XArray: Document the locking requirement for the xa_state
      XArray: Include bitmap.h from xarray.h
      XArray: Fix xas_create_range() when multi-order entry present
      XArray: Update the LRU list in xas_split()

 Documentation/core-api/xarray.rst | 14 +++++++++-----
 include/linux/xarray.h            |  1 +
 lib/test_xarray.c                 | 22 ++++++++++++++++++++++
 lib/xarray.c                      |  4 ++++
 4 files changed, 36 insertions(+), 5 deletions(-)


