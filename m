Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AD14F8818
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiDGTbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiDGTaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:30:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911B629B7DC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:28:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bg10so12976928ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 12:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wnTbVdy3uat7re2/juPonFklxWNyK89ebuwaKNLBbWU=;
        b=bHEgGFlejC0vA5GIGYJCTRgW+62fOE07VV1oIh0ULpSxNPVDs7Crq8tng1eP3bPCrr
         MZejo/w74kPfI5tmypAEQNOw/08WlUNbWKariIeozihTmnO+8rB7XbLD5EnbQFtf5yHR
         KXFO/D3lm1DqtgxbypU98uHO6/Kjsv/kbn1NRyRA7ffAwvxXwCN1zMqk8/YQGCH2P85b
         b+05e+MzDSmtp6Sz2ENZyioygmJT+pOFIbDY0FpVQ2PUWHoGjDqx6MUBo1v4BE9HRNB6
         bsqphuASgGWefs25oLSr2NM0LQuHnV/gvAMzfTEp8y6defaTuhCNtSL1wr62j0JPgqGa
         7eXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wnTbVdy3uat7re2/juPonFklxWNyK89ebuwaKNLBbWU=;
        b=GDcI4gxK4cFgCKN0rPctmSz9TsFa2ct/eIixm3XSik0Jg9kRh/GCRqT1wAkF1+pgFS
         lhZ5ghD8gPft1gV9POfNjPALKolw5BcvmXkCkLVS1oRDQUaBnQ46mB+fWP+HSXYlQ0pG
         jxPFhUy0XLvg3TeCt2tGSGXkGORZy2P+BDReJ+RgiQyKIaD/Exz0f0QcZgnMPvqpaT1e
         SQCSvB/5X7whUIWM8WoTyORXuP42Nj+wi7t+czn5e8hCC0hemGdC5YkTchlEgWoIAIYG
         pHWt9IhyDB7PHHvtYcAC3So7srKtsRc3pknAjun0W5sX/uQsmZhDGiXlKB88H9+J4huL
         kd4g==
X-Gm-Message-State: AOAM531mlhIrveDQGiNVs/bWLf2ccOFcYUhT++88OgFtm84z2gklKvHO
        DhHdmaSMW6m0aQqS8MH988Q=
X-Google-Smtp-Source: ABdhPJw46DX5p9tNemvjd8lEzMNSiQDkXYThLCxegQUrEqGXGes/Jno7y/w1kC/1LeRIyYPy5J//UA==
X-Received: by 2002:a17:907:7252:b0:6df:75cc:615e with SMTP id ds18-20020a170907725200b006df75cc615emr15235818ejc.683.1649359706161;
        Thu, 07 Apr 2022 12:28:26 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm9652798edl.22.2022.04.07.12.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:28:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/8] staging: r8188eu: remove unused fields from struct eeprom_priv
Date:   Thu,  7 Apr 2022 21:28:15 +0200
Message-Id: <20220407192819.10661-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407192819.10661-1-straube.linux@gmail.com>
References: <20220407192819.10661-1-straube.linux@gmail.com>
MIME-Version: 1.0
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

Remove unused fields from struct eeprom_priv.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_eeprom.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_eeprom.h b/drivers/staging/r8188eu/include/rtw_eeprom.h
index 3e8d3bb48903..d8d48ace356c 100644
--- a/drivers/staging/r8188eu/include/rtw_eeprom.h
+++ b/drivers/staging/r8188eu/include/rtw_eeprom.h
@@ -11,10 +11,7 @@
 
 struct eeprom_priv {
 	u8		bautoload_fail_flag;
-	u8		bloadfile_fail_flag;
-	u8		bloadmac_fail_flag;
 	u8		mac_addr[ETH_ALEN] __aligned(2); /* PermanentAddress */
-	u16		channel_plan;
 	u8		EepromOrEfuse;
 	u8		efuse_eeprom_data[HWSET_MAX_SIZE_512] __aligned(4);
 };
-- 
2.35.1

