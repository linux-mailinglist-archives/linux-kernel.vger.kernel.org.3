Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1793F4F21B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiDEDS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiDEDSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:18:40 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846A72D1CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 20:16:37 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id b18so9419118qtk.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 20:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tpmJ9JB/ykvkb+WcvF07K5tTjzwOCUQVaGyVvSReF7c=;
        b=Z7GpZlyDyQiEzgCn9NVqlL1a/EOlD60omRHVpUSC98e37MBwA9XFLiJosEUBFkLdux
         sHbFUF8eAsyYOEszsfiWgNA1hetcXk2YQvkIkEZmN0iwgLgKebI+NIvcwO+/kCn8iGem
         M8HGk9yJw2JhlJZTQxm79xUIzMGFNImPkMBPriRr0yUMwlSxl5r+eODQsmzXnr0VDq2H
         f/5wzQuotHv6NcH2SDh4Ujg0VFas0p4InJLON7jDQ2iYO5dygAEjMxNFUt5uFvxseik4
         PmbL177c0plkgqFHuxA6+tk5LPECgLqkbr7DjHWHvv5NkkUS4JBggVZmpoix0CzivVyX
         N9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tpmJ9JB/ykvkb+WcvF07K5tTjzwOCUQVaGyVvSReF7c=;
        b=FcHUbBEolGmzeB4EvkkpiJjq2RVqaWGc6W2P5JetDOgmXNb/Ryykpfy/kxTD9t2gcj
         i4OAlfJyFp4y0Em0LCGruFaKVaaf8pRWAQnaeGmuUCbQ25cbqGHBF5UohRxPc2MttyHE
         Qrv9jFtyyjpv6EosnFJ3KvNfl35XWcDs/RuDpXgybkC8ExAL4A1pm27oT7nvItrcYy09
         H2Kc77j16TnShvapkO2g73s8mX1jlq1KbCZGth7YMF/gV+5oPbNTEVo0bPtq8TZ9SlkS
         Zuiy0rp0+FFJRo46jfNrpZbzFnbqVXYDf33lF/E5/dNfnCCEfY18Se7UrLApeAqRdrpe
         OqVQ==
X-Gm-Message-State: AOAM530qwB462FFvPTBnnLqgp7+5YZoDnyvN+uCHqSf76r9qapbE3Ztb
        uoRwKktFWbXBOv7fkqpeIJKXnWaUGaI1eA==
X-Google-Smtp-Source: ABdhPJwlpP2v6CjMbc42ukFJfS0blQ4VolnyepFQ8f9fW6HWjm+Gn6GD+9s7SlxHER617ErrOGBaPA==
X-Received: by 2002:ac8:5f4f:0:b0:2e1:d42d:b5bb with SMTP id y15-20020ac85f4f000000b002e1d42db5bbmr1320722qta.48.1649128596650;
        Mon, 04 Apr 2022 20:16:36 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id j20-20020a37a014000000b0067b3a0c7d89sm7179208qke.38.2022.04.04.20.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 20:16:36 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH 5/5] staging: rtl8723bs: remove space after function name
Date:   Mon,  4 Apr 2022 23:16:12 -0400
Message-Id: <86494fef795f1c3e28c55e556d68b407dadd1488.1649128267.git.sevinj.aghayeva@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649128267.git.sevinj.aghayeva@gmail.com>
References: <cover.1649128267.git.sevinj.aghayeva@gmail.com>
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

Adhere to Linux kernel coding style.

Reported by checkpatch:

WARNING: space prohibited between function name and open parenthesis

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 5eddff488f27..56e3b85f7006 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2388,7 +2388,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 				pframe += ssid_ielen_diff;
 				pattrib->pktlen += ssid_ielen_diff;
 			}
-			kfree (buf);
+			kfree(buf);
 		}
 	} else {
 		/* timestamp will be inserted by hardware */
-- 
2.25.1

