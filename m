Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E633055D0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbiF1JsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344302AbiF1Jqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:46:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1196525C55;
        Tue, 28 Jun 2022 02:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFAB6B81D96;
        Tue, 28 Jun 2022 09:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5437BC36AE5;
        Tue, 28 Jun 2022 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656409590;
        bh=mH0IqtWPBXiWck++b9ZqdkpJ66zW1PTOjMSEWTBrX+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XREhXjmjga1ST6oPjVBoVrw2g/POI3UZPZH0Uur2uXBVHdyxnM/NKyoOUM9lZ4Svj
         8lcDUw38dt2ScApnROT1od6WQaE1fMt0Af+7x9M8uOHnU6xhQUCYHWFVwGKX5NUutS
         txs5W65kPmdmxfN4qrOBHBTcFY/z0zhcdCtpbAez9fNP4QMTjmmiChAiEyx+RYkH61
         uQJ3Z0ip5J6ktkEgH8ECdrvlrYbOmWBJ3n2lPd48IChTgQwO2D7hkWr0n4LzLXqOX4
         4878MBQ2sBGI+X2dgnMhn8Mey4qRjeLRIi8EAr3HHNiZ6rHcN5fM8mvt2eNEw0jXrZ
         rwOvkdHv7gdrQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o67nf-005HFk-W5;
        Tue, 28 Jun 2022 10:46:27 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 18/22] regulator: fix a kernel-doc warning
Date:   Tue, 28 Jun 2022 10:46:22 +0100
Message-Id: <15efc16e878aa327aa2769023bcdf959a795f41d.1656409369.git.mchehab@kernel.org>
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

document n_ramp_values field at struct regulator_desc, in order
to solve this warning:

	include/linux/regulator/driver.h:434: warning: Function parameter or member 'n_ramp_values' not described in 'regulator_desc'

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/

 include/linux/regulator/driver.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 0228caaa6741..f9a7461e72b8 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -348,6 +348,7 @@ enum regulator_type {
  * @ramp_delay_table:	Table for mapping the regulator ramp-rate values. Values
  *			should be given in units of V/S (uV/uS). See the
  *			regulator_set_ramp_delay_regmap().
+ * @n_ramp_values:	number of elements at @ramp_delay_table.
  *
  * @enable_time: Time taken for initial enable of regulator (in uS).
  * @off_on_delay: guard time (in uS), before re-enabling a regulator
-- 
2.36.1

