Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5498C4ED639
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbiCaIv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiCaIvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:51:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6673BA75
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F626B82002
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699A3C340ED;
        Thu, 31 Mar 2022 08:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648716591;
        bh=zXvjwZOU8GJ+ECcGYNxUHGqpoy6es9MsyxSeGLT+BGs=;
        h=From:To:Cc:Subject:Date:From;
        b=sFuBnLuF/nW/CI94rIioZwq5+a4OSnxfsxQbRdl4VWOAoT4sfFmVpAaHKKs/qHUIq
         zTBz0auXlJB7IzZ3bb8ttZW5g3UEc2uW0+pkZhS9Wfs85Ep7vBre1MilhzwoQ3+2X1
         kVyCBTQZ1272KDOFsao385jfH5WgkqJndzNqNvGfvuTq+0sd4wqWC+Qjk4d7gUy40v
         eh2lt2wr/Ygg33LnwdqRyXgkzB4d1XPBApuNPAE6tV/l7Dgri7WvGEyZ8RtAC0dutn
         ZYKpgMK3pvdlkXyF8brgmo4nPvqp6ZVUz0vCXirPc4IiAZBarfb0IqgXNqk3hoBord
         fSRlWCO/knJeA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     andreyknvl@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH for-mm 0/3] Trivial fixes for build failures
Date:   Thu, 31 Mar 2022 08:49:36 +0000
Message-Id: <20220331084939.26749-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes trivial build failures of -mm queue, which is also
available at
https://github.com/hnaz/linux-mm/tree/v5.17-mmots-2022-03-30-13-04.

SeongJae Park (3):
  arch/arm64/Kconfig: Fix a typo
  arch/arm64/kernel/irq: Include missed header file
  arch/arm64: Set HAVE_SHADOW_STACKTRACE depends on SHADOW_CALL_STACK

 arch/arm64/Kconfig             | 4 ++--
 arch/arm64/kernel/irq.c        | 1 +
 arch/arm64/kernel/stacktrace.c | 4 ++++
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.17.1

