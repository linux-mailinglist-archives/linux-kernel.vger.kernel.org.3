Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADC847704F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbhLPLcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:32:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42490 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhLPLcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:32:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6B2F61D73;
        Thu, 16 Dec 2021 11:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F0BC36AE2;
        Thu, 16 Dec 2021 11:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639654342;
        bh=hyN+gjpicXJNJCG7LerXG8qmnTOMKtc/atowCpie6gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoDus1NlONwOOWqwd6POvxB+8hbWhTzETGAlFI+wcxZHcSi/+lvm/QSY3aK2zGKo6
         yFQyfT+DsorxrpVgs8PjzQjiETcxMk3lTFjdQWPAdpHz9t1bqBPlNjj6+kv5Ty8LNz
         HVBK6rFz9F5ss5HCjQlaNVu3fZDRbEuwzm2Fex6wtEImpn03U8nnQK7eGIZ6M6BnPR
         8RDtDVCMbPBuMk7HabJUEfNhKAhCYlAE1KRNvjqWQNtbcSNLPZi9DbAUzyHWk2vqcz
         FXi3EOBbn3HShv/A1dUYi9Lc2JkGsljDEVtgUxDVqGZJTGZSTxDpzVfTYyZvY6musX
         DZaFpwXWG8+gA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mxozk-005bfb-5V; Thu, 16 Dec 2021 12:32:20 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Subject: [PATCH] LICENSES/LGPL-2.1: Add LGPL-2.1-or-later as valid identifiers
Date:   Thu, 16 Dec 2021 12:32:18 +0100
Message-Id: <4f45e733caaa08b8b13f8cfd95848cc5ea89bfba.1639654324.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211216122311.0c9d154e@coco.lan>
References: <20211216122311.0c9d154e@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some files have been flagged with the new LGPL-2.1-or-later
identifier which replace the original LGPL-2.1+ in the SPDX license
identifier specification, but the identifiers are not mentioned as
valid in the LGPL-2.1 license file.

At it, together with the LGPL-2.1-only at the the license file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 LICENSES/preferred/LGPL-2.1 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/LICENSES/preferred/LGPL-2.1 b/LICENSES/preferred/LGPL-2.1
index 27bb4342a3e8..5feb8a6dbf15 100644
--- a/LICENSES/preferred/LGPL-2.1
+++ b/LICENSES/preferred/LGPL-2.1
@@ -1,5 +1,7 @@
 Valid-License-Identifier: LGPL-2.1
 Valid-License-Identifier: LGPL-2.1+
+Valid-License-Identifier: LGPL-2.1-only
+Valid-License-Identifier: LGPL-2.1-or-later
 SPDX-URL: https://spdx.org/licenses/LGPL-2.1.html
 Usage-Guide:
   To use this license in source code, put one of the following SPDX
-- 
2.33.1

