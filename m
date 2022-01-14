Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4E348E773
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbiANJZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiANJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:25:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448C6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 01:25:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D63DE61E8B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 09:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E934BC36AE9;
        Fri, 14 Jan 2022 09:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642152337;
        bh=P/bm0LGDZJvi20w4ynwHGaO4gRrS312I6XLwmwXc6zE=;
        h=Date:From:To:Cc:Subject:From;
        b=G2IxCYzqi2axbQfsMiqaGE9avzhCxdxeX9gDAYHVb06FszPue07LTJDwA1cqj/28R
         XODwpvQImT1J76cvDRBWk1egDyAeNluNucCkbsanqFLjWdZkRu+VhlDm37Cj5aL3Np
         lpEu06z+FWKYVMoKC5bsbrd6ceuuywqFwKUS9HlgNuGO7gk0zTssf2QDVXQr2X7QEB
         bc+wZL5ZjMrdZ5pdvTNAnnCbLpH3feH4PCRsDvsp+Hd49P5JCortO6t/Ci9xq461N6
         ZYAclPi3Rz6HTogHx56dmuOpewpmhRqHLOoi1Ij16F6YjYHtF2lLdMamY7TI5zaAmB
         ghurcsi8Gk8hw==
Date:   Fri, 14 Jan 2022 11:25:30 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: Remove #ifdef __KERNEL__ from memblock.h
Message-ID: <YeFBiiDO0FUz3mpZ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this small cleanup in memblock.h.

The following changes since commit df0cc57e057f18e44dac8e6c18aba47ab53202f9:

  Linux 5.16 (2022-01-09 14:55:34 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.17-rc1

for you to fetch changes up to a59466ee91aaa9d43889a4c51e01de087d188448:

  memblock: Remove #ifdef __KERNEL__ from memblock.h (2022-01-11 12:36:47 +0200)

----------------------------------------------------------------
memblock: Remove #ifdef __KERNEL__ from memblock.h

memblock.h is not a uAPI header, so __KERNEL__ guard can be deleted

----------------------------------------------------------------
Karolina Drobnik (1):
      memblock: Remove #ifdef __KERNEL__ from memblock.h

 include/linux/memblock.h | 2 --
 1 file changed, 2 deletions(-)

-- 
Sincerely yours,
Mike.
