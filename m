Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2BA55D567
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344357AbiF1Jr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344314AbiF1Jqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:46:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4620225C40;
        Tue, 28 Jun 2022 02:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 86550CE1F4D;
        Tue, 28 Jun 2022 09:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508B6C36AE3;
        Tue, 28 Jun 2022 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656409590;
        bh=WbBL6ytq+2PylXv/jxqYZH6s3NkumUGsKk7uYgLBh3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJnPwrAeaVZd6fbyKl80bJCJXnyjKgaY3QWur0sVI4zuFy6dzmrffSKPmqfwWRJDY
         prZ6LliDnGIuBjmX78uQHggtl/Ao/IdMljs1pMBq/+TBwypzMlh/SQ8fR+vveUP9Wx
         gP+Ebs30z++Hdl4gQaF1OXMOSwoxM5OKNem0PGJv+bWsDkvdpm6BQ2ap5NbYcPGnM2
         sj10BZ31vC840hE/8gd7u+p8+i1+ij1CqykguZnULqkqpSMBRvlH/tbN4u9Fk1B0Kc
         uQPjzaUywUFc+34drLUYfo8Bq9gJn0RtBLRFT53HCMKrEB7jxdo3Rd2wK/sFCk2n7v
         nblBwwk2DdC4g==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o67ng-005HFn-0P;
        Tue, 28 Jun 2022 10:46:28 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/22] dcache: fix a kernel-doc warning
Date:   Tue, 28 Jun 2022 10:46:23 +0100
Message-Id: <3dbb2c7e6a9180de4ca628f96eaddd27e6327f8d.1656409369.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656409369.git.mchehab@kernel.org>
References: <cover.1656409369.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the function is wrong:
	include/linux/dcache.h:309: warning: expecting prototype for dget, dget_dlock(). Prototype was for dget_dlock() instead

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/

 include/linux/dcache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index f5bba51480b2..ce0b36f728fa 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -297,7 +297,7 @@ extern char *dentry_path(const struct dentry *, char *, int);
 /* Allocation counts.. */
 
 /**
- *	dget, dget_dlock -	get a reference to a dentry
+ *	dget_dlock -	get a reference to a dentry
  *	@dentry: dentry to get a reference to
  *
  *	Given a dentry or %NULL pointer increment the reference count
-- 
2.36.1

