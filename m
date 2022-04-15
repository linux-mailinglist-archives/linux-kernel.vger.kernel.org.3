Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD53B502B93
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354318AbiDOOQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354298AbiDOOQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:16:13 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F257CEE0B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:13:45 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-d6ca46da48so8161749fac.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aqd3cVPWfCv4uAfqdQC3dxQYsG0PuSaL4S7UTovgqyY=;
        b=I8AVxiJekURB8bEX7DWfqphVA8le7jh+z8Rfgw+4a8Fm577YgNItUP1SiHVal7wN2F
         xv6Ja1Dvp45bcSoCiWb3eV27JRMI5LP3YLMz2IixEzjkB7Vza28slEJ1TI8jqP8keeKf
         vw/KLU9ZuOf8Emfo+lcg1wMlUDTdywAwTxNThbvS6a1BnxH7B9ljMhMQMV3li6jQe7dn
         s2wtM3uuKjESQXyCdjln5YJ3JdJmXEjQ1XUgon/uXCIueWB3J9SaJwCg3A4aB7D1upzb
         1RmBF9YsrCFarO/XIhJt4TmL8PMfmFlMD5bYTy0PV7FENoUJWMNzVLL6TEr00vX5Oh8d
         7kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aqd3cVPWfCv4uAfqdQC3dxQYsG0PuSaL4S7UTovgqyY=;
        b=K/RDlgFVJ046LLto62jvhmFnrHe5dQi5y9YungdR7upwZFVswNRXghdgEFbmGoYyLF
         AyMLwBANUSanvUS23JQ7by7/S+7tHOMjpShrm98RnJKzHyf7NpTWVmb59XCb9h0m/QZx
         1heXJxeIV+q21fgtzfRyEgiFiaCi7p+5waZGO9FWk0qJo+LFmIcS1pNp+qlTjA8ZLc+x
         w1em4+VDuzgkFmkj19hhSyLP5gcVAXuxI7EaAyp1cGZw0zZOIBtIEDRYwzdJ5Otzc9gJ
         ErW3s7iteX34Xear46pnVx9AJLPkQVkzcQFN6pd1pdNw/a3FsAbdyTbfilkAy0INZHoy
         LOUw==
X-Gm-Message-State: AOAM532Vb+v4XC0W0KUsuX5nnPreo3gr4G0la4vO4wWDwMQBxA21XgQ2
        KH67FoLkgrpoWncjueRMrKw=
X-Google-Smtp-Source: ABdhPJx7pK+v5H7Ot/XNC6LqmJEc+H87E7GWfhSQrxGFZ/vaaBYtjMcxb4At4cr9yDvTdqXtGu3LlA==
X-Received: by 2002:a05:6870:f295:b0:e1:ea02:2001 with SMTP id u21-20020a056870f29500b000e1ea022001mr1464904oap.241.1650032024623;
        Fri, 15 Apr 2022 07:13:44 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8a9b:dcc3:45ee:2581:b4cb])
        by smtp.gmail.com with ESMTPSA id x1-20020a4ae781000000b00320d5d238efsm1156189oov.3.2022.04.15.07.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 07:13:44 -0700 (PDT)
From:   Tales Lelo da Aparecida <tales.aparecida@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrealmeid@riseup.net
Cc:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>
Subject: [PATCH v2 0/2] drm/vkms: check plane_composer->map[0] before using it
Date:   Fri, 15 Apr 2022 08:12:58 -0300
Message-Id: <20220415111300.61013-1-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is a follow-up of my last patch. Thanks for the reviews!

Changes from v1:

Edit the first commit message as suggested by Melissa and add a commit to enhance the
error handling (André)

Tales Lelo da Aparecida (2):
  drm/vkms: check plane_composer->map[0] before using it
  drm/vkms: return early if compose_plane fails

 drivers/gpu/drm/vkms/vkms_composer.c | 32 ++++++++++++++++++----------
 1 file changed, 21 insertions(+), 11 deletions(-)

-- 
2.35.1

