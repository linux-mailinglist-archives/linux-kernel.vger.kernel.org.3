Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382ED51B6C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242237AbiEED5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiEED5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:57:07 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735C36584;
        Wed,  4 May 2022 20:53:27 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2453qiRE021346;
        Thu, 5 May 2022 12:52:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2453qiRE021346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651722765;
        bh=4dot4VWke2BM46mzqxkMpIv5xMDbcGp5EcqAjN/9nu8=;
        h=From:To:Cc:Subject:Date:From;
        b=IreQMiQFBuDmaZSC7LeWQ6INfvvCckBFi6u0/hhq3MeuLF1AjaFoQUrYbJeoXlggK
         kT1SJeBUNke7OJB3fF7TcBxGTK3FLtJq/b55ooEwG0L2r3h3ztR31PIe9MxCiFtiqQ
         WZSw4s16qKERT9aXN9uLXOubXTJ2ZEbPZXDXKHuIlm3TWoJdpSjY/YI+sRUx9FmuZs
         cJMI3seUz2v3KDnTzNbG7/u6h/RKldgADB8h/eRGHrCJglatclqoEft/ucPIH7BAte
         zGx+Sc+o8SIkVhLDKo4PBz46ZD+smI5qzYG77k/fc9NQgph0P8iaeDAp3R7k0h6N9D
         IrtVyAZlmg78Q==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 0/3] module: trivial cleanups for symbol search
Date:   Thu,  5 May 2022 12:52:09 +0900
Message-Id: <20220505035212.1130858-1-masahiroy@kernel.org>
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

V2: rebase on module-next.


Masahiro Yamada (3):
  module: do not pass opaque pointer for symbol search
  module: do not binary-search in __ksymtab_gpl if fsa->gplok is false
  module: merge check_exported_symbol() into
    find_exported_symbol_in_section()

 kernel/module/main.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

-- 
2.32.0

