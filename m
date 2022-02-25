Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B124C43C7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbiBYLk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240193AbiBYLky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:40:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB2A1C230B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:40:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s14so7075967edw.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sh8KsV81M+QXoRNgVzknS/NXvNTFWAIyMGZLr+InVTw=;
        b=WrbLRly4ilsY3GUV1h7mYr9Zt0Yzbo14uqQ5tTd6RFelch9hGFfbqoFRjTllLfAR6J
         zJ1K+llds/xre5alZmbQaXSvNd3+7an7RSzJ/Cn8yJBV6BJFe2EoK/+p361Gmbk0lHy/
         xzlps++u+zaO1SK5W1g3htuRMBOkM7vWX8yzM0sNngS+g/riKJu+x65PlphW3Za5BTzI
         c+BLx2XV2YwPg+Uk7TYL0j3qRCRebWR1ZuOad21Z0srjZWwq8t3WFqxXiokb+IM4T6LM
         pKsp0eVZag0RbTQ8x/MO2ZN9bisSqFunxAzHt7lnvuuiBc0BVMIdk4+38EjzIa7pmDx7
         0xsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=sh8KsV81M+QXoRNgVzknS/NXvNTFWAIyMGZLr+InVTw=;
        b=X8XZGMbuaCHZLPZlI0Ue5/xIVmw1rEmWIGwhMjxnDic43UPGkW6v7LxUu+DRv7U2tg
         k2STDItQwUp3+yZLRVY//zZbAEI7JLpaMOM43K/WlgemrBJTyc478IrZXu351KDpsqsL
         25BIXOAyXM8gfKIYACdmVT0AuEovCVsm+WyKmI+60KZJyU7p1Jm2W1+SA31m6QylHAgT
         EbGZvkApcFh0DhsZxUDY9w0dQTiobNeeJ+Oi4GJvDPfDjUKApfc8zLPHLL21wyvDdiCx
         xYgessETE9rCYPui8nZwPqjoEixVtIyzApYbELILuWEU1p7YjjUVZRFiHm4nIjbNKn4U
         qlig==
X-Gm-Message-State: AOAM532p4yVNnBFY7Ws2n3I5W5KAhVERF8xR7qzJRkankbxoB+s3s1/Q
        B9l6+24HS//w6v35Kw/HlGESM7N4DWFxCg==
X-Google-Smtp-Source: ABdhPJxhaN6uQd+9OJcHWGjswRd28eblw5Yj+CkB3d6idqwuxuBf6gKYhuBZ366JduJlWDHGKOGbtQ==
X-Received: by 2002:a50:fc81:0:b0:408:4c2d:bf69 with SMTP id f1-20020a50fc81000000b004084c2dbf69mr6776517edq.229.1645789217382;
        Fri, 25 Feb 2022 03:40:17 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id n24-20020a509358000000b00410bedd9eb4sm1228299eda.88.2022.02.25.03.40.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Feb 2022 03:40:16 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH] scripts: get_abi.pl: Fix typo in help message
Date:   Fri, 25 Feb 2022 12:40:08 +0100
Message-Id: <1ff3605db3dead41bbde33fbbff6754900eceead.1645789205.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspelled word in the script. (s/COMAND/COMMAND/).

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 scripts/get_abi.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 6212f58b69c6..1068cd0e3e90 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -987,7 +987,7 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
 B<abi_book.pl> [--debug <level>] [--enable-lineno] [--man] [--help]
 	       [--(no-)rst-source] [--dir=<dir>] [--show-hints]
 	       [--search-string <regex>]
-	       <COMAND> [<ARGUMENT>]
+	       <COMMAND> [<ARGUMENT>]
 
 Where B<COMMAND> can be:
 
-- 
2.35.1

