Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DF7481E69
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 18:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbhL3RBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 12:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbhL3RBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 12:01:35 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7386C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 09:01:34 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id x15so18630512plg.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 09:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sqIE3ldOgeHNddnhpAWWPYAlyFaHucud7uyIf39nJQw=;
        b=FS1Iypx6rRIN2o7+2QNHFDX6gAAVjxMV4eesKtQ81T2ge01iA2nZDS9gVmcgvFFpWw
         MpdO8RmKUd8MqG0MZeK+bu3fXkFZAVWRdPDMadjZrmcuIIrvLGR64c0xYoIznEbexP/s
         EysrgJx2g+pomImMjd/SBWFk2VLjePgzgb0uY/aVXJ1ZSq68+ZBKm5JCsCBv6Bp6cw5i
         aoRexUTr5mIJXGepii4bhdvo3B2/cjvGL+/oEK5n2UHs4c4j7ok0D/ajmrYQEqpsNOuq
         FZTn5Ke92gJyo9hd0rgBbmWAQCcK4OxuY1UHGzIxHBvQ3/EgqnpnPEBDV8hvvFSNtnqo
         WHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sqIE3ldOgeHNddnhpAWWPYAlyFaHucud7uyIf39nJQw=;
        b=kCONSIaJXkIznGP4iNnry5pmM3ckmwm2yCOpwVd6sggx2K8+6cxNpxqkFhYe8Q5zX9
         /SJUQFzzaUeEJWKDkhXvh0nQmhtrlA6W3IBN1YHJsWUG+KQI6s0E9ROFo+MDnERJGcH/
         5noUQt1hqz6Npn7c/G4K8PDZJ9Ew5Xwg8YjSOkUQlimD+5Ti1IhxBCW5rucBEsAfCbDt
         UGeTKeTkTPmjeGFvBZVnraY1OvSRMGO6KXTOrWTEOW3VTiKWbqPDOhzGOodFUDZspiqo
         Sfoudhll7i4bPlRGZm+r/+tmCmRLSTx6WosbR+twS0GiJGBYvgWBlKpgo6eKtQdIZh9P
         2++Q==
X-Gm-Message-State: AOAM530nkl74vxyS6bUUmfXk9RN5J3xc5/ysFIeuxGxHxwh4iF8JWPFu
        dycb4X3z8UiwDkPSnzNSTJY=
X-Google-Smtp-Source: ABdhPJwJqILEgA0wbUtfOFTbmdxUEKZum/AuuO+RqH9FwwFdrDJg7qgNWXiV8LcdYN9g+ZvGtjs2lg==
X-Received: by 2002:a17:902:f682:b0:149:194c:d4a3 with SMTP id l2-20020a170902f68200b00149194cd4a3mr31642249plg.122.1640883694372;
        Thu, 30 Dec 2021 09:01:34 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id e16sm26380990pfd.38.2021.12.30.09.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 09:01:33 -0800 (PST)
Date:   Fri, 31 Dec 2021 06:01:29 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: pi433: add docs to packet_format and
 tx_start_condition enum
Message-ID: <20211230170129.GA10296@mail.google.com>
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
v2: removed comments pointed out during v1 review (Req Greg k-h)
v1: https://lore.kernel.org/lkml/20211229094713.GA28795@localhost.localdomain/
---
 drivers/staging/pi433/rf69_enum.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index fbf56fcf5fe8..0f0fa741d089 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -110,12 +110,24 @@ enum fifo_fill_condition {
 };
 
 enum packet_format {
+    /*
+     * Used when the size of payload is fixed in advance. This mode of
+     * operation may be of interest to minimize RF overhead by 1 byte as
+     * no length byte field is required
+     */
 	packet_length_fix,
+    /*
+     * Used when the size of payload isn't known in advance. It requires the
+     * transmitter to send the length byte in each packet so the receiver
+     * would know how to operate properly
+     */
 	packet_length_var
 };
 
 enum tx_start_condition {
+    /* the number of bytes in the FIFO exceeds FIFO_THRESHOLD */
 	fifo_level,
+    /* at least one byte in the FIFO */
 	fifo_not_empty
 };
 
-- 
2.25.4

