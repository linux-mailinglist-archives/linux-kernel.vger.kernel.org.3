Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1D4DCA31
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiCQPki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiCQPkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1256F20C2E0;
        Thu, 17 Mar 2022 08:39:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A37256199A;
        Thu, 17 Mar 2022 15:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E67C340E9;
        Thu, 17 Mar 2022 15:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647531560;
        bh=kAnUC1aavvusyWa+wFL6sbzRNu9ksr/TulLSJxlxVL8=;
        h=From:To:Subject:Date:From;
        b=syX9WOU1OyD5EzA6dIyZgD/DEBIhb1Bfem0i5y0y9fP0z9TLnbqKxkmWgkWUT0DL1
         rcEOhYwMEVM6jtuI0GJefJevUgNMCqKLioJ0rtpdIFeBi/ZuKtXHASYu0G5IVUuPqB
         ANVUCGbTaBX8KspC8/H3urbvthJvsLWbcUNru5ygQ97HXoDG1e5MUw1Y1zX+0lZRyN
         Gtfi3Ij95S+gTsC+n46n5oT8dNNVecSuaj6CN6DDq4slIsjcz1DbCPN7Z9wRroqCQp
         Uca2MxPc989aHEWjYceokpcIYAHSBlqNKZiud9eDGsrepAfIrNNqEKaWXpHC6whETP
         pQ/pQ4+RrJdQw==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 0/2] Linux v5.4.182-rt72-rc1
Date:   Thu, 17 Mar 2022 10:39:15 -0500
Message-Id: <cover.1647531549.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 5.4.182-rt72-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2022-03-20.

To build 5.4.182-rt72-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.182.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.182-rt72-rc1.patch.xz

You can also build from 5.4.182-rt71 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.182-rt71-rt72-rc1.patch.xz


Enjoy,

-- Tom


Tom Zanussi (2):
  eventfd: Fix stable-rt v5.4.182-rt71 conflict fixup issue
  Linux 5.4.182-rt72-rc1

 include/linux/sched.h | 8 --------
 localversion-rt       | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

-- 
2.17.1

