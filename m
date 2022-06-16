Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1361A54ED7A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379085AbiFPWnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiFPWnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:43:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC41EE2D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F6BBCE2782
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 22:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCAAC34114;
        Thu, 16 Jun 2022 22:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655419389;
        bh=kfQarxH/56UT/XY118hOydrKuncAQiLkLupR53PFGck=;
        h=From:To:Cc:Subject:Date:From;
        b=XM/dze1GtQVrVsN2MD2FyK3sEW3Qv6oy6PvPJPdBbvr+LtmbHCSrKJpYygpMWrPeS
         VWLtmU/OnSSAUz2TBfyUjnYc/Q4VQqH71CvMbuCYiOuJRVDVh9TqXQ8aXcBIv50kLq
         aCr5xISTdd+sSKQqRDKIRXn88yxHBdbHT1lDuXocYR4vRkQdmv1PsQwZ9XfnicEy9y
         CEoUyN+aYUlivl5+eX5TK/ZDjNAIhe4e9d5pQRXaPHn3oDrYEJP0Wt30D4f+LRwMbO
         Umba7WGdoI0gqaF10PJ5EE/2s4F9vImCJvhLMCW6DaVhyMYXXfrkpK8d6yHCSkG3vH
         fjet+FLpzz/iQ==
From:   SeongJae Park <sj@kernel.org>
To:     ksummit-discuss@lists.linuxfoundation.org, ksummit@lists.linux.dev
Cc:     linux-mm@kvack.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [TECH TOPIC] Current Status and Future Plans of DAMON
Date:   Thu, 16 Jun 2022 22:43:06 +0000
Message-Id: <20220616224306.92076-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Hello all,


I'm posing my Kernel Summit topic suggestion as below.  I will also submit it
on LPC site.


DAMON[1] is Linux kernel's data access monitoring framework that provides
best-effort accuracy under user-specified overhead range.  It has been about
one year after it has been merged in the mainline.  Meanwhile, we received a
number of new voices for DAMON from users and made efforts for answering to
those.  Nevertheless, many things to do for that are remaining.

This talk will share what such voices we received, what patches are developed
or under development for those, what requests are still under plan only, and
what the plans are.  With that, hopefully we will have discussions that will be
helpful for improving and prioritizing the plans and specific tasks, and
finding new requirements.

Specific sub-topics will include, but not limited to:

- Making DAMON ABI more stable and flexibile
- Extending DAMON for more usages
- Improving DAMON accuracy
- DAMON-based kernel/user space optimization policies
- Making user space DAMON policies more efficient
- Making kernel space DAMON policies just work (auto-tuning)

[1] https://damonitor.github.io


Thanks,
SJ
