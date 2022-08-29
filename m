Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DA35A519D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiH2QYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiH2QYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:24:10 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6208E9A1;
        Mon, 29 Aug 2022 09:24:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B5F392E0;
        Mon, 29 Aug 2022 16:24:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B5F392E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661790245; bh=XeyUldM2kmPjFp1Z0j6QSolrm05MZv8BAzINIRKoqEY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RnA5M4bH42RGLuL0ljDzYlRtDkw4JhryUnz2i2GYQpk8Wl5m+XidZYec3ADf7FH/i
         NHkkMMg6VThGrpS0kyNDpugXnksCcR5Tf41LT5z41jq62QnaJKB+ArlyCEXX2L5xby
         jRgs8t9PpxTzdovTgn2l9HjWD6G9HYmcWhfh9Sp5uSwtMNu32RylyZ9Vci4itsVmQV
         d2gY2Cn7DGWxWGpCjNBtrWNCL7GRq57souTK4RuLHq91i2he3VvwNyXrkelsde2BhB
         wJWaWDBIxbbyN3TwE78EsxsSrTmU9DoBFcREZH/6HmEOaUBqkeRpVNWKOeYxMcPcRz
         b7uVGXjJoKeqg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     zhaomzhao@126.com, djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Subject: Re: [PATCH v1] Documentation: filesystems: xfs: update pseudocode
 and typo fixes
In-Reply-To: <20220823013653.203469-1-zhaomzhao@126.com>
References: <20220823013653.203469-1-zhaomzhao@126.com>
Date:   Mon, 29 Aug 2022 10:24:04 -0600
Message-ID: <87a67nqaqj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zhaomzhao@126.com writes:

> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>
> According to the implementation of xfs_trans_roll(), it calls
> xfs_trans_reserve(), which reserves not only log space, but also
> free disk blocks. In short, the "transaction stuff". So change
> xfs_log_reserve() to xfs_trans_reserve().
>
> Besides, fix several typo issues.
>
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> ---
>  .../filesystems/xfs-delayed-logging-design.rst       | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

I've applied this to the docs tree, thanks.

jon
