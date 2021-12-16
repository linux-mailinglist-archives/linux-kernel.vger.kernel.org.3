Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA42477BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhLPSmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhLPSmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:42:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158B6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 10:42:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63224B825F2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 18:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D89DC36AE0;
        Thu, 16 Dec 2021 18:42:40 +0000 (UTC)
Date:   Thu, 16 Dec 2021 18:42:37 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.16-rc6
Message-ID: <YbuInd5ccML4yOMP@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit 35b6b28e69985eafb20b3b2c7bd6eca452b56b53:

  arm64: ftrace: add missing BTIs (2021-12-02 10:18:32 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 9c5d89bc10551f1aecd768b00fca3339a7b8c8ee:

  arm64: kexec: Fix missing error code 'ret' warning in load_other_segments() (2021-12-16 17:44:58 +0000)

----------------------------------------------------------------
Fix missing error code on kexec failure path.

----------------------------------------------------------------
Lakshmi Ramasubramanian (1):
      arm64: kexec: Fix missing error code 'ret' warning in load_other_segments()

 arch/arm64/kernel/machine_kexec_file.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Catalin
