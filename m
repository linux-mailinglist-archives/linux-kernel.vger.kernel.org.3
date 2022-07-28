Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BBC5837C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 06:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiG1EFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 00:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiG1EFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 00:05:16 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0619A637A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 21:05:10 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id n16-20020a4a9550000000b0043568f1343bso98089ooi.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 21:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w3ZvXOi58iLmqXMoB+Pk7kq83LCFc7KsAO1ebX7B/ns=;
        b=VBVapj9fDuUiMhOo/t74oJiah7FQ707LUH5LhxoEV8hLE6VycGQR/JzM0ewWtMOJ3n
         aZ+Zo+0e7VjDdrb+kFSBwHTcnA5BqysI1uEkg8wtC5COCY1Zb95dWLUopVzpE6J2Ayjw
         sRCxKpmRQYIe60tcTmGFmDb2vCAvBEnl+7MQRI2WBRJIdWCJxxvB7afELQB/xkbPhD2N
         hZBGrGHXBvkSLCkEMHO9+4h0y5kLtIUlKaU3JOG1TY8DMW5j4bMhHqHvwBhkwxsark+o
         U/55J70Z9/v4WtFH0yn4FvkWcW7kXtV6icUxUv24PFLEDvjO+TPN+ExbioDbx4Z/kR9m
         tDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w3ZvXOi58iLmqXMoB+Pk7kq83LCFc7KsAO1ebX7B/ns=;
        b=6valCiy2b/wjsvhL9dYAIN11zQRH8mguNPBqbuiAx6W9KrU+qmBmbCAAsJFMaYyMqL
         44ZNH+/2H+jzOMGXVhK7NmiDCiYKzlzIs12CsHfCTQJJmyrkoFKpCUNfdOTWqSEf5JA+
         ZBI0WSMg2jOWv3hWcGev9BYfHr6kXzaDg1uhB6/gdneRcPg+5cWgb48ZbrJjHp9RHulR
         G35mqc1HtFAZXdydLV7wMeC73vhndBK4aFeueOL7TmpfP13Xx6GlQ/37gc/POg9eCK4O
         PDldCG8mNT1TCUWyeGI5E2wbWu0HKGwrYoC9IoHgbWbQ8vNPVdGueAM2N6QRRnw5bnxn
         ayQQ==
X-Gm-Message-State: AJIora+L0Oy2fDPkIkliKyZ44m0EDFvdPs/ZIgBjgvtoAAxodMlYOsaB
        IP2NVL3LnOhLcUr6ebtRSmnwtqOcvlM=
X-Google-Smtp-Source: AGRyM1sls4qhxEGs/5y1MoMOolLttyl41O5u8SrzAGP7Y01XjkxIZegy9jWSkSkrKjRvBVnSSNfXyA==
X-Received: by 2002:a05:6820:16aa:b0:435:acba:37ef with SMTP id bc42-20020a05682016aa00b00435acba37efmr8831262oob.69.1658981109070;
        Wed, 27 Jul 2022 21:05:09 -0700 (PDT)
Received: from bertie (072-190-140-095.res.spectrum.com. [72.190.140.95])
        by smtp.gmail.com with ESMTPSA id k1-20020a544401000000b0033aef871695sm3383781oiw.16.2022.07.27.21.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 21:05:08 -0700 (PDT)
Date:   Wed, 27 Jul 2022 23:05:01 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     shaoqin.huang@intel.com
Cc:     rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memblock test: Modify the obsolete description in
 README
Message-ID: <YuIK7cU8uH7zVP+S@bertie>
References: <20220728011228.23691-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728011228.23691-1-shaoqin.huang@intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 07:12:28PM -0600, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> The VERBOSE option in Makefile has been moved, but there still have the
> description left in README. For now, we use `-v` options when running
> memblock test to print information, so using the new to replace the
> obsolete items.
> 
Thanks for catching this!

> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> ---
> Changelog:
> ----------
> v2:
>   - Tweak the sentence to make it more clear and continuesly.
>   - Commit log changes.
> 
>  tools/testing/memblock/README | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
> index 058146b528a5..d3875e7065fd 100644
> --- a/tools/testing/memblock/README
> +++ b/tools/testing/memblock/README
> @@ -33,16 +33,19 @@ To run the tests, build the main target and run it:
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

--help will display the list of command line options by default, but a
help command line option isn't explicitly implemented. I'm planning to add
the help option, so if you want to remove this sentence, I will add it when
I implement the help option.  
> +
> +It is also possible to override different configuration parameters to change it
> +test functions. For example, To simulate enabled NUMA, use:
>  
>  $ make NUMA=1
>  
Maybe you could add "build" before "options" in the line after this:

-For the full list of options, see `make help`.
+For the full list of build options, see `make help`.

> -- 
> 2.30.2
> 
> 
