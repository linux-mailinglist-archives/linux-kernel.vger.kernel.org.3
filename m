Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7520F576409
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiGOPEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGOPEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:04:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F9011C2A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5644B82D10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C70C34115;
        Fri, 15 Jul 2022 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657897445;
        bh=13jIvIL0nHyC4LWVlCldF+m8Fv0dOO1jTeJg/q5G0JA=;
        h=From:To:Cc:Subject:Date:From;
        b=Sir1ax8AtdPQy4KeovaAZ+qaZ/zsa3LIilIKsegpg39QDt+E3xSZCxixaBIEcVolx
         5ZKVhpD0BbRR6RxW0QDyE4WQsbdKQmTiALmIETmpIE1N1kmDu0zS0Fvvs6rVUqCwBW
         CSmyiEaT2t/ZnE1OeV1GbpwcL9gwpXFz1+zadCU4i255Pa2w7iCtF2ktwm3Cz+NbHa
         tPMWSnOkcPSE2TmcxUQh6XSoDwXsJtWUQkU7G9DfoF6yzq1uqYXY/gfDqUKakpbNh4
         6rtUGSfWSiyFej4ZXmg/wqqDqRTg9YYUJbdijXUyaSSH0G8PXHYW0jP8rdkRQsneNz
         5wAJX6XY7NIOA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: stratix10-svc: fix kernel-doc warning
Date:   Fri, 15 Jul 2022 10:03:49 -0500
Message-Id: <20220715150349.2413994-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/firmware/intel/stratix10-svc-client.h:55: warning: This comment
starts with '/**', but isn't a kernel-doc comment. Refer
Documentation/doc-guide/kernel-doc.rst
 * Flag bit for COMMAND_RECONFIG

Fixes: 4a4709d470e6 ("firmware: stratix10-svc: add new FCS commands")
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 include/linux/firmware/intel/stratix10-svc-client.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index a776a787ac75..0c16037fd08d 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -51,7 +51,8 @@
 #define SVC_STATUS_ERROR		5
 #define SVC_STATUS_NO_SUPPORT		6
 #define SVC_STATUS_INVALID_PARAM	7
-/**
+
+/*
  * Flag bit for COMMAND_RECONFIG
  *
  * COMMAND_RECONFIG_FLAG_PARTIAL:
-- 
2.25.1

