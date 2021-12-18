Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473E8479A22
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhLRKFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhLRKFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:05:23 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5BBC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 02:05:23 -0800 (PST)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:e9c7:274f:a8f6:5f25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 9E1A7282FB9;
        Sat, 18 Dec 2021 11:05:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1639821921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yNYM3gaAafnuJ2liaYoRaWhkVmWo/Nbv7c/qHG10ffs=;
        b=5F68zuLxDVpQkygIFm99yS1N9SdzS6nmWtSHSwYZVkyHdOeHwggfx8HBf7aQMJjanvi82P
        h1OLIeHVdwEROcaicmGnIX1q4IXTUsYlMeno/k4RYEYWgYkjl6dur2usIkneiyME4QFmw8
        Ioqo4tFwizumqd56kLj8Tws4dozHQ8gZq91plQgwaFKOp7sr+4FbdYp76JKZx2kL99W1tQ
        o5E/2A6N2L31plfolDDDIAlDR6C32IBHQ6wLtKIxZhEAoiBsp2BnZ8h0lFgDyPmeIar+Zn
        ju0iO8dALFxA9Dk9IqYs2X6L0EeCyBxMq9M+m6TD40P2wh19r0k5a3/UGMCFBg==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-mips@vger.kernel.org
Cc:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2 0/2] Support MT SMP on generic MIPS kernel
Date:   Sat, 18 Dec 2021 11:05:09 +0100
Message-Id: <20211218100511.42508-1-sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches should allow a generic kernel to enable MT SMP, if
supported by the current CPU.

Changes since v1:
Link: https://lore.kernel.org/all/20211217183930.16192-1-sander@svanheule.net/
- Add patch suggested by Jiaxun

Sander Vanheule (2):
  MIPS: only register MT SMP ops if MT is supported
  MIPS: generic: enable SMP on SMVP systems

 arch/mips/generic/init.c        | 11 ++++++-----
 arch/mips/include/asm/smp-ops.h |  3 +++
 2 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.33.1

