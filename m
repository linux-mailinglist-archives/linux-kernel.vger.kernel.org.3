Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E24E55D2C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbiF1Jre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344313AbiF1Jqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:46:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A276125C7E;
        Tue, 28 Jun 2022 02:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CAB7B81D90;
        Tue, 28 Jun 2022 09:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5526BC341DD;
        Tue, 28 Jun 2022 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656409590;
        bh=ArSgShbnkK2vHPevrDl6OPLY7UfpcoMZgBRBgsm9KFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tqZwdgSkTS3zWgVo6RJLP5DXaDs4LrUfYTgvhpHKtPRSI3r+5QU/Qwevqvh6twQWf
         qd0t2C4R4Tnlu8ohElGMDr38d5ubHQGRvy8SnU+bAl22zBVniBhnVa6u7oqmL/7fAN
         JbOE46EB+me3ezX7rqOfjnfz7pSzSINn4nwUxPy/i4CmOFMn0+PRvEQ9sYIVJF+LEV
         LjLa+jnLMY3edi3Fnuk6qInTTZYCo8vYXiB+6F7MOwvPHpRgww2zqNL83NwkyCDFC9
         Pl1dnK3aG81Ky+oAQEo+h0yDeeKf3Og9zQ4dQrED7x3SZxPgvzJmee7mz/Zuhdp8j5
         t9843HoRHDfmA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o67nf-005HFh-VU;
        Tue, 28 Jun 2022 10:46:27 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/22] textsearch: document list inside struct ts_ops
Date:   Tue, 28 Jun 2022 10:46:21 +0100
Message-Id: <f0395fe37a91f789a8cf40fd849fa2b4fd4bbe61.1656409369.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656409369.git.mchehab@kernel.org>
References: <cover.1656409369.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list field of struct ts_ops is not documented:

	include/linux/textsearch.h:51: warning: Function parameter or member 'list' not described in 'ts_ops'

Add a documentation for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/

 include/linux/textsearch.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/textsearch.h b/include/linux/textsearch.h
index 6673e4d4ac2e..29de95657ff1 100644
--- a/include/linux/textsearch.h
+++ b/include/linux/textsearch.h
@@ -35,6 +35,7 @@ struct ts_state
  * @get_pattern: return head of pattern
  * @get_pattern_len: return length of pattern
  * @owner: module reference to algorithm
+ * @list: pointer to ts_ops list
  */
 struct ts_ops
 {
-- 
2.36.1

