Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7235C57A361
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbiGSPnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbiGSPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:43:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89D3564D8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CE3EB81A25
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C338C341CA;
        Tue, 19 Jul 2022 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658245407;
        bh=+fiRoUTBCoMM9FWNz1jO0UAtnpewL4HCjyLVEH/lGtc=;
        h=From:To:Cc:Subject:Date:From;
        b=DXY4Tdu7H/k9Zd+9k0ME47B3DpnxFbjux31hBv5pfNpt2yb0z4ygu7NX6Hufygkcx
         mdF5qqYNgpwTO5Y5w3SMxO3KrBzk6++fPVY3VXvNCvbhVhMnvRJ5yeW/pbHUvb6TRv
         KPKmZgt2ah9jP0ia4iqskfFdZbq/2wSwY4Qw4tC+dTzPZ5kpdZXUyivCRKFQMM98eE
         MtEMB9WT1VcWqMsdPe3Hxrd63SYWU/A7TYhtfS1QjAo1QH70yHmwM/or8LjqeAt0Ue
         j6AHkNT7XupXzquGRuwuYec8roDkN7gzSksUSycdGfKCytWImwg2vt7rJNiidmfZ1U
         mswcek0pH7uBA==
From:   Gao Xiang <xiang@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Gao Xiang <xiang@kernel.org>
Subject: [PATCH] mailmap: update Gao Xiang's email addresses
Date:   Tue, 19 Jul 2022 23:42:46 +0800
Message-Id: <20220719154246.62970-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been in Alibaba Cloud for more than one year, mainly to address
cloud-native challenges (such as high-performance container images)
for open source communities.

Update my email addresses on behalf of my current employer (Alibaba
Cloud) to support all my (team) work in this area.  Also add an
outdated @redhat.com address of me.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 2ed1cf869175..e759e00f0b45 100644
--- a/.mailmap
+++ b/.mailmap
@@ -132,6 +132,8 @@ Frank Rowand <frowand.list@gmail.com> <frowand@mvista.com>
 Frank Zago <fzago@systemfabricworks.com>
 Gao Xiang <xiang@kernel.org> <gaoxiang25@huawei.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@aol.com>
+Gao Xiang <xiang@kernel.org> <hsiangkao@linux.alibaba.com>
+Gao Xiang <xiang@kernel.org> <hsiangkao@redhat.com>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@de.ibm.com>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <gerald.schaefer@de.ibm.com>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@linux.vnet.ibm.com>
-- 
2.30.2

