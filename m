Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B509159B2B1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiHUIGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiHUIGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:06:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3561A39A
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F353B80B87
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8EAC433D7;
        Sun, 21 Aug 2022 08:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661069173;
        bh=QFXFHcvGRL8IofNAPTP6j4muM/s/DlvWWNNSHQPfbZY=;
        h=From:To:Cc:Subject:Date:From;
        b=CwPrQBnz+jgfhtHig2oYki3Nx61hSuENFaH4NYdrn6BaHq5R7kjctIYarR9L1aNh3
         maQzskSK8R1P7VjJW73KgByaRyGDbrjv9E0rC3vnWYJCLLE3ErtRzst28yLcXdJBP7
         tPCSgSALzbMiIrFiL74/A2nRW2ffqB1vpYEPSbzUcxnmeFve4y3FEWoHcetvuKOezZ
         5qvRAnGqSlPmPoBhB0aG90qze7we4uJqdh8RuE5T0571UuXkK0fQJzZ58BDf1cZLTt
         UHURvKkFMt2AqqLOI2fClxMeZ0XFCXXNbtMNvprdZ1tZB+paVa7kWa7Z3EfCFJLFlV
         4ijf20Va4Y3MA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v2 0/3] Adding support for trace events to habanalabs
Date:   Sun, 21 Aug 2022 11:06:05 +0300
Message-Id: <20220821080608.27486-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Thanks for your comments. We have fixed the patches according to them.

You wrote the first patch is r-b, but I took the liberty to add your r-b to
all three patches, I hope you don't object.

Thanks,
Oded

Ohad Sharabi (3):
  habanalabs: define trace events
  habanalabs: trace MMU map/unmap page
  habanalabs: trace DMA allocations

 MAINTAINERS                                   |  1 +
 drivers/misc/habanalabs/common/device.c       | 49 ++++++----
 drivers/misc/habanalabs/common/habanalabs.h   | 40 ++++++--
 .../misc/habanalabs/common/habanalabs_drv.c   |  3 +
 drivers/misc/habanalabs/common/mmu/mmu.c      |  7 ++
 include/trace/events/habanalabs.h             | 93 +++++++++++++++++++
 6 files changed, 166 insertions(+), 27 deletions(-)
 create mode 100644 include/trace/events/habanalabs.h

-- 
2.25.1

