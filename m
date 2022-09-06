Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F356F5AEE11
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242169AbiIFOub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiIFOuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:50:01 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0F6A1A6C;
        Tue,  6 Sep 2022 07:07:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bq9so2734231wrb.4;
        Tue, 06 Sep 2022 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=1EGslfwy0MFQFuPxDqa4hdz7FVgxyvnt/2v6+bpojsw=;
        b=qhf5a0GZV2cBvuh/pYnMi7KLp5gKWtRISzjGRTP5REDM4YmGUL41DR7mVchpFFLMOg
         opuspTu/eYmzZcnH0LiJXOeX/xR0ZFWFaFzbjZF/xJUYHaaFMnEtcLEsA1wx2GZobVVg
         /MmDH4u2KEY3lEi7QUQV4xKBXyWOF0viOXrEgg0aoJbU1tPiCRWP3rQsV8WA96hRKpPo
         Ry4wRbwH301tCwPYYyn/VPrG8KLw/zzJVp56zGhSrGTEtRY6iNmdD6oyBP7ens/XNKcZ
         4Ew5Ut2v8+0nuCE6SsElrsnkOIsGVcBSS0ptfqtF5AAD09xzNUHjP0HyuznvjEy9DGSw
         cseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1EGslfwy0MFQFuPxDqa4hdz7FVgxyvnt/2v6+bpojsw=;
        b=KRh25JNuVngJ+EdrLXnPqnNYXlQlhpyXLuc0lVXTV+lafHIF2YChubKKUvkvkV4b3x
         SDmJVrOF75zjA17UsNmjS3jxEN3AzkCHZkQQ14BBOE8EnspsJvudIL2CUh1RCrTVTyc/
         ll0SINtQoUGvoa3iER2w118O9bg0XlBmHLCeNAQM09imlLa6tbrGa+YtoBMTKxrttn+O
         06NexAowJHWho2jvK2Vs8xoxFgOScv/gzcuZDAx66qDeaNfFRjfpX7vZo8yMNKR+EXDz
         VAgy+VawkHnDLez/65dSyldDK1H6KqNifeSJ/P0xVWLtOxyH4Sktx6t8h3yH73iqBbGb
         8GvQ==
X-Gm-Message-State: ACgBeo08qWSMJ0Ja8ubxYMkQldmu0o99/vpYh3W3i8989TeOEgUvYo5H
        qVyxIAmOaHt7ybHYYmw/2nY=
X-Google-Smtp-Source: AA6agR6CafI5cXxHZpv1AcnAeYJoO6nsDVSHTnaVBzYG43RBPFf2UPsdO71OQQCfHlpCNpdtAekyEQ==
X-Received: by 2002:a05:6000:1882:b0:226:ef64:55c8 with SMTP id a2-20020a056000188200b00226ef6455c8mr16134026wri.183.1662473154154;
        Tue, 06 Sep 2022 07:05:54 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b003a83ac538a1sm15410239wms.29.2022.09.06.07.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 07:05:53 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thunderbolt: Fix spelling mistake "simultaneusly" -> "simultaneously"
Date:   Tue,  6 Sep 2022 15:05:52 +0100
Message-Id: <20220906140552.194869-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are spelling mistakes in the thunderbolt sysfs documentation.
Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-thunderbolt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
index f7570c240ce8..76ab3e1fe374 100644
--- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
+++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
@@ -153,7 +153,7 @@ Date:		Jan 2020
 KernelVersion:	5.5
 Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
 Description:	This attribute reports number of RX lanes the device is
-		using simultaneusly through its upstream port.
+		using simultaneously through its upstream port.
 
 What:		/sys/bus/thunderbolt/devices/.../tx_speed
 Date:		Jan 2020
@@ -167,7 +167,7 @@ Date:		Jan 2020
 KernelVersion:	5.5
 Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
 Description:	This attribute reports number of TX lanes the device is
-		using simultaneusly through its upstream port.
+		using simultaneously through its upstream port.
 
 What:		/sys/bus/thunderbolt/devices/.../vendor
 Date:		Sep 2017
-- 
2.37.1

