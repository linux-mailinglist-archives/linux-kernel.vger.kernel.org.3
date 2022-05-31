Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558735395A9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346731AbiEaRzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346724AbiEaRzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:55:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3501378EF9;
        Tue, 31 May 2022 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=5qgPWbu1LAKzbDTijZmrwRKZussN5dXdmwQD1+Wcxks=; b=nxEOpA2AYHcT+nSglra4Y8vLPT
        /onVq/y8GBCq72oBkxzK/xgOEEOluDWdXPTkvY+novtidysHyPK/zPzadWRZKMaIzQl65JYJQwIf8
        NcIcQy24aEbXg5KGGFSblOfn6JcayrZNHsMab3e2WSVqex9bB+L9LwmGAwb6sDl8oZYSO8rWlRtg3
        UNTJ6W0O3Z6UjEB8o9V2N9xRfcSYu85xITfJnvUZWFf9YFvijRyiYF9vdGpTNJ7sbjlyD+7Ii2q8s
        NtaJhB19kLwafv70zNmIr59b4lSjPhc0wmUdWPSUtNAFWjKtDKqJWzv1OraOOMW/IVerd5RoT1FcI
        604w8mXA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nw65K-005Zqe-Hj; Tue, 31 May 2022 17:55:14 +0000
Message-ID: <e92a9cb8-0270-523b-d853-1ee648b20e0f@infradead.org>
Date:   Tue, 31 May 2022 10:55:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] m68k: virt: Kconfig minor fixes
Content-Language: en-US
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220531174514.1586248-1-laurent@vivier.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220531174514.1586248-1-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/22 10:45, Laurent Vivier wrote:
> Select VIRTIO_MENU as it is needed by VIRTIO_MMIO.
> 
> Add an ending period at the end the virt machine help message.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/m68k/Kconfig.machine | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
> index a1042568b9ad..4fbe57de1851 100644
> --- a/arch/m68k/Kconfig.machine
> +++ b/arch/m68k/Kconfig.machine
> @@ -161,10 +161,11 @@ config VIRT
>  	select RTC_CLASS
>  	select RTC_DRV_GOLDFISH
>  	select TTY
> +	select VIRTIO_MENU
>  	select VIRTIO_MMIO
>  	help
>  	  This options enable a pure virtual machine based on m68k,
> -	  VIRTIO MMIO devices and GOLDFISH interfaces (TTY, RTC, PIC)
> +	  VIRTIO MMIO devices and GOLDFISH interfaces (TTY, RTC, PIC).
>  
>  config PILOT
>  	bool

-- 
~Randy
