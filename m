Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B60148F5BC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 08:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiAOHmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 02:42:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57574 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiAOHm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 02:42:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34EA060B49
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 07:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9260EC36AE3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 07:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642232548;
        bh=RdMz71aVH7MRsRYYqzi6YeeTPLxSQZeTUi/YdZsOfTQ=;
        h=From:Date:Subject:To:Cc:From;
        b=mx3G35DM2d4+xVGWnzkZHM6mvO/rL4gtXPEJsn7DcQ/qtN+1Z2YWFGaC3K3XGGK62
         gQgkb8+LbtzbPPqG3OF29/FdY5p36FQ0pQieYWi6vCEJuqnbfV5ZANq56vEvHFrHqD
         y6kbNOc45IPDlqvAfh3+t9rdojmIXBFxyEhR5lqBHbEm1JuZyD8W1VxA98nfeHpn6r
         sdkJbj1lwljoMEP3pzoJ/XfFpnFvRhjLjIJ+daMCNaeCw5QeZiI+BnUmEe6RHaR7uv
         EgVBH+WQm8BhbH1OrP+JuQKPCTCeq+cAVh6yZU4DcPHV+md/svuOPhpM0TYiBQs6c2
         9UWP+0KmGd4Bg==
Received: by mail-yb1-f173.google.com with SMTP id c6so30195590ybk.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 23:42:28 -0800 (PST)
X-Gm-Message-State: AOAM530B8vHZh/8fa1e6dBS2ESE5qhlToCqalUgBM2DN11WC6mkU0pr4
        lu61KTIkNdQHpGp/JpgDH1P4eIVIhs04LnCXeZ0=
X-Google-Smtp-Source: ABdhPJzPq0iqqG+PxHdlLn0jL6uEXtzlgftRVAYkFdIFcYGBlAuzfRcKb342RZA5RUsPFfGeVQfZoyFZ0CqXuTwx0+Y=
X-Received: by 2002:a5b:244:: with SMTP id g4mr17303856ybp.507.1642232547681;
 Fri, 14 Jan 2022 23:42:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:5011:b0:123:6c39:8652 with HTTP; Fri, 14 Jan 2022
 23:42:27 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 15 Jan 2022 16:42:27 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8hP6CEoK8qvTPrjmC+kSzpEOQggWyvd_JQANjdSOjVtA@mail.gmail.com>
Message-ID: <CAKYAXd8hP6CEoK8qvTPrjmC+kSzpEOQggWyvd_JQANjdSOjVtA@mail.gmail.com>
Subject: [GIT PULL] exfat update for 5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v5.17-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit df0cc57e057f18e44dac8e6c18aba47ab53202f9:

  Linux 5.16 (2022-01-09 14:55:34 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-5.17-rc1

for you to fetch changes up to 3d966521a824082952990492442c7b486fefb48c:

  exfat: fix missing REQ_SYNC in exfat_update_bhs() (2022-01-10 11:00:04 +0900)

----------------------------------------------------------------
Description for this pull request:
 - Fix ->i_blocks truncation issue that still exists elsewhere.
 - 4 cleanups & typos fixes.
 - Move super block magic number to magic.h
 - Fix missing REQ_SYNC in exfat_update_bhs().

----------------------------------------------------------------
Christophe Vu-Brugier (5):
      exfat: simplify is_valid_cluster()
      exfat: fix typos in comments
      exfat: make exfat_find_location() static
      exfat: reuse exfat_inode_info variable instead of calling EXFAT_I()
      exfat: fix i_blocks for files truncated over 4 GiB

Namjae Jeon (1):
      exfat: move super block magic number to magic.h

Yuezhang.Mo (2):
      exfat: remove argument 'sector' from exfat_get_dentry()
      exfat: fix missing REQ_SYNC in exfat_update_bhs()

 fs/exfat/balloc.c          |  2 +-
 fs/exfat/dir.c             | 42 ++++++++++++++++------------------------
 fs/exfat/exfat_fs.h        |  6 +-----
 fs/exfat/fatent.c          |  4 +---
 fs/exfat/file.c            | 18 ++++++++---------
 fs/exfat/inode.c           | 15 +++++++--------
 fs/exfat/misc.c            |  3 ++-
 fs/exfat/namei.c           | 48 ++++++++++++++++++----------------------------
 fs/exfat/nls.c             |  2 +-
 fs/exfat/super.c           | 11 ++++++-----
 include/uapi/linux/magic.h |  1 +
 11 files changed, 65 insertions(+), 87 deletions(-)
