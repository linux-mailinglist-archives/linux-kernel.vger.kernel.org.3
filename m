Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6098A4D3B60
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiCIUwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbiCIUwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:52:06 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F35696834
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:51:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v1-20020a17090a088100b001bf25f97c6eso5104512pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 12:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=suRNmv6R67HpMji5/xf/olL00ZEMpVSYsMjDd2Yupcs=;
        b=aZspRFy9P0OU6RMmNAybc+fl4/Ya6uKHWiIz5KFSKXo3O6dhVOTo1nCehdIcpGf4sR
         iIHlbU2DcVvkuuhsYoewXDghk82DXsVPh6VC177KLLR8kYJuBUTBp4ZodOLQGkn19eFj
         1BJfzFNtQDHPqL9aH6Rygua/qOTObAFPA2E5lYZMezbrjI1eTTTqlALGk6jwQwSdExlg
         Lvw9gWk1CWCeH5ri0RAq/+Ju7qfxfyS7wiOXlcoETI+pTeyvQ681frFDxRuBkD0A+vNg
         IOcObX3Rb9nTC+azrw61/BzLo7UV0ro6VFKeaRtvXIHWdMoyQi97ZCHM0/jdWgvTYeeF
         fGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=suRNmv6R67HpMji5/xf/olL00ZEMpVSYsMjDd2Yupcs=;
        b=N6pEoPpNtgwaX30v3plvb/B5Uc6CIpd9X/1MAYo2pFscF4WKxrs/SRGZQ5/79hJu/T
         HknHRe7GSkFE6vLTVxdQBYfLnHgF8VYtMmhHy9uya1F8DxFebcDrNsNKgvIOdzzesJT+
         zwXif5kU0V651+vvpd9fNjDuPi9nAe97wy2VX9blAhJvLjFmT9matA9cN711rE3p+drg
         lSfvxwEj0wPMC75Pz8lB0h64ewCTIYC/SUuoT6lqx622Y0isRzYHRpKnr7ND08VjTfzf
         MmSu8gHy/V9TQRTq3dz95apseCIF3BSm6HiD+1ChiEiIZr4KHe4WfXzJAJyfJjNqFZiN
         Ul1w==
X-Gm-Message-State: AOAM532ZXChWqE/QmaIKwbGULEgMSLRq4/D84OKlorG3ZDXuc6aMauEM
        tlRp+X8mMpTYqgegmB8BjCvv/N3yyEI47w==
X-Google-Smtp-Source: ABdhPJytxunVsvk4zBdKbaY75AOod7nkz/wTIxFKKwQjzou1amumLklanF/WocA6j5yYvYFPGp+dqQ==
X-Received: by 2002:a17:902:9308:b0:14e:def5:e6b5 with SMTP id bc8-20020a170902930800b0014edef5e6b5mr1467317plb.73.1646859061860;
        Wed, 09 Mar 2022 12:51:01 -0800 (PST)
Received: from localhost.localdomain ([103.85.9.4])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7259674pjc.56.2022.03.09.12.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 12:51:01 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2 0/2] staging: r8188eu: improve error handling
Date:   Thu, 10 Mar 2022 02:20:45 +0530
Message-Id: <20220309205047.45981-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
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

This patchset improves error handling in rtw_init_drv_sw() and
fixes some memory leaks.

v1->v2:
Added fixes tag in patch 2/2.
Used dev_err instead of pr_err as it prefixes the error with
device info.

Vihas Makwana (2):
  staging: r8188eu: call rtl8188eu_free_recv_priv from
    _rtw_free_recv_priv
  staging: r8188eu: proper error handling in rtw_init_drv_sw

 drivers/staging/r8188eu/core/rtw_recv.c   |  1 +
 drivers/staging/r8188eu/os_dep/os_intfs.c | 60 ++++++++++++++++++-----
 2 files changed, 48 insertions(+), 13 deletions(-)

-- 
2.30.2

