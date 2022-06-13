Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C380754A151
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352090AbiFMV1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347782AbiFMV0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:26:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFD0F6F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:17:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y196so6834742pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WN51alfUqcsRZ8Lxmu6cDf0AJBgi7QA0H7Ls78skmto=;
        b=CyUwJZr3PggbFuS8WvKhWVv3MD5wlTRay3i1dfAivNvQDgXFtdpTFOzH3g0jVP2o1a
         HRGDamXE47+50a1NYIzTPHHgdDgZYD0HEXtDZV86yPBepvYlPEoBMRLcXbSS6+CJTGhK
         2xMXtNCHkXeJMHfzWmCBscBStIcj9QSXPWRepd+uMRFhnITRMjF23ziaOoetZjVERKRI
         LCR7rL4AfY1SPaky9XLR+IZoQDLp040pK/xwC59JF5rKhXJrlMwbAIzfgDiopsPtXbGa
         7/4IJJdj9g20GQCBomGEylqhiTxKsqz7sBWvbtfoB9W9XTq0ZBY03kJYXqDFarUxPjun
         6RFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WN51alfUqcsRZ8Lxmu6cDf0AJBgi7QA0H7Ls78skmto=;
        b=x4/+D34eIueZP77YfiA9U1HhQXuDDZGtiZrq6vvqpKLZUY4fmE33W+kaa2tRVqkupB
         juY2KFnXYse6J98XZnPwx7Gyj8VPndRiwoOZ2hF2/iXrmObv9ayfliEcEMRW3HtJGFHe
         inoBjrJOzqH6ksMS4CTsAZiWc3KBRBXb/4P2n4sAQw6HowTdptP5vWmL3lL9LVWuFgKR
         y8a3YLLr86+cnnNaocFKFQqYSM2tSvahT2Ie5yB5eSLUa9YxAS8Xz8Stq8/Bt7LibRjm
         G0Nent3RvP+jJaVmHrFoOXgXxwIMJINaRVXKZ+fbpfi05sbgKObtOHuMGAeIrLdAnRal
         Lxyw==
X-Gm-Message-State: AOAM5316VZU58U35wKBNepJbzrGxxlq3CKWJJa7bMIaopTHqqEJ8qcRl
        herjlfLDp1b+2syqRcEG3Ro=
X-Google-Smtp-Source: ABdhPJwZkaNQOsgyQJe/hnFt6wfysGTnfJNmuDFBU0HsagL6HdknIaMWVEUgl0b8mZIAuPLt5bZgww==
X-Received: by 2002:a63:2160:0:b0:3fc:b8ac:1976 with SMTP id s32-20020a632160000000b003fcb8ac1976mr1346610pgm.453.1655155030451;
        Mon, 13 Jun 2022 14:17:10 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m17-20020a056a00081100b0051b9c0af43dsm5880622pfk.155.2022.06.13.14.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:17:10 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     samyon.furman@broadcom.com, tomer.yacoby@broadcom.com,
        philippe.reynes@softathome.com, joel.peshkin@broadcom.com,
        dan.beygelman@broadcom.com, kursad.oney@broadcom.com,
        anand.gore@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MAINTAINERS: Add BCM63146 to bcmbca arch entry
Date:   Mon, 13 Jun 2022 14:17:08 -0700
Message-Id: <20220613211708.259165-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608180100.31749-4-william.zhang@broadcom.com>
References: <20220608180100.31749-1-william.zhang@broadcom.com> <20220608180100.31749-4-william.zhang@broadcom.com>
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

On Wed,  8 Jun 2022 11:01:00 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add BCM63146 related files to BCMBCA ARCH maintainer list entry
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/maintainers/next, thanks!
--
Florian
