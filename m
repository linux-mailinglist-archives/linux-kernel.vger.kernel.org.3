Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9C04D6A0D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiCKXMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiCKXMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:12:21 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F14924A;
        Fri, 11 Mar 2022 15:11:17 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 35D5D2C3;
        Fri, 11 Mar 2022 21:15:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 35D5D2C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1647033332; bh=0/483QzGB30kNJZAm68LV8BK75E5dsf9QB/OPM1v+VI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nMVL4CO+nGhSSSOc4+P3qrAN7+tzfmVlreuIKwh81LhbMacZz7zKADrNiBPXO56qi
         zvqkfZ5CRwIaO7cWWSsMLrRck5hCjrNSJznG74avYURgps6cY84XT+odG7cMLh3DHi
         t2GouQ/7IyLlqm7h7judn33EpjVtgR45prF7qndJAwXx175XsLAXTzFMbKyUYJmnuD
         fytEkmNsfLnVFgum/eC+fVXGJvnfvEnzIGFE0IEo/zSEKUt1CO9YPSIqlC6SjD5VGm
         ND7cSeT8PedbM7llk4lngV2zTqQmQJOnh065aC/k1MskNb2S63hsOkh+2rNNrlQY8L
         tx1JLMKucnOlA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Frank Rowand <frowand.list@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Docs: ktap: add code-block type
In-Reply-To: <c29f1836-5e85-2c8d-fb98-d63c3d8a654d@gmail.com>
References: <20220131003637.14274-1-rdunlap@infradead.org>
 <c29f1836-5e85-2c8d-fb98-d63c3d8a654d@gmail.com>
Date:   Fri, 11 Mar 2022 14:15:31 -0700
Message-ID: <87ilsk2nt8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Rowand <frowand.list@gmail.com> writes:

> Hi Jon,
>
> Are you planning to pick up this patch?
>
> I had independently included the same fix in another patch series, but David Gow
> let me know that Randy's patch already existed, so I removed this fix from my
> patch.
>
> Reviewed-by: Frank Rowand <frank.rowand@sony.com>

I never know what to do with the testing-tools patches; some of them get
picked up by others, some done.

I've just applied this, because it's better than what we had.  The
proper fix, though, would be to just turn all those "code-block"
directives into straightforward literal blocks - that what they are,
after all.

Thanks,

jon
