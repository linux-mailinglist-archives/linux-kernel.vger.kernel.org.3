Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE23C470114
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241422AbhLJNCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:02:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36726 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhLJNCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:02:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 549E5B827F5;
        Fri, 10 Dec 2021 12:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BFFC341C6;
        Fri, 10 Dec 2021 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639141154;
        bh=CUnM6j3bfj/xWpGWZipfwOsGfxf4k2eiApr8tWcJ5n8=;
        h=From:To:Cc:Subject:Date:From;
        b=GKWi8yL3wa7VE//U7h9MyDVXW9cl/DO1K+J0bgj7rFwu88MCOmln/1RBwXeE1rUSh
         AB/8LPPvfJ2aNtxlO8i+Lp20RUwwAp/TMXpBDrGTM0t/JBSvrslL5DlKLNg6ztVznO
         kpdjPtXVMDQiSyH9tJmhUpXL8gtpuEaOCrfQ+jAj8mPdQwLU7xYmV9EtynJx/oICWB
         3YWMerGvyW4KHPRyo4c79eVIz9+65ZBWj4saTqOU2NpKZh04zmMLJ8jZn1dVQl+017
         8hbZfjLdRb3fHbnXdAW4V/3wKEbSnpepIxA0/yfCEQGha0HGiTLqYCHe0ixZRqQdQn
         UIlxSWWXpyKDQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvfUV-000GDW-Sb; Fri, 10 Dec 2021 13:59:11 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 0/3] media: si2157: do some minor improvements at the driver
Date:   Fri, 10 Dec 2021 13:59:07 +0100
Message-Id: <cover.1639140967.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The si21xx terrestrial tuners can support ISDB-T and DTMB (as it is really
just a tuner, and not a demod), but the missing settings are missing.

Some of the devices on this family also support bandwidth filters for 1.7 and 6.1.

Finally, si2158 and si2157 have identical APIs for analog TV. So, it makes
sense to also enable it for si2158.

Compile-tested only.

Mauro Carvalho Chehab (3):
  media: si2157: add support for ISDB-T and DTMB
  media: si2157: add support for 1.7MHz and 6.1 MHz
  media: si2157: add ATV support for si2158

 drivers/media/tuners/si2157.c      | 12 +++++++++++-
 drivers/media/tuners/si2157_priv.h |  8 ++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.33.1


