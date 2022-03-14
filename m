Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ECA4D8C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbiCNTcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiCNTcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:32:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C363B3FA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:31:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p15so36374744ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D6Lk3jnpYTqv/HWX6yrqb55oTaEViGuZiXEI3RUj6V4=;
        b=p0wpgAkiyJexVIo0wuOxwo1bS9TuqVC6uRlgs/2FMOHV4tqsRyxR91Y1/I/rluNSDQ
         HbVGqQnkMDMusD+D3ld2bL1b6eXRzog5oSEkDaMHetBxlsNmMDPPSscmyQwS8CSZVOQs
         MNMnbk3sVW0NmAUcUDD7jevUnBlIEVmMuyse0CGpuXKplTST+WLbixAaK1GXgWL4izPw
         iBuZ0Ws0/FWDlm1InkRWqv1olHlV2jvYh5DQVJoT4pTRzq6FqxN2I0gVPx0Fw811pwch
         vnPSWFHyIKztE8DroNe5yX2cucDbv1fXkkORskPzrnS0u+ErdTfmw7SYJGnYU6CMLDmy
         YyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D6Lk3jnpYTqv/HWX6yrqb55oTaEViGuZiXEI3RUj6V4=;
        b=rVEBAN5T1L+Pdyi+wp5SWhWO9AU2//1RupxVm6Lcz/84WjSgNjB6fwpENtMXJ7bbyb
         2GoQh+XaG/N3YD1SeBk7Q1zVc+fWjCsbexM/abP5+16fKoQPJTxS4qbG447Ho80V78w3
         li+HQb/BcBOS53OJEE2ThXn7NxJ5NnvncYbRn6e7uH2Krd78epKPKlAcCx0AVlok79xP
         A6NexqC1O2/1sK41nU4ZOWyvHmlQyuijZ1GEqnjU33XMDMvgn4RSL2tw1U22qk5U2iGV
         +lRY5jpmiyUfsK2eMMAX+6wwu7/5PDiLF8v1M9lXCQdtrUaeBCxX988vzL5lRlaDxBIa
         l4NQ==
X-Gm-Message-State: AOAM533AMhr5O2rw5vLZ9flHgk9MGRP+TD9mUII3N1hoeWkwZ/wpYH+j
        Bp3uU8L3tuQ/PxS6Tl4y+1rFaU7G7E5m/w==
X-Google-Smtp-Source: ABdhPJyU7dNnqsEihK3XmO+jJXMko6Cv76F6Nj/P4DToErH4ibNdWbrTXH3+d5/c2okPf8pPsBRz3Q==
X-Received: by 2002:a17:907:e8b:b0:6db:7536:d84a with SMTP id ho11-20020a1709070e8b00b006db7536d84amr20194374ejc.464.1647286268405;
        Mon, 14 Mar 2022 12:31:08 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id y6-20020a056402358600b004166413d27bsm8696848edc.97.2022.03.14.12.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 12:31:08 -0700 (PDT)
Date:   Mon, 14 Mar 2022 20:31:05 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: vt6656: Removed unused variable bb_vga_0
Message-ID: <09f65cf4839b089ad38f28ff691d5146e6095e58.1647284830.git.philipp.g.hortmann@gmail.com>
References: <cover.1647284830.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1647284830.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missing part of staging: vt6656: Remove unused rf_type in card.c
Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6656/card.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index d74165d0d3bb..7827e579ef3d 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -438,7 +438,6 @@ int vnt_set_bss_mode(struct vnt_private *priv)
 	int ret;
 	unsigned char type = priv->bb_type;
 	unsigned char data = 0;
-	unsigned char bb_vga_0 = 0x1c;
 	unsigned char bb_vga_2_3 = 0x00;
 
 	ret = vnt_mac_set_bb_type(priv, type);
@@ -449,7 +448,6 @@ int vnt_set_bss_mode(struct vnt_private *priv)
 
 	if (priv->bb_type == BB_TYPE_11A) {
 		data = 0x03;
-		bb_vga_0 = 0x20;
 		bb_vga_2_3 = 0x10;
 	} else if (priv->bb_type == BB_TYPE_11B) {
 		data = 0x02;
-- 
2.25.1

