Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836C059B8EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiHVGFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiHVGEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:04:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A03F20BF9;
        Sun, 21 Aug 2022 23:04:54 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id l1so13284716lfk.8;
        Sun, 21 Aug 2022 23:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=doWgkAfEcmSMhRNIxRoHTjD9fSl7Q2XFQ3gDJGe0anw=;
        b=d4vR2s8+jxnIrEGB/CJTUEY5EHRuuUOMpojTc+QpmNEZGAUirYD2O/zwgfBwghXVth
         6ano1jbjTf3HWovy0VG6zgWCy0MS1HfZNWz/HW1FgMoLWnPHUgyPyvBttjXjvfmQW2rL
         PSOLIssuruiQRbESq/mSb7kQhv58B6FsKldWmZ8LljlHFwB73Yu4rNA1xzwdZvKAgcmT
         EPiVVOC4BnnexElaDjpHuDA7C4mvbm6B/FOwkTcn9WGsDSMOWjqXf4ZoNwjsy3MXueXH
         KZbE83t2aOGeNqTER/qtLoaXLCYBbAPvZhlEVDTSyNtDL0Eg/w/Yz1ytZTN+CU5gdyGC
         TpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=doWgkAfEcmSMhRNIxRoHTjD9fSl7Q2XFQ3gDJGe0anw=;
        b=oLi4mi7fwDSZ3mVQ+EaLes+lhF3DzUd20hCl6FPc42jZJC+0UmIeQ8E/V2TWKA0SMc
         XaiVVESZOGbuw2nfKYf29GSVvRLtpBAt6+1had99UH7OYhSh+vkQ4Aq1QN1rloTNlt4W
         4L0NzjSwuGhQgbStobZOVBry4b0uDcb1KRs02ZMtUYUlxCi5aXd8h1SLc4WTtRIPk01M
         I3SVCenDw8hOoa2wg8JQutLrEcNaBRsY+8Vky5fSlgVDmG+U0NHdGKkzdepO1TLC4fn6
         GKKIASXmM79bK/MxzTgD4m0SEr8BrmnefKMZh05BbBGS4PpeJd0W5AKQDEJEMAt2FH5F
         u45Q==
X-Gm-Message-State: ACgBeo1YQJ0DEg4HTatm4BRShVD8lv3nwOtWsoOYaiGGWmoMCBAfhPX2
        1/WsekxQnQArjAovmXtXbQ0=
X-Google-Smtp-Source: AA6agR7S8W+RHjW6Fx6LlBk13x71rzPMpPIyQa8sXXSvRaIDvZJ7qmlMXLPS0fUSGTwuUpzhC7hc/A==
X-Received: by 2002:a05:6512:3f19:b0:48a:874f:534 with SMTP id y25-20020a0565123f1900b0048a874f0534mr6304213lfa.446.1661148292323;
        Sun, 21 Aug 2022 23:04:52 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id u17-20020ac243d1000000b0048afeb4ea32sm1776929lfl.100.2022.08.21.23.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 23:04:51 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [RESEND PATCH 2/2] MAINTAINERS: Add entry for RC Simulator Controllers
Date:   Mon, 22 Aug 2022 08:09:36 +0200
Message-Id: <20220822060936.769855-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822060936.769855-1-marcus.folkesson@gmail.com>
References: <20220822060936.769855-1-marcus.folkesson@gmail.com>
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

Add an entry for RC Simulator Controllers and add myself
as maintainers of this driver.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..216b9f021f72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16896,6 +16896,13 @@ M:	Patrick Lerda <patrick9876@free.fr>
 S:	Maintained
 F:	drivers/media/rc/ir-rcmm-decoder.c
 
+RC SIMULATOR CONTROLLERS
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/hid/rcsim.rst
+F:	drivers/hid/hid-rcsim.c
+
 RCUTORTURE TEST FRAMEWORK
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
-- 
2.37.1

