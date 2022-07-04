Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F92565D75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiGDSUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiGDSUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:20:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62BF1147C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:20:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id d2so18030120ejy.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PCZv/Uz95M1+6hqmuzHaDR2ZyBz0Tq19f4wHlGSIGnI=;
        b=lm9xRjzd/xI2zC28SFIXFHNwsjb9oo6bLwYpKi4rVA9kfgHzZf7piE8NloO5C7gaJt
         +QkXKALaJ18nWtTKSN7oO82UinX0zDCZ/QJg3KUgNO9/1r/Yd9ETiE55vjQl1ZtYNS/z
         Vyl/rLL57gV6gcITiyF22SSb6C3RaJB9m36GYTR7sNzH6o2TCItJJcLQF7XPznEDaOl1
         HLsER6XYz6YNeRPi3uXWwd/NItdsSFgO0FnXJe6LmluWLYpEi+oc62swDNd13EZImrDt
         ZmHQObJs8Sxs53+JscMMeKT3x0DHY1DGM3maVcpsDxHUHZtHcx/9GdaCOj/rDrSIHCko
         ARog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PCZv/Uz95M1+6hqmuzHaDR2ZyBz0Tq19f4wHlGSIGnI=;
        b=BrRIuMfvUbP/s6sWFNMHg5/Bvvi1DdFtMgrc3OARrCB0bRJ/SxYS9I3oXGKUg1exle
         hrwKzOY1ghKESWDvY7yYP/areKI+IHJSs+DGjdQzPKuVQpbot3JQyiShZsSru+4Th+pY
         MGwPEf/7kk9h+U44tbFwdoYjl6W4TwJgZV8znLruofv8/eCRRGdmyoaljVWnMBkV8S0j
         otgytVislzBzuri6UOxLh/icZvPFxLK0JN76sIZkMspzTYVnYkeB9zwWZ22VwK0LLSVi
         U2EHGM3LH7zzBH67pK1pYiScyu6FwppHvbw0NRqgqmTeIjc574i9QEVRS6R56t275R4B
         36HQ==
X-Gm-Message-State: AJIora+w8Z2bfAVqCJNZk+7ovyO+cJRT6/REsadxaSXxpPZ9sWH6OiUv
        3iIdhnw15BMTJKtr7wkZ3Yk=
X-Google-Smtp-Source: AGRyM1vR5ZgP4WOaEMq0OOqsLpBzxz7sNYRDMgS7w5DXyXW/+9DVFDs1SOqYguaN1V+hwREwL9LxZg==
X-Received: by 2002:a17:907:c14:b0:726:9118:3326 with SMTP id ga20-20020a1709070c1400b0072691183326mr30271442ejc.68.1656958837153;
        Mon, 04 Jul 2022 11:20:37 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id x21-20020aa7dad5000000b0043a2338ca10sm3751896eds.92.2022.07.04.11.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 11:20:36 -0700 (PDT)
Date:   Mon, 4 Jul 2022 20:20:35 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] staging: vt6655: Rename MACvWriteBSSIDAddress
Message-ID: <1190d93181409679f9ae348a95ea269b48b1115c.1656835310.git.philipp.g.hortmann@gmail.com>
References: <cover.1656835310.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1656835310.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix name of a macro that uses CamelCase which is not
accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 2 +-
 drivers/staging/vt6655/mac.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 204994692c90..6cf21883d1fe 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1405,7 +1405,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 		spin_lock_irqsave(&priv->lock, flags);
 
-		MACvWriteBSSIDAddress(priv->port_offset, conf->bssid);
+		vt6655_mac_write_bssid_addr(priv->port_offset, conf->bssid);
 
 		spin_unlock_irqrestore(&priv->lock, flags);
 	}
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 541c6ed6a62f..cfebd126e42f 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -565,7 +565,7 @@ do {									\
 	iowrite16(wData & ~(wBits), iobase + byRegOfs);			\
 } while (0)
 
-#define MACvWriteBSSIDAddress(iobase, mac_addr)		\
+#define vt6655_mac_write_bssid_addr(iobase, mac_addr)		\
 do {								\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
 	iowrite8(mac_addr[0], iobase + MAC_REG_BSSID0);		\
-- 
2.36.1

