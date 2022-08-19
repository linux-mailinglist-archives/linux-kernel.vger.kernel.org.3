Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FA1599D23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349425AbiHSNu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348496AbiHSNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:50:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F03CFBA40
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b16so5745528edd.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZgX6jdvBhV2Y++t5rSQiAxJFF+Lv/REHFFRciLPQA3g=;
        b=p9qLO9IU4C+bXeIBFkgmM0bmivY2RTNsQbXiEGI7ChVegQZy7XEmzOF90+wDKAQlMI
         CktLvXLPekO4ehUNoDHKO1CGyiSAJpeuFLxvHsYunecK5cIiw/o/doMTHTbRjJ8RTtuo
         yLreXK9VBHEEZAcOSW0AH81OVqgcovbxeCoq3ovm6ydNMM90kYrd383VAoqpUrBDJBvJ
         kfaXUm+GRS/lGGxxOgzlw5uma/rM3Uwit5+EENXZRuF9Bp4IItdHTmAgNxeuklS7sS5D
         fq5D7hGrUv5XcPdG3L5yOPUJXJ5Z4mu6l+XRn0VqycXVNzrifc2U6rkTGzdkYe1ZR+fH
         dOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZgX6jdvBhV2Y++t5rSQiAxJFF+Lv/REHFFRciLPQA3g=;
        b=EpIuwt267iPJIDXejkk1lR9KbqkNcyzNhgjg+jkaS0tgnv0KumWRrPiRptGn/jIpUy
         8Q7Do4rO6zbbK0lsaknTd5yC7fraL1K0D41qos/Pia+DI9eqaFoAMOKpDz6q0KfTmxq1
         H/4jOjOAIzo4Y6vY8mrShhtvS+v5TMRRlflJBKentXrq07CiRfLmcqI5NBNz9loUlbNB
         6ZvY79S/CjPfIcl50D95vec65osARkRuf5fG4E1Rv5Dc6P2c8xqpDDCAw2k0Ys3f92r7
         CaSbeoLJOBGxsYJymRwdLIYwVC/IyWHh1P9kOjiFUA+QRf181siBdccq2449Zy+nr8iH
         CcbA==
X-Gm-Message-State: ACgBeo1tF3UbEuju3FzrKGFS0pRbD5mhRXa5iIHRa0koU4Wj02/oNvBc
        2uAeaAO1HvRYofB2apeimmI=
X-Google-Smtp-Source: AA6agR52xXbSQg1P6N21/poLhCvNJJl+djZ9g/YfAgBWWXesc5ikEGCUc4ePWlv/EGa8DU0x/Zq2bw==
X-Received: by 2002:aa7:cd78:0:b0:446:49f4:1c0f with SMTP id ca24-20020aa7cd78000000b0044649f41c0fmr1829636edb.342.1660917022992;
        Fri, 19 Aug 2022 06:50:22 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b0073087140945sm2313821ejk.123.2022.08.19.06.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 06:50:22 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com
Subject: [PATCH v2 0/8] remove some dead code
Date:   Fri, 19 Aug 2022 15:49:34 +0200
Message-Id: <cover.1660916523.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202208192018.BfgiZyOY-lkp@intel.com>
References: <202208192018.BfgiZyOY-lkp@intel.com>
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

Remove some unused functions and variables.

Change in v2: add a new patch to fix kernel test robot's warning
about unused variable.

Nam Cao (8):
  staging: rtl8723bs: remove function rtw_odm_dbg_comp_msg
  staging: rtl8723bs: remove function rtw_get_ch_setting_union
  staging: rtl8723bs: remove function rtw_odm_ability_set
  staging: rtl8723bs: remove function GetFractionValueFromString
  staging: rtl8723bs: remove function IsCommentString
  staging: rtl8723bs: remove function rtw_odm_adaptivity_parm_msg
  staging: rtl8723bs: remove function rtw_odm_dbg_comp_set
  staging: rtl8723bs: remove static const variable odm_comp_str

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 21 -----
 drivers/staging/rtl8723bs/core/rtw_odm.c      | 79 -------------------
 drivers/staging/rtl8723bs/hal/hal_com.c       | 55 -------------
 drivers/staging/rtl8723bs/include/hal_com.h   |  5 --
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  1 -
 drivers/staging/rtl8723bs/include/rtw_odm.h   |  4 -
 6 files changed, 165 deletions(-)

-- 
2.25.1

