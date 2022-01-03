Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20374838D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 23:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiACWqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 17:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiACWq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 17:46:29 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E48EC061761;
        Mon,  3 Jan 2022 14:46:29 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8D4C64A6;
        Mon,  3 Jan 2022 22:46:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8D4C64A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641249988; bh=qf5K0CH0zwQh+dRvici2Yhs/O2Q9DxeX9GI/jF7NgG0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GkR6EIdr0sZnDb8wQmib2pyB7UihpSktVblwbffZHEJT1un90ZLLHc7T54bMle1Vl
         ojcIeqpewCc102zVesU+EqdtWxbSuiBxD4j4HmCFLXlsx4q44t3JH4l8/OVH0mtXVz
         khk75B24IaUle2trWp4SEH4RHtB2ZTgc7yMJekn066bSTC5h4pyzYWGOR8aM9YRpr6
         ev1Pbdg6GdpDKOR7pQ+bp4CLnwizCc3T8Q6RR9Fe6wIcMa6EUHtPel7/hmQl5Nc0u8
         q4SG6pGRgJTOX217yi5D+4XdSv5D0Ys77jsbOXaKW/eJE/J1gHXaR6wZfSe2SHM2r/
         mqrucZ6tvKQ/A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/1] scripts: sphinx-pre-install: add required ctex
 dependency
In-Reply-To: <165aa6167f21e3892a6e308688c93c756e94f4e0.1641243581.git.mchehab@kernel.org>
References: <cover.1641243581.git.mchehab@kernel.org>
 <165aa6167f21e3892a6e308688c93c756e94f4e0.1641243581.git.mchehab@kernel.org>
Date:   Mon, 03 Jan 2022 15:46:30 -0700
Message-ID: <87mtkcxws9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@kernel.org> writes:

> After a change meant to fix support for oriental characters
> (Chinese, Japanese, Korean), ctex stylesheet is now a requirement
> for PDF output.
>
> Reported-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> See [PATCH 0/1] at: https://lore.kernel.org/all/cover.1641243581.git.mchehab@kernel.org/
>
>  scripts/sphinx-pre-install | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index 288e86a9d1e5..46aaab414098 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -78,6 +78,7 @@ my %texlive = (
>  	'ucs.sty'            => 'texlive-ucs',
>  	'upquote.sty'        => 'texlive-upquote',
>  	'wrapfig.sty'        => 'texlive-wrapfig',
> +	'ctexhook.sty'       => 'texlive-ctex',
>  );

I've applied this, thanks.

jon
