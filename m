Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A374958BC4B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiHGSQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiHGSPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:15:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9EE64F3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:15:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gk3so12859256ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 11:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiw906G5oy9MybCFLcFF/KhsSArim48rj625F4hCIBw=;
        b=p3T2spBWrVd9RZkJEA9beebMLqaXSJOAp/4nW+3POhPPApnhuuZBzqQLlmCzVFuoaU
         w5DQO/6b29O4sq52ZV26LcyyJGpzFte7zwFHSCzsbRJYSqHK9SfrkwfXRxdJ/Eq1sRnw
         NW2Yz586T/kBIfpFEyMAXXzKrac1hK9soVuxVhnEtI/vRsg2K94ry5gFSIsTheuO1LGB
         YKNyQUwbFEhZXyKk60XD7QrRl8Rx3SKRBzRMHy7qUUz0Z4kTjhFkMrld4lwnzjX4FgcC
         lQw/Z7XbjGpbErEq+tlkAzf4gQYoaboG6JgIY8RvAiU3CuhYp2Ezve8ke2d4YOtAegko
         RwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiw906G5oy9MybCFLcFF/KhsSArim48rj625F4hCIBw=;
        b=WmoAk1+psyKt6YnRVU82AWq0vEpiHFwQKGBUJOYZJgqCL0A3HzStlDl5E4IybpXx5M
         d25Zjd3LQZJ6grep9e/xP31N96DNY4L1pSLKEwMkj+He22+dUxQPfuezY4n01DiDTlPt
         TflLoSA5/DUui1gaN9ZcQ8zYGN8WvsPvpd/JalbJOs8gky5fHaROwlYW0QVob2+kKRIv
         8jc2IyG+jntXlCNrlUpYhW42P8G6TtD83vnTLV9+cAg1HyNPqmOANVjyyLW8KJNJpAzU
         4q+pjbkc8eih3YhKoCRbqxgYEiwmHZx7mj4A+udYTgm8ssIM01cXyKLBzjubAJ7LzNhC
         PHMg==
X-Gm-Message-State: ACgBeo28EX5fhIXMeX7G+ADDT3P4bn/iVGYVnD73XxNVBBp9n3cn/8P8
        stva3Poy7T/eQEzcxFIfoz0=
X-Google-Smtp-Source: AA6agR4NDOfW0brTJs4BFgA+vaBmECmiB9nN6VPef+TyVO6RqyDvw3eTh+FhGO0lmKa7XvebAJ8R5Q==
X-Received: by 2002:a17:907:a0c6:b0:730:f081:6e8e with SMTP id hw6-20020a170907a0c600b00730f0816e8emr8696123ejc.479.1659896148185;
        Sun, 07 Aug 2022 11:15:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb84.dynamic.kabel-deutschland.de. [95.90.187.132])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090630c700b0072b92daef1csm4157441ejb.146.2022.08.07.11.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:15:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: remove os_dep/recv_linux.c
Date:   Sun,  7 Aug 2022 20:15:33 +0200
Message-Id: <20220807181538.8499-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
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

This series moves the functions and/or their functionality from
os_dep/recv_linux.c to the relevant parts of the driver. In most
cases it's just making the functions static. This allows us to
remove os_dep/recv_linux.c.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (5):
  staging: r8188eu: merge rtw_os_recvbuf_resource_free() into rtw_recv.c
  staging: r8188eu: merge rtw_os_recvbuf_resource_alloc() into
    rtw_recv.c
  staging: r8188eu: make rtw_handle_tkip_mic_err() static
  staging: r8188eu: make rtw_recv_indicatepkt() static
  staging: r8188eu: make rtw_init_recv_timer() static

 drivers/staging/r8188eu/Makefile             |   1 -
 drivers/staging/r8188eu/core/rtw_recv.c      | 125 +++++++++++++-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c   |  13 ++
 drivers/staging/r8188eu/include/recv_osdep.h |   7 -
 drivers/staging/r8188eu/os_dep/recv_linux.c  | 165 -------------------
 5 files changed, 135 insertions(+), 176 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/os_dep/recv_linux.c

-- 
2.37.1

