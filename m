Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE884FB9EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbiDKKr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345683AbiDKKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:47:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D234B12AF8;
        Mon, 11 Apr 2022 03:45:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 92E9D210E6;
        Mon, 11 Apr 2022 10:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649673910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ohjgTIrzAY3tDsd5YmcNz1c8ceaacTij0d18ctY12GA=;
        b=SH/b/2L8bRwlDBQWl2E4LSrh8DufB2tJi/6/jUXfrYM8nxweE1uOQynszvEPEoCMHOvTxp
        qZnqk92ZFU2H7dG7+ypAatdnF4yRb85ykabyURtsxODxcfeiEEFqsj5wALtgt8FPggx2fb
        ypFJRs+NBqrB02LkcW2+27jRLW1c3Qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649673910;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ohjgTIrzAY3tDsd5YmcNz1c8ceaacTij0d18ctY12GA=;
        b=r+gkmOswkAbQ7cUbzSiBOojEuwUHmR7s3GvLTVZ2clxH2d/AHse+n5MupZAqvxpRnpdCuy
        xD05qBivDdh1j2Cg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 608B6A3B93;
        Mon, 11 Apr 2022 10:45:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 0/3] tty: various cleanups
Date:   Mon, 11 Apr 2022 12:45:03 +0200
Message-Id: <20220411104506.8990-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This is another couple of tty cleanup patches for 5.19. See the
respective patches.

Jiri Slaby (3):
  tty: serial: mpc52xx_uart: remove double ifdeffery
  tty: serial: owl-uart, send x_char even if stopped
  tty: serial: altera: use altera_jtaguart_stop_tx()

 drivers/tty/serial/altera_jtaguart.c | 6 ++----
 drivers/tty/serial/mpc52xx_uart.c    | 3 ---
 drivers/tty/serial/owl-uart.c        | 6 +++---
 3 files changed, 5 insertions(+), 10 deletions(-)

-- 
2.35.1

