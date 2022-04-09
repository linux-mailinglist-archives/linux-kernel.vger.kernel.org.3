Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3B04FA239
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 06:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbiDIEPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 00:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiDIEPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:15:02 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD2238BDC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 21:12:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CF6E33201DE8;
        Sat,  9 Apr 2022 00:12:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 09 Apr 2022 00:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=SnrLR3Sr37N2IK+ovWdtsG2oHIe46e1XW5qxi2
        8NvZs=; b=YyY0CKkeBs4TQ4eVNBXIMFQgjcC5X1ynOl+Y0Wz3ICfay3DcPhl/sZ
        akpkNVCR00i00WOOadJ+MBubnLhswKK21AcXcuWQgQFcN/i1EHavkIjZRS4Rnt+8
        1qzeIPmoLQjax6TFcFKdadzGTf1NGnw3KgTkja7TD14GVV0Hb6xb57A0BsHHtrbP
        lR7Ek8bhbeHPOhEnLwX9EVXXl7W/wuvPweDL+dw5L187xN5Di7ZkulzCsgqPNjuk
        p/+rDNbocBnEKsUvDBnLqiTGOVH76V4xf+FvSY84JBR0/3QbSTGY784vVyqeynYG
        VUg0j0SOIn/FSBw8kJSqN5rEMP/xhwPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=SnrLR3Sr37N2IK+ovWdtsG2oHIe46
        e1XW5qxi28NvZs=; b=nK3P+zeW/T8wQL+Vg/eByQMkQFCjo6lpIqCE5RfyvRiS3
        wTcnh8817kj/hYjuDKKfTCo+fy/M1TSWiE747Ku8qOCzAPdYOLMOCjekoMiKjvSg
        PMCj2ztPqLFCGyvqrIg1UEQW3Fix/8WG0pQu5iV9455d/NqItzG+GBc6ql/qWjxe
        uIEYZvvi+K5+qb1PvHSC2qhqP35uQxUhCJ7R3DH/2h2TpTUZGVFS7hjg1PZtke6h
        8JhKvSj5/oUoEmK2wqtyKY1QyFIEPRxdXRR0w1vB4iLAsXhO7T9beJzCE3/T3dKx
        jcYCBeIyguz+nJRWtlCnhdpldQzCnlt8QaYWMXc4A==
X-ME-Sender: <xms:vwdRYn4yV8TT6W6H_b6oQP5UorSd1RvtwO6upMN3gLSRm64T0vEK1w>
    <xme:vwdRYs7PmwhsDOfoRNKjtFvj9En01kFezXCxYyuIqr__J08DOD8HJwXuXX48fOdm6
    fJzgdOSKTotfIAjvpg>
X-ME-Received: <xmr:vwdRYufmUtSkCKOiYrZxaD-hyEGVITvP9A8VTmyPpVlAHWIXULyN-x9_Lv-EDw7-aIoLu3AVs_gEKh90Aqp0sopvUm-kgT1gG7UIbZwXGbV2Q7A8efY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepteeiuefhjeekke
    efheetieekvdegfefhgffgvdeiheehhfehiedvhffgjeejuddunecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:wAdRYoJGl1alGqvkd6Z_2H7mtoj3cWK4cBCJY4nmJkTMouF2ARwJrA>
    <xmx:wAdRYrKV3b-w9kFXGWEWwymTSuu0bCVVEZ2IeRVyWvQ3u9Xffs9rRg>
    <xmx:wAdRYhxF1aKVxyUkvK965n7LcmSlnyU2DTEe3e_EmV_7np2Fg2mvWQ>
    <xmx:wAdRYiXnDkm2a3HrgxRukcapBjsMZmaOqhKyYYXRsEkAwkD1B2aw3g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Apr 2022 00:12:46 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     tiwai@suse.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 0/3] firewire: fixes for kernel v4.9 or later
Date:   Sat,  9 Apr 2022 13:12:40 +0900
Message-Id: <20220409041243.603210-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset respins patches posted before to fix some bugs for Linux
FireWire subsystem. I expect them to be sent to Linus via pull request
by maintainer of Linux sound subsystem since the path appears to be
available after a short conversation with the maintainer. This patchset
is expected to be applied to 'for-linus' branch for v5.18 kernel, and
to stable kernels based on v4.9 or later.

This patchset includes below patches:

* [PATCH V2] drivers/firewire: use struct_size over open coded arithmetic
    * https://lore.kernel.org/lkml/20220210060805.1608198-1-chi.minghao@zte.com.cn/
* [PATCH] firewire: core: extend card->lock in fw_core_handle_bus_reset
    * https://lore.kernel.org/lkml/20220303183038.54126-1-dossche.niels@gmail.com/
* [PATCH] firewire: remove check of list iterator against head past the loop body
    * https://lore.kernel.org/lkml/20220331223601.902329-1-jakobkoschel@gmail.com/

Chengfeng Ye (1):
  firewire: fix potential uaf in outbound_phy_packet_callback()

Jakob Koschel (1):
  firewire: remove check of list iterator against head past the loop
    body

Niels Dossche (1):
  firewire: core: extend card->lock in fw_core_handle_bus_reset

 drivers/firewire/core-card.c        |  3 +++
 drivers/firewire/core-cdev.c        |  4 +++-
 drivers/firewire/core-topology.c    |  9 +++------
 drivers/firewire/core-transaction.c | 30 +++++++++++++++--------------
 drivers/firewire/sbp2.c             | 13 +++++++------
 5 files changed, 32 insertions(+), 27 deletions(-)

-- 
2.34.1

