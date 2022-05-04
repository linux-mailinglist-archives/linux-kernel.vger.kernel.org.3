Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650A351AE35
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377659AbiEDTri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377669AbiEDTrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:47:33 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0890A4E39E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:43:54 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 244JhL7k001234;
        Thu, 5 May 2022 04:43:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 244JhL7k001234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651693402;
        bh=NtOPCiHOzYlkJIRKdMAZ3FSXrEPjfH/3gnPWepxEaJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=Jz/0NXe8GvKHKCSOmfo8IfbYqM0U5EqHnepA0S0+RgqKBzXGao6OdcuvG4Fo5rcwc
         GtO5GRX1htIHPYObISNubytvRxK529tWnONSUD/7q5ks6ct3l2g2Ptw6ixYLvRdVp6
         a28YeftXaGcCAP17niD8aF1HxEXgF5IO99w2MkceefOBHRmonm8/qnyKvWjN4DQqxE
         SbtiGT+kz7sargdPgHPz66CKQulWyw4wIsQ9rYrjRymXs6OWQetCR4u5uwbXU8hHmP
         U65RxdgL/lMPyPx8tETlMY5kF2LzTbl32+YIOqZByGqMVIiat5e+BCxSR+kS6bWwLj
         fi4FimVYBLQ2A==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/3] module: trivial cleanups for symbol search
Date:   Thu,  5 May 2022 04:42:42 +0900
Message-Id: <20220504194245.1088063-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masahiro Yamada (3):
  module: do not pass opaque pointer for symbol search
  module: do not binary-search in __ksymtab_gpl if fsa->gplok is false
  module: merge check_exported_symbol() into
    find_exported_symbol_in_section()

 kernel/module.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

-- 
2.32.0

