Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447814764E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhLOVuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:50:03 -0500
Received: from mxwww.masterlogin.de ([95.129.51.170]:42528 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhLOVuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:50:02 -0500
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2021 16:50:02 EST
Received: from mxout2.routing.net (unknown [192.168.10.82])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id CEDF92C43B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 21:33:14 +0000 (UTC)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id 5DDD55FC9A;
        Wed, 15 Dec 2021 21:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1639603990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CGLX4lLKfaZJIZOOlRW1Svrup+UeHGpvxaEwvbFjJ8Q=;
        b=w4/Jg15uEcK4Lge66BgXoVXqq8ATZOv9qKAS5iTDg3c3qh327Fes066m3haOUXjYW1WBqg
        0h0ciRXFEWNMAGdzFJyjaD68IamgLcg3bk27RjZw0TRM5pXgkXvaHXEA376NOL/30vM+AC
        hsuQaUN73stUjvpGT1peX49j3DdVbGY=
Received: from localhost.localdomain (fttx-pool-80.245.79.169.bambit.de [80.245.79.169])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id A63AC4023F;
        Wed, 15 Dec 2021 21:33:09 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 0/2] Add Poweroff/Reset for rk8xx PMIC
Date:   Wed, 15 Dec 2021 22:32:58 +0100
Message-Id: <20211215213300.4778-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: f522c713-099e-4ada-b605-9e769a6c0983
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This Series adds Reset functionality for rk805,rk808,rk809,rk817,
rk818 PMIC and poweroff feature for rk809.

Frank Wunderlich (1):
  mfd: rk808: Add poweroff and reboot support for rk809 pmic

Peter Geis (1):
  mfd: rk808: add reboot support to rk808 pmic

 drivers/mfd/rk808.c       | 50 +++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/rk808.h |  2 ++
 2 files changed, 52 insertions(+)

-- 
2.25.1

