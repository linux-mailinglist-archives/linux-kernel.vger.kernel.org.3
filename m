Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2ED55DD09
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbiF1Grc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbiF1Grb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:47:31 -0400
Received: from sender-of-o52.zoho.in (sender-of-o52.zoho.in [103.117.158.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB6426AEB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656398840; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=elbxiBPgCFU3Q1HeSZO3T8aGAHTd7WBPWTrQUtxH99UOQQGLfonylpAqEMnGaIDrFkx1synYywGZACJw7PgHKxxO9hlGJKeerQQCm/hKb1JPoOOMzoyYiqgRj3EK8UyrRbV6eG+v9UthpEgczMsTUiYzdIoIot9+8bU4Q6GlCzE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1656398840; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=HRFI+eRTirvZRFeTRPwa50gFz5/7YOJxbkzkaz1APeo=; 
        b=UD7QxIJjRGdKPD2/0fdixEKyX7I8dLW/lSOmSrR9WClyT+GMpSadNyOMElXveJlBDkuuqkxi8PLxfqL1AdjXpXU9egqqqVl4CKObe087P891gOOuRn2Nvf/us3Y/OcAWVePlFFY4+InQZxeE8QsXWyODIiV4rOXkZKuIvc7BB+U=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656398840;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=HRFI+eRTirvZRFeTRPwa50gFz5/7YOJxbkzkaz1APeo=;
        b=IwR5aSq0pFdUwm9fE5cj4I1c+7n4CBylMdgFHnPZL55IuDKWZaR/7Lemx8vDSMLZ
        sUNrNz6su04MiJ53GAkTSRKaMnfTSYQLdJyJXZ0VNzot50G3mLVIv8HlVkaWzg2OGhO
        FN9M0IxMSWe8cUV0SXdXlWw9Jf1cSVXponQ5TpzA=
Received: from localhost.localdomain (103.249.233.51 [103.249.233.51]) by mx.zoho.in
        with SMTPS id 1656398838723609.1768701113493; Tue, 28 Jun 2022 12:17:18 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org
Message-ID: <20220628064621.14427-1-code@siddh.me>
Subject: [PATCH] MAINTAINERS: Add tools/testing/crypto/chacha20-s390/
Date:   Tue, 28 Jun 2022 12:16:21 +0530
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


