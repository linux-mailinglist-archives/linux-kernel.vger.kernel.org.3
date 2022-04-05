Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFBE4F506D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1841789AbiDFBZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457456AbiDEQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:15 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476C24FC45;
        Tue,  5 Apr 2022 08:44:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35:2589:2a93:190d:b787])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C920C30D;
        Tue,  5 Apr 2022 15:44:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C920C30D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1649173494; bh=Y8JQDAaUoR51nr0vreh9K+hDkAMzDHJLaO+1EAdFo9U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lu+X5ocZQ6WZkbc2wXsM4cqL34a9FLx1z3xpNTOL3MT4WKsa5vuLqHNmJNNRUEhmr
         URG4ecTZsNnVxgMf/x1lsfzpYbSGj7uoQjS0M6JRxWEO/InCglQctIWK0sYZAoWCz7
         LeYJ558E8Paj4f32H7ziSiD2dogckzHvwzDbqcQ3ti5gK7p/hxVfA9A8ewHRdZp56Z
         0XJ73mMFyorsbpO8kHDT5xJp+hSd6SZ1b0tIdTSEWugZPIyAy9hSLGqbXF6G0R+u4R
         GWuvP0THvPffQb9yi8v3hSWKNtBJtP7sB1LG4xZFx3nsjyWp86ninn35Hb3QRf6LRq
         q13qDHPZUvwDA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] Documentation/process: mention patch changelog in
 review process
In-Reply-To: <20220402100706.57507-1-krzysztof.kozlowski@linaro.org>
References: <20220402100706.57507-1-krzysztof.kozlowski@linaro.org>
Date:   Tue, 05 Apr 2022 09:44:52 -0600
Message-ID: <874k37fsaz.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Extend the "Respond to review comments" section of "Submitting patches"
> with reference to patch changelogs.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/process/submitting-patches.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

jon
