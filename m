Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B14F4EEDB6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346101AbiDANE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245752AbiDANE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:04:58 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F875220FD7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:03:08 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id kl29so1948358qvb.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuEZGYCDTIg4hAs18A6RZQYja/XtuoYHfBwjj8fnnZ0=;
        b=FnP/rNV7/WXimg+zgn3ZqWYzD72kkxZ/ONysifSpqL/1K7GEgH19xEywvc/NBFTB67
         /fR/Qc2j32gxCUahzaVZJ9DXaVZULmEjajoKBSjIa5Xd+pKVSaxeu+JgLGjDdJXPqRHP
         1C/h8SdDjkKTBqNEjYbYg/hnkBSlVZSPHtdzdgRLr3QS0czqcsXEuNs8p9mZ3Vjyu2eo
         lu2m4KQpjSUwls5Cp9s32l6HbNcuT6KdcGYRs3oEk2xosAk28ZaTlNAbRIYJmjJfBWZ0
         C/PUuBgVfsMTuMA51hheK8DvaccF7J47dgy4LTtQ9QS8ngwCa2kAENdsCOcaycTdfaoW
         rEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuEZGYCDTIg4hAs18A6RZQYja/XtuoYHfBwjj8fnnZ0=;
        b=yxauyUcvlWKWB6eVplA0Ym8d5ZLNdJU32HYzIzDL8WZx8ZxXh49yLJrt7hVAKw0vCA
         +v3W3uNr8DU70s67LkEq0DmtXDTrqWgiBhSJ6SFT2cMhk8vO+JE39LCfpbd7SPnWsMzc
         4eT4760Enw6Tx+khh1P5olmez6MVozJhcuWoQV/9itO54gaznfnfIqFL2/r4AVpAtgqY
         RWIQphm3iJuu11IBs0wR5j3ILNesvJxKgBZhAVbS9iLM2eEqFNgooXTgOF4I4prfrt04
         A4ebJZnGi4oYC5oTgbINYVnbBFqIHDmBLF9nJEvfbgx/CKACoGmRX1hqcJmG71uCOwOH
         YxMA==
X-Gm-Message-State: AOAM5302sirepJ+zkGeZpwk+Sl4C36RO24jOza3Kyh6jAw63rhEGLmRp
        euU6cQZu3CugWI7XjduxcBjKb7G6pKF/9Idv
X-Google-Smtp-Source: ABdhPJxDLw2zhT+Jeb4LonUp4ejui9EfOEDSyMLbQER+MBQC28/Iq33mx1o7adfNF3glFSgma3LaEQ==
X-Received: by 2002:ad4:5dca:0:b0:441:6063:e235 with SMTP id m10-20020ad45dca000000b004416063e235mr7845530qvh.48.1648818186806;
        Fri, 01 Apr 2022 06:03:06 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b0067afe7dd3ffsm1348581qki.49.2022.04.01.06.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 06:03:06 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH 0/3] rlt8723bs cleanup
Date:   Fri,  1 Apr 2022 09:02:44 -0400
Message-Id: <cover.1648817213.git.sevinj.aghayeva@gmail.com>
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

Sevinj Aghayeva (3):
  staging: rtl8723bs: remove redundant braces in if statements
  staging: rtl8723bs: place constants on the right side of tests
  staging: rtl8723bs: remove redundant else branches

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 167 ++++++++----------
 1 file changed, 70 insertions(+), 97 deletions(-)

-- 
2.25.1

