Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDC35351F6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347738AbiEZQYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiEZQYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:24:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A173BBE9;
        Thu, 26 May 2022 09:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653582275; x=1685118275;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qRgGhRHwCCm7GnDbtwlUeFiN+mzozJcVTBpdrrRgFaM=;
  b=ORhdfFyb+SwtLft4cCCDNkptldtA7YewaujDL2yldIJ/sk/B8hENW5T2
   LAV9S+T9wWCpzhpnC5TY/3Twu5+48cu8oeQA915h1NB1YBU4BfJE1BAUX
   SohYbVf4pUhcDftASiQeG1bDtBOLh1Zzj8bg1LRzHdeqWHQIPq0W/hXez
   pjktOll6GmidIB0EJnqqmeoYG3uPobMDs5iRxT5l20FHDR4khCLik8iC5
   +OgsjdNo2h/xuUvE7XXx4/P00lpYEVjrtmtLHZQtavkAyHcU73La2w5oz
   NbjQ+BiD7tEGfrhbLd6K+ligViAGD+K1b3qrdlLxDckUPpHt9t6Lsx6S/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="337254792"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="337254792"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 09:24:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="642955355"
Received: from tjeziers-mobl1.amr.corp.intel.com (HELO [10.251.23.34]) ([10.251.23.34])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 09:24:32 -0700
Message-ID: <8f3be3c2-dcd0-1646-b5bd-0a6597e7ca2e@intel.com>
Date:   Thu, 26 May 2022 09:24:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2] x86/idt: traceponit.c: fix comment for irq vector
 tracepoints
Content-Language: en-US
To:     sunliming <sunliming@kylinos.cn>, mingo@kernel.org,
        linux-tip-commits@vger.kernel.org, dave.hansen@linux.intel.com,
        rostedt@goodmis.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com
References: <20220526110831.175743-1-sunliming@kylinos.cn>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220526110831.175743-1-sunliming@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 04:08, sunliming wrote:
> 
> diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
> index fcfc077afe2d..065191022035 100644
> --- a/arch/x86/kernel/tracepoint.c
> +++ b/arch/x86/kernel/tracepoint.c
> @@ -1,9 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Code for supporting irq vector tracepoints.
> - *
>   * Copyright (C) 2013 Seiji Aguchi <seiji.aguchi@hds.com>
> - *
>   */
>  #include <linux/jump_label.h>
>  #include <linux/atomic.h>

While I'm also generally careful about removing others' copyrights, Mr.
Aguchi only touched this file once and all of the code from that one
touch appears to be gone to me.  Shouldn't we just zap the whole comment?
