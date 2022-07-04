Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300A5565D74
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiGDSUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiGDSUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:20:34 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BC3397
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:20:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y8so6875492eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 11:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=piuVSP6b5EJfk61/T0TEns1FkUnGG9mIS4f5KM3XE7Y=;
        b=cVjeFfGZhlxVaqLuhUs2603WjD5WkcyxPJ8pbE5wuEp5iCZeK3fq8aYAGdwrfcJRhb
         1EVhubr0tj95pgAW0Kg/Jr5561Oe0+XEHUUgWanPU72657jxiJvJxDybTh8S4NazxokO
         Ah/8zaNPcfS+dvG9toO+s5OzY318XqWVlIHSVjNUym94/zcqsdPYZWF0YA1zTkGuw7Zu
         PULIU0I01UBZGlUJybRvXvagvkzne6sVXbIOEb0ngww6tJflsUUvWSd17tMVJIPNoKxJ
         UmzvM4NYw5DsYoGigY/pU4+NedqGWKzUcIPRNoLnNqgthJfWfdwhJY5aIPKYDTeEuSZ5
         E7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=piuVSP6b5EJfk61/T0TEns1FkUnGG9mIS4f5KM3XE7Y=;
        b=JSg1LwzBsI73p2hpYp5Adso47cCttI3OuPWpzY4p0nSiUonNRV2+tKoNrJ4euiLt5+
         P3JZQcsxe1rPtsKVtaqkrZDmDJKOfMY3ybVblQCPDWweRwSTrLjQNBuG887rMzdVoitU
         kAO4Uh8zA9fIHHEojtNn945u674a6sNbewPEZxvxg9YH4sVb82OU8NLDFOEGIWQkzFAQ
         z1s1lvD9oSkSj25rIt2JagHDZ2FLRHwvsmJnsVMWptxKpUw8e2/4gk0JVllJaveRUsFS
         MGO+Z1PwMhLhbE7Fk12AW3MyokLh5BPigDyP/A9Yj+ebfajVDEKaBp/EW3iTMuJo1jhz
         GUWA==
X-Gm-Message-State: AJIora9Eh0CaC3EN6JFuWLjpvMJk3jkFqUxKwRbTihjokMcmvRVwkq6E
        VixqnB0+Z4/b7o1DfuPPTzY=
X-Google-Smtp-Source: AGRyM1uKzCKoKK/k/hM8LIo0vM94XycjFQmtEPjv9a32FT2wyza56ObWZ/RnEBDPncySe927lYaB9w==
X-Received: by 2002:aa7:d7c4:0:b0:435:6a5b:b02f with SMTP id e4-20020aa7d7c4000000b004356a5bb02fmr41012117eds.365.1656958832206;
        Mon, 04 Jul 2022 11:20:32 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id u17-20020a056402111100b0043a6e807febsm1241753edv.46.2022.07.04.11.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 11:20:31 -0700 (PDT)
Date:   Mon, 4 Jul 2022 20:20:27 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] staging: vt6655: Rename pbyEtherAddr to mac_addr
Message-ID: <fcc66446a04c1ecb3c2b66cdd47e932c231b1b9d.1656835310.git.philipp.g.hortmann@gmail.com>
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

Fix name of a variable in two macros that use CamelCase which is not
accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 102e575c965d..541c6ed6a62f 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -565,27 +565,27 @@ do {									\
 	iowrite16(wData & ~(wBits), iobase + byRegOfs);			\
 } while (0)
 
-#define MACvWriteBSSIDAddress(iobase, pbyEtherAddr)		\
+#define MACvWriteBSSIDAddress(iobase, mac_addr)		\
 do {								\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
-	iowrite8(pbyEtherAddr[0], iobase + MAC_REG_BSSID0);	\
-	iowrite8(pbyEtherAddr[1], iobase + MAC_REG_BSSID0 + 1);	\
-	iowrite8(pbyEtherAddr[2], iobase + MAC_REG_BSSID0 + 2);	\
-	iowrite8(pbyEtherAddr[3], iobase + MAC_REG_BSSID0 + 3);	\
-	iowrite8(pbyEtherAddr[4], iobase + MAC_REG_BSSID0 + 4);	\
-	iowrite8(pbyEtherAddr[5], iobase + MAC_REG_BSSID0 + 5);	\
+	iowrite8(mac_addr[0], iobase + MAC_REG_BSSID0);		\
+	iowrite8(mac_addr[1], iobase + MAC_REG_BSSID0 + 1);	\
+	iowrite8(mac_addr[2], iobase + MAC_REG_BSSID0 + 2);	\
+	iowrite8(mac_addr[3], iobase + MAC_REG_BSSID0 + 3);	\
+	iowrite8(mac_addr[4], iobase + MAC_REG_BSSID0 + 4);	\
+	iowrite8(mac_addr[5], iobase + MAC_REG_BSSID0 + 5);	\
 	iowrite8(0, iobase + MAC_REG_PAGE1SEL);			\
 } while (0)
 
-#define MACvReadEtherAddress(iobase, pbyEtherAddr)		\
+#define MACvReadEtherAddress(iobase, mac_addr)			\
 do {								\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
-	pbyEtherAddr[0] = ioread8(iobase + MAC_REG_PAR0);	\
-	pbyEtherAddr[1] = ioread8(iobase + MAC_REG_PAR0 + 1);	\
-	pbyEtherAddr[2] = ioread8(iobase + MAC_REG_PAR0 + 2);	\
-	pbyEtherAddr[3] = ioread8(iobase + MAC_REG_PAR0 + 3);	\
-	pbyEtherAddr[4] = ioread8(iobase + MAC_REG_PAR0 + 4);	\
-	pbyEtherAddr[5] = ioread8(iobase + MAC_REG_PAR0 + 5);	\
+	mac_addr[0] = ioread8(iobase + MAC_REG_PAR0);		\
+	mac_addr[1] = ioread8(iobase + MAC_REG_PAR0 + 1);	\
+	mac_addr[2] = ioread8(iobase + MAC_REG_PAR0 + 2);	\
+	mac_addr[3] = ioread8(iobase + MAC_REG_PAR0 + 3);	\
+	mac_addr[4] = ioread8(iobase + MAC_REG_PAR0 + 4);	\
+	mac_addr[5] = ioread8(iobase + MAC_REG_PAR0 + 5);	\
 	iowrite8(0, iobase + MAC_REG_PAGE1SEL);			\
 } while (0)
 
-- 
2.36.1

