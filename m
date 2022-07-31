Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F57585DDA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 09:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiGaG7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 02:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiGaG7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 02:59:50 -0400
X-Greylist: delayed 109 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 30 Jul 2022 23:59:49 PDT
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95B01277C
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 23:59:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2824842597;
        Sun, 31 Jul 2022 06:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1659250788; bh=sMZiOPCA2blsp3dIdFuPC1F5P0eAqfkl2hGZxKNmOag=;
        h=Date:From:Subject:To:Cc;
        b=GLnJpcZRejcOG54zx2QXW76t6a18gXBBmFZS7mEEenCCTXH2Tm4pgyjxrYERWWfnG
         EinSjhJtTiKsoPS5O8BQrl4wMgCB0u0zlUw2OBQzd3NAL9KhZE+qOHltoRbahqfUTi
         3U1vV53xubeKs5ej6SXk/bMHP4BjBwIPBY1XIIikohpzpSn+qONgE69OaxN+xFvIZr
         +1vjbbd78tKeBIh5JSO+qDlvBX1vyeKkY7WuVnzc6LpAnbgL+4oVU5l+7yKHI5zlNc
         He2UybV5ujMOkjcitw7pCSyL9SuUOziaFPlLpOk2hps7sUNMBaOi7ogNqDaSLpkc5m
         rZrzFJj4uuaFA==
Message-ID: <308defdf-8873-63ed-dc9c-a88cd7a3cc2f@marcan.st>
Date:   Sun, 31 Jul 2022 15:59:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Hector Martin <marcan@marcan.st>
Subject: [GIT PULL] Apple SoC MAINTAINERS updates for 5.20
To:     SoC Team <soc@kernel.org>
Content-Language: es-ES
Cc:     Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi SoC folks,

Please merge these MAINTAINERS changes for 5.20.

This one is trivial, so hopefully being this late won't cause you too
much trouble... My apologies.

-Hector

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://github.com/AsahiLinux/linux.git tags/asahi-soc-maintainers-5.20

for you to fetch changes up to 57a2d0c1b27dd0a92d4d22818176e7f53eed3104:

  MAINTAINERS: add ARM/APPLE MACHINE mailing list (2022-06-21 14:46:36 +0900)

----------------------------------------------------------------
Apple SoC MAINTAINERS updates for 5.20.

Just one patch adding our shiny new mailing list to the relevant
section.

----------------------------------------------------------------
Sven Peter (1):
      MAINTAINERS: add ARM/APPLE MACHINE mailing list

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

