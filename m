Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB74F4C89
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578716AbiDEXYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389627AbiDENeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:34:04 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E15137022
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:39:47 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 235CdbGR027079;
        Tue, 5 Apr 2022 07:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649162377;
        bh=/OV5EIXkyfTUEfMK+NbO/uRsTKu3O0KPAyqpHSHxqVY=;
        h=From:To:CC:Subject:Date;
        b=rBhAQvK+jG6gu6yh+a7D4lygUBpzbeisNCiBjy3MNPUnwXIrHof24o1aJMlicO6tc
         P58OgNH+HBMBItFGCTa1Mo1RTPG/vdjiUMWMY0sNLaFoWxatW0qG7oxjQkmOJHPtzB
         8DSsfUVYO1E4JjPYVAV2pwlcCnQ3Wj/Yx0n0cHPQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 235CdbAo035535
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Apr 2022 07:39:37 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Apr 2022 07:39:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Apr 2022 07:39:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 235CdbEr112656;
        Tue, 5 Apr 2022 07:39:37 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Nicolas Palix <nicolas.palix@imag.fr>,
        Julia Lawall <Julia.Lawall@inria.fr>
CC:     <linux-kernel@vger.kernel.org>, <cocci@inria.fr>,
        Kirill Smelkov <kirr@nexedi.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] coccinelle: api/stream_open: Introduce metavariables for checks
Date:   Tue, 5 Apr 2022 07:39:36 -0500
Message-ID: <20220405123936.30259-1-nm@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle spatch version 1.1.1 reports the following:
warning: line 134: should no_llseek be a metavariable?
warning: line 141: should noop_llseek be a metavariable?
warning: line 223: should nonseekable_open be a metavariable?
warning: line 290: should nonseekable_open be a metavariable?
warning: line 338: should nonseekable_open be a metavariable?

So, introduce these as symbols to be specific C identifier to match.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

based on: next-20220404
Changes since V1:

* Switch from identifier to more specific symbol

V1: https://lore.kernel.org/all/20220404215926.14811-1-nm@ti.com/

 scripts/coccinelle/api/stream_open.cocci | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
index df00d6619b06..d33732f35710 100644
--- a/scripts/coccinelle/api/stream_open.cocci
+++ b/scripts/coccinelle/api/stream_open.cocci
@@ -129,6 +129,7 @@ identifier llseek_f;
 
 @ has_no_llseek @
 identifier fops0.fops;
+symbol no_llseek;
 @@
   struct file_operations fops = {
     .llseek = no_llseek,
@@ -136,6 +137,7 @@ identifier fops0.fops;
 
 @ has_noop_llseek @
 identifier fops0.fops;
+symbol noop_llseek;
 @@
   struct file_operations fops = {
     .llseek = noop_llseek,
@@ -216,6 +218,7 @@ identifier stream_writer.writestream;
 
 @ report_rw depends on report @
 identifier fops_rw.openfunc;
+symbol nonseekable_open;
 position p1;
 @@
   openfunc(...) {
@@ -283,6 +286,7 @@ identifier stream_reader.readstream;
 
 @ report_r depends on report @
 identifier fops_r.openfunc;
+symbol nonseekable_open;
 position p1;
 @@
   openfunc(...) {
@@ -331,6 +335,7 @@ identifier stream_writer.writestream;
 
 @ report_w depends on report @
 identifier fops_w.openfunc;
+symbol nonseekable_open;
 position p1;
 @@
   openfunc(...) {
-- 
2.31.1

