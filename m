Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2199507921
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356922AbiDSSbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357346AbiDSS2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:28:02 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E858B4838F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:45 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id b17so13802776qvp.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fKMQkFvawID0CZV29rgaqxHAegUM/E6NxGk6DDsZkI8=;
        b=b9m9pXxzgZJeMtfo2Cug0ppaOJkm4czZvE9egRvfXA80ejbbVEM2YliZd2gb90pe4s
         YBMVpdlGLtygfzJmBl6Uui35l4cd3RoTHhJayr9Jz0XGKVQjHdj+VIyBnwQE0vlpflhD
         Sqr8qmt/p5Av2FmHHvQ+qMqQwHHIxXcdZaVAimgIUn3BvRU1QNt2zgPiPUJWpuH1hdLp
         dXwl1Et+jfP2BV99Dl37NfmABFH8q1Cew3szTjBXJlN0CpTFiwZWZdHCqNmqXLHH/++4
         lik4LA5dmp2QL+Ry0GYel+JjEBsFfsG1/VuOFT+renLK4a/IyHZjGyxS3rTvRqqx46k4
         yA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fKMQkFvawID0CZV29rgaqxHAegUM/E6NxGk6DDsZkI8=;
        b=lhL14VEJL80tp6K1J4J2WfJUOfm4JB4jAw/cYSDnfQHz00LTLS/Wr4W34GDFvT9qSU
         AD1deRzhrCK/gZ5PG4uXsm9ao/KU87ldd73qElvyp+6F7dgGn4yOHDRMVcfODkQm24oA
         z0UEtSjOVH3FJyGPqV6ML7y/Q/sIW2MKOSFgwWw3HHxxTCUX7YhJyMqobEiZ90l//UEm
         SqRV0Qs/vKBBjXro2bv0vaePh38AiucNtYZtDmMPlr6ALT+kQPTiWOiAxwfoEwt0gtNR
         adxVbIYHWoaZQ8ubLqhdIMZ2OoQhJD0qAbnR7oam+A6bYk0KO99fm7w6HxiVGWZR8TcZ
         B0YA==
X-Gm-Message-State: AOAM530OtGAOFxdtB/9jEvmyjN4sKXoWMGJzqhjNESrZMYwsyy/40RKd
        Ucrto0GEzdRks5rhAR9e0/s=
X-Google-Smtp-Source: ABdhPJwKjdLJQr8u8TDroFMFAbW0yrBrzevoiPmgWTe8N0+nUfmLQl1EPpkje/hetIESp0NGT6PGpQ==
X-Received: by 2002:ad4:4dca:0:b0:446:1674:4a89 with SMTP id cw10-20020ad44dca000000b0044616744a89mr12729173qvb.68.1650392385016;
        Tue, 19 Apr 2022 11:19:45 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id e126-20020a376984000000b0069c86b28524sm373334qkc.19.2022.04.19.11.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:19:44 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v3 0/7] staging: r8188eu: fix warnings reported by checkpatch
Date:   Tue, 19 Apr 2022 14:19:31 -0400
Message-Id: <cover.1650392020.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
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

These patches address style issues found by checkpatch in the
core/rtw_mlme.c file.

changes in v3:
- first patch that removes an unused member needed more removal of 
  unused variables. ubuf has been removed. 
- the log of the third patch has been edited.
- another small patch was added to remove un unused else condition.


Jaehee Park (7):
  staging: r8188eu: remove unused member free_bss_buf
  staging: r8188eu: remove spaces before tabs
  staging: r8188eu: remove 'added by' author comments
  staging: r8188eu: place constants on the right side of tests
  staging: r8188eu: replace spaces with tabs
  staging: r8188eu: correct typo in comments
  staging: r8188eu: remove unused else condition

 drivers/staging/r8188eu/include/rtw_mlme.h |  1 -
 drivers/staging/r8188eu/core/rtw_mlme.c    | 63 +++++++---------------
 2 files changed, 19 insertions(+), 45 deletions(-)

-- 
2.25.1

