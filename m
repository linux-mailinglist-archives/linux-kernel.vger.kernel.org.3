Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3335A58F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiH3Brb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiH3Br2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:47:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9967C778
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:47:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso16419104pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=IyD7fwTMy15wH7pBcObtdwE5dJQ5CpVWpD2s2V7wnQg=;
        b=UyIN6Jt3LBLWRE8mHc+0kCt3klWBuwoY3j/hDdBnD1v/EOw8PkgPQ5JZno1K4KZ0LA
         IDz8PubRdmoICKtAXGDsHdqUABsocbumFpcnntKeFO2iMcb4FweCrlg/Ds1Iam3TCrtB
         wQZi2kbqVbCVME0cyyV9aoBB4DIW8MgrwC6YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=IyD7fwTMy15wH7pBcObtdwE5dJQ5CpVWpD2s2V7wnQg=;
        b=zGWlpV9aLffvEHrY9xsDUct6u1MVYo7Wz6bmvN1xS8B4aH7WB3QsbGzq8NIDS+32f7
         IpYDldGLw2MHyEIeeoEw+/+uBuj4e0UR9cuTZgYI1Oo7rph6OUsLSnb+HZEpPQ2ARQlZ
         oAv+h/OGa0iXTDcN6+W4G9dfnP4Wl5d3n9HtT1FKdTsRowGTIWTFnOC6RAhtpyBJO97v
         qMburfCqUB4AfMhKpwHn/NjPinQoy7MxHMzOk9d8vpSA872I8+MaWXij8qWkMg5q8sm0
         PEtdMNEQv7QUYflVcmC+JCBYZhz7eLQgtEkdvOc1YN7cn5xXd4lBbws5QzazxxD2OMLy
         GyFA==
X-Gm-Message-State: ACgBeo1YaI9dldCfuH4Xf7OsExSVugbBms7TuNHW+NZKUiO8BZdk0njj
        U7fWD6NrQRkFCBfSMs4Cza7L0A==
X-Google-Smtp-Source: AA6agR6Vtf9yrF/gN/4hEfM3EyhsyzlTFsaOTnVNngviGQ2VNePTZJuQIauz2Zs73YXWXEk0nFFJ3A==
X-Received: by 2002:a17:90a:3002:b0:1fd:d4fe:29a6 with SMTP id g2-20020a17090a300200b001fdd4fe29a6mr7155764pjb.236.1661824046912;
        Mon, 29 Aug 2022 18:47:26 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709029a0c00b0017294d80f25sm8154306plp.258.2022.08.29.18.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 18:47:26 -0700 (PDT)
Date:   Tue, 30 Aug 2022 10:47:21 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/2] lib/test_printf.c: Add ip6 tests
Message-ID: <Yw1sKTOEs1Nrdb2S@google.com>
References: <20220830003119.1793219-1-kent.overstreet@linux.dev>
 <20220830003119.1793219-2-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830003119.1793219-2-kent.overstreet@linux.dev>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/08/29 20:31), Kent Overstreet wrote:
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 4bd15a593f..6a56dbf076 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -18,6 +18,7 @@
>  #include <linux/dcache.h>
>  #include <linux/socket.h>
>  #include <linux/in.h>
> +#include <linux/in6.h>
>  
>  #include <linux/gfp.h>
>  #include <linux/mm.h>
> @@ -61,6 +62,9 @@ do_test(int bufsize, const char *expect, int elen,
>  		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
>  			bufsize, fmt, ret, elen);
>  		return 1;
> +		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d (%s != %s)\n",
> +			bufsize, fmt, ret, elen, test_buffer, expect);
> +		return 1;
>  	}

I assume you intended to replace first pr_warn() with the second one?
