Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DD35A2BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243526AbiHZQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344493AbiHZQCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:02:16 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979CDD34CC;
        Fri, 26 Aug 2022 09:02:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 199so1898419pfz.2;
        Fri, 26 Aug 2022 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=4CHMpfodr+A683JL6hoWZB83QwyHqrKIPppn/xZbB0w=;
        b=AA76Pp5S5oVg5MQorGulxTr60Q4GG6xkAInDgl2SBTq0Y3TVR4M885T9eE6iaw6K5Q
         sSebgok4lxpfHRpH9z3X02c46fBe3C7f+iApBmD0gUcwbzIPGiWXYdpadbdLvXt7XoXy
         R4OmhyE9NQtJjbCmG8Df1+tjZw2QC5+zZz0+tEjTzViLkjBFebrMzCs9D+vkyfvxiUyb
         m7G1dKrPar6uHYBikKEP7kvJuoHTV8PDEW42NSFFsI6wTqF5sx0OasR+fdmn1gh9Tizq
         jnRlpqzgmEdVrmX+LnsJsz6/9edEUjJUFDwAtCY+Uokcx6+XejOjTOIsSmaibTg79QNV
         qmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=4CHMpfodr+A683JL6hoWZB83QwyHqrKIPppn/xZbB0w=;
        b=htyeoZl2CLQh+TXNkcCWRFTNt9UdLaW6BLJ1JRHn5drfQBydqJbFGtj8XQZ0jRC8qn
         mswQwGfXaalQCnO6TiNdUdIzaBuZtciqJtQI0KqzJePhwbA2wD59we+gWc0bpULVXzOR
         Z9XSgNhdE3q/0sxcpPDyulWpQ+zuXpxA0b6ksLoGG1mMLo57GorK3fpaxAIVuRjZfHiz
         gWhDlb8YOftceGOop9KzuWToZ2nJpM78/zSD/sUCf6p/i3VIkLb6kJlWMjysL1P2zeIS
         jIUh8+aJ6lR+RAx2BOLsEvJK/Dg9BjfNY22ode41FFns6T34GaJ4N89Wh82LK5MBiTYX
         bvWA==
X-Gm-Message-State: ACgBeo17m5CzL3aRA6PsFDKcynWUwq/iKl1HZUk7mSu5ya7/UiVcJqlJ
        Rr5Hze99dATTu2SnOsruHnemHu3fkhI=
X-Google-Smtp-Source: AA6agR5LAmpNvBHmm316LUzRkH8Yd0kc5/4dY45ARuAUU5xWjkre45Gqls3bC5TfrLQ1cDP/1ZaCFA==
X-Received: by 2002:a63:fe12:0:b0:42a:e57:7464 with SMTP id p18-20020a63fe12000000b0042a0e577464mr3772235pgh.552.1661529735028;
        Fri, 26 Aug 2022 09:02:15 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.82])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090341c100b0016b81679c1fsm1796331ple.216.2022.08.26.09.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:02:14 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     kuba@kernel.org, sfr@canb.auug.org.au, bagasdotme@gmail.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next v2] docs/conf.py: add function attribute '__fix_address' to conf.py
Date:   Sat, 27 Aug 2022 00:01:50 +0800
Message-Id: <20220826160150.834639-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

Stephen Rothwell reported htmldocs warning when merging net-next:

Documentation/networking/kapi:26: net/core/skbuff.c:780: WARNING: Error in declarator or parameters
Invalid C declaration: Expecting "(" in parameters. [error at 19]
  void __fix_address kfree_skb_reason (struct sk_buff *skb, enum skb_drop_reason reason)
  -------------------^

Add __fix_address keyword to c_id_attributes array in conf.py to fix
the warning.

Link: https://lore.kernel.org/linux-next/20220825154105.534d78ab@canb.auug.org.au/
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
v2:
- optimize the commit log, as Bagas Sanjaya suggested.
---
 Documentation/conf.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 934727e23e0e..255384d094bf 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -86,6 +86,7 @@ if major >= 3:
             "__used",
             "__weak",
             "noinline",
+            "__fix_address",
 
             # include/linux/memblock.h:
             "__init_memblock",
-- 
2.37.2

