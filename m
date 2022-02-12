Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6E34B32AC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 03:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiBLCbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 21:31:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBLCbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 21:31:02 -0500
X-Greylist: delayed 555 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 18:30:55 PST
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD3022527
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 18:30:55 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 96AB93201D2D;
        Fri, 11 Feb 2022 21:21:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 11 Feb 2022 21:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=cRHm2GhJlaNLqABTQI1t1w+2bCz5SKGqO3g6bK
        8UMd4=; b=pBtajA1I6pgzKR1auvViNuflvfBpKlGJA+6ZOMnvWsFSojrf9yTndH
        Rs+dggcqIrPR8MR/wFbhVI76wgH+erlYODcQRTStY02J/BWsIgjf8o2CEpUv7OrO
        sfoT+aK4Cgf3/m+Ux60+okacv16itS37WDhd1Ln62ppLnEmqnDBHjxIH2vUnY8Gf
        QuK0x0+4/nlsXhw5T/VUWG2IK0MvcnCRBYvEHwB+ciFeYhvSJl6+TgbNfmqyI2La
        xr30/ONmnd6Cq+it3tr0EovXyRU7rLlgXDcWKDu0jqIQf1VIPSmmMksguuM6TC2S
        4pvu5Tybauka/YKn7S5T9tNPgJKIFivw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=cRHm2GhJlaNLqABTQI1t1w+2bCz5S
        KGqO3g6bK8UMd4=; b=KTfgNKpHZkoGuLnUmQGBMpY7UkQIQYNwznMvIeJHpTpkL
        IgiPW/NHb99aG1u+TQ8Avv7pbYzlkWr/p13JdrYgvndD2ycI4Xlld3CE3mV9AgGH
        QIfhN3WG/lmAsQKMkJl0WEev8cU8UN0xoe9LfcZN9KPoSwNhMBx99pQ0DokOXR3i
        tK/RcZgWZS6rYRc+Qg9P9oDODGLFXiT7F2RUcmvcZfOdV9fEs3FXm6ZLeKgO+maY
        YxUV9Vjqm6OlNmAFFFz1RkOeTLV5vX0XxqzhBqHIEpGYz/5KCYKgLVK4onVyrysJ
        fLlk2nYX4V5GKgmcafyk3dxdfqjchDgRhXoTrESDA==
X-ME-Sender: <xms:sBkHYqcK7qMNW5nbufNxoz4YgG4E3MwBqISt-gWDzMHF3xeQspdgKQ>
    <xme:sBkHYkOv1pVt7sp9_SuAl_yXYUqxlsTekI4do0Pam0N-ufKH6z8NTh8ir2QdsVz2i
    OXa6ilPffY6yUJvshc>
X-ME-Received: <xmr:sBkHYrgpA1Gy5YcgvZl2OT21B1JvP_0TKYo9JsfrU0ycfsV1VprjA8_PkQoMPUA8iFn0qOfsdtGoY-qmBpFSAQO2IXo5YCHKJjpQsJKAWS6FrThZlFCz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieeggdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetieeuhfejkeekfe
    ehteeikedvgeefhffggfdvieehhefhheeivdfhgfejjeduudenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:sBkHYn9_V6CgeO3i4WDnsRF2Gve6FOfGKHpUIGNyuHTjQoxgSZE0FA>
    <xmx:sBkHYmsnJcngHTFp3qAOQe5obyH7Kyqj2i7QUXKrTUwnYGZhB9h5ZQ>
    <xmx:sBkHYuGGxqfR9EMbg0JMIGF8AtY0VA4APGJBsqDaYTXjm46UKOgv7g>
    <xmx:shkHYqKHihHg8ePsurbu1UjYVnN7weHcc0TrNzIURrz_xVLjHAW3lw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 21:21:35 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, clemens@ladisch.de,
        alsa-devel@alsa-project.org
Subject: [PATCH v2 0/3] firewire: assist unit driver to compute packet time stamp
Date:   Sat, 12 Feb 2022 11:21:28 +0900
Message-Id: <20220212022131.199855-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Current implementation of Linux FireWire subsystem doesn't allow unit
driver to operate content of packet in IR context according to
time stamp. Additionally it doesn't allow unit driver to read current value
of CYCLE_TIME register in OHCI 1394 controller. It brings disadvantages to
drivers in Linux sound subsystem in regards of handling time for sampled
data such as PCM frames and MIDI messages.

This rerolled patchset is first step to improve the situation.

Changes in v2:
 * Rebase v1 patchset to v5.16 release

V1:
 * https://lore.kernel.org/lkml/20211202113457.24011-1-o-takashi@sakamocchi.jp/


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

