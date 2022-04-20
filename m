Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4FD508510
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377259AbiDTJiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377260AbiDTJiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:38:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A50315A1C;
        Wed, 20 Apr 2022 02:35:15 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 71CAF378;
        Wed, 20 Apr 2022 09:35:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 71CAF378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650447315; bh=/drfVWlpA5rvL+Fx11EF7dxixc4TXy05BiVzmO3nX6Q=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=BNoyTCusYisehvH1uDCtgaTeCCwQWpDmKVC5M5AMsgEulgiLPO3HfoSUlZZyOlM8h
         JC/7h0TpOjDpNBtOn+17ID99REjcprINr4UaklTLdHHhSkFGmW44wcyj19aOklrdpY
         a/PrFfnGKYQik4i9hgbdLNWSsTgjFk4sx9ok4XsrwjFxGUtkUsKB8mxsBQ/djWlG+4
         FQFR0exYECfzMKfLJfJZ8CTjeAtmzD73fk+AbqexelSkUxfEBk1Y1cV/EVOugeSM1S
         CXloiBRrDBRdlr7UhOne2BlDGxIbP4eLlAh6EkbupWuZPydIiTncKvcUrNvQx3DjBZ
         NFSAbM5MAfeVQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bruno Moreira-Guedes <codeagain@codeagain.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v2 0/2] Docs: Update information at changes.rst
In-Reply-To: <cover.1650376049.git.codeagain@codeagain.dev>
References: <cover.1650376049.git.codeagain@codeagain.dev>
Date:   Wed, 20 Apr 2022 03:35:10 -0600
Message-ID: <8735i83xo1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bruno Moreira-Guedes <codeagain@codeagain.dev> writes:

> Add and update information at 'Documentation/process/changes.rst'. The
> text has outdated kernel version and misses the 'cpio' build
> requirement, necessary for the `kernel/gen_kheaders.sh` script called by
> the install target.
>
> The PATCH 1/2 fixes the missing cpio requirement, while PATCH 2/2 fixes
> the kernel version reference.
>
> Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>

Patches applied, thanks.

jon
