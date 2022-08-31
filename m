Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D83D5A8084
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiHaOpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiHaOpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:45:36 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1F74B4A9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:45:35 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fa2so6656503pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kcg2Q/3J3Ju4dFD9SiNuiFf7WPpy0/Z3n17LeQlJ4Zk=;
        b=HrAyq7AYwQdxuPqPF9lcKP/1LOiLbB+6lqfDjjA/ZAa6BtTUwcAtffEPCJzp4Vm7uu
         mmKNx5FyPQFuRcTZ+h9YD8lYiK9K0+otCUArq+g1oARRy0s9uhN9Typxrzw8K+ucnWLa
         xz8IqQwATJZD8lhQUAT0ApZ8fskyms8WXk+2QnXd1Iylf2zDykLUYGit6gQMKlA00PUN
         cgIlYJV5zs8Y78xchFnK34F4K72XK0ibEs5OP+JCmJcVswMyq7zEjyrLzMVTUBD09ZD9
         t+bH2zOUT0XsQUQg/E+XpwVQmn4426UdUJrfDQwfC7I9Lo7QWBP9PsHmJbzh8+oxUpIm
         uRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kcg2Q/3J3Ju4dFD9SiNuiFf7WPpy0/Z3n17LeQlJ4Zk=;
        b=dDwBFb9JcSoR3rUyLi4RIeqsoCRtBzsWT3CJVmwoT4cdxlnspch4cM8ub04p6a6mTK
         PfGpw6Ci+GHmhKYXnKUFI7Fm+tavbgsvsQ2GfmzCqsLsEwv5zrY7IvarNneG8nMEG9EM
         DxjBzk9vfi0DlEBV4Pri0loOwDX5GW6EiUSE1qNuZht8JTDglYkwQP4Yn/EuqZgzpt58
         RUvq5zkMuEJW+2TTVzT9rjWuoECpQ197cNefuvcsSdb3T+/vNaB7VIrwnEQyfXrfLxHB
         +xI0mUQUvqHe5X9rGqj3he1HnzQSZD7aspJGvqG/9Uh+OMeFVROQFuHElefeHxOUWIVH
         nm1w==
X-Gm-Message-State: ACgBeo25dIHDASPgWwh/1ZsOpVrFXjMTnSBlxHwOh4DI2PtyShW26jXR
        tLKfyHS8FhT/Invy8LtUbJzJzfe3tMI=
X-Google-Smtp-Source: AA6agR50AgP4dMzaMMUwe5EM57JCW/RS9jAv3FzrbFhfpU8Lvy8L0ALv1LgeC64QTgfbq3pamI7LuQ==
X-Received: by 2002:a17:902:be12:b0:170:cc74:989b with SMTP id r18-20020a170902be1200b00170cc74989bmr25899146pls.88.1661957134708;
        Wed, 31 Aug 2022 07:45:34 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m20-20020a17090ade1400b001fad1f975casm1415835pjv.12.2022.08.31.07.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 07:45:34 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com
Cc:     martin@kaiser.cx, straube.linux@gmail.com, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] staging: r8188eu: remove redundant variable ret
Date:   Wed, 31 Aug 2022 14:45:29 +0000
Message-Id: <20220831144529.304636-1-cui.jinpeng2@zte.com.cn>
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

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Return value directly from rtw_set_wpa_ie() instead of
getting value from redundant variable ret.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index d6b6021a4250..31a439663626 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1709,11 +1709,9 @@ static int rtw_wx_set_gen_ie(struct net_device *dev,
 			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
-	int ret;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
-	ret = rtw_set_wpa_ie(padapter, extra, wrqu->data.length);
-	return ret;
+	return rtw_set_wpa_ie(padapter, extra, wrqu->data.length);
 }
 
 static int rtw_wx_set_auth(struct net_device *dev,
-- 
2.25.1

