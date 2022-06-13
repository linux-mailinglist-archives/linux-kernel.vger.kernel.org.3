Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3304254A16B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiFMVar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352640AbiFMV2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:28:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A3E2E9E8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:21:23 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z17so6835052pff.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1pdPmusGMnUfQyyEHdu3Oky7j+h/vnutTYbvmZDyqZs=;
        b=XUNbexr4kGyEWSemqyCTT+8Y3QUcITPQxnaHgckUUUsjuQFsbpOYwCs/VMAbViAxsp
         fxb6wUVmkSoRBuhZRgbQSCpVfsD5PJIHl9QNg8/w7yEr7vn8U2IwmWyFW47EIqWigFL1
         YkDfx9KjX47u+27zvLVOSmKeiSdRcGxIRSzg4NWfvRQZr4OaMJZjnz0wptD9+a4ZMPvm
         zytSu5i4whwjqSEfax9CF3l709vL3YxmZMcTQSmulbCZ/zfm2MJxxVasDG5UdWVAVpFX
         WYV8ouCc4xGFX21BekPO9hGfcWxFYjoivG6UEps2q+OLquqOOHOzWkurJVzr/F05EbHZ
         fgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1pdPmusGMnUfQyyEHdu3Oky7j+h/vnutTYbvmZDyqZs=;
        b=qWvA4JEoF5nCnpXsFMftTiqJlbbKAdTJOK6lj4nVa6+5zxMZMZbwVQ1w7+uwqoIBe0
         6Rutx5xXi9rAS6QKlXTk8ykTqxjysSa412vNB3jJ9guDa2ScWL6fe4GjT9m3ia422p7f
         iyfZ+GaLQR+1EJaKqlKTRBBV3IRS8YFIaAL/DqOtg5h7LR4SFjkFNR84Wz94Oue6amLL
         OGPZTrNrcV8SIMcfIKinwYC8g7e/5/06ltbz6d1TilAMgMpYZSUxG5SqwPevYU5QAC1N
         DEh/wsd0bM290AFm/mUermmb6SSUxXVzLg0ZqXIO7KM6R54YHtV6Y1KFl4Ybbet7w2xg
         xTKA==
X-Gm-Message-State: AOAM533E6+rQovYYQbaY46zB151KW2W91/awg7Z/U/tIoyw2LeQ91iHJ
        8HoyW38Whuo0fTDyd6JvQ6dF9P/lkSo=
X-Google-Smtp-Source: ABdhPJy3+lg35CK83pWQYOr/pm2VSe4+EXNwARqiW7cDOYbfBDIvxi1ptscUUO3Z/57x4NfCyyQ40g==
X-Received: by 2002:a62:8702:0:b0:51b:c452:33cf with SMTP id i2-20020a628702000000b0051bc45233cfmr1283955pfe.72.1655155282381;
        Mon, 13 Jun 2022 14:21:22 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d20-20020a170902f15400b0015e8d4eb285sm5564414plb.207.2022.06.13.14.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:21:22 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     samyon.furman@broadcom.com, dan.beygelman@broadcom.com,
        tomer.yacoby@broadcom.com, philippe.reynes@softathome.com,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        joel.peshkin@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MAINTAINERS: Add BCM6856 to bcmbca arch entry
Date:   Mon, 13 Jun 2022 14:21:20 -0700
Message-Id: <20220613212120.260366-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608180437.31971-4-william.zhang@broadcom.com>
References: <20220608180437.31971-1-william.zhang@broadcom.com> <20220608180437.31971-4-william.zhang@broadcom.com>
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

On Wed,  8 Jun 2022 11:04:37 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add BCM6856 related files to BCMBCA ARCH maintainer list entry
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/maintainers/next, thanks!
--
Florian
