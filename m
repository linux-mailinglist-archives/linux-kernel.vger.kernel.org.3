Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A3A49E5D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbiA0PRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:17:38 -0500
Received: from out28-194.mail.aliyun.com ([115.124.28.194]:56675 "EHLO
        out28-194.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243023AbiA0PRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:17:20 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1905793|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0580845-0.00345395-0.938462;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=icenowy@nucleisys.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Mj85P0E_1643296636;
Received: from ice-e5v2.lan(mailfrom:icenowy@nucleisys.com fp:SMTPD_---.Mj85P0E_1643296636)
          by smtp.aliyun-inc.com(33.45.46.134);
          Thu, 27 Jan 2022 23:17:17 +0800
From:   Icenowy Zheng <icenowy@nucleisys.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Icenowy Zheng <icenowy@nucleisys.com>
Subject: [PATCH 12/12] mailmap: add Icenowy Zheng's Nuclei mail addresses
Date:   Thu, 27 Jan 2022 23:16:47 +0800
Message-Id: <20220127151647.2375449-13-icenowy@nucleisys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127151647.2375449-1-icenowy@nucleisys.com>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A mail address is assigned to Icenowy under @nucleisys.com for
supporting Nuclei SoCs/CPUs in Linux (and other open source projects).

Add it to the .mailmap file.

Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index b157f88ce26a..4bacaef7b06d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -144,6 +144,7 @@ Henrik Rydberg <rydberg@bitmath.org>
 Herbert Xu <herbert@gondor.apana.org.au>
 Huacai Chen <chenhuacai@kernel.org> <chenhc@lemote.com>
 Huacai Chen <chenhuacai@kernel.org> <chenhuacai@loongson.cn>
+Icenowy Zheng <icenowy@aosc.io> <icenowy@nucleisys.com>
 Jacob Shin <Jacob.Shin@amd.com>
 Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@google.com>
 Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk.kim@samsung.com>
-- 
2.30.2

