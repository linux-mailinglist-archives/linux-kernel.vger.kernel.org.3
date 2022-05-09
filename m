Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E8B52074D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiEIWIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiEIWIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:08:02 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECDB2A83C7;
        Mon,  9 May 2022 15:04:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 889D6732;
        Mon,  9 May 2022 22:04:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 889D6732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1652133846; bh=jB4LpymYnzlG4qkZC/mQ2W7zByxYnZ+9R68QH+RF8yY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SlHX6wn0QfP8+qUnqCJGoiUdYZkk8AWL+hDaUDZWwHoup9pUa0Ip1JoeqO2Fmg2KK
         jK+xuMG5QRljmWeixwlxBSgQqxGuhYvEMSTgvtaSQ6tefysZ0qEwIghojEOVk03uzO
         sy/HG9gpPOsbmmIfVIcEGm61U2aBBVMvNbqFIdV91ojbFzR1omFhvkVj4nazS4PUs9
         oPBuj+GxEaFokq6Jtcuo7gm8hXySCA4SJVLJEuMnXWxU5/XcRPSKyXszm/bCH2REWn
         DshdXRz/CwCoTSunpCIZNbUgz/oBE2c6jtJTUrk/NbvoRh9ZKa+kcUDc03Uk4DDuBf
         +kOl+Zw6jZyfA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] docs/ja_JP/SubmittingPatches: Trace changes in
 English docs, take 1
In-Reply-To: <20220503102429.48304-1-akiyks@gmail.com>
References: <20220503102429.48304-1-akiyks@gmail.com>
Date:   Mon, 09 May 2022 16:04:05 -0600
Message-ID: <87mtfqcqi2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Hi,
>
> This is the first batch of updates attempting to modernize Japanese
> SubmittingPatches.  Conversion to ReST will be done later when the
> corresponding commit doing the conversion is reached.  Pending list
> of commits is quite long (about 90) and this effort is expected to
> produce dozens of series.
>
> List of commits for English (then) SubmittingPatches:
>
>  - f5039935ac68 ("Documentation: update GregKH links")
>  - e52d2e1f25f0 ("Documentation/SubmittingPatches: suggested the use of scripts/get_maintainer.pl")
>  - 755727b7fb1e ("Randy has moved")
>  - 8543ae1296f6 ("checkpatch: add Suggested-by as a standard signature")
>  - 0af5270324cc ("Documentation/SubmittingPatches: Request summaries for commit references")
>
> Note: Commit db12fb833a88 ("Documentation: fix spelling error in
> SubmittingPatches") does not affect Japanese translation.

Series applied, thanks.

jon
