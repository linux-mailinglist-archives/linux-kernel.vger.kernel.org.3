Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26734627DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhK2XMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbhK2XMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:12:03 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1124C08EA73;
        Mon, 29 Nov 2021 14:32:39 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 62274221;
        Mon, 29 Nov 2021 22:32:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 62274221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1638225159; bh=V5AIbjAOveHG7paLAjbeI5qsVb0ravBYOIKrb0ocAN8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Z39+lll32XY03AUnd858HlZTX9qoe36jBbaW6QqjF/uJSlY6iBAZnjv31h9O61T1j
         bbt2yWwz97Xg6QKtSJv/mF2zD2m7HFeCnL987HOKpbvBuARiVcmp583ir6XwOnD8Jw
         fIrfxV2PaMYKaZnTNuZKdb0X851pQypnqLCLjjp0Zdabsd2FO6STwz21gExXybs0y3
         zK2hf5UrHWxL84aWRpto8d60k+goDfesQd7MC/NA4596PNZgE1k9BbX3w+Wq6PTZI7
         z8mtqjVAQDrpjUhuJX0qpt4iAwD7qbcY8itB/cXIo9+rck7Pv/KfnuLqQE+1pTvm2I
         gQMTlY5IowL5A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     cgel.zte@gmail.com, alexs@kernel.org, siyanteng@loongson.cn,
        seakeel@gmail.com
Cc:     yang.yang29@zte.com.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs/zh_CN: Add zh_CN/accounting/taskstats.rst
In-Reply-To: <20211129065113.306748-1-yang.yang29@zte.com.cn>
References: <20211129065113.306748-1-yang.yang29@zte.com.cn>
Date:   Mon, 29 Nov 2021 15:32:38 -0700
Message-ID: <87tufur3sp.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com writes:

I'll ask the same question I've been asking others...

> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Add translation zh_CN/accounting/taskstats.rst and links it to
> zh_CN/accounting/index.rst while clean its todo entry.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Reviewed-by: Alex Shi <alexs@kernel.org>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> ---
> v3:
> - add necessary blank line for bullet list.
> v2:
> - fix incomplete words and long sentences.
> ---
>  .../translations/zh_CN/accounting/index.rst   |   2 +-
>  .../zh_CN/accounting/taskstats.rst            | 147 ++++++++++++++++++
>  2 files changed, 148 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/accounting/taskstats.rst
>
> diff --git a/Documentation/translations/zh_CN/accounting/index.rst b/Documentation/translations/zh_CN/accounting/index.rst
> index 362e907b41f9..124b590fb01b 100644
> --- a/Documentation/translations/zh_CN/accounting/index.rst
> +++ b/Documentation/translations/zh_CN/accounting/index.rst
> @@ -16,10 +16,10 @@
>     :maxdepth: 1
>  
>     psi
> +   taskstats
>  
>  Todolist:
>  
>     cgroupstats
>     delay-accounting
> -   taskstats
>     taskstats-struct
> diff --git a/Documentation/translations/zh_CN/accounting/taskstats.rst b/Documentation/translations/zh_CN/accounting/taskstats.rst
> new file mode 100644
> index 000000000000..f88a8d58ec69
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/accounting/taskstats.rst
> @@ -0,0 +1,147 @@
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/accounting/taskstats.rst
> +
> +:Translator: Yang Yang <yang.yang29@zte.com.cn>
> +
> +.. _cn_taskstats.rst:

What is the purpose of this label here?  Nothing references it.  Somehow
this practice of adding unused labels got started, but let's try to stop
it now; it's just clutter.

I've applied the patch but took that label out.

Thanks,

jon
