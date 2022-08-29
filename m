Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D975A49A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 13:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiH2L1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 07:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiH2LYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:24:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15726E897;
        Mon, 29 Aug 2022 04:15:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso14319860pjk.0;
        Mon, 29 Aug 2022 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4yXDgpAZYNa1Qg8bJezDyVwNEF8m9R6f8tXglUSQRDk=;
        b=i/iTcWalA7CDYnt3YV8sLadYau4Aq6bbLRZucH+PalTaAW9hszaUiVnuxAZkVLUvB2
         JVHixTONRWiun6/Xd9x8b0LoCsF1hbIaKYMgubh+Pl5T3kDsPem/OV70Ew/TBrgervD+
         QF6rDCKglKwKvdrwpi9mZCRp0KRD3ClNR034q8MmLzwEaBSXGLhfwIcPmYrUZvb40XCZ
         Yrxd47m3Jt5+vefvgb+LqwWZLN72vBHHli5iD2IK9Rg3x/mrL1xAWLGJ5qsnLf3MWrEl
         lRUJOc3ywkqI2gnI+eKnNzguV3TYvIWbtOr0bKBO4+caIBh5+hiJdh1yYy+Ve3snf8mq
         hEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4yXDgpAZYNa1Qg8bJezDyVwNEF8m9R6f8tXglUSQRDk=;
        b=iWpQwXpJo0cwjnAvDuwg6WgT8iK9MDwRhW8XDSoSU5MMJsz55j/ald3y+jRI18oLwH
         qowxvkPGuP492ELvHXbaplSFcMyNM86ODLwVzgrg06aeki9oPYXq2OdtvLeTL6veKFyL
         pIYKvc4msJ503fbxSFbDlSdS30R4/RaF8qhrYhP9TD9b9WeYEtDKTkOW1vbB0/D96s2p
         G1ew075INMWYrD+Si2nnluDJithxtUILKzFe2JrpoPg4HtmjA7KsX+g7GB3nXKYkdaPv
         6ohuQQHFt9yjYo1PJA+U6sCdtRibrcOThCgmcVheWJZrjvIU38ZAcK8R/whehNgiWz6w
         DVdA==
X-Gm-Message-State: ACgBeo1wtMF4e1czV1MYXXzLtDgdyCBRYmFIlJCfJ8UnD/MUFIrblb3D
        sfvErGKyig9HUQaDYzem2f4SzIihL37zMQ==
X-Google-Smtp-Source: AA6agR6Fn/T9fwe4T8BDIe4FeAIP9fYye+t6nIVn+y4ex/4wapqGm4DwVKxt2jPGEZoW0MRd17aagw==
X-Received: by 2002:a17:90a:d685:b0:1fb:2d31:84fa with SMTP id x5-20020a17090ad68500b001fb2d3184famr18112978pju.51.1661771655313;
        Mon, 29 Aug 2022 04:14:15 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902680900b0015e8d4eb26esm7177973plk.184.2022.08.29.04.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 04:14:14 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: [PATCH v7 2/3] thunderbolt: Modify tb_nvm major and minor size.
Date:   Mon, 29 Aug 2022 19:10:58 +0800
Message-Id: <20220829111059.665305-3-chensiying21@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829111059.665305-1-chensiying21@gmail.com>
References: <20220829111059.665305-1-chensiying21@gmail.com>
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

From: Szuying Chen <Chloe_Chen@asmedia.com.tw>

The patch modify tb_nvm->major and tb_nvm->minor size to u32 that support
diffrent vendor's NVM version show.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
Modify tb_nvm->major and tb_nvm->minor size to u32.

 drivers/thunderbolt/tb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index fc32737fcde4..9cf62d5f25d2 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -50,8 +50,8 @@
  */
 struct tb_nvm {
 	struct device *dev;
-	u8 major;
-	u8 minor;
+	u32 major;
+	u32 minor;
 	int id;
 	struct nvmem_device *active;
 	struct nvmem_device *non_active;
--
2.34.1

