Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65FF4BB939
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiBRMd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:33:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiBRMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:33:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2285F256
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:33:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 441B161F88
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B22C340E9;
        Fri, 18 Feb 2022 12:33:36 +0000 (UTC)
Date:   Fri, 18 Feb 2022 12:33:33 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.17-rc5
Message-ID: <Yg+SHbDujjurwIqb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit da5fb9e1ad3fbf632dce735f1bdad257ca528499:

  ACPI/IORT: Check node revision for PMCG resources (2022-02-09 18:16:22 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 4f6de676d94ee8ddfc2e7e7cd935fc7cb2feff3a:

  arm64: Correct wrong label in macro __init_el2_gicv3 (2022-02-14 18:37:07 +0000)

----------------------------------------------------------------
Fix wrong branch label in the EL2 GICv3 initialisation code.

----------------------------------------------------------------
Joakim Tjernlund (1):
      arm64: Correct wrong label in macro __init_el2_gicv3

 arch/arm64/include/asm/el2_setup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Catalin
