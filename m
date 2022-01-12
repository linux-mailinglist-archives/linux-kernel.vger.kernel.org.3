Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CE048C55B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353828AbiALN7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:59:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54200 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353824AbiALN7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:59:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EAD9B81ECF;
        Wed, 12 Jan 2022 13:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E065C36AE5;
        Wed, 12 Jan 2022 13:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641995959;
        bh=+LlsTTL6jKby2wg3vA3f/f/mlBHdCpbvYqKPOji/bos=;
        h=Date:From:To:Cc:Subject:From;
        b=eLxRWdCNCikhQNYuxBmci5w69bsdkpE4Ss3pilDKLAFfINjXmgFfV3hch9i6ayRYg
         3Gz9j6ywQvwbqi1mcGSDie2biroiOdgoi5tuMyJRh4pQWXgsh2wahtHYjacqbsmvMt
         eA62k1vE5CIHi/A9EOj3qVm0Yc+XqEUdR1NbV/zo=
Date:   Wed, 12 Jan 2022 14:59:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: [GIT PULL] SPDX update for 5.17-rc1
Message-ID: <Yd7etLWYHrtjFRdq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.17-rc1

for you to fetch changes up to bc128349588d571b55bfec471a773e29cfcd2d73:

  LICENSES/LGPL-2.1: Add LGPL-2.1-or-later as valid identifiers (2021-12-16 14:33:10 +0100)

----------------------------------------------------------------
SPDX/License update for 5.17-rc1

Here is a single change that fixes up the description of the LGPL-2.1 or
later identifiers so that the tools properly acknowledge that this is a
valid license.

This change has been in linux-next for weeks with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Mauro Carvalho Chehab (1):
      LICENSES/LGPL-2.1: Add LGPL-2.1-or-later as valid identifiers

 LICENSES/preferred/LGPL-2.1 | 2 ++
 1 file changed, 2 insertions(+)
