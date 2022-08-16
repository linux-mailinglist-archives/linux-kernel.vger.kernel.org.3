Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41735953B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiHPH1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiHPH0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:26:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739BA17DAF4;
        Mon, 15 Aug 2022 20:56:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so8503768pjf.2;
        Mon, 15 Aug 2022 20:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=43JJPl2/b0ePcqgmiIwFOJRXHeqLyakQiBrbeBqJ1gA=;
        b=WRPvKdPC/m9FRpNzEBZxDXD6kWUNfmomVCkcDdRT17+GngC86zKzODxfXeiV8DFEBV
         73qJWT/lAGD0Cm6afAjnaS+X9hBtVILhlr/p2dvKHttDqfkt01S1Lw1qYASfc4KZYzP9
         FkNiL0rYZUfNHGe95DfcG+3xGihuI/U9DTM87hb63W6i3kboLOx6mV4/4nGZi7OPELhJ
         mEQLeZMIw5e4gJC2H6zKUebrvGMn/1wykgUPgzIe9TJRwT0+jJkWXJlOD5Gdx4/b6S5P
         DtkNpCbzXUSwQPx9xms/vtSNd3j98SQ9+ZM2Z0jFtVnVDb9X6YvtbAQrRKx/dAlXcTcR
         y06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=43JJPl2/b0ePcqgmiIwFOJRXHeqLyakQiBrbeBqJ1gA=;
        b=tOPq1KG5S7vN2uVw1lPtCSoLblDaQDf38VM+xUVkvHBk8BfNYPVoXX4mpmZtms9xKh
         cezostPvxoBt+SQHin2nKKp3HGKUGrY/7hJwRjIaUqxIEvARNRf0OVh7JTXoTFXUYSkR
         tzNC/+LbJXaSd+GYhi0l4N8pkARSANgPzh6zUk97Ocn8Jxa/sEoE88sW4jrYlmYJuvqc
         fxfOIUeN4QzdhSNA6GMlvio3BXZhOAxoZwZtOyvplLIF8k/TGNlkUjhie8hLsF7/mesM
         MMgFOz3MKxdtkCM4SyGDtIO6XByWbVj/teXWuSV46qZzPyGnMe6Qdrigr9OOAJKz16hE
         sZNQ==
X-Gm-Message-State: ACgBeo1d1FFvtGPeD5NXjpIhIEvDNHh1Bpge9xidWqIAvFqbFVHc4INh
        VVG3pgQ4cGRegMlXOCVjVEgIKPekOFE=
X-Google-Smtp-Source: AA6agR4C+cL9nTUptDwV+vx3d93GsX8/3Nb7L4ahPfrp8PqK8YCsb4Po9dppJqdbE5BlpX9kWfKiqw==
X-Received: by 2002:a17:902:f303:b0:172:689f:10a4 with SMTP id c3-20020a170902f30300b00172689f10a4mr10135814ple.42.1660622200836;
        Mon, 15 Aug 2022 20:56:40 -0700 (PDT)
Received: from localhost.localdomain ([116.75.96.232])
        by smtp.gmail.com with ESMTPSA id l13-20020a17090ac58d00b001f2fa09786asm5356846pjt.19.2022.08.15.20.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 20:56:40 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     alexandre.belloni@bootlin.com, a.zummo@towertech.it
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jagathjog1996@gmail.com
Subject: [PATCH 0/3] rtc: rv3028: Fix codestyle errors and checks
Date:   Tue, 16 Aug 2022 09:26:33 +0530
Message-Id: <20220816035636.27226-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fix the following errors/checks reported by
checkpatch.pl:
- Add space required before the open parenthesis '(' and after the ','.
- Using tabs instead of spaces.
- Matching open parenthesis and removing unwanted blank line.

Jagath Jog J (3):
  rtc: rv3028: Inserting some required spaces.
  rtc: rv3028: fix code indent issue
  rtc: rv3028: Alignment to match the open parenthesis

 drivers/rtc/rtc-rv3028.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

-- 
2.17.1

