Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921224EFA49
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351466AbiDATJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350566AbiDATI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:08:57 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E01A28A01B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:07:07 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id o15so1588552qtv.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 12:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7sCg00QwNMKVUFlzQkj2jwwa0uYhEC8jL1U6rlvYrSo=;
        b=klBxS0IuRANL9EkV0AlTz7LfzK2HCEuB8787h4LJqwiiafZvZ1IoFlcrBBD3IzOlfe
         +KxC7PFfqALM13UDk0nBznmlKk3pLKttxxohCRaOnT+FqLK86EKdXlhuOEpC9I1F0ISx
         BNtFO5r+FOz/4S5IQ3SvA54Kj8dNpiMGM7Iuy6gfYgiVhrMeE6s3qoHzYV8E+DWDuqcI
         4HAm9W3hYNvVk1rBMy7x6Mdz1Mqq5mFWgesqFnKPDSk5cd6pX8UFOUWkwImJgHgW3aXc
         WFC54LPQGB54yujmOs9Tv4RgCFHNR+pY30y3w1L7/93sHUOdDMCMSEbDwXnVS8HSQAyB
         HDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7sCg00QwNMKVUFlzQkj2jwwa0uYhEC8jL1U6rlvYrSo=;
        b=SrRX3kLMNT1DdU2GR7VTSYMRUw24UEsF3tBwR6hZMa5pypxGHLjqY7JcahmvOaGErL
         ACZAbHtwWitoDDOHBansGxF3IJrQ4TVe2c4Kzv+N5MyucBP4pP0e0xNNzLAdpVdNKpLB
         L/5TRaSFB9OItiSQvK0aPs+2YW/dZ7ObIMP7sOoI5iWmWck//TsR17ZCSQOINF8sPEU3
         JafaibRWzUxo4KMs59ut4MhvY0X1iakLzgHJmsFvZr6rPs8fJDpccWNE6TeSINExiYGS
         DEuc/hI6bKpBLye9Znq8o5hKSfTUBS+4W+Mb05uc7VqYVHanO+PHhNCx+uaM4orS6Uo6
         QS5Q==
X-Gm-Message-State: AOAM531zdPOTDrEThXMHz1DhgkCzfgifjsLfpRRsC/fjrP2uzmWCqfAf
        Of1FUUd5FrP5V7feIth4daM=
X-Google-Smtp-Source: ABdhPJwpO0qbLyMdD6SzmDXNla4KlXsoLvFGbpLE5RJEEM73tH2inLiDjeKeBTv3EfGrih8xy0EzHQ==
X-Received: by 2002:ac8:5855:0:b0:2eb:87af:ab50 with SMTP id h21-20020ac85855000000b002eb87afab50mr9628284qth.406.1648840026397;
        Fri, 01 Apr 2022 12:07:06 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id r11-20020ae9d60b000000b0067e5308d664sm1797765qkk.92.2022.04.01.12.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 12:07:05 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH v2 0/3] rlt8723bs cleanup
Date:   Fri,  1 Apr 2022 15:06:55 -0400
Message-Id: <cover.1648839305.git.sevinj.aghayeva@gmail.com>
X-Mailer: git-send-email 2.25.1
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

These patches fix three categories of checkpatch warnings (redundant
braces, redundant else branches after return/break, and constant
placements on tests) in file rtw_mlme_ext.c, which is part of the
rtl8723bs driver. False positives, such as

if (foo) {
	/* TODO: ... */
}

were not altered.

---
v1 -> v2: Removing a redundant else branch left a variable declaration
mixed with code, which was caught by the kernel test bot. Move the
declaration to the beginning of a function.
---

Sevinj Aghayeva (3):
  staging: rtl8723bs: remove redundant braces in if statements
  staging: rtl8723bs: place constants on the right side of tests
  staging: rtl8723bs: remove redundant else branches

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 167 ++++++++----------
 1 file changed, 70 insertions(+), 97 deletions(-)

-- 
2.25.1

