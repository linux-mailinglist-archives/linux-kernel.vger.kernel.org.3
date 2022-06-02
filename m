Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94053BB42
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbiFBO4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiFBO4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:56:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A02332CE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ydvIhpgLEADdD5BuqSKgbyA0NtFIKzXjlgMW574OjrM=; b=FEbhP23QCwz/ndLVTOKOjs3/ig
        5Nh/epGvQmigX+9Pz2L42sIZRcPFusyUD+kd1dQbkt2ZVzl0erGcMOaNsFdnmeTFHU9FrUZAeRIef
        MIUABf3qnAtRdh660k2pjtoF+Tohk3SZfMyWTu5K80UrR6czPhArQdQwpD6ERue3fcxMv+ehxUP32
        3cKLQEmfU/mPSZjP3kZB0EY1aF4YYIhkAQ9CFhwMO18/HyAvx4I8p1ZrTE8nH2BrNbYKqs+QuhT+s
        HG2ta4hMNWMk990aFyDcyjweysXJb1oUte+L+DZog7D9JD2I/nROy7HtAZEqf+sO4S2iI+/Fv1XDY
        6M3Tevlg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwmF1-007DXh-Ky; Thu, 02 Jun 2022 14:56:03 +0000
Message-ID: <4e2ef3c7-f329-eeaf-f330-3da2b30b0b7a@infradead.org>
Date:   Thu, 2 Jun 2022 07:55:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] drivers: misc: intel_sysid: Add sysid from arch to
 drivers
Content-Language: en-US
To:     kah.jing.lee@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        tien.sung.ang@intel.com, Ley Foon Tan <lftan@altera.com>
References: <20220602122212.3021232-1-kah.jing.lee@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220602122212.3021232-1-kah.jing.lee@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/2/22 05:22, kah.jing.lee@intel.com wrote:
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 41d2bb0ae23a..a31489cc092c 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -483,6 +483,15 @@ config OPEN_DICE
>  
>  	  If unsure, say N.
>  
> +config INTEL_SYSID
> +	tristate "Intel System ID"
> +	help
> +	  This enables Intel System ID soft core driver.
> +	  Say Y here if you want to build a driver for Intel System ID driver.

Probably drop the last (redundant)                                     driver

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called intel_sysid. If unsure, say N here.
> +

-- 
~Randy
