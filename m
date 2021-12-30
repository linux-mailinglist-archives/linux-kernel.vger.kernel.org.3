Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58341481D99
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhL3PJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbhL3PJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:09:06 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429A4C06173E;
        Thu, 30 Dec 2021 07:09:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso16196203wmd.2;
        Thu, 30 Dec 2021 07:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sf/3KqcCBGZ0jjyoE9sxhd/PuBCJYLVQgneAgtveI+Q=;
        b=VrLKSJJHDL2DA29VZEX7N3edD3i7J1oADh0QdE+Ge+67lM+yQkAOci75Oz2ljErixb
         JGWYKOGDUm81Gr6QLvLWyvaiEWCS9H7/kchC8IP3E52+Wsm5Wniu2I9z3T0LgHkPWT2k
         CYbmpkhZXP1xP/aGCwh0RRl768aTvEWeyotCQfaHpj2oDihdO8fPQ9qywBgnMO0sNP5L
         XJwkIpZihkbNfjsPPljHiv2BHjV70T1/6IY/dbtMMokE9kEBKsSbFUEWmzn8jmfUZma0
         N4hvkcBYVHlX834+yXrVnuS5yY+0RPM/ffnmu46nSi/88lDqu2Pwg6o/D6hbY4Dkqt4j
         ZLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sf/3KqcCBGZ0jjyoE9sxhd/PuBCJYLVQgneAgtveI+Q=;
        b=vdpApFK2VaaSvv/LCImS07IOeSIzA0U2hJZjlBLVAU7FFN7p5aLGrvznRrb10jRhp4
         1chXtF9i86f8fu00/gZ+Gbg4MHrdJjnZ+oIW+kI1c+V9xKERfHw2yHhZOmna1BmsahbD
         +6+FHoVouprmUEWwM9D6qFiHaZF8foHCeDMSFRZQ33tyK3p6IWzpR7Ha2x5KzxxjIIQi
         v6bVBQ2jzcT6GOe0gA5JhcqHRD+gPG5TqgjPfHMxvDY/9EL+Hz7okvaFYCGz/2vGyorQ
         uBlj3fHnp93A0zRbeMWNWnQPu0l5lxZGUnIAKjQJz4yt5DnXrwgMsEAvrzzl5FDZExWa
         8NgA==
X-Gm-Message-State: AOAM5311Ba5oqChdLBtVqB/mtCoHmfnAnHreKWr4K7voMiR6s1cBZVWg
        Wso/IG+UbcX2vtONwxnZQLB1WG7bt0H95aKh
X-Google-Smtp-Source: ABdhPJwkiMs/OeTQoco6BR7K7opw58ewBVj+GETPXIuGVQyoCDEIJ0BNvZTdWtwtYsATV6WazqvGwg==
X-Received: by 2002:a1c:3b86:: with SMTP id i128mr26609703wma.50.1640876944798;
        Thu, 30 Dec 2021 07:09:04 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l4sm27466631wry.85.2021.12.30.07.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 07:09:04 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     kernel-janitors@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/oid_registry.c: remove redundant assignment to variable num
Date:   Thu, 30 Dec 2021 15:09:03 +0000
Message-Id: <20211230150903.190860-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable num is being assigned a value that is never read, it
is being re-assigned a value in both paths of the following if
statement. The assignment is redundant and can be removed.

Cleans up clang-scan warning:
lib/oid_registry.c:149:3: warning: Value stored to 'num' is never
read [deadcode.DeadStores]
                num = 0;

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 lib/oid_registry.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/oid_registry.c b/lib/oid_registry.c
index e592d48b1974..fe6705cfd780 100644
--- a/lib/oid_registry.c
+++ b/lib/oid_registry.c
@@ -146,7 +146,6 @@ int sprint_oid(const void *data, size_t datasize, char *buffer, size_t bufsize)
 	bufsize -= count;
 
 	while (v < end) {
-		num = 0;
 		n = *v++;
 		if (!(n & 0x80)) {
 			num = n;
-- 
2.33.1

