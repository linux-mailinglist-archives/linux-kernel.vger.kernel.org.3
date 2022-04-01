Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058984EFA61
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351599AbiDATan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiDATam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:30:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6157F34BA0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:28:48 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id v15so2916574qkg.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 12:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHudlMOg6jYguBQ34zTnQT806trua03XNCZ7WUQx1wE=;
        b=ZfACbjdXfGyVT3TF7t51D8Rpm/gB4pRB+G8lva/IEekE65/lmPgPh4+V0I20mVexv+
         z/AmRY3n2uyuf4NAce/eDYNs/LcyG2KK2gduukJE4aKndOt6bx95U6hTp9qU9Ku6lDtP
         felAYSzkxqvaIGkKS5cqeJJwvIamfWJD0aPBKzvXzmOnOIrggtgPx/iEQCVOHRBzTyMQ
         PY4OyOrcYJWrGhuwZnDzvI80BZsVQaeQnvpOVzqFOmAgXVqeKP5MugOB0VMvj16NH2AM
         4kmbNGnXiV3lFMJc3ArrfzQ3Ok3iU22CUS3TMN2r83bnaTdf5eip++FiGPoUzRJmwKSe
         sTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHudlMOg6jYguBQ34zTnQT806trua03XNCZ7WUQx1wE=;
        b=EYNSI0BGDwK6hwITd07JCRZuD5F2Lo9JxM6Ou2lxYkBBWLATC7NVE8dHnzrBX+UzPG
         qXy0+daHvDk2Uiz7YytPjh33CbQlQU7t9lh+1VOLk4DwW3nGtYsuIQesKzDBTbpJrvj1
         dSPIWSwaTm05JaLghkVNVNjni5hgvXJgO8MuNEJM5uNxIAI/7aeY9HtPW+zD9D4A4ICa
         J75eGxBYutvLbb2GsvPSzL3GMDLb5r9Vn6nlcfXWEYNi+G2zfVlEdq++qx+Wd0aG/7aF
         UeahGHEvyZXP85Srx6BiaWoxR5NgdVmt3kDHs4t2ZudHHBlFIeIFFVeMCsoUTbeMmyX5
         lLgw==
X-Gm-Message-State: AOAM531Z8fl6Af0E1ey1KdM4G0mKZYPnTA5fddxIpyPyU4CCwCk/Bjpn
        2NENwlc5t9ZJFwsSWvd+iS0R5eU7N3vEwhtR
X-Google-Smtp-Source: ABdhPJyHrJFhTLvc16ABbcfM0ueAJAmhHaDIKPxBGPTLnmDMA8IF0B573/tJaIjF/+u7OvgjFeRpeQ==
X-Received: by 2002:a05:620a:484:b0:67e:16fe:3689 with SMTP id 4-20020a05620a048400b0067e16fe3689mr7332513qkr.745.1648841327493;
        Fri, 01 Apr 2022 12:28:47 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id b21-20020a05620a04f500b0067b4895472esm1792938qkh.5.2022.04.01.12.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 12:28:46 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH v3 0/3] rlt8723bs cleanup
Date:   Fri,  1 Apr 2022 15:28:35 -0400
Message-Id: <cover.1648840991.git.sevinj.aghayeva@gmail.com>
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

v3 -> v2: Include correct files in the patchset.
---

Sevinj Aghayeva (3):
  staging: rtl8723bs: remove redundant braces in if statements
  staging: rtl8723bs: place constants on the right side of tests
  staging: rtl8723bs: remove redundant else branches

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 167 ++++++++----------
 1 file changed, 70 insertions(+), 97 deletions(-)

-- 
2.25.1

