Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B8B5856BC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 00:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbiG2WD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 18:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiG2WDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:03:24 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037588BAB1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:03:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z12-20020a056830128c00b0061c8168d3faso4190513otp.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=RXWJjLRz7P9r1hNunIcpGJfPNUX5gzjTNT3qhw4Q8tc=;
        b=gBbVHOZCRQEC/xR/pKz52eY39CztxQaMuB22gkEz7v9ovzBeQZMjKvcNa58SKpeB6S
         X6ZR3csKR+tXv9VglmLTq4euN/XKZy3Q9iNNzEVEALpSkbjUms9TbORc9guZWmW3grMi
         WaFa1M7NCo0JqeOHqfYCLNXMNlyq0gpcnkQGh65L5TOx57hAM/+FF/2/0cW+h4fmhUgv
         EBTs9SIrjot83v/AdgBdAuiswROLcorb4eAs44X2WNwmXAZaDyJE/spadOkGzCguK3it
         ju+qZPUum7YY/JYJz+N3oBUqukxeudtyd3XvPi3wa6vKSTJ7VtPBUaalDsoeyoCQlkIK
         ZVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=RXWJjLRz7P9r1hNunIcpGJfPNUX5gzjTNT3qhw4Q8tc=;
        b=Nv6APnylBgSQn0Yaa8Dtze3+6DVsx4kNW+oIa77FAVPPCIziQqtH4MpdY6WDFDJZlO
         bal2Xug9+901Ae4uVBi9F/MB/4phebvVfM7K9+hlzuHe/0jCXidL3Le6rrf0eSZZG9bq
         YrCeUKMwiUmJdL5SoUGi86n2bvnITnRcEnhEMDGRIGcQINRnYZk/euEz0XLhSmxTYazB
         kEI9kSY9+QEiu+1RnEyy2ajKORPEknWY8A9Gz+S8x+yxPqxeZ4O5pponmZAzrYP0oxkh
         /7qsUWrSNgBHIy61BXXHzqr+PxRzI9960p6P6RqhcZwLXHKnTeFcdrfOq/4Dn8JfmT5e
         52ug==
X-Gm-Message-State: AJIora9UsNZpt7GyEwbtXFAdAZWlaCUhSm/os1CbRrl7FG8M5Nm71uAZ
        KKlIi1wEYjrMRv6iIdN710yCHWHrFos=
X-Google-Smtp-Source: AGRyM1uxHqelv+2GP2cScl0HPfPe/tNoB5TLIAlvzfnUV2iBsdEDFUzqiKtuYqVT8K7ao4TXZ2JUNA==
X-Received: by 2002:a9d:c65:0:b0:61c:bed2:622e with SMTP id 92-20020a9d0c65000000b0061cbed2622emr2144718otr.292.1659132202981;
        Fri, 29 Jul 2022 15:03:22 -0700 (PDT)
Received: from bertie (072-190-140-095.res.spectrum.com. [72.190.140.95])
        by smtp.gmail.com with ESMTPSA id 69-20020a9d02cb000000b0061c80736666sm1452425otl.28.2022.07.29.15.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 15:03:22 -0700 (PDT)
Date:   Fri, 29 Jul 2022 17:03:21 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     shaoqin.huang@intel.com
Cc:     rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] memblock test: Modify the obsolete description in
 README
Message-ID: <YuRZKTNl+USWFR5H@bertie>
References: <20220729161125.190845-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729161125.190845-1-shaoqin.huang@intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 10:11:25AM -0600, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> The VERBOSE option in Makefile has been moved, but there still have the
> description left in README. For now, we use `-v` options when running
> memblock test to print information, so using the new to replace the
> obsolete items.
> 
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> ---
> Changelog:
> ----------
> v3:
>   - Using `build options` replace `options` to make it more clear.
> v2:
>   - Tweak the sentence to make it more clear and continuesly.
>   - Commit log changes.
> 
Looks good!

Acked-by: Rebecca Mckeever <remckee0@gmail.com>

>  tools/testing/memblock/README | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
> index 058146b528a5..72162b5f4a76 100644
> --- a/tools/testing/memblock/README
> +++ b/tools/testing/memblock/README
> @@ -33,20 +33,23 @@ To run the tests, build the main target and run it:
>  
>  $ make && ./main
>  
> -A successful run produces no output. It is also possible to override different
> -configuration parameters. For example, to include verbose output, specify the
> -VERBOSE flag when building the main target:
> +A successful run produces no output. It is possible to control the behavior
> +by passing options from command line. For example, to include verbose output,
> +append the `-v` options when you run the tests:
>  
> -$ make VERBOSE=1
> +$ ./main -v
>  
>  This will print information about which functions are being tested and the
>  number of test cases that passed.
>  
> -To simulate enabled NUMA, use:
> +For the full list of options from command line, see `./main --help`.
> +
> +It is also possible to override different configuration parameters to change it
> +test functions. For example, To simulate enabled NUMA, use:
>  
>  $ make NUMA=1
>  
> -For the full list of options, see `make help`.
> +For the full list of build options, see `make help`.
>  
>  Project structure
>  =================
> -- 
> 2.30.2
> 
> 
Thanks,
Rebecca
