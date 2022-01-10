Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A41648953C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbiAJJaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:30:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44044 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242953AbiAJJ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:29:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53EEA60EC9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F1EC36AEF;
        Mon, 10 Jan 2022 09:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641806985;
        bh=OOABhVBm69G8uwBX6CL0JtulGTer5o3/3Kx3hwxHPyw=;
        h=Date:From:To:cc:Subject:From;
        b=DwFZAaovin89aNPlf3CmbwFskpgC0ijg/CzQ0iZudUsjdVAuvfGLyPlGfI2/jaaS1
         96XhJKZ7Rz4EjT0wf64NmVEkJwzp5sJvmfrP99IO6G685pyAoTYJ0s5QkmJznbZSWY
         ID/yIi0asjQfp9iSOYPZV+zGs1ORPOy6LhpalqZfhnRipGL62X/0FdS0EImCMPXxRv
         k/tEt9elrMzXafoTlGnUGb9SwImHOm+AgGorX5nc0BoAOzCvh6CzAiYfDuFj1ZZh4q
         W7Jx8dJtPTU5+1E3vD12j5FH2PzS5E1gcBzBflF6D2SvCSQQVMqgsD4bsoAlupXUSx
         5t4Pl/1Fw0jEg==
Date:   Mon, 10 Jan 2022 10:29:42 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] removal of trivial.git
Message-ID: <nycvar.YFH.7.76.2201101025190.28059@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git for-linus

to remove any mentions of trivial tree from the documentation and 
MAINTAINERS. This has been discussed on ksummit-discuss@ some time ago 
(link is provided in the commit message, together with the reasoning). 
It's a general agreement that reason for such a tree to exist is currently 
pretty much non-existent.

Thanks.

----------------------------------------------------------------
Jiri Kosina (1):
      Documentation: remove trivial tree

 Documentation/process/submitting-patches.rst       | 20 ------------------
 .../it_IT/process/submitting-patches.rst           | 19 -----------------
 Documentation/translations/ja_JP/SubmittingPatches | 15 --------------
 .../zh_CN/process/submitting-patches.rst           | 23 ---------------------
 .../zh_TW/process/submitting-patches.rst           | 24 ----------------------
 MAINTAINERS                                        |  6 ------
 6 files changed, 107 deletions(-)

-- 
Jiri Kosina
SUSE Labs

