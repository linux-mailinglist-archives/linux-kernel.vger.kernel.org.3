Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC19482DF1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 06:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiACFB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 00:01:58 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42259 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbiACFB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 00:01:58 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 167735C014F;
        Mon,  3 Jan 2022 00:01:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 03 Jan 2022 00:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=wz+qDCWouRE+aAv6AloGgB/Pef
        Pmyiugp/hFiHnMkZw=; b=H/SE3xpD76o+pAwEpb1ggvF+h4ZjLjKAI1C0tUlrG6
        N689gCnNgdtcufQ2Rl2o9D38H0N0su4LObdvczg/zwAQoFY4fMhPdPm2ENgg96Nu
        TIxUpqbF9xApAzBbD0+GEjHofqg7nWtc+bkLJjKZF7I9/5zKRIhFjhDvl1PhqFd0
        y5Im6Ci+X1VW1/+Loh0T7MmUfTyI/7tWDYbBd9b52oC+D5dWeRaBmqxx5ETkUr3A
        yMYmgeHi/JB5FeMtTrcF+RHCW+09fCliB26saCB0DAH2e8ZbKjn70IwcNtHvYApj
        rb8VALcVw2xClc8lR0gSiWsJLKmocL7fDYvT3qhEFWJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wz+qDCWouRE+aAv6A
        loGgB/PefPmyiugp/hFiHnMkZw=; b=ZxzNo6VBUfH9IdbtotCvNu6rTRt1WWBpD
        KDlSVY8i1vB7ZBQyYx/gk3cdgXysXgltaAK+oyySw9j21+FD60KbBcu+HGJzjxmW
        foY/qkQouxgZk8enA3mgFovR7uMMAJuvKxyvgnp9tFIEtIpgF9kmZb9aZW3ptyZ5
        +R58jXLxC17coTQqTZ+LEQurDULJFUCml4Drc7gqudXpeiP+YP4dr0Q84qsaqKsL
        aVYfX/VUMe0haI6Czsu/SixYjpyyNs7HuEZy1ZaIuVKiaZ3mfzH1LotvSNBTB/24
        URUR9AmDCbKnur3fTxcskBSRQp3sZMzml6PYeYwotuhLxzSAgCg8g==
X-ME-Sender: <xms:RIPSYcx-BNGE_1WH9l9lKi0oRQlD8YAX9lzNX2CHZmNXm8lGb7DqnQ>
    <xme:RIPSYQRh2xwuUgxtZvuOxjFLQtQ3ZESV124xXz1YvjAH6VEzes9wne99cJgmmFQGX
    Ddfh2zFlncgRFFLEA>
X-ME-Received: <xmr:RIPSYeU-okGlQLX3__2PaiBzEsZs1TFsjjW_CqZlaBrLW2dtf-eOEFv85HLisbdj1HhSaUdURv_xeo_eVOBEmFARo7wFKjyJaTiYdv77yNSG0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudeftddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeifffgledvffeitdeljedvte
    effeeivdefheeiveevjeduieeigfetieevieffffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:RIPSYajxlYx8jiXS0u0-Jq2ASlagpb9lXn1p_EBoXQPouJ7jOtC3Ug>
    <xmx:RIPSYeCYGEa-sze50rxDBn-PkPq_EgfdpBd1U2hIBhCoxXZJS9FsDg>
    <xmx:RIPSYbLzOKFbRty0iA09o_qdgFF72y4c-TrmL7swOg7v1h0e6WTBZQ>
    <xmx:RYPSYV4yY1OqsxbQuCwa5EYrBcdo28r8bZmW-QXYe-mJN2cVMy0-zQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jan 2022 00:01:50 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, giometti@enneenne.com,
        linux-kernel@vger.kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, thesven73@gmail.com, ojeda@kernel.org
Subject: [RFC char-misc-next 0/2] Add private pointer to struct cdev
Date:   Sun,  2 Jan 2022 21:01:38 -0800
Message-Id: <cover.1641185192.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The details are explained more thoroughly in the actual commits, but the
basic idea behind this RFC patchset is that:

* Using cdev_init() on an embedded struct cdev can lead to subtle
  use-after-free issues
* Switching to cdev_alloc() and storing a pointer fixes the lifetime
  issues but also breaks container_of()
* Deal with container_of() breakage by adding a void *private field

I've "fixed" (I'm aware module unloading is best-effort and may not
constitute a "real" bug) the issue in a random driver I found that
exhibits the issue. The other drivers I've seen with the issue are hard
for me to load/unload, so just one for now.

If this patchset is deemed acceptable, I'd be happy to convert other
broken drivers I find, but with the understanding that the best I can do
for testing is compiling them.

Daniel Xu (2):
  cdev: Add private pointer to struct cdev
  pps: Fix use-after-free cdev bug on module unload

 drivers/pps/pps.c          | 20 +++++++++++---------
 include/linux/cdev.h       |  1 +
 include/linux/pps_kernel.h |  2 +-
 3 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.34.1

