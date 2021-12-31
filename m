Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409554825B4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 21:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhLaUBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 15:01:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33792 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhLaUBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 15:01:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD3FFB81DCF;
        Fri, 31 Dec 2021 20:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6760C36AE9;
        Fri, 31 Dec 2021 20:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640980858;
        bh=J/YhgplwbzCAtQrNHiVFUQO7/JbOvD5UTT8N+uN3SQQ=;
        h=Date:From:To:Cc:Subject:From;
        b=ZsC2+GjlMJgo1dKwfQjYFV6Cokbp69TEvWUbc6essnRrp13ymbZIZXlq30k+m+fcq
         bic1B+Mw25u+8ERtSg48VGbXSPjIxqK1GbeKTab/8kyIjWL7Gopmxzd+7NRxlZLiin
         sUEk8BhLszCZHFTZYIoAGW0k7aIQf0fjZT5NnvATivVUud9vs0wDCTIf81DRwTCq7T
         1QB/oieu5QTTS2SLWGeqOgd3YPUSKhg5MFDy2KMmFeq4TihWlz1XWSKmnapiQztyl1
         lc0H6eh2+GjsonBCHQmg59M9cEYHBXf+tFvo73/ml1md5ye5vgx/UT9SpNccYHDcVL
         +wEuMA43m+zfQ==
Date:   Fri, 31 Dec 2021 20:59:25 +0100
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: kbuild: fix default in `imply` table
Message-ID: <20211231195925.GA1678@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`BAZ` takes `FOO`'s value as default (as far as `BAR` allows it).

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/kbuild/kconfig-language.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index 98c24183d8c3..93a5b6e1fabd 100644
--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -176,7 +176,7 @@ applicable everywhere (see syntax).
 	y		y		y		Y/m/n
 	n		m		n		N/m
 	m		m		m		M/n
-	y		m		n		M/n
+	y		m		m		M/n
 	y		n		*		N
 	===		===		=============	==============
 
-- 
2.34.1

