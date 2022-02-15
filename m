Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7504B7B09
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbiBOXKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:10:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiBOXKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:10:05 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A93F7454;
        Tue, 15 Feb 2022 15:09:54 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A220B35F;
        Tue, 15 Feb 2022 23:09:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A220B35F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1644966593; bh=maBWfkLJ9FQZgucG+ecBwq9+6hnMLANDC8Yj+/9A3q0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EoKvGIJ2w8H67HH5GSyebp8pVmafnkQYbsC7nFuYlFtk2FwwCFzd2RpDG4by7GZaN
         wLXoNeoKWVyQsCI8fuGm7xOKU1xsHNeC90WQrXZbHYWBRdm57/+g5CAtQnGu4kC0iZ
         JsaV2JiI4Qh2Sx5MGG6lhWI9X24frzlRVSQNuWSaabrRsGtim35okS6b6RIvRwey8B
         W/iewqouVq6EbzB5amsU+GarPDsRO2AaUQg7F8y5m0cvR/PEwiBmJ622+XhfzeAG3U
         A5fl9D2gYbqRqHa/BiwkMlOe9rzXzSbvo4I0FxI+NkENyPkjqHmb/H5XQcTXlXn1t8
         0a/FRE7t66WtQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs: Makefile: Add -no-shell-escape option to LATEXOPTS
In-Reply-To: <52112481-29af-1f8c-b82c-3519582e9850@gmail.com>
References: <519bd2d9-1bee-03e1-eeb4-d9883c18be0c@gmail.com>
 <87zgmybofe.fsf@meer.lwn.net>
 <52112481-29af-1f8c-b82c-3519582e9850@gmail.com>
Date:   Tue, 15 Feb 2022 16:09:53 -0700
Message-ID: <87wnhv7mm6.fsf@meer.lwn.net>
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

Akira Yokosawa <akiyks@gmail.com> writes:

> I don't think the "restricted \write18 enabled" mode permits *arbitrary*
> shell commands.  This is different from adding -shell-escape, rather the
> default option is -shell-restricted.  In this mode, only those commands
> listed by "kpsewhich -var-value=shell_escape_commands" are allowed.

Ah, OK, I stand corrected on that, thanks.  It's still worth turning
off, but it wasn't quite as bad as I'd feared.  Now that I've thoroughly
showed my ignorance I think I'll just go get busy with something
else..:)

Thanks,

jon
