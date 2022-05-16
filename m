Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D00528618
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244112AbiEPN5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243592AbiEPNyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:54:55 -0400
Received: from mail.bitwise.fi (mail.bitwise.fi [109.204.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A166939164;
        Mon, 16 May 2022 06:54:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 4FC8E460034;
        Mon, 16 May 2022 16:48:59 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id snCWiBDrwSnN; Mon, 16 May 2022 16:48:56 +0300 (EEST)
Received: from localhost.net (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id DD208460008;
        Mon, 16 May 2022 16:48:56 +0300 (EEST)
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] can: kvaser_usb: Various fixes
Date:   Mon, 16 May 2022 16:47:36 +0300
Message-Id: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Here's a set of fixes for issues I found while testing kvaser_usb as we
are preparing to start using it in production (with 0bfd:0124).

The biggest caveat is that I only have two devices to test with [1] and I
don't have HW documentation, so there is a possibility that some of the
fixes might not work properly on all HW variants.
Hopefully Jimmy can confirm they look OK, or suggest alternatives.

[1] Tested devices:
- 0bfd:0017 Kvaser Memorator Professional HS/HS FW 2.0.50
- 0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778

-- 
Anssi Hannula / Bitwise Oy
+358503803997



