Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4BB4BEEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbiBVBMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:12:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiBVBMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:12:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7C224F09;
        Mon, 21 Feb 2022 17:12:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4073DB8181E;
        Tue, 22 Feb 2022 01:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C13C340E9;
        Tue, 22 Feb 2022 01:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645492332;
        bh=fjfjMUQ2+wGeydmUGZlvSS2cR6/r++uioOTeHCEJSnE=;
        h=From:To:Cc:Subject:Date:From;
        b=d7M5tosV8Qb1/ppdK/LoXarg0uBvCEK33VGMgVQsCRTrGxbUTOmpwamrzfOL/irMV
         IX+8CrlnLjY1wkGp3hXxzxL60xxUvCMOxSiG7oNBR7rCcU3w04iVS3Q1CAJLiKnJb7
         P4hfieQiIWPeFAJjAjCOiyxXRNLAWPGeJGRtBbOK24Qp/5iWd+udjAvsqTh2icouLL
         zB4RI6x2iOEI/aKNlm/E2QqGSdIwS8BlR5jGVJivE1k9/g+nJaQDbOJ5lYZdH3EsgX
         tco8Yb6+WQehZS0LhKrhXHSg93lWnr/YbFTGz/ff9qAlICGw00yizgPd/6nNjQQQTd
         CDaSPpRPvqn6A==
From:   broonie@kernel.org
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: linux-next: manual merge of the slab tree with the origin tree
Date:   Tue, 22 Feb 2022 01:12:07 +0000
Message-Id: <20220222011207.3407124-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the slab tree got a conflict in:

  mm/zsmalloc.c

between commits:

  ffedd09fa9b06 ("zsmalloc: Stop using slab fields in struct page")
  a41ec880aa7be ("zsmalloc: move huge compressed obj from page to zspage")

from the origin tree and commit:

  a593db30a7365 ("zsmalloc: Stop using slab fields in struct page")

from the slab tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

[Used the origin version again]
