Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D1B48358E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiACR1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:27:40 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:53926 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiACR1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:27:39 -0500
Received: from localhost (scalar.blr.asicdesigners.com [10.193.185.94])
        by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 203HRRsf008814;
        Mon, 3 Jan 2022 09:27:28 -0800
Date:   Mon, 3 Jan 2022 22:53:21 +0530
From:   Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org, jwboyer@kernel.org,
        ramaraju@chelsio.com, rahul.lakkireddy@chelsio.com
Subject: pull request: linux-firmware: update cxgb4 firmware to 1.26.6.0
Message-ID: <20220103172319.GA11176@chelsio.com>
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

The following changes since commit 57d6b9507e28ac4803ea4aa4dba9592c889d6733:

  cnm: add chips&media wave521c firmware. (2021-12-29 08:43:43 -0500)

are available in the git repository at:

  git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to 9e89f3b81e3258e7bffdc0ed18a5c56b1cbf3e3e:

  cxgb4: Update firmware to revision 1.26.6.0 (2022-01-03 08:37:13 -0800)

----------------------------------------------------------------
Rahul Lakkireddy (1):
      cxgb4: Update firmware to revision 1.26.6.0

 WHENCE                  |  12 ++++++------
 cxgb4/t4fw-1.26.4.0.bin | Bin 570880 -> 0 bytes
 cxgb4/t4fw-1.26.6.0.bin | Bin 0 -> 570880 bytes
 cxgb4/t5fw-1.26.4.0.bin | Bin 676352 -> 0 bytes
 cxgb4/t5fw-1.26.6.0.bin | Bin 0 -> 676352 bytes
 cxgb4/t6fw-1.26.4.0.bin | Bin 729600 -> 0 bytes
 cxgb4/t6fw-1.26.6.0.bin | Bin 0 -> 729600 bytes
 7 files changed, 6 insertions(+), 6 deletions(-)
 delete mode 100644 cxgb4/t4fw-1.26.4.0.bin
 create mode 100644 cxgb4/t4fw-1.26.6.0.bin
 delete mode 100644 cxgb4/t5fw-1.26.4.0.bin
 create mode 100644 cxgb4/t5fw-1.26.6.0.bin
 delete mode 100644 cxgb4/t6fw-1.26.4.0.bin
 create mode 100644 cxgb4/t6fw-1.26.6.0.bin
