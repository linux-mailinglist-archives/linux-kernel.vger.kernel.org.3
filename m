Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6724B8DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiBPQXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:23:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiBPQXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:23:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098EF21D084
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:23:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8556B81F70
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50603C340EF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645028606;
        bh=mXGykfBCZ5bn8SOX4YGF/cowTRTX6TYtyqZJOhZX0JA=;
        h=From:To:Subject:Date:From;
        b=lqosD+Gxij9gop8OeWq/NlwJgdInqEm8Z1DqISrs823fWUqZsmqI5ERi/askA3ilh
         Qwe08gNKNfuWBu8CTB/DPPnD2I1ejwJTVoEBF6OwmpjZvMuVudUByS31idcw2iD1nl
         PYcWN6bjzfonPOlZBs64E8xRiflkEPwgUPBljCez2KjYbDqZyr3/nZtTfuVDRnURFj
         CXRmTopxFedBqoSnXg4eiE60vjSRZEYkFe50e5P6pPjvlZ/BVmOxzAF4n2QAzWBwdU
         B5cCTWndi2NeUA8KF440w7Jb20GPKxqoaRFQDXiUDNJcKyklOiEy8rcQE3c5GXpxOC
         l/K2ghl+u55QQ==
From:   Seth Forshee <sforshee@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: update Seth Forshee's email address
Date:   Wed, 16 Feb 2022 10:23:24 -0600
Message-Id: <20220216162324.236059-1-sforshee@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seth.forshee@canonical.com is no longer valid, use sforshee@kernel.org
instead.

Signed-off-by: Seth Forshee <sforshee@kernel.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 8cd44b0c6579..f44a40bd7e37 100644
--- a/.mailmap
+++ b/.mailmap
@@ -350,6 +350,7 @@ Sean Nyekjaer <sean@geanix.com> <sean.nyekjaer@prevas.dk>
 Sebastian Reichel <sre@kernel.org> <sebastian.reichel@collabora.co.uk>
 Sebastian Reichel <sre@kernel.org> <sre@debian.org>
 Sedat Dilek <sedat.dilek@gmail.com> <sedat.dilek@credativ.de>
+Seth Forshee <sforshee@kernel.org> <seth.forshee@canonical.com>
 Shiraz Hashim <shiraz.linux.kernel@gmail.com> <shiraz.hashim@st.com>
 Shuah Khan <shuah@kernel.org> <shuahkhan@gmail.com>
 Shuah Khan <shuah@kernel.org> <shuah.khan@hp.com>
-- 
2.32.0

