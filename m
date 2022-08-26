Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1EE5A3023
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245684AbiHZTnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiHZTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:43:29 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EC2D7407
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:43:28 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-f2a4c51c45so3318975fac.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=eiyNYMtneNX7CSj+dgkUWXzOT8i/iivgh6eDQitYFyQ=;
        b=kNWQVtnMNFKcBiOg8XFKYDmlecn6FgPvKsTG/8NhBXVPgwPIjD3+cHAL9nOrFFxuui
         WunA93DNEoKDDRWx76/2bprt9m4LNwWe0rRLj5HQ7nyZ+M7ysud/5tpWDh1JGQ1PB8sB
         OZSMlV+LJzJ+FNbv7mbg35xvzg3bmigZzxZyGD0crDMrUbsErvt/Rhw6gk7LRQp2+6Rc
         EdOBZfCCaWO7awuSNgwy5pRZt0JGMNyCvc6iEDXW69qmXP3WCKIuWDdoB3yZ1zblEOLY
         uRcxIx3dzEA+7uGOu1oqUI1CqhqCMA52aIVdA3RZ2jHBfyGvP6wjqPZStFaiaIISDxJw
         1ELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=eiyNYMtneNX7CSj+dgkUWXzOT8i/iivgh6eDQitYFyQ=;
        b=tMAHsGxlUPn27tp74fDuV0/MmYEFy2eMv1P+ih6h0DC2zWEMyxxU0mZh/KPrX56cn7
         Hq8Gx20JfjxFpct8eji/04eZkGKQe7WVWo/+wSJmlbVTwghp2MWjLh9kWQDjoSKjuDCN
         ife7NaHsEsHdVOL1WVCd+C13qi7xWXo/1vFN2g+tAaBNBSIN6c63AXsr0MAXhkZryTu/
         wTRGWaHcpR2xZglF0ap0JW2eW1gzp5bw6tFQtBzkl3eqdvDozienS/G2eb3WVMnDR39r
         8boJxpdocVSE+k0CaLg58XEV2ueIBlUUyejvo+NRhoABLsiL1FqFl6hp2oOqfKn0cvmS
         rbDw==
X-Gm-Message-State: ACgBeo1anSV8003i+oxNZ/4xkzsMdq9lC3jRfMCl+t7EyeaFY8AP9jUq
        4YP4oY0ZDaCQDJT95UuHTdXKvxWoV7C6zuhoEnG/lZ0HwEHE
X-Google-Smtp-Source: AA6agR6bxYJFF6A/pP8yAsQodJdlc0C4MRgH2RcIfXjZXMBSHo5XyRUCCxxBOoyUVBzJB2L3uwLHSvjja0KSfJpqmak=
X-Received: by 2002:a05:6870:7092:b0:11d:83fe:9193 with SMTP id
 v18-20020a056870709200b0011d83fe9193mr2692218oae.41.1661543007805; Fri, 26
 Aug 2022 12:43:27 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 26 Aug 2022 15:43:17 -0400
Message-ID: <CAHC9VhTj1qHQ9gkrkay12AFv8rk8ttvaecP_NEBaSeN9xh2zEA@mail.gmail.com>
Subject: [GIT PULL] Audit fixes for v6.0 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Another small audit patch, this time to fix a bug where the return
codes were not properly set before the audit filters were run,
potentially resulting in missed audit records.  Please merge for v6.0.

Thanks,
-Paul

--
The following changes since commit ad982c3be4e60c7d39c03f782733503cbd88fd2a:

 audit: fix potential double free on error path from
        fsnotify_add_inode_mark  (2022-08-22 18:50:06 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20220826

for you to fetch changes up to d4fefa4801a1c2f9c0c7a48fbb0fdf384e89a4ab:

 audit: move audit_return_fixup before the filters
   (2022-08-25 17:25:08 -0400)

----------------------------------------------------------------
audit/stable-6.0 PR 20220826

----------------------------------------------------------------
Richard Guy Briggs (1):
     audit: move audit_return_fixup before the filters

kernel/auditsc.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

-- 
paul-moore.com
