Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBC477057
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhLPLdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:33:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43082 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhLPLdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:33:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6975361D76;
        Thu, 16 Dec 2021 11:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB46AC36AE3;
        Thu, 16 Dec 2021 11:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639654416;
        bh=UJ6aPJtkAUGmyExkszl/dWUZ5oh7wj/TvKfeJAAe8i8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hE/u5ofzgtfygO3HRR327lVvqs9OdoeLBLEd7a7QKXDkSv6IqRRgY0cugHm+ZNyEe
         aH6kKS3FfBbCF9uqmK+NDS1svPSNKwhideGP6y0Dfvl8meOBvQotTbsyoSnntdKv+s
         mDqHwO/ndyve9FfTlBVMn98dTPIZxFKV03s7NyHW4yq1nsXNIdM+XuMXqJfCvjPvtE
         q1EsqgeO2NFN5omrszX9YFANgUuoN+W37eT7es/y5DYVm8PV98rk/W1MJO+/+KPTgK
         C6AcQohuC3GvizhG5TIrJyaIp6FPBHSJnWA2xLsTvJndVL3d3hBK5QS6LL7HyEFo4I
         5Y6q/lI6OOUSA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mxp0w-005bi7-Kp; Thu, 16 Dec 2021 12:33:34 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Subject: [PATCH v2] LICENSES/LGPL-2.1: Add LGPL-2.1-or-later as valid identifiers
Date:   Thu, 16 Dec 2021 12:33:33 +0100
Message-Id: <0af6460832237cbec13ff403695cf90e75488e96.1639654402.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <4f45e733caaa08b8b13f8cfd95848cc5ea89bfba.1639654324.git.mchehab+huawei@kernel.org>
References: <4f45e733caaa08b8b13f8cfd95848cc5ea89bfba.1639654324.git.mchehab+huawei@kernel.org>
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

Add it, together with the LGPL-2.1-only at the the license file.

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

