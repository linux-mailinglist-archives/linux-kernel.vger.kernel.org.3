Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093894820F7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 01:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbhLaATk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 19:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhLaATk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 19:19:40 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED49C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 16:19:39 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so24385770pjq.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 16:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NkqRNNqdWnGnE0W/FPoPkuJT53qZDL0ppvXkFpYOLH0=;
        b=Wyr+9BhjCsOXR3L78Hkb48nq/AiQO0hWGBvmvgeWkGmDfGbULdR67cAiqu5foOt0Y8
         ZSqNuZQEJ8EyCjbJIuR/uK7I7X5qnXeqXgiKAqHUmJUH0+lZ0HP80YbkPgLZHHRHBQIJ
         5uCTUvM+8poGE8Hsp3AHoKZhTNBdPmTftsFjeX0YfdNWp5xXVcV3Qo7loaCp5DJ+Jkg/
         doztlJX7ZFKJMDv5suL+3LoA7CsoQ8Q9C2DB8BPGY7V2Z3OLobudOdikRSn9Fu4EVzzi
         uFtxwa6PzZZFFuXXK0ERZGVkKp6TOQUUqWkIu671PVoiD/q+C0Thylj5RKYi4T6PDG/8
         ibPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NkqRNNqdWnGnE0W/FPoPkuJT53qZDL0ppvXkFpYOLH0=;
        b=0m8V0JKSLB2sHlaJwNgeT+dHSA5kqHRzcOttKWBQ61INqaUEy4JUGo9XqBjoaxOSIa
         +Qz93exjrD/shIIi96RkilHl2GJazy1i1iNR6JWi3KWVfWyYATwapMJBCkHnbg9R1bhJ
         0xDJ6zUxDNbvzzB9bdFGVFXfNMUeCm2zGKhKvnfXPlORQsWRwCB4HpTgNlxQt+XhD6So
         jDNHPNKJ/RnSOs35Z5wuq5V2Rmu7ex3N1KwDQeDPt+WHbU4F5agVRK3TMwu0G8ZLfuwp
         glC8JSBHy2thXmtHCHxa2oBlrY0OOS3Xrgg86qEpapByTY0mXfZBeOo98AtWoL93gXIi
         FGOg==
X-Gm-Message-State: AOAM533tRKqoOOq5PY6mR84ndIz5wBtVj89fZALWktUYqoUVkGg/D+4j
        br7pvDa6ukHtAdp5Dl6DaDE=
X-Google-Smtp-Source: ABdhPJw+ibIWzDJmRsxqV8rxNJpYCQa722YIWG/QIFpWLfxbcbZVrugjVI+wrejWywkT62zAraOt8g==
X-Received: by 2002:a17:902:e28a:b0:149:907a:1b4e with SMTP id o10-20020a170902e28a00b00149907a1b4emr15380960plc.44.1640909979409;
        Thu, 30 Dec 2021 16:19:39 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id ev3sm28843282pjb.48.2021.12.30.16.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 16:19:38 -0800 (PST)
Date:   Fri, 31 Dec 2021 13:19:33 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: pi433: add docs to packet_format and
 tx_start_condition enum
Message-ID: <20211231001933.GA6779@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While pi433 driver deals with the nuances of the different possible
config combinations, it's hard (at first) to understand the rationale
for some of the tx/rx-related source code unless you're fairly familiar
with the rf69's inner workings.

This patch documents the expected behaviour and limits of both
packet_format and tx_start_condition enum fields.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
v3: fix formatting issue (Req Greg k-h bot)
v2: remove comments pointed out during v1 review (Req Greg k-h)
v1: https://lore.kernel.org/lkml/20211229094713.GA28795@localhost.localdomain/
---
 drivers/staging/pi433/rf69_enum.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index fbf56fcf5fe8..b33a33a85d3b 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -110,12 +110,24 @@ enum fifo_fill_condition {
 };
 
 enum packet_format {
+	/*
+	 * Used when the size of payload is fixed in advance. This mode of
+	 * operation may be of interest to minimize RF overhead by 1 byte as
+	 * no length byte field is required
+	 */
 	packet_length_fix,
+	/*
+	 * Used when the size of payload isn't known in advance. It requires the
+	 * transmitter to send the length byte in each packet so the receiver
+	 * would know how to operate properly
+	 */
 	packet_length_var
 };
 
 enum tx_start_condition {
+	/* the number of bytes in the FIFO exceeds FIFO_THRESHOLD */
 	fifo_level,
+	/* at least one byte in the FIFO */
 	fifo_not_empty
 };
 
-- 
2.25.4

