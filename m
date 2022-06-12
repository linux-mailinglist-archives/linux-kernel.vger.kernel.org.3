Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC562547831
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 03:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiFLBcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 21:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiFLBb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 21:31:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E2D1FA43;
        Sat, 11 Jun 2022 18:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Wapc6QcTDw02DJ4ptk4hYfpeWb/lZUMprSYn9BA+CP8=; b=Ulm0IU1cgXPYm7MbjAK7E7B0/V
        EfVehm2eXdSJRTNovJMiPtKUKrBfihHAGB80xuKX/nSKUOTJUnXAX0lwL7C0ohnjD3BuhQR/PDCxT
        RuBnRAK0PvGyLfJ60Wtndtn3eMSs/s4y4nMoQGuNjje8lfByBKXEbwTxAskJW52hnwUqLs4bWcGnX
        2KgytCWA1CAwlNxDUapDa7RTlUAhQqhbNgq2YWchfX9cn1NEmdZz1T5X/Z5iXhvZ1TFxozxXhzg8n
        BWOBUDzBgMx+8HtYClMq4CBLoAANJem63x6Nqh8+gS5m5HyFR9dZWuQ6b0ucK/PQ+rLv2Rrhr0wOt
        G433e/uw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0CSC-00FfmT-59; Sun, 12 Jun 2022 01:31:48 +0000
Message-ID: <967fa124-5ebc-6b0d-fa1a-27619eb01b8c@infradead.org>
Date:   Sat, 11 Jun 2022 18:31:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] firmware: stratix10-svc: remove extraneous asterisk from
 #define comments
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Ang Tien Sung <tien.sung.ang@intel.com>,
        Richard Gong <richard.gong@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org
References: <202206120445.FeU5wA93-lkp@intel.com>
 <20220612012253.16583-1-bagasdotme@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220612012253.16583-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/11/22 18:22, Bagas Sanjaya wrote:
> kernel test robot reported kernel-doc warning:
> 
>>> include/linux/firmware/intel/stratix10-svc-client.h:19: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> The warning above is because comments above #define statements are prefixed
> with double asterisk, which kernel-doc script mistook these as actual
> kernel-doc comment.
> 
> Remove extraneouse asterisk from these comments.

         extraneous

> 
> Link: https://lore.kernel.org/lkml/202206120445.FeU5wA93-lkp@intel.com/
> Fixes: 88f42ac48b8968 ("firmware: stratix10-svc: Add support for FCS")
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Ang Tien Sung <tien.sung.ang@intel.com>
> Cc: Richard Gong <richard.gong@intel.com>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infraded.org>

Thanks.

> ---
>  include/linux/firmware/intel/stratix10-svc-client.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index 5098dbba138d0f..63927aba0b5699 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -15,7 +15,7 @@
>  #define SVC_CLIENT_FPGA			"fpga"
>  #define SVC_CLIENT_RSU			"rsu"
>  #define SVC_CLIENT_FCS			"fcs"
> -/**
> +/*
>   * Status of the sent command, in bit number
>   *
>   * SVC_STATUS_OK:
> @@ -50,7 +50,7 @@
>  #define SVC_STATUS_ERROR		5
>  #define SVC_STATUS_NO_SUPPORT		6
>  #define SVC_STATUS_INVALID_PARAM	7
> -/**
> +/*
>   * Flag bit for COMMAND_RECONFIG
>   *
>   * COMMAND_RECONFIG_FLAG_PARTIAL:
> 
> base-commit: 107da326a0a3e7b6e81557c4225548db670a2647

-- 
~Randy
