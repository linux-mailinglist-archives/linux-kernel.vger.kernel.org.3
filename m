Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D14B4B8C53
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiBPPYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:24:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiBPPYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:24:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2FB25A33B;
        Wed, 16 Feb 2022 07:23:47 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v12so4076208wrv.2;
        Wed, 16 Feb 2022 07:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FveRsyn6G+AiS/67uc2i7UcswT5E00/72XjPpLnE4PU=;
        b=d8/oHYZiL5fPjypqzqC21dxn9m+5MWflaSyB57w2/iyRfc81j2rJneQta5DNxCIf10
         ofV5Ts/su54o7RROgrg7VuNlmzGdZbgtbP3ni3hgC2jJmZ5qPW1gB55J99ozYpeV1I3F
         WdNZpsM8tz6qz21zaM7MjSzToTMQnJIQJkXZ8CyOiMKd7yoLOT28Dbw439CGWCwNIZZd
         rDWijBfvh4ZtuNQ9kIj0cvuXeAl0vyOv/HlkgP9uxv+haYuv3G44NtvTYATrvWsWzg4v
         ZXWxn6SzZ+ualDt7vaYRSkygzCz77iFv2OjgNPePBaJTknwCKKn6me6jwawZMPVscMOH
         aNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FveRsyn6G+AiS/67uc2i7UcswT5E00/72XjPpLnE4PU=;
        b=1WnBr0z8rQLXjDPRgzkloFtiLOvyQVGxAQL/Bhg6Zr5PdvZsXnAHIP3xLdpXJmt4jX
         SwR66ubaGBAxrYJ0b8dNKdV5LZ24mu6VfZmLTvP2o4+EjTK3bZ1+92erS5oRnVr1JlCM
         gGtAk13ctYgAPPyGokKFhaj5lmG3fmVkt2iYeO5xT82mTWIx57GFKmbLs0cuAwsRgVLz
         hweTFsqT6Yji+MRY8txFJqzg2EKkzVx/60YaMoL+YV0gWdpwwq3J7mJh6TBFd2oy2BSK
         LuiGqGENjukyw1TuCG0DADK8UXHtzpnh3hj7Pa4nuD+kR/DtpSrgF9jikM63WC+TjGkZ
         WODQ==
X-Gm-Message-State: AOAM532OdhlGqXR5CEIkCgyReQWjHmNKIMaSPR8x9V/eJOTELuCN5NUf
        x7XcD7UJ82tDXy0k+ExhA79zX88yGbE=
X-Google-Smtp-Source: ABdhPJyD/zn/Q853EHIU6kOwRmhyWrIBSXkmeOd2MBDDMvbqV7244T6J6otJbW+HnYFfrz//bDDJrQ==
X-Received: by 2002:a5d:51c1:0:b0:1e3:45bf:da38 with SMTP id n1-20020a5d51c1000000b001e345bfda38mr2695639wrv.144.1645025024872;
        Wed, 16 Feb 2022 07:23:44 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w18sm19030411wrl.62.2022.02.16.07.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 07:23:44 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/spelling.txt: add more spellings to spelling.txt
Date:   Wed, 16 Feb 2022 15:23:43 +0000
Message-Id: <20220216152343.105546-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Some of the more common spelling mistakes and typos that I've found
while fixing up spelling mistakes in the kernel in the past four months.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 scripts/spelling.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 0c8b79cfb1bb..8435b99452b6 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -180,6 +180,7 @@ asuming||assuming
 asycronous||asynchronous
 asychronous||asynchronous
 asynchnous||asynchronous
+asynchronus||asynchronous
 asynchromous||asynchronous
 asymetric||asymmetric
 asymmeric||asymmetric
@@ -231,6 +232,7 @@ baloons||balloons
 bandwith||bandwidth
 banlance||balance
 batery||battery
+battey||battery
 beacuse||because
 becasue||because
 becomming||becoming
@@ -333,6 +335,7 @@ commoditiy||commodity
 comsume||consume
 comsumer||consumer
 comsuming||consuming
+comaptible||compatible
 compability||compatibility
 compaibility||compatibility
 comparsion||comparison
@@ -353,7 +356,9 @@ compoment||component
 comppatible||compatible
 compres||compress
 compresion||compression
+compresser||compressor
 comression||compression
+comsumed||consumed
 comunicate||communicate
 comunication||communication
 conbination||combination
@@ -530,6 +535,7 @@ dissconect||disconnect
 distiction||distinction
 divisable||divisible
 divsiors||divisors
+dsiabled||disabled
 docuentation||documentation
 documantation||documentation
 documentaion||documentation
@@ -677,6 +683,7 @@ frequence||frequency
 frequncy||frequency
 frequancy||frequency
 frome||from
+fronend||frontend
 fucntion||function
 fuction||function
 fuctions||functions
@@ -761,6 +768,7 @@ implmentation||implementation
 implmenting||implementing
 incative||inactive
 incomming||incoming
+incompaitiblity||incompatibility
 incompatabilities||incompatibilities
 incompatable||incompatible
 incompatble||incompatible
@@ -942,6 +950,7 @@ metdata||metadata
 micropone||microphone
 microprocesspr||microprocessor
 migrateable||migratable
+millenium||millennium
 milliseonds||milliseconds
 minium||minimum
 minimam||minimum
@@ -1007,6 +1016,7 @@ notity||notify
 nubmer||number
 numebr||number
 numner||number
+nunber||number
 obtaion||obtain
 obusing||abusing
 occassionally||occasionally
@@ -1136,6 +1146,7 @@ preprare||prepare
 pressre||pressure
 presuambly||presumably
 previosuly||previously
+previsously||previously
 primative||primitive
 princliple||principle
 priorty||priority
@@ -1297,6 +1308,7 @@ routins||routines
 rquest||request
 runing||running
 runned||ran
+runnnig||running
 runnning||running
 runtine||runtime
 sacrifying||sacrificing
@@ -1353,6 +1365,7 @@ similiar||similar
 simlar||similar
 simliar||similar
 simpified||simplified
+simultanous||simultaneous
 singaled||signaled
 singal||signal
 singed||signed
@@ -1461,6 +1474,7 @@ syste||system
 sytem||system
 sythesis||synthesis
 taht||that
+tained||tainted
 tansmit||transmit
 targetted||targeted
 targetting||targeting
@@ -1489,6 +1503,7 @@ timout||timeout
 tmis||this
 toogle||toggle
 torerable||tolerable
+torlence||tolerance
 traget||target
 traking||tracking
 tramsmitted||transmitted
@@ -1503,6 +1518,7 @@ transferd||transferred
 transfered||transferred
 transfering||transferring
 transision||transition
+transistioned||transitioned
 transmittd||transmitted
 transormed||transformed
 trasfer||transfer
-- 
2.34.1

