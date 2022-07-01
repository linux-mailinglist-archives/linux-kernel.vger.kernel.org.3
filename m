Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89CC5635E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiGAOhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiGAOgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:36:09 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A857F71BE4;
        Fri,  1 Jul 2022 07:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656685875; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=erWTcZFPc95uCcQpwWIsuffV+kMaIdZaBX2lUFVZ6jQ0PkdyHTqc0dgxgq+SJpUEKhZ8oaW3QIf0a/ZO3ZsSMD72HA4t4cPRLHOpqqauFo9veeNn2A8crxUBVJ5JIzIaBcxO42va30l9d2W/YI01+SZ27NGn25xSVtBHlJ94jOQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1656685875; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=veI3Bj2kl/WS8P7h6+c+mQ6AYTA/bSwSuSLXsp+yw6c=; 
        b=A2oWkHKIUEIGcq9vZwEgZwueTgVJ6qaIjKwYp4DrQR1pJ9o+DXNBxHi7w2oWC+mM2ioJCGkVgWJClQpwYiJGYiesQuThFbEJz8a/aOLlYi5vA2Ifma/Y2j7kdVYOBnknzTuU/VLzeQ8jCvFgg0I/Cbnzx09xP7/ujfoQBMEFnAg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656685875;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=veI3Bj2kl/WS8P7h6+c+mQ6AYTA/bSwSuSLXsp+yw6c=;
        b=Mj1LyBSmD4fFfVr9RLZxrfArld07QiqMwOU8nOsCvbAFUGlly4k6nsqGitBpd2Mz
        yMihqvc+n9a+fUzYM0OH6NRJBVTb/dudXgBDo6mhot4fbzIEh2L2+KJNmr92UzDQzug
        xSVhrMm8GvSg3zyn7WTeYSXwBtjx2V46W5lQwW1g=
Received: from localhost.localdomain (103.250.137.221 [103.250.137.221]) by mx.zoho.in
        with SMTPS id 1656685873410201.92961736997165; Fri, 1 Jul 2022 20:01:13 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Vladis Dronov <vdronov@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Harald Freudenberger <freude@linux.ibm.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <20220701142515.14800-1-code@siddh.me>
Subject: [RESEND PATCH] MAINTAINERS: Add tools/testing/crypto/chacha20-s390/
Date:   Fri,  1 Jul 2022 19:55:15 +0530
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the maintainers' information for the
s390 ChaCha20 self-test module.

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
CC'd the maintainers in this enail which I had not
done last time.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe5daf141501..0fcacd715b1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17438,6 +17438,14 @@ F:=09Documentation/s390/
 F:=09arch/s390/
 F:=09drivers/s390/
=20
+S390 CHACHA20 SELFTEST
+M:=09Vladis Dronov <vdronov@redhat.com>
+M:=09Herbert Xu <herbert@gondor.apana.org.au>
+R:=09Harald Freudenberger <freude@linux.ibm.com>
+L:=09linux-s390@vger.kernel.org
+S:=09Supported
+F:=09tools/testing/crypto/chacha20-s390/
+
 S390 COMMON I/O LAYER
 M:=09Vineeth Vijayan <vneethv@linux.ibm.com>
 M:=09Peter Oberparleiter <oberpar@linux.ibm.com>
--=20
2.35.1


