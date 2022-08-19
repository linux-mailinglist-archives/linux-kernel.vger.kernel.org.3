Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C333599839
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347464AbiHSIxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244382AbiHSIxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:53:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151EB66A4E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:53:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s11so4823822edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=hxfDpHx5aBjdPJ7ut0oRiSJJNqXdwJRmBzKw30DQFLU=;
        b=C4W/cvGB1ZFq/B426WjT28e3uwBvSfedlvMqfuKLuIeg2YwKRMk8F84od51Du2DlN7
         mAJI3/widzSOOfHXmjFrqyOkwQFH7xe9e6n93Em7+/l/Kc101oP9O/43FchQtYk3lVGF
         nq/XvgoQjaAnGZxude1NKPPRgcsShhR1UG+NAmiE07Pmz1nmhyL6FjT7772ACNk3Ienu
         nnu9vZfEO8sMoRTscvOlyT9H0TIJ/oRX2azumgVe22wblkZEBq3q+y2NvNmfvuuFQrYg
         ckmIL6nycYulPISHnux/owkecdKI/XsahOA1MYpcYmlyzlfMYt/UOKRl/bTChMMCm46h
         YGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=hxfDpHx5aBjdPJ7ut0oRiSJJNqXdwJRmBzKw30DQFLU=;
        b=OsRoGW9UG46b2VgZn7uWBDZ6KWPbaNI1ik5Qi06uudkqdNGJagysA6MQ9TulRUWlIp
         J0UR4QQw9fUKVDRhHPtxUXTcaarhCVeFPd1O2JY+lcdFylEMBnQ0Um00Q7mmxyKjOBZa
         VYBCrwUd0xK5E+n+qKGhriyXmwM8WU8QeHY5DhbOpxYPqqPIG4C+EBZ3sQ3h6Lc+6zCI
         O8FYzoNCjp4eygh/CUtTIeVQJxSG3tN2IVgE+MVTsiq7H1ziGnAXA29u73NCAoWT8xv9
         DoRJJi21tcI+zqFjSZw+tjR+swHEgm/MA1OpqGopur8tHOrPuoxVk7VpVBGuiNztvPqC
         djZg==
X-Gm-Message-State: ACgBeo3Rm6aV5Ocx0rVBl20WuUofPEXh7h5bZzUXfY0BMjN0/jBqzYbk
        Vz8xqbOB5ZHwECxLTsKKUpw=
X-Google-Smtp-Source: AA6agR5iCwqiQtFvUmlCA4t99JTfX4nJh7lNYQbLi5S34idYBiEekRZTHdrY15vGlnbr9QPbGyq2xQ==
X-Received: by 2002:a05:6402:3323:b0:43d:65fc:8d29 with SMTP id e35-20020a056402332300b0043d65fc8d29mr5558051eda.251.1660899229576;
        Fri, 19 Aug 2022 01:53:49 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b0073c9d68ca0dsm1084261ejb.133.2022.08.19.01.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:53:49 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH 0/7] staging: rtl8723bs: remove dead functions
Date:   Fri, 19 Aug 2022 10:52:49 +0200
Message-Id: <cover.1660898432.git.namcaov@gmail.com>
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

Remove some functions in this driver because they are not used anywhere.

Nam Cao (7):
  staging: rtl8723bs: remove function rtw_odm_dbg_comp_msg
  staging: rtl8723bs: remove function rtw_get_ch_setting_union
  staging: rtl8723bs: remove function rtw_odm_ability_set
  staging: rtl8723bs: remove function GetFractionValueFromString
  staging: rtl8723bs: remove function IsCommentString
  staging: rtl8723bs: remove function rtw_odm_adaptivity_parm_msg
  staging: rtl8723bs: remove function rtw_odm_dbg_comp_set

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 21 -------
 drivers/staging/rtl8723bs/core/rtw_odm.c      | 44 ---------------
 drivers/staging/rtl8723bs/hal/hal_com.c       | 55 -------------------
 drivers/staging/rtl8723bs/include/hal_com.h   |  5 --
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  1 -
 drivers/staging/rtl8723bs/include/rtw_odm.h   |  4 --
 6 files changed, 130 deletions(-)

-- 
2.25.1

