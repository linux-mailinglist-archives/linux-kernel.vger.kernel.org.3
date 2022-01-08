Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F628488644
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 22:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiAHV1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 16:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiAHV1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 16:27:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0C9C06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 13:27:34 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso11451826pjg.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 13:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=Hln/abMmSGptaGAwTz+GKaanQQs67LPV58I6VoMNHu8=;
        b=g15Yc7jTPv4tOUKzEqNuKmxSFPSKgN3zOxTRMRiOuJWpv8fxHh5t/x5VcMB8dlGiX1
         CcbIi7qfX0uF+0HXHI8QZDxVqUXlcVnA8eVoo1tKv8/Hc+w2ElCWy98KNrqa2OcKIJ6V
         BPPvDEqysqW/+2uGMG7V9O9YJz+9SN1VLmCYetqRB84Y9gkJUr/8JwHRxwU0dsgvAV5m
         DUIbPK0jWi/wa0ydF+iZvSfspfjHeI7NlcdsROMmU8fJMoQAPMO1VhKtfjd8sDjza1wG
         7YHyDGK3tHcmMzmYB8w6Cyn5POvtjtnKCsID1RX94ncR2vpR2QwlucCJAkU5Y+Kz5CsV
         Ru4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=Hln/abMmSGptaGAwTz+GKaanQQs67LPV58I6VoMNHu8=;
        b=assmCNsQ2RqrozLsfNF33gG/Uns9BfQxIuJrth4SQ5GfuyJr8YyVBbE6ApesRfXPX+
         Ne8diO08cullDtJxsJQ5QiteM6Yj/04eVb82XVe5+W4oY61mvZlP2FtrAxMd9P1bVL5a
         9o9wsdI+pHsKn6wnFHsxvT8rggJjl04ba6lz3NSDDEYgD6ZD55dyuGf1gUF3jhVPO/Sq
         cFp7re1qgrdkCZTaXo5smbiQctUpNiKdFnm7eh1OlCTsX25MHub6/vQp3awl1fwh5VwQ
         yLsOeKuxhyVMjdyF+Zuj2/cmFaiS6guYlObJJ/9zAOQElqSlqhAWJEVArv/3865tIU4M
         AKgg==
X-Gm-Message-State: AOAM530/suhoZ0/geTPj6TPoglauaejAUT+R2MQZJCSIxefMLl6/AwFC
        vuq/vrhtALzksVhR6wtDnFE=
X-Google-Smtp-Source: ABdhPJx3caGq9OVUiu1RUlDNfvtbm4t6Th9ctenQkoF2PNqCtnGVcj5BCJsMDp1g9OmiPwtdbz082w==
X-Received: by 2002:a62:5211:0:b0:4bc:c949:ae8d with SMTP id g17-20020a625211000000b004bcc949ae8dmr23710733pfb.26.1641677254101;
        Sat, 08 Jan 2022 13:27:34 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id v24sm2595991pjn.29.2022.01.08.13.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 13:27:33 -0800 (PST)
Date:   Sun, 9 Jan 2022 10:27:28 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: pi433: move get version func to where all other
 functions are
Message-ID: <20220108212728.GA7784@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108205955.GA3660@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a convention for the pi433 driver, all routines that deals with the
rf69 chip are defined in the rf69.c file. There was an exception to the
rule in which the uC version verification was being done directly
elsewhere. While at it, the Version Register hardcoded value was 
replaced with a pre-existing constant in the driver.

This patch adds rf69_get_version function to rf69.c

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
v3: add original validation right after reading version value via spi.
Requesters: Dan Carpenter, Sidong Yang, Greg k-h
v2: function names where altered to match suggestions given during code
review. Requester: Sidong Yang
v1: https://lore.kernel.org/lkml/20220106093110.GA20011@mail.google.com/
---
 drivers/staging/pi433/pi433_if.c | 4 ++--
 drivers/staging/pi433/rf69.c     | 5 +++++
 drivers/staging/pi433/rf69.h     | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 68c09fa016ed..051c9052aeeb 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1115,8 +1115,8 @@ static int pi433_probe(struct spi_device *spi)
 		"spi interface setup: mode 0x%2x, %d bits per word, %dhz max speed",
 		spi->mode, spi->bits_per_word, spi->max_speed_hz);
 
-	/* Ping the chip by reading the version register */
-	retval = spi_w8r8(spi, 0x10);
+	/* read chip version */
+	retval = rf69_get_version(spi);
 	if (retval < 0)
 		return retval;
 
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index d64df072d8e8..ee8c81d164e1 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -102,6 +102,11 @@ static inline int rf69_read_mod_write(struct spi_device *spi, u8 reg,
 
 /*-------------------------------------------------------------------------*/
 
+int rf69_get_version(struct spi_device *spi)
+{
+	return rf69_read_reg(spi, REG_VERSION);
+}
+
 int rf69_set_mode(struct spi_device *spi, enum mode mode)
 {
 	static const u8 mode_map[] = {
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index b648ba5fff89..c25942f142a6 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -17,6 +17,7 @@
 #define FIFO_SIZE	66		/* bytes */
 #define FIFO_THRESHOLD	15		/* bytes */
 
+int rf69_get_version(struct spi_device *spi);
 int rf69_set_mode(struct spi_device *spi, enum mode mode);
 int rf69_set_data_mode(struct spi_device *spi, u8 data_mode);
 int rf69_set_modulation(struct spi_device *spi, enum modulation modulation);
-- 
2.25.4

