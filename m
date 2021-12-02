Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32C246625A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346409AbhLBLia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:38:30 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:50675 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233852AbhLBLi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:38:26 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3F5463201EE7;
        Thu,  2 Dec 2021 06:35:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Dec 2021 06:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=MWDOJiV7eBjWcPXOnu0j5XNbpz
        BsWzhlK6tNHfjT1Kg=; b=LNyw9nr36KA0eyni69wBg2vuM1wXOUh5BTEIGrVX56
        nuznzaKvnEAPwWi5G9HzoNDeZS/RKrmqsQYj3/adcnlufbJB2tK8FvGFhr1pCKUB
        DcJok7uqPdEE8dG923rhisDT+3bkEQUW/xh1iZSv3OXfVNzrNYtegvOk+4SRP9X2
        gIKFcckcVwmCUgdSeA6rMfXBfobD023Do2nAkDMopsuavD5lnFto+kJCJJKGaRTv
        v3DBE4un1xRHNhiWhsxx/BmVb6M/gQm2BylQsQoBCcaYDs2vO7nsAy97ZX2cwUie
        ArPqB2pZ50UjaMuZ04OpSD3Ud/1n8zUZ8QXnDA90b1UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MWDOJiV7eBjWcPXOn
        u0j5XNbpzBsWzhlK6tNHfjT1Kg=; b=iwyrb1qC0yZh25MM/6bB9X72K/6jokl0i
        /bl98rWGP6KH6n5kZ5xK00oZxvRwYopuBnPuGVhUKXiOK2tM7oT5iyppkl+Fo9vY
        Qbk6YQFiUVMIzPbkJcW+sb6EYSKGxEk9BPkgEl/H2PNhYGFA0A83wqV2LZ68/6B8
        N3TK4iMBjKe7S8xP4lQqOG1qTN4f7It/GD0qQT79WFYDk46DJwDNsWtyJPZxG/Mz
        oBB7HNgNvapW8tojTel0KnwteFOT5bKhcvpSTth/qnmuilZKwUyJC1qSryPYLEjG
        mU4D/TaRmub5EQBAYDueyWCJHKtCHj0o/bQ2AxAqIHzxeuKvDJS3g==
X-ME-Sender: <xms:Zq-oYX7ZkaV_lTw5dPGjow9LRTNRA3YPkJMTg0NwLnKBdhF9zIaROw>
    <xme:Zq-oYc7qnpSRUeCgPjx7Hrrt62N0-CW6nSwfy4zp3kMZaRhQZMFRluPW6DodPi3iV
    F1lyxttaoQ_ivMDIM8>
X-ME-Received: <xmr:Zq-oYedl5x_hKzGL_FqW7naI2B5UjMwzvno5DuY33PBrh3Jjhsc-T8o_vXxXOuG3Tr29aHof5nlhiYncnvQAei3jMUnBGwO5XxvDObQPwxRUrH-PcDwv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetieeuhfejkeekfe
    ehteeikedvgeefhffggfdvieehhefhheeivdfhgfejjeduudenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:Zq-oYYJZ6wLcEDDuWCnfhCc9AIlWwJelJFGN9Zu-CwWU-TM5U4AyrQ>
    <xmx:Zq-oYbKsuyzHtogCRs2MvQriOJHqbhh93t_Pv5q4vj7f5Gl6BMW7YA>
    <xmx:Zq-oYRwQD7ovEoEP-gXySfSJ0ltxLcHAzg9inZN5SrqRyGF9FgQIRg>
    <xmx:Zq-oYYGgoMhV3_OC8HewPGIFDBZp4dwxD0rMc6YRW0P5PGsiKmk8Ag>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 06:35:00 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, clemens@ladisch.de,
        alsa-devel@alsa-project.org, marcan@marcan.st
Subject: [PATCH 0/3] firewire: assist unit driver to compute packet timestamp
Date:   Thu,  2 Dec 2021 20:34:54 +0900
Message-Id: <20211202113457.24011-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 1394 OHCI specification, each descriptor of IR/IT/AR/AT DMA context
has timeStamp field. The value of timeStamp field express the time in
which the controller accept packet. The resolution of value is isochronous
cycle count (8,000 Hz) with second up to 7.

I have a plan to use the value of timeStamp field for ALSA firewire stack
so that userspace ALSA PCM/Rawmidi applications can get converted timestamp
(ktime) for PCM frame/MIDI message. The timestamp can ideally express
finer granularity than the time to invoke IRQ handler (and co).

Current implementation of Linux FireWire subsystem delivers the value of
timeStamp field to unit driver for IR/IT/AT DMA context, but not for AR
DMA context. Additionally, the way to refer to Isochronous Cycle Timer
Register in MMIO region of 1394 OHCI controller is transaction to local
node. It includes overhead of transaction and it's preferable to add
less-overhead way available in any type of IRQ context.

This patchset adds two functions exposed in kernel space:

 * fw_card_read_cycle_time()
    * allow unit driver to access to CYCLE_TIME register in MMIO region
      without initiate transaction
 * fw_request_get_timestamp()
    * allow unit driver to get timestamp of request packet inner request
      handler

I note that Hector Martin found kernel null pointer dereference during
process to remove PCI card and has posted a patch:

 * https://lore.kernel.org/lkml/20211027113130.8802-1-marcan@marcan.st/

His patch is included in the series with my comment for relevant commit
20802224298c ("firewire: core: add forgotten dummy driver methods, remove
unused ones"). The patch is required since unit driver can refer to dummy
driver between removal callback of PCI subsystem and removal callback of
FireWire subsystem.

Hector Martin (1):
  firewire: Add dummy read_csr/write_csr functions

Takashi Sakamoto (2):
  firewire: add kernel API to access CYCLE_TIME register
  firewire: add kernel API to access packet structure in request
    structure for AR context

 drivers/firewire/core-card.c        | 39 +++++++++++++++++++++++++++++
 drivers/firewire/core-cdev.c        |  6 +++--
 drivers/firewire/core-transaction.c | 18 +++++++++++++
 include/linux/firewire.h            |  3 +++
 4 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.32.0

