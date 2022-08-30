Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C679D5A5D64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiH3Hvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiH3Hvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:51:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF3994EC2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:51:29 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p7so3254828lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/7wqfc1vR6+qERkDsgDQZ1K9CfOnKqD3gFPpMnPcJOc=;
        b=Nstr3SAEdiFrok61VU9PL0cvoicsZf0pmsk67m3iP6IOxOglPatqCsfk7ajxuivPaR
         XDMIViDl0r04ulpxB4i5KFUZae/kuXrXZVBkC2kS33LfzPhm32Y91c726wLLvLjpeKEB
         AxMg4rlTw1Udwimaiw9AtPTixK/XF/q67HV3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/7wqfc1vR6+qERkDsgDQZ1K9CfOnKqD3gFPpMnPcJOc=;
        b=bfMKJt/b13kmvthpWsUpeq4YFvMVnu9G2gtLwnnyTN+9tgpJhrg2Ex1U9Sz583/+n9
         SbrmzRKBaDQ5jbW6Ltp59qLotp7Oy94Jo9AuuhHSB6wx/M6E2uITtq4wY0vIzRIbGa/p
         NDTEf92BxomhcoXKNilJ7kDd67FssD7G2zcrqVK0CdtU1VxS1KT2VI4ZeXdbAOh0vqCr
         JoLh4SelQNu/FSeLyn/74z/bEO8GLixUEiH1Qs6OLxWYK441GRX9HpgPHV6gtdBkLXvE
         LbOiwKVZQb68iM7FoM7dEtJXnOMgKumBUBlGYPS941VZjirsWcWyJyo+fc/xDOKVlbWO
         v2iA==
X-Gm-Message-State: ACgBeo0lkLtxCzhXZVDoAmfmHYJBqdqHCGNrG0tudTrDG1u8m3E+xHdF
        dAPTde2Qr4G6/QeL6h0i6Hx2Fg==
X-Google-Smtp-Source: AA6agR5R5MZEMJmENvkW4uZjodNElsQr04lLF+CuElaawlSkPI3R2Nk7a3UVC5rWbu0MGX4+d5jQJg==
X-Received: by 2002:a05:6512:158b:b0:48b:38:cff8 with SMTP id bp11-20020a056512158b00b0048b0038cff8mr6880088lfb.100.1661845887468;
        Tue, 30 Aug 2022 00:51:27 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r19-20020a2e8e33000000b0025deba4d9f1sm607578ljk.86.2022.08.30.00.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:51:26 -0700 (PDT)
Message-ID: <b96b9267-12b7-12d6-d883-084fda5cd3b8@rasmusvillemoes.dk>
Date:   Tue, 30 Aug 2022 09:51:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] lib/test_printf.c: Add escaped string tests
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220830003119.1793219-1-kent.overstreet@linux.dev>
 <20220830003119.1793219-3-kent.overstreet@linux.dev>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220830003119.1793219-3-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 02.31, Kent Overstreet wrote:
> This adds missing tests for %pE, escaped strings.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  lib/test_printf.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 6a56dbf076..247b1adbbe 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -413,6 +413,21 @@ addr(void)
>  static void __init
>  escaped_str(void)
>  {
> +	const char buf[] = "test \f\n\r\t\v \"\\\a\e \0 end";
> +	unsigned n = strlen(buf), with_embedded_nul = sizeof(buf) - 1;
> +
> +	/* ESCAPE_ANY_NP: */
> +	test("test \\f\\n\\r\\t\\v \"\\\\a\\e ",	"%*pE",  n, buf);
> +	/* ESCAPE_ANY: */
> +	//test("test \\f\\n\\r\\t\\v \"\\\\a\\e end",	"%*pEa",  n, buf);

Is there a reason that one is commented out?

> +	/* ESCAPE_SPACE: */
> +	test("test \\f\\n\\r\\t\\v \"\\\x07\x1b ",	"%*pEs", n, buf);
> +
> +	/* ESCAPE_SPECIAL: */
> +	test("test \f\n\r\t\v \\\"\\\\\\a\\e ",		"%*pEc", n, buf);
> +
> +	/* ESCAPE_NULL: */
> +	test("test \f\n\r\t\v \"\\\a\e \\0 end",	"%*pEn", with_embedded_nul, buf);
>  }

Perhaps also include a few byte values >= 128. Otherwise looks good.

Rasmus
