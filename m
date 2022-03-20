Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B424E1AF7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 11:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243862AbiCTKCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 06:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbiCTKCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 06:02:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771975C859
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 03:00:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q5so1167479plg.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WdvnP6677XQUxwCvb+l3NHWmDq4klejHLdViSs4u5xY=;
        b=mS1TSrJNdEiCOFtmoOF/KnIDhNET7eyG8ivZ1PFjeqh7OcrOVIIsp/RUFHunY1m716
         qfbw7QWuMYIO/XMAC4xqiCiMnnINehPKDHQkirPyw6BTAvDMA8uJ2pIKjiFJ8XAf5M8A
         XxP80x8By12aUzJkjzJkJfsuDDOdycyiQEIZa5UdHewXx9wlQ1l9s5N9B8qNOizKfFCL
         1alHdl5ogIgoKZMF6PZLIRgjq4Rc6d16PrqraTW8WhGRzrqG/olB+3rqEIQ1a7jv7+w3
         4CuJ9Eur0FS1VSl2wSUE8wMjmTTVpbKotGiNyitU3yvh9UOlppGCv/PMxybqy4BB4E9j
         aBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WdvnP6677XQUxwCvb+l3NHWmDq4klejHLdViSs4u5xY=;
        b=Fj+DStmRe78ct2RaRDspreZ7PKBHUzfG0QJ0xGEaA5/jJsaWiBYIi7JCOtSfE3UzPJ
         SctFyFD8NmFx019DKxeeMuMQ4jWzjl5uLqhO2sG43NdmQRHor0QT39OGGG/DE53ckmBI
         o7WksfJ5MbHsCjqVKHMr8Njc00bFt8TqaptwBuJZu3aq6k9cfWl7+bcm1pmqqARnk8tW
         rxtJ2DnfW4Feo0rgZXtmaaB73LWktKoG0H2esRTZgGAiyAHO61w5wp11nVZSeu6GeAwC
         hh1ArDERzgzuOo5qEx5Lp9/7ceanYIUvN6IZQyrC1t/V+f9YoHBrxwT3mwyNyOC3FD8+
         52yA==
X-Gm-Message-State: AOAM531Qca0eSA0Ek7Z2q0pQYtqrvz5l3xF451SCqQhDfeskNEIWzc2Y
        LOmVP1tFDDXI7gRalZwSH78=
X-Google-Smtp-Source: ABdhPJzXqt/qIbR3gYmHaut+yR75NuNMnBq80tn8bXLXCw0a57qzjmw1CUMA4eS0cyLqvWDlDSA8YQ==
X-Received: by 2002:a17:902:8491:b0:14e:dad4:5ce5 with SMTP id c17-20020a170902849100b0014edad45ce5mr7525767plo.76.1647770438809;
        Sun, 20 Mar 2022 03:00:38 -0700 (PDT)
Received: from guoguo-omen.lan ([2001:250:3000:7000:7978:d40d:86ff:591d])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f791d0115esm16597810pfk.171.2022.03.20.03.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 03:00:38 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Roese <sr@denx.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/5] mtd: spinand: add support for more GD SPI NANDs
Date:   Sun, 20 Mar 2022 17:59:56 +0800
Message-Id: <20220320100001.247905-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for gigadevice SPI NANDs currently
in production.
Tested the following chip by reading and writing a large file on
UBIFS:
 GD5F1GQ5UEYIG
 GD5F2GQ5UEYIG
 GD5F4GQ6UEYIG
 GD5F2GM7UEYIG
 GD5F4GM8UEYIG

Other untested ones are variants of tested or currently
supported chips with different voltage and capacity.

Chuanhong Guo (5):
  mtd: spinand: gigadevice: fix Quad IO for GD5F1GQ5UExxG
  mtd: spinand: gigadevice: add support for GD5FxGQ4xExxG
  mtd: spinand: gigadevice: add support for GD5F1GQ5RExxG
  mtd: spinand: gigadevice: add support for GD5F{2,4}GQ5xExxG
  mtd: spinand: gigadevice: add support for GD5FxGM7xExxG

 drivers/mtd/nand/spi/gigadevice.c | 158 +++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 1 deletion(-)

-- 
2.35.1

