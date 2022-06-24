Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B1D55A1FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiFXThH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiFXThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:37:06 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2134E81D9C;
        Fri, 24 Jun 2022 12:37:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A9A002A0;
        Fri, 24 Jun 2022 19:37:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A9A002A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656099425; bh=x4wbdnxAg9IQfvLXt0JnRMgyxywI8bO2mXS6K1R4n6A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Mnneccn9+DDS2JB+u6+j5T5Ltk2U/SKqUehWNDuJuvUSwpuW8dSPLiDjIo9Tb951p
         gRIJLOG734+W+QpKDiUNih9bg4x4merQ8WGtjYOlM3DIhMVkJF22hLXmFW7s+Vy78i
         QaWDsGuffwM3qLDVNFuyGEqe4t4XV0ZyUuhJ3uiPE3N21EqsQVGlyMG2XPpzPJN2G1
         l7JttZXrSrnFsRWYQJ/LOoXBSse6lI3aZY+KfgGTRHue8i6iprhQgegp8y6tGFONOJ
         kTVwf+408frXWkrmxsJSgigm90Up1GrdoVLyv2vvjzRqSeLiYGYhYXkvnHLrJAvubA
         tK0t2vZhMWj8A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dev-tools: fix one invalid url
In-Reply-To: <CAD-N9QUOk938-+1CtGfWNKUvWowknKScLuFXXkFAv59M=-F84g@mail.gmail.com>
References: <20220613071243.12961-1-dzm91@hust.edu.cn>
 <Yqbu8TwmaXdBiIBs@debian.me>
 <alpine.DEB.2.22.394.2206131212160.2812@hadrien>
 <CAD-N9QUOk938-+1CtGfWNKUvWowknKScLuFXXkFAv59M=-F84g@mail.gmail.com>
Date:   Fri, 24 Jun 2022 13:37:04 -0600
Message-ID: <877d554zvj.fsf@meer.lwn.net>
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

Dongliang Mu <mudongliangabcd@gmail.com> writes:

> On Mon, Jun 13, 2022 at 6:12 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>>
>>
>>
>> On Mon, 13 Jun 2022, Bagas Sanjaya wrote:
>>
>> > On Mon, Jun 13, 2022 at 03:12:42PM +0800, Dongliang Mu wrote:
>> > > From: Dongliang Mu <mudongliangabcd@gmail.com>
>> > >
>> > > Fix the invalid url about Semantic Patch Language
>> > >
>> >
>> > I think what this patch doing is to point SPL reference URL from old
>> > Coccinelle documentation (doc root) to actual SPL doc entry on new
>> > Coccinelle page, right? If so, "fix invalid URL" may not be right patch
>> > description and title.
>>
>> Agreed, thanks for the suggestion.
>
> Okay. Let's modify the title to "modify SPL reference URL to actual
> SPL doc entry".

Normally, the way to effect such a modification is to submit a new
version of the patch reflecting the change.

I've applied the original patch and made the change, but it's better not
to ask maintainers to do that.

Thanks,

jon
