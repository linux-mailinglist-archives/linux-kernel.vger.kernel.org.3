Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E29D4B7B55
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244843AbiBOXqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:46:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbiBOXqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:46:45 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C80B7D1;
        Tue, 15 Feb 2022 15:46:33 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5046A35F;
        Tue, 15 Feb 2022 23:46:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5046A35F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1644968793; bh=MNWowirlgRREMQi3jxNT3zqanigNKlLDCr1BaueZGO4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ppRtWmuIWeldUwDZIVU+63mrxI045OAz7yBYj9O8sgifrarXkU53/7rh2yjyzhTB/
         ikP1XObawNHu7WaSo5LAm+d5i1H544sHvmvt/M3hsV+6p0Na9V3dDpH/uv/5XZZv0m
         FhydAKI9wLe7jIuV4JCT7ezl9eHeXyUOLwio7up6o3F8elApVlPDwcjHpZudax8lkz
         CJaYLHeby4yJH1KiG0k02OBABaKy+Un/d6DqZSRVeMnaSwvMFqzpPG7higdba/9D3F
         5Px8oZgIDC+apd1BWu5qCpgbnXDX69SxTo7w7newlgpTkDH2v1LgI/5Hl3Gw1AQLB9
         D8L54k0UXIv4g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 0/5] docs: pdfdocs: Improve LaTeX preamble (TOC, CJK fonts)
In-Reply-To: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
References: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
Date:   Tue, 15 Feb 2022 16:46:32 -0700
Message-ID: <87zgmr66cn.fsf@meer.lwn.net>
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

Akira Yokosawa <akiyks@gmail.com> writes:

> Hi,
>
> This is a follow-up series to the CJK font setting patch series [1]
> upstreamed in v5.15.
>
> [1]: https://lore.kernel.org/r/39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com
>
> There is still a lot of room for improvement in the layout of PDF docs.
>
> This series resolves issues listed below:
>
>  1. Some of chapter and section counts in Table of Contents (TOC) in
>     large PDF docs collide with chapter/section titles, e.g., Chapters 10,
>     11, 12, and 13 and Section 10.10 in userspace-api.pdf.
>  2. In docs of more than 99 pages, page counts in TOC are not aligned
>     properly when maxdepth >= 2 is specified in toctree, e.g., Chapters 10,
>     12, and 13 in userspace-api.pdf
>  3. In TOC of Latin-script docs, quotation and apostrophe symbols look too
>     wide, e.g., Section 2.2 in userspace-api.pdf.
>  4. In TOC of translations, Korean chapter titles lose inter-phrase spaces.
>  5. On systems without "Noto Sans CJK" fonts, CJK chapters in translations
>     results in full of "TOFU" boxes, with a long build time and a large
>     log file containing lots of missing-font warnings.
>  6. In translations.pdf built by "make pdfdocs", ascii-art diagrams in CJK
>     are not aligned properly.

I've applied the set, thanks.

I do notice that Documentation/conf.py is getting large and
unapproachable.  At some future point, it might be nice to pull all of
the latex stuff out into a separate file where it won't scare people who
stumble into it by accident.

Thanks,

jon
