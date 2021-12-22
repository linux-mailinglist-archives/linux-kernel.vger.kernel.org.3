Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC3947D617
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344452AbhLVRwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:52:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58070 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344430AbhLVRwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:52:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CE5FB81DCB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 17:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CBEC36AE8;
        Wed, 22 Dec 2021 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640195520;
        bh=dhr8vCkRAJIHZ4wScULjxojIk2OzMoX4p5ItMq0Y4dc=;
        h=Date:From:To:Cc:Subject:From;
        b=nFYRLDeyL5Y9EoFFiengffNL3+Iz3DW9UfdG+tsj4SMpE1y3wcIVxlYvnrMcFNwTA
         nZxFrkfecP1vT8kd3cnY5YZ7ap9VJaYFSBVjn8btY86AnkC5x+akjMobFxrLYeJ/dw
         CKf1RMU2+RS2Bo/9LI+QnoMIfxWQ7WTLLF7r9gSnXlyxo4Yj8JYYwRr3qjx9KkwArj
         UzVxGmPcIqQg+sjIKLZ5SGUqqOcK/8AZSqsEq9pkxkC4zX2zXwa/8cbVrMjPIWPdMp
         MXvlwbAm+maX9zgvzOGK2RcmNeJ7pKvzDIqaKTwNIqROP7eu3XgPuGpBMEIHgEVnkp
         +5nhdj6oI4o5Q==
Date:   Wed, 22 Dec 2021 19:51:50 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jackie Liu <liu.yun@linux.dev>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: fix memblock_phys_alloc() section mismatch error
Message-ID: <YcNltr7TxsAe+fzP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock fixes-2021-12-22

for you to fetch changes up to d7f55471db2719629f773c2d6b5742a69595bfd3:

  memblock: fix memblock_phys_alloc() section mismatch error (2021-12-22 19:35:29 +0200)

----------------------------------------------------------------
memblock: fix memblock_phys_alloc() section mismatch error

There are section mismatch errors when compiler refuses to inline one-line
wrapper memblock_phys_alloc(). Make memblock_phys_alloc() __always_inline
to avoid these mismatch issues.

----------------------------------------------------------------
Jackie Liu (1):
      memblock: fix memblock_phys_alloc() section mismatch error

 include/linux/memblock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Sincerely yours,
Mike.
