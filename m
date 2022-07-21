Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46C257D2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiGUSBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiGUSBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:01:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95218B4AB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1AD9B82606
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA60C3411E;
        Thu, 21 Jul 2022 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658426495;
        bh=TKACgOn1j3yfUl9fU5IEUDYu8U9Q1ivBCfLrXSdWVOA=;
        h=From:To:Cc:Subject:Date:From;
        b=STZ/Z4Ej3lgoW7O70ZU7KSsK5LtJC7AlhgooIAOvKGLv33lFwifhpnnJ3abwL8Gxa
         7Jcqid3RdqoatJUme+feNYDQxUHtRIHLQCQP8fEmIvhLOZ3VnlfbC9HjgBMYMhJMTK
         cNsTwFzxykgCl2ylPjaMx/tt0fl2Sg1GYI2+SO3u3uZTBUjIJ3zvOdmA5NU1Akg+Tc
         ZSeLzmoYoOLHVtXWK375/dEI8tUcZfKml5g0MsrPQ81s6tlct4i+uX8Mh96YeVyIYu
         UrJ4I8n+G90qx8+bBKdJJ+OZF5cq1eItpEgx+Ndkfx7orw98UpCkhoajQf0q9PcHJr
         lEj606ouQe2oA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] faddr2line fixes
Date:   Thu, 21 Jul 2022 11:01:22 -0700
Message-Id: <cover.1658426357.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix faddr2line on arm64, and improve the error message for missing
CONFIG_DEBUG_INFO.

Josh Poimboeuf (2):
  scripts/faddr2line: Fix vmlinux detection on arm64
  scripts/faddr2line: Add CONFIG_DEBUG_INFO check

 scripts/faddr2line | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.36.1

