Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665AD520769
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiEIWRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiEIWRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:17:20 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438D5164CA2;
        Mon,  9 May 2022 15:13:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E650A732;
        Mon,  9 May 2022 22:13:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E650A732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1652134405; bh=sEMrik7WYGW/7x9Mgr4lGXr3bXEO5dv8oIWWDb5ZT7U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Up8/me1vktG5QJsMclCUdE9vZdl0x/2/+g6CNBQetQ2CBiF1rzN1Gz94+ri7NEO5p
         Bqx876vGb44nKwfLqzZAS7pvhV2WJM7Zw+6RH7Ej8amt0yNurkHOKmRwN91q93rhFE
         +MG6tkkUwFcFUhOPGemNizVgiE47tCAEGKN/bHZhUXMw8oKt6pQR54Ezt9SCM+7nfF
         JC5Vc86WpgH5gNXxISuAKuVXvtNaZAeE58rHB2gRob/LrB2PTojD2AsnzrpNsm9M08
         CopFXlWfLSu172GZKUKRLdBY8g7eZlk7xJhcjVZQkPJc70YEs7OMugjyBn+ldVqTgW
         IJw2xAYNLLt8w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] Documentation/process: use scripts/get_maintainer.pl on
 patches
In-Reply-To: <20220427185645.677039-1-krzysztof.kozlowski@linaro.org>
References: <20220427185645.677039-1-krzysztof.kozlowski@linaro.org>
Date:   Mon, 09 May 2022 16:13:24 -0600
Message-ID: <87ee12cq2j.fsf@meer.lwn.net>
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

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Explain that, when collecting list of people to Cc the patch,
> scripts/get_maintainer.pl should be used on patches, not on the
> directories.  The behavior is quite different, because with "-f" on
> a directory, the maintainers of individual files will not be shown.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> It seems using the script on patches is not obvious and it already
> caused some misunderstandings.
> ---
>  Documentation/doc-guide/contributing.rst     | 5 +++--
>  Documentation/process/3.Early-stage.rst      | 9 +++++----
>  Documentation/process/submitting-patches.rst | 7 ++++---
>  3 files changed, 12 insertions(+), 9 deletions(-)

I worry about trying to cram every detail into these documents; it's not
as if their length isn't intimidating already.  But I've gone ahead and
applied this, thanks.

jon
