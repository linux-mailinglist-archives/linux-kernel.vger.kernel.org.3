Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36A44FBA6D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbiDKLEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiDKLD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:03:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1568DC47;
        Mon, 11 Apr 2022 04:01:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C10A4215FC;
        Mon, 11 Apr 2022 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649674903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TOslUvi/cDmQavLrpqh4QEcnpVMqxdKoJ62gjCK8ziE=;
        b=JtBV4ZhgmdXf8dZaJA6HD71mXaHPDMZcSZy5VmAnLNCRnOt28GdDdSKadhIVhJxSuzINWk
        p4WL1phACClTu4Ao11X3I6YMERR3cQ3eZmhA8VUHnHkwx5+o/jBmYeppN0rejqZtjKadJ7
        H2fB4N0Re26OK4Hfl4pKxuEDeYO1vcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649674903;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TOslUvi/cDmQavLrpqh4QEcnpVMqxdKoJ62gjCK8ziE=;
        b=Sl7m5Js0SIxcFKOk2BZEI3qkI0fUIDCKPpEsQ84MF6629tN/T0zTGBZ01djLx2K8MiutZY
        6F3xs+OBaqHJWWBQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9556FA3B88;
        Mon, 11 Apr 2022 11:01:43 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 0/6] tty: Documentation moves and updates.
Date:   Mon, 11 Apr 2022 13:01:37 +0200
Message-Id: <20220411110143.10019-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves tty to driver-api, move more tty documents there and updates
them. Either to use ReST properly or update so that they correspond to
the current state.

Jiri Slaby (6):
  Documentation: move tty to driver-api
  Documentation: tty: introduce "Other Documentation"
  Documentation: tty: move n_gsm to tty
  Documentation: tty: move moxa-smartio.rst to tty
  Documentation: tty: n_gsm, delete "Additional Documentation"
  Documentation: tty: n_gsm, use power of ReST

 Documentation/driver-api/index.rst            |   1 +
 Documentation/driver-api/serial/driver.rst    |   2 +-
 Documentation/driver-api/serial/index.rst     |   2 -
 Documentation/driver-api/serial/n_gsm.rst     | 159 ------------------
 Documentation/{ => driver-api}/tty/index.rst  |  22 ++-
 .../{serial => tty}/moxa-smartio.rst          |   0
 Documentation/driver-api/tty/n_gsm.rst        | 153 +++++++++++++++++
 Documentation/{ => driver-api}/tty/n_tty.rst  |   0
 .../{ => driver-api}/tty/tty_buffer.rst       |   0
 .../{ => driver-api}/tty/tty_driver.rst       |   0
 .../{ => driver-api}/tty/tty_internals.rst    |   0
 .../{ => driver-api}/tty/tty_ldisc.rst        |   0
 .../{ => driver-api}/tty/tty_port.rst         |   0
 .../{ => driver-api}/tty/tty_struct.rst       |   0
 Documentation/index.rst                       |   1 -
 15 files changed, 171 insertions(+), 169 deletions(-)
 delete mode 100644 Documentation/driver-api/serial/n_gsm.rst
 rename Documentation/{ => driver-api}/tty/index.rst (81%)
 rename Documentation/driver-api/{serial => tty}/moxa-smartio.rst (100%)
 create mode 100644 Documentation/driver-api/tty/n_gsm.rst
 rename Documentation/{ => driver-api}/tty/n_tty.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_buffer.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_driver.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_internals.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_ldisc.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_port.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_struct.rst (100%)

-- 
2.35.1

