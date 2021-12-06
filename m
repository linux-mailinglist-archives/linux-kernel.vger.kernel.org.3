Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53826469852
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbhLFOQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:16:47 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:17743 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245673AbhLFOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:16:46 -0500
Received: from localhost (scalar.blr.asicdesigners.com [10.193.185.94])
        by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 1B6ED6WM000731;
        Mon, 6 Dec 2021 06:13:07 -0800
Date:   Mon, 6 Dec 2021 19:39:33 +0530
From:   Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org, jwboyer@kernel.org,
        ramaraju@chelsio.com, rahul.lakkireddy@chelsio.com
Subject: pull request: linux-firmware: update cxgb4 firmware to 1.26.4.0
Message-ID: <20211206140932.GA3035@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the new Chelsio firmware from the following URL.

git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

Thanks,
Rahul


The following changes since commit b0e898fbaf377c99a36aac6fdeb7250003648ca4:

  linux-firmware: Update firmware file for Intel Bluetooth 9462 (2021-11-23 12:31:45 -0500)

are available in the git repository at:

  git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to 38e72a0f98306c4ddb9608d68bf92f0caf5f1ce9:

  cxgb4: Update firmware to revision 1.26.4.0 (2021-12-06 05:07:25 -0800)

----------------------------------------------------------------
Rahul Lakkireddy (1):
      cxgb4: Update firmware to revision 1.26.4.0

 WHENCE                                         |  12 ++++++------
 cxgb4/t4fw-1.26.2.0.bin                        | Bin 570368 -> 0 bytes
 cxgb4/t4fw-1.26.4.0.bin                        | Bin 0 -> 570880 bytes
 cxgb4/{t5fw-1.26.2.0.bin => t5fw-1.26.4.0.bin} | Bin 676352 -> 676352 bytes
 cxgb4/{t6fw-1.26.2.0.bin => t6fw-1.26.4.0.bin} | Bin 729088 -> 729600 bytes
 5 files changed, 6 insertions(+), 6 deletions(-)
 delete mode 100644 cxgb4/t4fw-1.26.2.0.bin
 create mode 100644 cxgb4/t4fw-1.26.4.0.bin
 rename cxgb4/{t5fw-1.26.2.0.bin => t5fw-1.26.4.0.bin} (77%)
 rename cxgb4/{t6fw-1.26.2.0.bin => t6fw-1.26.4.0.bin} (64%)
