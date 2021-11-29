Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E6C462422
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhK2WQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhK2WQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:16:33 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9160DC08EB2C;
        Mon, 29 Nov 2021 13:42:41 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 15D6F2D3;
        Mon, 29 Nov 2021 21:42:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 15D6F2D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1638222161; bh=dxVqXyJt+NWgZ8KiVRMsoxhFaqe07X8UZntns7f7gKQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EA8Ro+5/aZe+MD7I/L/neRV6pUADrcqN0wTI9mdNnQFFtxll3BF5mry3LchTdNuYI
         61iUnEvzODQooGQx07UYwLpMbd/fsA6qIwZFnQ0zqJEV/zcAyTHxrSa86YTBmf7C2o
         epFHqXGnpMNzaQNQhgzCQuXjUvjPTK/CpK+h/IA828cowQ3U5ToEXqND6wb49f+CDW
         7xaIMxqEbr5WT3uzVfQWw0R+7sCl2C0TlVHtijieqtlfVTafYQ3031RXZfPUt5OEtk
         Ma6dx60u7jEwaiSxNFiyhqOOl/XKRCqHPMarkmEjzqmbdkeON90DzAIGWNYtgLiPf1
         1vs/rhQvOPsYA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Erik Ekman <erik@kryo.se>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Erik Ekman <erik@kryo.se>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/process: fix self reference
In-Reply-To: <20211119200758.642474-1-erik@kryo.se>
References: <20211119200758.642474-1-erik@kryo.se>
Date:   Mon, 29 Nov 2021 14:42:40 -0700
Message-ID: <87o862skof.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Ekman <erik@kryo.se> writes:

> Instead link to the device tree document with the same name.
>
> Signed-off-by: Erik Ekman <erik@kryo.se>
> ---
>  Documentation/process/submitting-patches.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index da085d63af9b..6b3aaed66fba 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -14,7 +14,8 @@ works, see Documentation/process/development-process.rst. Also, read
>  Documentation/process/submit-checklist.rst
>  for a list of items to check before submitting code.  If you are submitting
>  a driver, also read Documentation/process/submitting-drivers.rst; for device
> -tree binding patches, read Documentation/process/submitting-patches.rst.
> +tree binding patches, read
> +Documentation/devicetree/bindings/submitting-patches.rst.

Applied, thanks.

jon
