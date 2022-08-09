Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BB558E32D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiHIW03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiHIW0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:26:20 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08275FAD3
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:26:18 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4M2SMs5T6Xz9s1T;
        Tue,  9 Aug 2022 22:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1660083977; bh=ot3Tf5cVJ9DBjrPftvCXsrF2Eskp3r7kGhcOwZ0rEW8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G/hYcdFOLQUyWKySrO05csWNOaQl/8Gg6uEH0kaIyormmSMuOatydHrpDLAoVsWze
         BHGt1kuDDv+O2H7ANZTI/7FyOlVJSzKRYCd7W2zernn7XY1A4kWJ65R37GDeUQd5bV
         g0gw0HYvt16CZ4fK3yfkt9V0Zd1am0BIW2YP43wE=
X-Riseup-User-ID: 663878C0FA3D246D0FCD1307423475148F2501460A6D19B556D927938EFCED6B
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4M2SMq71jrz5vtw;
        Tue,  9 Aug 2022 22:26:15 +0000 (UTC)
Message-ID: <15acd7ab-e624-b2ee-cde5-100b69cf7206@riseup.net>
Date:   Tue, 9 Aug 2022 19:26:13 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/5] lib/test_cpumask: drop cpu_possible_mask full test
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
References: <cover.1660068429.git.sander@svanheule.net>
 <30d8882efedea697da20c27563050008d1569b9e.1660068429.git.sander@svanheule.net>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <30d8882efedea697da20c27563050008d1569b9e.1660068429.git.sander@svanheule.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 15:08, Sander Vanheule wrote:
> cpu_possible_mask is not necessarily completely filled.  That means
> running a check on cpumask_full() doesn't make sense, so drop the test.
> 
> Fixes: c41e8866c28c ("lib/test: introduce cpumask KUnit test suite")
> Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net/
> Reported-by: Maíra Canal <mairacanal@riseup.net>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

Tested-by: Maíra Canal <mairacanal@riseup.net>

> Cc: David Gow <davidgow@google.com>
> ---
>  lib/test_cpumask.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
> index a31a1622f1f6..4ebf9f5805f3 100644
> --- a/lib/test_cpumask.c
> +++ b/lib/test_cpumask.c
> @@ -54,7 +54,6 @@ static cpumask_t mask_all;
>  static void test_cpumask_weight(struct kunit *test)
>  {
>  	KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
> -	KUNIT_EXPECT_TRUE(test, cpumask_full(cpu_possible_mask));
>  	KUNIT_EXPECT_TRUE(test, cpumask_full(&mask_all));
>  
>  	KUNIT_EXPECT_EQ(test, 0, cpumask_weight(&mask_empty));
