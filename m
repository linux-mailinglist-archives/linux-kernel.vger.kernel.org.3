Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58194FADA5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 13:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbiDJLaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 07:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiDJLaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 07:30:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C5437A11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 04:27:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFEDEB80A39
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 11:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347B9C385A4;
        Sun, 10 Apr 2022 11:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649590070;
        bh=LWY8HeKmuq5urBxEk1hWepixj9nb1CbIz60y8a/OxjI=;
        h=Date:From:To:Cc:Subject:From;
        b=IRlBd2a5I9wtl1XIcMJksJ5fXjrb3L77GNNAjFK7C+AzNiV3NWMqKIXAQqhxPRlxE
         wYcy/jVZWy+K5VNtC3A8YXUAvZBckPlom8LzQwI0qoMUndjz7fnpKlwqQfK1YVXi6N
         7daYjy2BDyGzd3EkFV/XQl7DvAd72WZJ+WhYZQKY=
Date:   Sun, 10 Apr 2022 13:27:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fix 5.18-rc2
Message-ID: <YlK/M8Va5si3UQ+y@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.18-rc2

for you to fetch changes up to 94865e2dcb46c1c852c881cfa769cec4947d8f28:

  habanalabs: Fix test build failures (2022-04-04 17:03:04 +0200)

----------------------------------------------------------------
Char/Misc driver fix for 5.18-rc2

Here is a single driver fix for 5.18-rc2.  It resolves the build warning
issue on 32bit systems in the habannalabs driver that came in during the
5.18-rc1 merge cycle.

It has been in linux-next for all this week with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Guenter Roeck (1):
      habanalabs: Fix test build failures

 drivers/misc/habanalabs/common/memory.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)
