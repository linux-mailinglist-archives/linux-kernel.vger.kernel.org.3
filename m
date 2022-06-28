Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6355CA50
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiF1IbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245435AbiF1IbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:31:10 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FE926AE4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:31:07 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2BxBQCEu7piffxkzoFagliDJYFXlBABAQEGjHGHH4ong?=
 =?us-ascii?q?gcBAQEBAQEBAQEJLxMEAQE9AQKKDyc1CA4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?gEBAQEBBwQUAQEjPCeFaA2GQwYyAUYQUVcZgngCAQECgmQBAzCuYIEBhloBg?=
 =?us-ascii?q?T+BZYE9iVmFH4FAgRCBSIEJgiyFEYVuBJcogl4KAwkEBwVGFxJOMSECRQscA?=
 =?us-ascii?q?QgGBgcBCAEFCCgEAgEBAQYFGBQBAwEBExIFEwwHKAoSAhIMChsHBwMLBTINA?=
 =?us-ascii?q?g4HAQEMDwECDwMBAhEBBwIJEggGDysIAwEBAwEHAQICAyALAgMWCQcIAgECB?=
 =?us-ascii?q?QICAQMPAQgKHBIQFAIEDQQeCQIIAQIZHiwHAgIEDgMjHwgLCgMOAwQDARACG?=
 =?us-ascii?q?AcCARUBBQIECAQBAwYDCBUZAQ0nBAcDEgINAQYBAgYBAQUFAQMYCAMUAwUBA?=
 =?us-ascii?q?ggDFgcBAiEFCiYJBA0DASIbAgMDAQQbCgIBAgIFFgUCAQECAwIGFQYCAj8vE?=
 =?us-ascii?q?R0NCAQIBAkSHCMBAgwBBAECBy8FBC0CAQEeBAUBBQ8CCAEBFgIGBAMCAgMBA?=
 =?us-ascii?q?QIBFgIQCAIIJxcHEzMZAQU3FA4PAQMGCBkcIgcJBwUGFgMMFSkeKQUHERIbD?=
 =?us-ascii?q?wQNDQo0IBYkAQEOBQMBEhkRDgcUClMmIRUQBgErFgMEAQMDAgYaAQIDIgISC?=
 =?us-ascii?q?wkVAgQtBQEiHRmaV3MBgQ1Ml32rYQeDURABixCVJoN1gVCKc4YqApIAlnCic?=
 =?us-ascii?q?YRPNYEtAUeBTE0jgzgJSBkPl1SFHnM7AgYLAQEDCY8BAQE?=
IronPort-Data: A9a23:cWh0oqOUwmaUAsfvrR0/l8FynXyQoLVcMsEvi/4bfWQNrUoi1zUGy
 mFLXG7UaP7eNzf3L91zbNu+pEgHsZSHxt5mT3M5pCpnJ55ogZOYWo7JcBuY0wB+jCHnZBg6h
 ynLQoCYdKjYdleF+lH1dOKJQUBUjclkfJKkYAL/En03FFUMpBsJ00o5wbZn2N4w2LBVPivU0
 T/Mi5yHULOa82MsWo4kw/rrRMRH5amaVJsw5zTSVNgT1LPsvyB94KE3fcldG0DFrrx8RYZWc
 QpjIIaRpQs19z91Yj+sfy2SnkciGtY+NiDW4pZatjTLbhVq/kQPPqgH2PU0R2JbsW+OmstIl
 cgS75m5ai4WMKHGsbFIO/VYO3kW0axu/bbGJSDm99GVzgjGfnrgzvFkAVs5e4EVkgp1KTgUp
 LpCcG5LN0jbwbjrmtpXScE17ignBNLgPIcSomlt1xnCEesqB43FQuDK6N5U0TM6i9pBW/rTD
 yYcQWMxMUmZP0QTZT/7Drodhrn1vHr9egFWqVeb/+0J5GyIkFdYhe2F3N39IYDUGZ8Mxi50v
 Fnu4GbiBQ0THNOawDuBtHmrg4fnkjn2V4ESPLm58ON6jlqOwGAaFBwRUx28u/bRokq/Xc9Pb
 lcI8yUvq6ca8E2wUsK7Wxy+vW7CshMCM/JeSPYx6EeCy7b85BuFAm8DTXhKb9lOnMs3QyE6k
 1yEhdXkARRxv7CPD3GQ7LGZqXW1Iyd9EIMZTSoNTA9dup/+poB2jh/OQttnGqOvgZv5FFkc3
 gxmsgAQorkp18kOzJzm4A+dhjuPj6fHQgQcs1C/sn2e0it1Y4usZoqN4Ffd7OpdIIvxcrVnl
 CZd8yR5xL1eZaxhhBBhU81RTe3wv6nt3Cn00QA/R8BJGyGFpib7Fb289g2SM29FH67okxfJb
 U7ftAdb6YVcVJdBRfEmOtjpYyjG5YLpGdnjE89/usBSfpV0fgKd80lTiaO42mnslBB117w5O
 NKbfMegAHIQBL5oija7Lwv87VPJ7n5urY8wbcmlp/hC7VZ4TCLKIVviGADfBt3VFIve/G3oH
 y93bqNmMSl3XuzkeTXw+oUON10MJnVTLcmo9pIMK7LdeFQ4QzhJ5xrtLVUJJd0Nc0N9yLugw
 51BchEJoLYCrSefeFjUMy4LhE3HDc0v/RrXwhDAzX7zhyZ/O9/3hEvuX5E6eaY6+aR+y/9qQ
 uMeetmRSvJCVivA4Td1UHUOhNMKSfhfvirQZHDNSGZkIPZdq/nhoIKMkv3HqHJTVEJadKIW/
 9Wd6+8sacBTG1k9VJeGM6nHIpHYlSF1pd+elnDgerF7EHgAOqAwQ8Atppfb+/0xFCg=
IronPort-HdrOrdr: A9a23:gpTfQ6xlvZv3K9yAflrvKrPwFr1zdoMgy1knxilNoHtuA6ulfq
 GV7ZAmPHrP41wssR4b9OxpJMG7MBHhHOFOkO8s1NuZMDUO21HYSb2Kj7GD/9SIIUSXygc678
 ldmodFZ+EYZmIK7voSjjPYLz8o+qj/zJyV
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 10:31:06 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 3C76330011A5C;
        Tue, 28 Jun 2022 10:31:05 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH 1/7] Staging: rtl8192e: Added blank lines before/after struct
Date:   Tue, 28 Jun 2022 10:30:50 +0200
Message-Id: <f23e5ad2839c238665956f0d552cacd9944b724d.1656402464.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656402464.git.f3sch.git@outlook.com>
References: <cover.1656402464.git.f3sch.git@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addresses an issue raised by checkpatch.pl:

     $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
     CHECK: Please use a blank line after function/struct/union/enum
     declarations

The additional blank line above the struct/before the headers is
just cleaner.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index cf9a240924f2..3b81a3395527 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -17,10 +17,12 @@
 #include <linux/module.h>
 #include <linux/etherdevice.h>
 #include "rtllib.h"
+
 struct modes_unit {
 	char *mode_string;
 	int mode_size;
 };
+
 static struct modes_unit rtllib_modes[] = {
 	{"a", 1},
 	{"b", 1},
-- 
2.36.1

