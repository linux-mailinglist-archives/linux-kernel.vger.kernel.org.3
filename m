Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5DB58A1DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiHDUWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiHDUWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:22:41 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F44824F34
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ww3i3+d1DBIDwwK62d8xCQHXhW9fUy2beppl8MwgrBU=; b=JLV+crfSbV9iGiKgox17YiuPDk
        QRzgSz5Gt4s4vbVm92r3aLJf/D1atbzvvzBiCcGPo4cGoXn2aQG0Fg56ED47quYkWMpc20QKcYy1X
        bkpnneI6zub8FaQ/qzCdA08H+/H+M9uN1R4i/jFs0c8jUIJQkEwNsJytmOmPXqdDHM0vqPGpouKNy
        7c/P4EA8wnJLmvoPrxQPpWriLIfjdcxDSCmupbY7rnnNgDGYV4zAz14+OSARIpwB43otDWOaGXz6y
        qatn3cjk09YdTRwEnslcFKaglLZSRtLxQR/C4HFs4CghjkiRpTb01n9hwEtXpaeRBrITKppqlNa4C
        miB5AUiQ==;
Received: from [187.56.70.103] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oJhMY-00GOdL-T2; Thu, 04 Aug 2022 22:22:35 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     kernel@gpiccoli.net, gpiccoli@igalia.com
Subject: [PATCH] mailmap: update Guilherme G. Piccoli's email addresses
Date:   Thu,  4 Aug 2022 17:22:07 -0300
Message-Id: <20220804202207.439427-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both @canonical and @ibm email addresses are invalid now;
use my personal address instead.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 71577c396252..1a4c9e268b89 100644
--- a/.mailmap
+++ b/.mailmap
@@ -149,6 +149,8 @@ Greg Kroah-Hartman <gregkh@suse.de>
 Greg Kroah-Hartman <greg@kroah.com>
 Greg Kurz <groug@kaod.org> <gkurz@linux.vnet.ibm.com>
 Gregory CLEMENT <gregory.clement@bootlin.com> <gregory.clement@free-electrons.com>
+Guilherme G. Piccoli <kernel@gpiccoli.net> <gpiccoli@linux.vnet.ibm.com>
+Guilherme G. Piccoli <kernel@gpiccoli.net> <gpiccoli@canonical.com>
 Guo Ren <guoren@kernel.org> <guoren@linux.alibaba.com>
 Guo Ren <guoren@kernel.org> <ren_guo@c-sky.com>
 Gustavo Padovan <gustavo@las.ic.unicamp.br>
-- 
2.37.1

