Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2220E46812D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383780AbhLDAZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383797AbhLDAY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:24:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6B0C0698C6;
        Fri,  3 Dec 2021 16:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=M+BqA3rXZtwt3zvm2Ce0wZmvZqrcJ5BQBRxgNgeLfYY=; b=Q/qFEbDwrJlie4IzpJKcaWx3FC
        qiuYDb4Oj+ucW9qJ65P3PpMN7i5PYrLCdoUdmwrS+FMFCwg/iM278WySuS9xjjSYmBitQISsOUt5X
        4HvNfqh/urxc9xe8wqQ/XOi3LlrjE4ZQ83X8GV/j8cMRvezx5Thd2VzhR03ZwCrBJfaBJAljfPxmW
        tusb02nlMc0gZ+qqZr2MTVDIa2sLAAG47vEB9FxkS16U9dKWOW2tAZqaduMc8j1JyYm3b5o0Y73Mt
        bLokosQGwQQ4DZLOi/99G44jL6/YSXHTUZ42Q4iGjlmix6wGaIeYIN/0pBug6hsVOpvTHMe927P5T
        WEB7gq3Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtInY-00At13-Kv; Sat, 04 Dec 2021 00:21:05 +0000
Message-ID: <d63edcb7-18c0-06fb-2216-2b1ed3b0215b@infradead.org>
Date:   Fri, 3 Dec 2021 16:20:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Content-Language: en-US
To:     Gabriel Somlo <gsomlo@gmail.com>, linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr
References: <20211203234155.2319803-1-gsomlo@gmail.com>
 <20211203234155.2319803-4-gsomlo@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211203234155.2319803-4-gsomlo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 12/3/21 15:41, Gabriel Somlo wrote:
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5af8494c31b5..84c64e72195d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1093,3 +1093,9 @@ config MMC_OWL
>  
>  config MMC_SDHCI_EXTERNAL_DMA
>  	bool
> +
> +config MMC_LITEX
> +	tristate "Support for the MMC Controller in LiteX SOCs"
> +	depends on OF && LITEX
> +	help
> +	  Generic MCC driver for LiteX

	          MMC            LiteX.


-- 
~Randy
