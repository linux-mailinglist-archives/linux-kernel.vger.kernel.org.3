Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC655522AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbiFTRUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241926AbiFTRUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:20:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C509115A12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:20:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e40so3493436eda.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hL7ahHjXLTtDBm4Zo1lgep1oM+nfQRKvYlwijREaM3Q=;
        b=LgttyniPQt4WnC8F+XhtOu3KXpbw+EU1ypNXIZNZ6sejWgT6UdE0Js2EgBn/mh/4v7
         V3BTvIYUuv/VyQnPASBHgiUTEBm+V49O/Bp1h6lL0kDyP2FFU9n2Y1yXBDmviqiOj8cV
         WxNqLrVOqJL1Al2G4YDwIED9c4JrMR0WxIECLn/E9KRvbyx52awl1se6QxAxGNW5f5au
         BV3z3maRflaA/J/0d5Kwohtz0gr4BIdBiHQ4vYiTC+HH01/HNcnAhe22+NvX9hOzVYwU
         9xJ+86noDsiBwF7haFzlwYt5g9TJQcnBeXfLAXGVteoH9kQXjj9s4KyNuvwRYxGaT63U
         VyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hL7ahHjXLTtDBm4Zo1lgep1oM+nfQRKvYlwijREaM3Q=;
        b=EqNKgVRw3FlYL9Uyox134FVCW1QjjNbybd+G1nfKEzL/VF5NncbSzrvH7Vs6Lm4SqD
         nJcwy0zpfqcjkismeslipxw0gE543rHFrSs45K+G9ymzS8lj+nsPa31UAmaE7qk8q9Tb
         jADW/UTg7KElKUTkgcr27fNA3rdEFrkkl7pzJvHUigRJMAbmSz9Hu7Tli/Ph8sFA28PV
         sIcIh7/zCVCFOHud2xlbX7lxkjA7RuWW6KKb5SooGPA6Szf3fzmDoSSKbbcNXbpaf2RI
         tNTGOhJVakl1EsHJOgIkZeibI6+S8Ehf5jdttGagikGtSy5cC46eNWKAsrc1xhdB1u4O
         XqjA==
X-Gm-Message-State: AJIora8RFLd8wjwxpDFM1q5uSt/B1SbZTZR1SzOWRLZDgxlcuxBa7Rd6
        eARDFfFkoLzslupl4ZurFms=
X-Google-Smtp-Source: AGRyM1s332Opp7vmMFHI71MQj8TqEt5Gtku8OuHELM9Cl2EAnzPta/OJ7HE1WBA3utEFgT6XVF0S2Q==
X-Received: by 2002:a05:6402:3224:b0:435:80fd:333 with SMTP id g36-20020a056402322400b0043580fd0333mr7518995eda.76.1655745608289;
        Mon, 20 Jun 2022 10:20:08 -0700 (PDT)
Received: from nam-dell.fritz.box ([2a02:8109:afbf:ed88:9959:ca73:b489:46f5])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709063ca900b0072232a898f1sm3409066ejh.103.2022.06.20.10.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:20:07 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, phil@philpotter.co.uk,
        Larry.Finger@lwfinger.net, paskripkin@gmail.com
Subject: [PATCH 0/2] get rid of useless header file
Date:   Mon, 20 Jun 2022 19:19:32 +0200
Message-Id: <cover.1655745123.git.namcaov@gmail.com>
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

The stuffs in basic_types.h are either not used, or already defined in
the kernel. Get rid of it.

Nam Cao (2):
  staging: r8188eu: replace N_BYTE_ALIGMENT with ALIGN
  staging: r8188eu: remove basic_types.h

 drivers/staging/r8188eu/core/rtw_recv.c       |  2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c       |  6 +++---
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |  2 +-
 drivers/staging/r8188eu/include/basic_types.h | 19 -------------------
 .../staging/r8188eu/include/osdep_service.h   |  1 -
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |  2 +-
 6 files changed, 6 insertions(+), 26 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/basic_types.h

-- 
2.25.1

