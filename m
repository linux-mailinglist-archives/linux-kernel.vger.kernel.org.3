Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF14F4E87
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446782AbiDFAaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457631AbiDEQVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:21:03 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D2E1AD8A;
        Tue,  5 Apr 2022 09:19:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35:2589:2a93:190d:b787])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C40DA608;
        Tue,  5 Apr 2022 16:19:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C40DA608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1649175544; bh=+RhP2wMlIenQpNZ9gtWvA3htzpj/xSyZCWrs4wfF5R4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Dbi7/Icr5no8hLxOP/HvRNkR+/DLgmH7zPFb7qoscjVnFjPXIwCUZvcUGxyjYmjkf
         Eb3dLtQauUFcK1iSVfxNsN6fqpXptzN04Qsqg8M5tgXbJ/hBwmmCVwPYJqQ+50Eboo
         4FIowjl5heWiwvfnkmGxpiGd4qxbeRE0A8CXfU6ovmF0tjRdRgzsxldPVHkX0QuOGn
         0aSxbJM6iAmo9EpNPwOIxYq78sFytT3b57pDxVS9sUD1xzTU6tDpA8GtNFlrwpNUT7
         HD/ZJ3w7jfwc4WEX5h4YpuiUf75yZmq2zeaMWSiEkkDPiQurl219XAwfH44Fy+aezE
         l5N1Bufr+zk7A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Grant Likely <grant.likely@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Documentation/process: Update ARM contact for embargoed
 hardware issues
In-Reply-To: <20220324151605.266645-1-catalin.marinas@arm.com>
References: <20220324151605.266645-1-catalin.marinas@arm.com>
Date:   Tue, 05 Apr 2022 10:19:04 -0600
Message-ID: <87h777ec5j.fsf@meer.lwn.net>
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

Catalin Marinas <catalin.marinas@arm.com> writes:

> With Grant taking a prominent role in Linaro, I will take over as the
> process ambassador for ARM w.r.t. embargoed hardware issues.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Grant Likely <grant.likely@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/process/embargoed-hardware-issues.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> index 6f8f36e10e8b..41a2afaaea75 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -244,7 +244,7 @@ disclosure of a particular issue, unless requested by a response team or by
>  an involved disclosed party. The current ambassadors list:
>  
>    ============= ========================================================
> -  ARM           Grant Likely <grant.likely@arm.com>
> +  ARM		Catalin Marinas <catalin.marinas@arm.com>
>    AMD		Tom Lendacky <tom.lendacky@amd.com>
>    IBM Z         Christian Borntraeger <borntraeger@de.ibm.com>
>    IBM Power     Anton Blanchard <anton@linux.ibm.com>

I've applied this, thanks.

I wish I could have added Grant's ack, but that email told me not to...

jon
