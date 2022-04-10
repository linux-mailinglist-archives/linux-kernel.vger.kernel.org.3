Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264A74FADED
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 14:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242759AbiDJMtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 08:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiDJMtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 08:49:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD2663503
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 05:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F7AECE0ED3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C06C385A1;
        Sun, 10 Apr 2022 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649594821;
        bh=dYMhQEzpgHnWUUNH0hPRezY0fA5jNru+ZMP67xw1L00=;
        h=Date:From:To:Cc:Subject:From;
        b=dEfF+UWCpTHhBJWPSuimRamdiovi0mi7pC4pLcSsfqqIWIxTbxJ4dh8NbwKrX6a9+
         6mlguTg+8SxzspANIK5Dzuv+CFaegrnc9EZxz31NR26aweykiZdzguMK5/2XpSNMRA
         MAiDGtG+hXAumOXVATLltHQHoxvxq5IqcYAmmjAo=
Date:   Sun, 10 Apr 2022 14:46:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fix for 5.18-rc2
Message-ID: <YlLRwmx7f+fdiDuu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.18-rc2

for you to fetch changes up to 20314bacd2f9b1b8fc10895417e6db0dc85f8248:

  staging: r8188eu: Fix PPPoE tag insertion on little endian systems (2022-04-04 16:35:20 +0200)

----------------------------------------------------------------
Staging driver fix for 5.18-rc2

Here is a single staging driver fix for 5.18-rc2 that resolves an endian
issue for the r8188eu driver.  It has been in linux-next all this week
with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Guenter Roeck (1):
      staging: r8188eu: Fix PPPoE tag insertion on little endian systems

 drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
