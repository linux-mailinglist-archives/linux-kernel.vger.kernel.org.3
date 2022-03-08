Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3914D1201
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344946AbiCHIUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344980AbiCHIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:20:53 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AB93F314
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:19:57 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 132so15801481pga.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=5urQPEXfDPWD6h0/ZSxr0FLAC0ujAefCEZFrLV2CQ3o=;
        b=q6ERUKGrM6tlptrFBXxei8rLRL8mHQ8SN569g8ZFkVtDAXx1eUvUE7ohFHOdES2Vw9
         fHPjPc0jLTaTOPMAmWOt6Tduw6qIEOb4Gn0yNXp52+9tXtDFOHUFmQidhrcycOjon0SI
         dudpHR4JeWBtjNs+MQkbOW0UacgObEKi3fOmyekVRCCDNcKzpJBDfBkvW4kqk8GqdEQn
         f9s+W0CdkJ8wV5l/ycUmeXVMkbkle32TuHNyF81sePlW60xoH5oRnALSoG8XtdDJuu0B
         45AdysKUZkjlE7UoXQjGfqxydc0U8liOxnp7khFd+F9pBFUwp412snMyERXpgmvx3ovM
         Sdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5urQPEXfDPWD6h0/ZSxr0FLAC0ujAefCEZFrLV2CQ3o=;
        b=WSrBaTNgQUfmJdWETVPIlTWnVHAY9HKRK8lvjcRRt38J8ibJoXvQDQs2qZamwnTjr0
         OlqdgpLDteqJwicx3cYapswOGYWPyB6l2V18JY0GhWIoQBamwOueHId+hKkTozZvmT6Y
         TcM3bqJHf2jkXCEvgEoNM2J/StM4KgsfA3LunG9AAcrmwdPoZmJ+2Xd4utzHerT+/KB2
         1SUOxyObXtAilNnyKOjMTJ+2lUzKM3uRzffv4NJDCVLZaWwqBJztHCd5ziUvLsSzLQMc
         jwPd8cUA3wODAd6IVLAsl5KYRsmcBQLLKQNPKK/q8Z+vRZ/+TIDGwP1Um7DIUPaN9MXK
         /H5Q==
X-Gm-Message-State: AOAM5339FPm6uuS24U7ghmnSulwVeAcPI9IUiPNo38o1UYYfd0fKm6kB
        +lDFZ/TUKRtwz2TJuL/IbWOegR5yOF/h3Q==
X-Google-Smtp-Source: ABdhPJwtsAG7xFHWyve3uOD/BbIQ2BXXngGRwLF4ygqQNKgyM6BcNMLhA93jZL5yKgphnkUH2eAkZA==
X-Received: by 2002:a05:6a00:1910:b0:4f3:aa39:1e17 with SMTP id y16-20020a056a00191000b004f3aa391e17mr17154103pfi.54.1646727596515;
        Tue, 08 Mar 2022 00:19:56 -0800 (PST)
Received: from mail.google.com ([122.58.164.114])
        by smtp.gmail.com with ESMTPSA id c34-20020a630d22000000b0034cb89e4695sm14372921pgl.28.2022.03.08.00.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:19:56 -0800 (PST)
Date:   Tue, 8 Mar 2022 21:19:50 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: formatting improvement for multi-line
 bitwise statement
Message-ID: <YicRpmT2xMupVp4h@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move bitwise & operator to the end of previous line for better
readability

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Meta-comments:

This suggestion was made by Dan Carpenter in a previous patch that ended
up being merged:
https://lore.kernel.org/lkml/20220228063238.GA2794@kadam/
---
 drivers/staging/pi433/pi433_if.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 3f3e863e6cc8..9a55fb29bd54 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -442,8 +442,8 @@ static int pi433_receive(void *data)
 		/* wait for RSSI level to become high */
 		dev_dbg(dev->dev, "rx: going to wait for high RSSI level\n");
 		retval = wait_event_interruptible(dev->rx_wait_queue,
-						  rf69_read_reg(spi, REG_IRQFLAGS1)
-						  & MASK_IRQFLAGS1_RSSI);
+						  rf69_read_reg(spi, REG_IRQFLAGS1) &
+						  MASK_IRQFLAGS1_RSSI);
 		if (retval) /* wait was interrupted */
 			goto abort;
 		dev->interrupt_rx_allowed = false;
-- 
2.34.1

