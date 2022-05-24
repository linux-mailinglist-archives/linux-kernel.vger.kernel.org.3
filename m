Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3953336B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbiEXWT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbiEXWTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:19:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8DE3AA7E;
        Tue, 24 May 2022 15:19:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8859C617D0;
        Tue, 24 May 2022 22:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546EEC34100;
        Tue, 24 May 2022 22:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653430792;
        bh=aQTROfTFdXi36U6mLYseBrPAPoPIYLg9rd9UBL8XdpU=;
        h=Date:From:To:Cc:Subject:From;
        b=i3JzHY6x2dWBF05YSG9bArKSvLQu29plyYJe7tqeNGh5mu+JMd3KkovUQW+JqjHRt
         4PhxqIZxrlHBXDtSAePCyqJ4YihTpVmr5VF5/iTnkqy6Q0/lERxadE0gcXxo0kLOrB
         zWf+plMdLyG21zKylkSk43f0xMNk00Hf5iQNJ7/o/krI1IlgeeCuiimhGwqjjctYXY
         NSpar9kQXBjj03S3U4qw2Xs5gti/cfPx0K8hDG+SBmlPvMm2+dI16pP3w36/fQjQaY
         J/L3xdm2JhiCxEpF0PTRoQH+p6WVBWkcZqKH0tXWBrGs545Al07oamJWs6dshU/EFr
         QJSJ5jMnkFqMw==
Date:   Tue, 24 May 2022 17:29:27 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] checkpatch.pl changes for 5.19-rc1
Message-ID: <20220524222927.GA7839@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/checkpatch-new-alloc-check-5.19-rc1

for you to fetch changes up to 73f1d07e5f8a1dec989a5ec964f5f2ce5b6f8825:

  checkpatch: add new alloc functions to alloc with multiplies check (2022-04-26 01:30:33 -0500)

----------------------------------------------------------------
Add new functions to alloc check for 5.19-rc1

Hi Linus,

Please, pull the following patch that adds new alloc functions to alloc
with multiplies check.

kvmalloc() and kvzalloc() functions have now 2-factor multiplication
argument forms kvmalloc_array() and kvcalloc().

Add alloc-with-multiplies checks for these new functions.

Thanks
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      checkpatch: add new alloc functions to alloc with multiplies check

 scripts/checkpatch.pl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
