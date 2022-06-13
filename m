Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225E554A19B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiFMViP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237746AbiFMViM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:38:12 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6386E102B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:38:11 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 31so5076031pgv.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9gsY2Q8N08q9UihH6zZfqHaNQOSS5MAqZbpHik6a1Ms=;
        b=Yv8SySYBMSHQ3jeUfaektJ4lkoPLvNczp3cN1pJKnlpJ8yyc9eWKsUjPuij3L9a9oi
         P/yg97ED80vLA/Z+UhunmJDnfpuEjwX3jD2E5tFmUe/wEdv0w4xVWDgH5/MUq8LAyhKe
         yKGnpVrYuh75xlDWVWzqXiYroqLBJWCAdvGYRvV4j5TJ/8L12g6s2rt1fh/hG0ORduiC
         8oi2GAJKRUF3KtlJjZkeRG/xve/mcn2zZrK6I10e+0woQDrqwgnEKNkKTG1K3C93bGOG
         WFY7sioDXz96jYUMp1YG+PJh2S0yjTrXVZohc9d/235EblzqaoE9EtIjyUs6G3pdg+cC
         /Hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gsY2Q8N08q9UihH6zZfqHaNQOSS5MAqZbpHik6a1Ms=;
        b=lnFghdVNnzD3PkjLOTZ2yqOQ1jo4sDcnb7TchvWDg03BKdbx26Ifh7z7045D/wPGYk
         asOL/jym1KRzFgZRADIo2gpICU8J9JlRK91lSNvkdefbTUMq6hAOISlbY3xDL3j/xxyv
         3jenlEgYRbSoZNODUOrNnHOkIPpcjQPvDzE59G2JTiDCeLyQDX8MuPU56oxTZJbGKbew
         6AGzBwPotRXh+il7GZR5+N0Ve7jCjovMmekQtMz3fECl8gjyoSq9Xw12+kjrkBlWaK84
         glmC3CArN6Sx9jz3A8pnVAwogCHhboMPOLHjULClCAsUl5zYCsib3I4sk+Kuj3gmQvni
         CkCw==
X-Gm-Message-State: AOAM531vNCSspGsMt/yeHPYIhct0DWYCZ9uFsxHoCfMvGR5+hsCF2Pl/
        LveehqqV+oAZpTiSz5iUKKF3ecloidE=
X-Google-Smtp-Source: ABdhPJy2tLXdP3F2FnRY4BwsMD2wl3lSz4husBTpww4mxCXJGo7AKgbzEJDOc5P8HeLFpGBhrbWYbA==
X-Received: by 2002:a65:5785:0:b0:401:a993:2434 with SMTP id b5-20020a655785000000b00401a9932434mr1399381pgr.411.1655156290873;
        Mon, 13 Jun 2022 14:38:10 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id fa21-20020a17090af0d500b001e31f4cc977sm5715907pjb.56.2022.06.13.14.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:38:10 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        samyon.furman@broadcom.com, philippe.reynes@softathome.com,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        anand.gore@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MAINTAINERS: Add BCM63148 to bcmbca arch entry
Date:   Mon, 13 Jun 2022 14:38:09 -0700
Message-Id: <20220613213809.268466-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610002113.14483-4-william.zhang@broadcom.com>
References: <20220610002113.14483-1-william.zhang@broadcom.com> <20220610002113.14483-4-william.zhang@broadcom.com>
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

On Thu,  9 Jun 2022 17:21:13 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add BCM63148 related files to BCMBCA ARCH maintainer list entry
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/maintainers/next, thanks!
--
Florian
