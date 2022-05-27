Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23A15367F9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 22:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350757AbiE0UTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 16:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiE0UTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 16:19:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2B431938
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 13:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F24FF61EAC
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 20:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CEBC34113;
        Fri, 27 May 2022 20:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653682746;
        bh=xwxngKRkYFiAJjYR+jDoq1ZPuo5G0nRwMVb2G04NCX4=;
        h=From:To:Cc:Subject:Date:From;
        b=NujAtmewOfuLlMk8THiJnWAbHGl1xXJWKtTuuDOJVtlQJL5tnAaW5rsOc6k0hroSI
         3PzA8z7lpZr76fyWbLmCsj05qsgudwQntKKLK2vXi2711BKZyWdYiOENGkwWhiZ/vD
         QLvQePqn04DoN5ZQXb9ZHV+TrYQWiyMVWhbA0wKAbPXQh82555yET6fa7LtGpxiQNC
         nrqGaLmdauIGAEbL+XHtqTVvPOlwzU5tp74FWiHNse+1jIMt/6pnF9JgcyU2vpjXVb
         syHQl+zDG0Q+WNPLNRHKkTQNs2LPkPU+ewWCquhUUxC4yLaIoh3OrVqggeVGjfuvfQ
         Bzk3aklRVfJ8g==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] mailmap: Update Josh Poimboeuf's email
Date:   Fri, 27 May 2022 13:18:52 -0700
Message-Id: <0519dcfbb1ee2cb82cb32b0aff61410a62949aa5.1653682698.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently switched to my kernel.org email address.  Add aliases for my
previous Red Hat and IBM addresses.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 6d484937f901..5956aa8d442a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -201,6 +201,8 @@ Jordan Crouse <jordan@cosmicpenguin.net> <jcrouse@codeaurora.org>
 <josh@joshtriplett.org> <josht@linux.vnet.ibm.com>
 <josh@joshtriplett.org> <josht@us.ibm.com>
 <josh@joshtriplett.org> <josht@vnet.ibm.com>
+Josh Poimboeuf <jpoimboe@kernel.org> <jpoimboe@redhat.com>
+Josh Poimboeuf <jpoimboe@kernel.org> <jpoimboe@us.ibm.com>
 Juha Yrjola <at solidboot.com>
 Juha Yrjola <juha.yrjola@nokia.com>
 Juha Yrjola <juha.yrjola@solidboot.com>
-- 
2.34.3

