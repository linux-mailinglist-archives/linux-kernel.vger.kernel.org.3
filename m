Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868445721B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiGLR1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiGLR1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:27:20 -0400
Received: from 10.mo584.mail-out.ovh.net (10.mo584.mail-out.ovh.net [188.165.33.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EA2BF573
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:27:18 -0700 (PDT)
Received: from player770.ha.ovh.net (unknown [10.110.115.91])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id 13C71239B5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 17:27:16 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player770.ha.ovh.net (Postfix) with ESMTPSA id 8CCDA2C9AB1D9;
        Tue, 12 Jul 2022 17:27:11 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-110S0044d4bc56b-d2ff-4311-87c4-7cb1bb377c48,
                    95116E16C79F3EB4FFDADE9184C2BF5B79F623F3) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 2/5] docs: sysctl: remove references to dquot-max/-nr
Date:   Tue, 12 Jul 2022 19:26:16 +0200
Message-Id: <20220712172619.359052-2-steve@sk2.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220712172619.359052-1-steve@sk2.org>
References: <20220712172619.359052-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12606419786049422982
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudejhedguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeeghffhleeigffhteeiffelveefhfeiudehkedtgefhgedvleffgfejgfdtveeigeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejjedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekge
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dquot-max was removed in 2.4.10.5; dquot-nr was replaced with dqstats
in 2.5.18 which is now /proc/sys/fs/quota. Remove references to
dquot-max and dquot-nr in the sysctl documentation.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/fs.rst | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 54130ae33df8..0935acd220dc 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -29,8 +29,6 @@ Currently, these files are in /proc/sys/fs:
 - aio-max-nr
 - aio-nr
 - dentry-state
-- dquot-max
-- dquot-nr
 - file-max
 - file-nr
 - inode-nr
@@ -90,20 +88,6 @@ they help speeding up rejection of non-existing files provided
 by the users.
 
 
-dquot-max & dquot-nr
---------------------
-
-The file dquot-max shows the maximum number of cached disk
-quota entries.
-
-The file dquot-nr shows the number of allocated disk quota
-entries and the number of free disk quota entries.
-
-If the number of free cached disk quotas is very low and
-you have some awesome number of simultaneous system users,
-you might want to raise the limit.
-
-
 file-max & file-nr
 ------------------
 
-- 
2.31.1

