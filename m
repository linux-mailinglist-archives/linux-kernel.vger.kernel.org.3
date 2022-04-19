Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7551A506C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352163AbiDSMT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbiDSMTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:19:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0096B2251C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:16:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABE7DB81878
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039F5C385A5;
        Tue, 19 Apr 2022 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650370599;
        bh=rQVOgG24HVhZ6E03EiJDUauMG0GM62VqIm3NHd65Nuw=;
        h=From:To:Cc:Subject:Date:From;
        b=S9gF+RUpaaZyoSofrWKOmrEODJh3l9FaL/hrZXCmTflrwa7/TlKv9OoXt3gT9FhIz
         vsV7kXHviSqnMsKtt7txt8jG5Lkq1hBAkvDggjHduP3nZkCh2yt2kCtfhTucXB0Zbs
         koVGzJP3gJP1hs3ZWE5qK27wG4BUvgIBMStW0Z4SYDtlL0XHTgjbtE+WFpq2gy366B
         iuTXeYQNDVyzjUe2DPQBUDjR4vCeiXM530NQKEsI26x62eEPFwMACicDPDtHyvwSTX
         GKFjyMKdPw1MhFlu4pRakiw5osP+xNkfU2TDHI7GoEUP0jBlz/ml3m0DcNSC+diBlF
         gcCyaosWJBMuQ==
From:   SeongJae Park <sj@kernel.org>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] scripts/get_abi: Fix wrong script file name in the help message
Date:   Tue, 19 Apr 2022 12:16:36 +0000
Message-Id: <20220419121636.290407-1-sj@kernel.org>
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

The help message of 'get_abi.pl' is mistakenly saying it's
'abi_book.pl'.  This commit fixes the wrong name in the help message.

Fixes: bbc249f2b859 ("scripts: add an script to parse the ABI files")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 scripts/get_abi.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 1389db76cff3..0ffd5531242a 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -981,11 +981,11 @@ __END__
 
 =head1 NAME
 
-abi_book.pl - parse the Linux ABI files and produce a ReST book.
+get_abi.pl - parse the Linux ABI files and produce a ReST book.
 
 =head1 SYNOPSIS
 
-B<abi_book.pl> [--debug <level>] [--enable-lineno] [--man] [--help]
+B<get_abi.pl> [--debug <level>] [--enable-lineno] [--man] [--help]
 	       [--(no-)rst-source] [--dir=<dir>] [--show-hints]
 	       [--search-string <regex>]
 	       <COMMAND> [<ARGUMENT>]
-- 
2.25.1

