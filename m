Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DC254F777
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382141AbiFQMZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381190AbiFQMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:25:23 -0400
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70BEC52539;
        Fri, 17 Jun 2022 05:25:22 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 9F58F40A00; Fri, 17 Jun 2022 12:48:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 9F58F40A00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1655462901;
        bh=HXXTiuebscsk8opdJ/SRx0Re5yhwMY6rNsZHEejdWzc=;
        h=Date:From:To:Cc:Subject:From;
        b=QU/Xfrxvm+mpMjQBI4vC7qpQG/C3GGCheQP6iPX7OUuuXlubvSRx0Kv9XBEm5GyUz
         I2fSHIzhqTSbW0lr9VM1eBV3nmpg13K8BrFQxLwIMp9BVKlYB6MZzIXLCKQRNhB+Of
         Jd2gDffqtFgxOXrYbAU5Ob8QWJiCg64zXzCTn+Eg=
Date:   Fri, 17 Jun 2022 12:48:20 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL REQUEST] watchdog - v5.19-rc Fixes
Message-ID: <20220617104820.GA10498@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull following watchdog changes for the v5.19 release cycle.

This series contains:
* gxp: Add missing MODULE_LICENSE

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit 6bfb56e93bcef41859c2d5ab234ffd80b691be35:

  cert host tools: Stop complaining about deprecated OpenSSL functions (2022-06-08 13:18:39 -0700)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.19-rc3

for you to fetch changes up to b6c8cd80ace30f308aeec0ecf946f55dec60cc68:

  watchdog: gxp: Add missing MODULE_LICENSE (2022-06-09 12:20:34 +0200)

----------------------------------------------------------------
linux-watchdog 5.19-rc3 tag

----------------------------------------------------------------
Guenter Roeck (1):
      watchdog: gxp: Add missing MODULE_LICENSE

 drivers/watchdog/gxp-wdt.c | 1 +
 1 file changed, 1 insertion(+)
----------------------------------------------------------------

Kind regards,
Wim.

