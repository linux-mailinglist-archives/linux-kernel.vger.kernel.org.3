Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D504AEE62
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiBIJou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:44:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiBIJos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:44:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B8BE06AFCB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:44:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D72D619D7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E123C340E7;
        Wed,  9 Feb 2022 09:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644399729;
        bh=I6tnF8guhidXkS7+MlaV/Uk38JYRoKRduLNRf90aHEM=;
        h=From:To:Cc:Subject:Date:From;
        b=fc+hAjODAlINFDe/bswS0nJOJOU5ZK6o+3GYOjy/g+o7KmtQcCT/rWOH98g9hnpoa
         xcNMPSo5AcO6Y0tTkx/ssxENEpm4OwT+r8c75s+bWrMEkXFmD/EpTK+VOJKUapuusm
         HOocn/VXmvgUlOboZAWR1n2HWwFlrXQj1Oz2H70Y3Tuy09CFT/bgyKnf7T1xPaBJvJ
         KqkcpefWG/MDwdAGAULKRX7OUhH7INiZh69aj1+YzjYtaFZe6SR5ge69oPrrER0Vrh
         VJDlPye9hVbdgZCvt/P5nXZgzWZKHYipNwL/QeKvflYtijqBpylWHInMH3NWflQUtk
         GjwuYQ97cMwPQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH for-mm 0/2] Fix trivial build errors on -mm tree
Date:   Wed,  9 Feb 2022 09:41:56 +0000
Message-Id: <20220209094158.21941-1-sj@kernel.org>
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

This patchset fixes a couple of build errors of latest -mm tree.

SeongJae Park (2):
  mm/internal: Implement no-op mlock_page_drain() for !CONFIG_MMU
  mm/gup: Make migrate_device_page() fails always if
    !CONFIG_DEVICE_PRIVATE

 mm/gup.c      | 9 +++++++++
 mm/internal.h | 1 +
 2 files changed, 10 insertions(+)

-- 
2.17.1

