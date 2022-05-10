Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4016522297
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348161AbiEJRah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348119AbiEJR34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:29:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA07C6F;
        Tue, 10 May 2022 10:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A02CB81E71;
        Tue, 10 May 2022 17:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC696C385A6;
        Tue, 10 May 2022 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652203544;
        bh=E5tHulDdEyVbd8pyewc2Uh4nakVaKYnyEVavHR0gbbo=;
        h=From:To:Cc:Subject:Date:From;
        b=nNclPHat4Q7+ZlM4hhZGyqFCwCyksH2rUNpBG3i2aFfAJt/+adHb/BQJSXxQUeDv5
         amrhDziLqfE8FPKkxzcasNLJauBjiTbUDqHp1VDbKsBIplpVgYASrdrxY0cYOJ2MV0
         enV4eotJADu7s8nb6+sIES+H5fRForV9Q6rGhmyHSTZKXCxtwWwhGT1nDF+MaS+Q6m
         lbM/6EZ66+EJs1wIGfL9SDOhHYhlokJRfueoAspCczc+lNF9ySZYFkjkcPgpnTj8si
         wUeuIvruTtiaHaSgmXVi1A/W3Ggr6QTW38VXPhMe/XQCSFnsKafoGBmxBGG2S/kuo7
         2Fp7NMqDnQ3qQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Garrett LeSage <garrett@lesage.us>,
        IFo Hancroft <contact@ifohancroft.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH v1 1/2] docs: move Linux logo into a new `images` folder
Date:   Tue, 10 May 2022 19:25:29 +0200
Message-Id: <20220510172530.29704-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having assets in the top-level `Documentation` directory can make
it harder to find the documents one needs, especially if we want
to add more of them later on.

Instead, create a new `images` folder inside it that is used
to hold assets such as logos.

Link: https://lore.kernel.org/lkml/8735hicoy7.fsf@meer.lwn.net/
Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/{ => images}/COPYING-logo |   0
 Documentation/{ => images}/logo.gif     | Bin
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/{ => images}/COPYING-logo (100%)
 rename Documentation/{ => images}/logo.gif (100%)

diff --git a/Documentation/COPYING-logo b/Documentation/images/COPYING-logo
similarity index 100%
rename from Documentation/COPYING-logo
rename to Documentation/images/COPYING-logo
diff --git a/Documentation/logo.gif b/Documentation/images/logo.gif
similarity index 100%
rename from Documentation/logo.gif
rename to Documentation/images/logo.gif

base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
-- 
2.36.1

