Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9691C4C8A82
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiCALTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiCALTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:19:23 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360901DA5F;
        Tue,  1 Mar 2022 03:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646133521;
  x=1677669521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UAGqPULHqhfB5VjEcyxTRMu/w+nN0gZA/W+LmKLFMVc=;
  b=JkxLntasRggkjg75kNnCwArLVAlBSsBI+Cbiom9JTFVsV/8rb+rRRViT
   NH9ayCUzhbn691JB/Y5fOIcoXxaH816EPh2PchIV8RL/0xwczbwp8SD8h
   cH1eU52Y/bdfSvcYc6deY6iOH6q0Q4PLxlB+BNmH3ktQOKxEdFqwFPOt2
   eeBWiXisw7k4D/RWzMsPHcSqqj13qXjCNDgWqVwAix9ykBQk/rVmcC+Ai
   6guXZu98EzsLJrZpSkJyrZg/r4pp3xsd4SEFhe1MbH4Z6WAxyZJVLClhT
   6C+2iwxy/nZgJPKanhvTdP6TX3NXg1MPFm1aQNpfKrXCy3/6i9Us6qRWa
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 0/3] Devicetree support for regulator-virtual-consumer
Date:   Tue, 1 Mar 2022 12:18:28 +0100
Message-ID: <20220301111831.3742383-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds devicetree support for drivers/regulator/virtual.c which is
useful for development and testing of regulator drivers.

v2:
- Only use the "default" supply name if dt
- Add a comment explaining the "default" supply name
- Add patch which warns against production use of this driver
- Add patch to use dev_err_probe

Vincent Whitchurch (3):
  regulator: virtual: use dev_err_probe()
  regulator: virtual: warn against production use
  regulator: virtual: add devicetree support

 drivers/regulator/virtual.c | 41 +++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

-- 
2.34.1

