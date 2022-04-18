Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC95504B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 04:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiDRC7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 22:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiDRC7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 22:59:12 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B106186CC
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 19:56:35 -0700 (PDT)
Date:   Mon, 18 Apr 2022 02:56:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail2; t=1650250593;
        bh=AFa0Oce4xuzRyJUgBo9k/EUFoeFcodpQfOJtly/yAm4=;
        h=Date:To:From:Reply-To:Subject:Message-ID:From:To:Cc:Date:Subject:
         Reply-To:Feedback-ID:Message-ID;
        b=OxLg8T7ee57FktoxYO6N9+Jo7Y3AeCALldLkaQ/Mzp/24yMnF5SF4cK89Em2hSEnh
         l+2fC3Zd8qriBKrgH+Oc9Te9BgTL3bbrAo7tDW21td/c8q4GYnxAtP+fi0tsVqgvRD
         Yjv1ZbYnaZqjvHdAJ2WqJvLZSMTtMf8LXhbKfBQBFqQs8NLb7Pi945T6Chz5c7ASII
         ULdtxwLeTBMpRZX17pW6JohbeMlUkEF9HxBlFXqK6TJ53/D2wjPIqY6s8tmGV1UesM
         RdrsJBJLV0irHOgYZIqungcodKGIcdudTVVt31blSmzKkVNk/DOjfu+1kq7dDAk4wz
         Gt55UgLLUjzOA==
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
From:   Solomon Tan <solomonbstoner@protonmail.ch>
Reply-To: Solomon Tan <solomonbstoner@protonmail.ch>
Subject: [PATCH 2/2] virtio: Replace long long int with long long
Message-ID: <YlzTUQa06sP94zxB@ArchDesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses the checkpatch.pl warning that long long is
preferred over long long int.

Signed-off-by: Solomon Tan <solomonbstoner@protonmail.ch>
---
 drivers/virtio/virtio_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index b717302dc4ac..839684d672af 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -657,7 +657,7 @@ static int vm_cmdline_set(const char *device,
 =09int err;
 =09struct resource resources[2] =3D {};
 =09char *str;
-=09long long int base, size;
+=09long long base, size;
 =09unsigned int irq;
 =09int processed, consumed =3D 0;
 =09struct platform_device *pdev;
--
2.35.3


