Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D7C4D01B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbiCGOrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiCGOrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:47:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3847B7D024;
        Mon,  7 Mar 2022 06:46:06 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id k24so14213935wrd.7;
        Mon, 07 Mar 2022 06:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnuayJqqO6PRDmzyTvn21h8f65mMIJndsojjx882OXc=;
        b=QNJugbyqzySDgHdDdGqu0c/SNKPry3EZ5Un0ef5kLO5A2MINUwhlw6rmfuY1bg/qDo
         lrIAPvEDtP3dTn8wAyounn60fEcS2VELUVmfrj5hehBxPbEvuXYKnAHEy8tZTldMon/4
         TgjpyZUEGFfUzp8x0pZrL4H5oNcmoO5fD76FRaam7XvG8GMZqA8zwAkLESXgHEpLAH0e
         R+uSXhekTZWguXSvr4MCnhV4aSK6JYAIpQCx1pBpI2IBjfsc+VN4/o9n7gm9wEzqzbEH
         aLWiyxkxYyOCqDzsNGAEXm3lXP53wZIFxJzOkbZS8ibEFbSB9y5I1Gg2R1kl5bRDMkhq
         1vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnuayJqqO6PRDmzyTvn21h8f65mMIJndsojjx882OXc=;
        b=7vinU83qY1yl0VrQpIIjlzJGgxI/gag4lYaUTB1yg7nbalYmpsrP8RBDMa+UMpNYda
         ZNLO9f4KJlSwOJD9mfcTzYA5FbalOUIIh7FlOrj0hBkNfgYJbbuCqWwlMD9ZHrV/afKU
         cpszKFXJB/DX+yJrB6gJ4dos7lERnRmsWaZpQN0i23MDRKFJrFqDtCgzbMQi8PgAb00f
         Nw1SlTAwOKv4igJePKe/SrsBgFcCe/xITFmU0Tt+qH/+k6tX22eNftzwrxzJppTKyy+l
         QcaWTAaPvIGw4kny2pvWKo5llc6J7/n0/hv6WAzm5J2PGalROf6L/YzPJsOVVLpjlhMI
         9eJg==
X-Gm-Message-State: AOAM5317N33V0dY12b0r+TqLk+5k1THeyVlGNsvz/3ZeyfdiXbQqUT0m
        tBm21EBTGgdICltJ+k//mmgwsr4uttg=
X-Google-Smtp-Source: ABdhPJwwXWeujosxzRqNzzOHBuqrta0lQ8JNylmK2wr7FxCzx7SadlOqXdGe4d6U7mz2dam3O5GbeQ==
X-Received: by 2002:a05:6000:1d8f:b0:1e3:319d:519e with SMTP id bk15-20020a0560001d8f00b001e3319d519emr8626895wrb.548.1646664364669;
        Mon, 07 Mar 2022 06:46:04 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c191100b00389a1a68b95sm11218160wmq.27.2022.03.07.06.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:46:04 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gdm724x: remove redundant assignment of pointer w
Date:   Mon,  7 Mar 2022 14:46:03 +0000
Message-Id: <20220307144603.136846-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Pointer w is being assigned a value that is never read, it is
being re-assigned a new value later. The assignment is redundant
and can be removed.

Cleans up clan scan build warning:
drivers/staging/gdm724x/gdm_lte.c:198:2: warning: Value stored to 'w'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/gdm724x/gdm_lte.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index 0d8d8fed283d..d5bec53b0194 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -195,7 +195,6 @@ static __sum16 icmp6_checksum(struct ipv6hdr *ipv6, u16 *ptr, int len)
 	pseudo_header.ph.ph_len = be16_to_cpu(ipv6->payload_len);
 	pseudo_header.ph.ph_nxt = ipv6->nexthdr;
 
-	w = (u16 *)&pseudo_header;
 	for (i = 0; i < ARRAY_SIZE(pseudo_header.pa); i++) {
 		pa = pseudo_header.pa[i];
 		sum = csum_add(sum, csum_unfold((__force __sum16)pa));
-- 
2.35.1

