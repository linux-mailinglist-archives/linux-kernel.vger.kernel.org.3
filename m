Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574EF4B1210
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbiBJPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:50:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243551AbiBJPu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:50:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D91B72
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:50:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C49DDB825F9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29965C004E1;
        Thu, 10 Feb 2022 15:50:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="L16M6hPQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644508223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KcGQffE18NmsJ+tZ72J4XqUFjIMpYLGwlABieNc6FKQ=;
        b=L16M6hPQaGdmSgMqt1CHOrs0TGd0qwcvwlQG2h2yYUzCyVfQYVgYojOhR5mO1rjVAMgMKn
        FuDXzR/MWjxrlKk7ciTNKtvnIISjyO0Dp5S/F8Mq2CAtXkJAteOozLrb67dm7uhNLmwuX8
        Vf6qt/wl0dId6cmW+ZcZoZekL1Mhi6g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b6a65896 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Feb 2022 15:50:22 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 0/3] random: maintenance administrivia
Date:   Thu, 10 Feb 2022 16:50:09 +0100
Message-Id: <20220210155012.136485-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches aren't very interesting: removing unused debugging code
and switching to SPDX. I'm not aware of any special ritual being
required to SPDXify a file aside from just doing it, but please correct
me if I'm wrong; none of the copyright info changes.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>

Jason A. Donenfeld (3):
  random: remove ifdef'd out interrupt bench
  random: remove unused tracepoints
  random: add proper SPDX header

 drivers/char/random.c         | 110 +-----------------
 include/linux/random.h        |   5 -
 include/trace/events/random.h | 206 ----------------------------------
 lib/random32.c                |   2 -
 4 files changed, 5 insertions(+), 318 deletions(-)
 delete mode 100644 include/trace/events/random.h

-- 
2.35.0

