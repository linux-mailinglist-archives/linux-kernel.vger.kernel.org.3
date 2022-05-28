Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CD4536D93
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 17:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbiE1PqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbiE1PqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 11:46:09 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FE84183AE
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 08:46:06 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 24SFjqA2008306;
        Sat, 28 May 2022 17:45:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/3] tools/nolibc: fix build issues when building from tools/
Date:   Sat, 28 May 2022 17:45:43 +0200
Message-Id: <20220528154546.8261-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus reported build issues when trying nolibc according to the
documented procedure in "make tools/help":

  https://lore.kernel.org/lkml/CAHk-=wgpAHhPVSqBWb4gYT=CRJzKAZ4inmrL_kcpeNWGkcg3pg@mail.gmail.com/

This series addresses this by setting the ARCH and OUTPUT variables and
adding a few targets to match default expectations. A "help" target also
explains what the existing targets do. This will be particularly useful
once the test suite is merged since it will add new targets.

Thanks,
Willy

---
Willy Tarreau (3):
  tools/nolibc: fix the makefile to also work as "make -C tools ..."
  tools/nolibc: make the default target build the headers
  tools/nolibc: add a help target to list supported targets

 tools/Makefile                |  3 +++
 tools/include/nolibc/Makefile | 37 +++++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.17.5

