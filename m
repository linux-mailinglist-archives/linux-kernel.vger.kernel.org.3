Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30924BF63C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiBVKkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiBVKkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:40:13 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC0315C190
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:39:45 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z22so35803054edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=siTXojcdsHj7A4c6haRamyOZoZQ5GQeAn8ts6RCL5ak=;
        b=bEWLt+yuDSPzef3PUYhNcEEDo6BSuGu5AcctabZIdls+2OY6FtBMGnhEyhmglcW3l8
         1ndByhcQnwULl03tlDREMFclhYRJjjfVJp2RSlOu8baAdECG7m2vPfgU5+xsRL4WLWbn
         9fw2xFsu9IoEJIfLdTPiKfO0z2QuL3gqLC2RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=siTXojcdsHj7A4c6haRamyOZoZQ5GQeAn8ts6RCL5ak=;
        b=WkM1RJP4FEAPSH+6/j6vu7SnIJLiXGs0VmG9QQbQJO7TvKOKd+BRWeaEdogbf4ssBg
         Sycc8fh2K9vfR3BdrIy+qVJ3LT+Zvx5W91VLoNosJbGzAqNvPJYJfB9S7tCMX02ymiXm
         mcVDavBWITIs8/69zhbExfi2MOisEGPJtgmMnwLbXxCqaqHcfZfhwvQUaiE7MwSpk1/S
         eYh+hYVTlTDegdVSwLZ8I2LZxJrv2LZntL36Pxb5TBK0osqRmnP3KwSjPM9g0sTTEZG1
         LEzjohEAUpdo0AJxcM/o8O0Ry+w/tfvnUQ2+MXRY1bWFnlqQf9dMVraNggpi/Fbxsw6q
         KRqQ==
X-Gm-Message-State: AOAM5324FqhTGSlZirlbhCIt8XCf5/gxVjfQLuwfPIsux7jrzt1ecwGI
        JGoMRmHBeSJT0+Rafraj9fYEIT1deU3eig==
X-Google-Smtp-Source: ABdhPJyZYwhD1WnW0wbBJlvLuz7a7BsT7jIZv5urAWT8X+sd0LNqFAaSCsByJrw8LAu7Xv9KuK6+Gw==
X-Received: by 2002:a05:6402:55:b0:413:2822:2928 with SMTP id f21-20020a056402005500b0041328222928mr1429827edu.174.1645526383904;
        Tue, 22 Feb 2022 02:39:43 -0800 (PST)
Received: from altair.lan (7.e.a.a.9.9.f.b.0.5.5.2.a.2.1.a.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:a12a:2550:bf99:aae7])
        by smtp.googlemail.com with ESMTPSA id p4sm6144203ejm.47.2022.02.22.02.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:39:43 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mailmap: update Lorenz Bauers address
Date:   Tue, 22 Feb 2022 10:39:25 +0000
Message-Id: <20220222103925.25802-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220222103925.25802-1-lmb@cloudflare.com>
References: <20220222103925.25802-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm leaving my position at Cloudflare, provide an address where
people can reach me.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 8cd44b0c6579..a84aa8c79bfa 100644
--- a/.mailmap
+++ b/.mailmap
@@ -229,6 +229,7 @@ Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
 <linux-hardening@vger.kernel.org> <kernel-hardening@lists.openwall.com>
 Li Yang <leoyang.li@nxp.com> <leoli@freescale.com>
 Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
+Lorenz Bauer <linux@lmb.io> <lmb@cloudflare.com>
 Lukasz Luba <lukasz.luba@arm.com> <l.luba@partner.samsung.com>
 Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
 Maciej W. Rozycki <macro@orcam.me.uk> <macro@linux-mips.org>
-- 
2.32.0

