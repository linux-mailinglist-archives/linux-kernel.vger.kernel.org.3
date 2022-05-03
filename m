Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D95518BE9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241021AbiECSLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbiECSLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A853EAA8
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF78861892
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3243C385A4;
        Tue,  3 May 2022 18:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651601264;
        bh=SCWU4RSKd7GJX8RI04zMEXi1tqeXseu+CufxWRBwHqo=;
        h=From:To:Cc:Subject:Date:From;
        b=oZ0k9l6ya1qO1ghGjCHYuqQuSZIaN0Kr8sjbw0JmBVN3WvvBCIh1AvxiuEZbd6S2P
         aeCHisDrsOgb7Nn4zgvum54KRt7i0KxrBaunp9ZvJQmSS1C6X1esCfGlBE+S66LXJQ
         PS5Jb7afdukemUQjiWM1xEHzda2ua2VAMIuv0eIgBqi+/QoM5XHF1DgAJR2XlCf8cw
         52W55OAmER/leA+JpOfJ6h38XMqK6nteyWzCEzPMGJNUesJTgMAHX+FC5VfrKQndxc
         ObO2nMnd/IIJdsNkLcmJMmbdnvP3AX3JZdteyJhO0grArcLUlztabU0YumP+1y4TlD
         MHDMV42xqm5ug==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] MAINTAINERS: Add a mailing list for DAMON development
Date:   Tue,  3 May 2022 18:07:41 +0000
Message-Id: <20220503180741.137079-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds an open mailing list for DAMON in MAINTAINERS file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 701504ef2902..56a751fca360 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5457,6 +5457,7 @@ F:	net/ax25/sysctl_net_ax25.c
 
 DATA ACCESS MONITOR
 M:	SeongJae Park <sj@kernel.org>
+L:	damon@lists.linux.dev
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-mm-damon
-- 
2.25.1

