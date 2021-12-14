Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1D4739B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbhLNAoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbhLNAop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:44:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD062C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 16:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=iZuPc4ELeOaliF8n7EP7QWMLU80qJKqmHcBNmIZWMSQ=; b=o4CYC9PGY++7qWTt9O8OOQ3YCK
        Id16u1H/E+C7K3bmzxONwGyS9tj9l8x1x89YS+05yqgvAKZkoqlREeqXQUqqnC9Kt5Qs7veyaiz6s
        i6WvPeimqsxO34b7nx0qgOkc65cUEbIOw9q6/SBGT8QasbwTWNvYK1c76b+ObXkTUaSQut8sye91g
        C+8b3Gs9DBHDQn6jw0B/5HHTPclTV6uPgmI8xhwSuV+XcSCEkL3fnuqYwtfpHE9g5YNmFDXb6jcai
        I4+nM9Rk2SgwfC3EYnLlR5D5iQdh8Z+bEUoNWS0CMIP7im2hNtcwn5efzEuCwOEbfahXz9ArI6ffj
        8De1MqIQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwvvx-00C5CF-Ac; Tue, 14 Dec 2021 00:44:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: driver.h: fix kernel-doc warnings
Date:   Mon, 13 Dec 2021 16:44:44 -0800
Message-Id: <20211214004444.16932-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quieten all kernel-doc warnings in <linux/regulator/driver.h>:

include/linux/regulator/driver.h:262: warning: contents before sections
include/linux/regulator/driver.h:433: warning: Function parameter or member 'n_ramp_values' not described in 'regulator_desc'
include/linux/regulator/driver.h:443: warning: contents before sections

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
Note: in MAINTAINERS, this following line seems to be incorrect:
W:	http://www.slimlogic.co.uk/?p=48

 include/linux/regulator/driver.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- next-2021-1210.orig/include/linux/regulator/driver.h
+++ next-2021-1210/include/linux/regulator/driver.h
@@ -253,7 +253,6 @@ enum regulator_type {
 
 /**
  * struct regulator_desc - Static regulator descriptor
- *
  * Each regulator registered with the core is described with a
  * structure of this type and a struct regulator_config.  This
  * structure contains the non-varying parts of the regulator
@@ -348,6 +347,7 @@ enum regulator_type {
  * @ramp_delay_table:	Table for mapping the regulator ramp-rate values. Values
  *			should be given in units of V/S (uV/uS). See the
  *			regulator_set_ramp_delay_regmap().
+ * @n_ramp_values:	Number of entries in the @ramp_delay_table
  *
  * @enable_time: Time taken for initial enable of regulator (in uS).
  * @off_on_delay: guard time (in uS), before re-enabling a regulator
@@ -434,7 +434,6 @@ struct regulator_desc {
 
 /**
  * struct regulator_config - Dynamic regulator descriptor
- *
  * Each regulator registered with the core is described with a
  * structure of this type and a struct regulator_desc.  This structure
  * contains the runtime variable parts of the regulator description.
