Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC9247546F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbhLOIoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:44:08 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37337 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231561AbhLOIoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:44:07 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D9675C0508;
        Wed, 15 Dec 2021 03:44:06 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Wed, 15 Dec 2021 03:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=plWu3ASybl5B1dQgYp4u8NdNa2AM
        b3bA+lObzK3DwaQ=; b=cBz5hYSvsUjHQhIePzcBZc/bBZ4W1aADKNuNxj1kDzfx
        6G9kfaweAvcb8PGET/C6Wv1VI2JQ0QULK+uxNn+Zx6KIbpNd1BHW8mfMrdhbFj4V
        gz9HtWRzJom38HquuZa2uJCiEQZ5pu7NAMjHUO9pxb5ChVUY3/0Z4M+eSyvFqF64
        ONlWSlRj2tfcFJ5Hi3zKO8lLuGAD/yv2bu/nbzPwx55+AZqVm7p8rESJh2enHiEC
        RKzXg3XuigYUzwpVGS5ve41O0GVD4d6W0KuPo/zQ2xtbKb1zeZbipQo5V911rPu8
        D3lXPrm5Up6KYqYli3/Aq++EL0idc1VubbhGIrhYog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=plWu3A
        Sybl5B1dQgYp4u8NdNa2AMb3bA+lObzK3DwaQ=; b=SPE7x4JjKomtPj4Zuz2hEu
        Ad7We6xF20DQGW7veXe+qiIxCL0o+aTpsvrxfudK/EBiTpR3QRxeNiUyveRY6X3s
        DOTtNUUzl4ifx4Pn2igvIhOgscy4RH5P+vT6hlytpEp4Bsn/tGgYgxhjrPPH8ERJ
        1CRUB8UWqzeWByrr+oH8j9Ob4DXgrS7U10CtDex1higS/XRSzlG9Q07UwFrAFnM3
        77XhfXyu8PcuXZmOrLKFbb/GxrPnQ57nas23jtBt6+m+XQv/WB/HYyXckaSCDe+y
        Ke/d9EdvjgP4ua/e9vtunhXoXOGGC3B797XdspjOk/Pm1EbI9jLLdsSXosjmJVHw
        ==
X-ME-Sender: <xms:1qq5YfO1Z6H0r6EnV_uesIvfdIDX1CPuBEKjJc2yThChsoDWhag9Cw>
    <xme:1qq5YZ_mmqTsF13tsndMVa6_CanuTupTrrzxCvXmGnR5p7OIZ178bj2IRJt-hm6np
    oasuUdbeeD4BssB2_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrledugdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:1qq5YeRjG7WMW-DKJy_6kaS9Wr6Em_X6OgzDhHrS3-i1_5_TdK1QTg>
    <xmx:1qq5YTvMe8u8WH3Vkz4NEh8mN34wYyo3uvkv48Q1gQB7KGaJEOtxTg>
    <xmx:1qq5YXe72ongrmMZu8QqOU1YcBfrycTgEFGg2egiCzTemCdi7kUhgw>
    <xmx:1qq5YYF4IRcJHs-r4N8Irvh371IEfQlrsWDT5mEB6bNm5evhftr-ig>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 65E35274042E; Wed, 15 Dec 2021 03:44:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4524-g5e5d2efdba-fm-20211214.001-g5e5d2efd
Mime-Version: 1.0
Message-Id: <072f4547-297c-40c6-852c-49d94a14583e@www.fastmail.com>
In-Reply-To: <caf8a7a4-bdb9-e1c9-871d-12c8d146376c@marcan.st>
References: <20211209055049.99205-1-marcan@marcan.st>
 <3fb087c1-2d67-4527-ad63-1f8ce54e6965@www.fastmail.com>
 <caf8a7a4-bdb9-e1c9-871d-12c8d146376c@marcan.st>
Date:   Wed, 15 Dec 2021 09:43:45 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH 0/2] Apple mailbox fixup: switch to generic compatibles
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Dec 13, 2021, at 04:55, Hector Martin wrote:
> On 10/12/2021 01.33, Sven Peter wrote:
>> On Thu, Dec 9, 2021, at 06:50, Hector Martin wrote:
>>> Hi folks,
>>>
>>> Just a quick fix for the Apple mailbox compatible. Similar to [1], we
>>> intend to use SoC-specific compatibles only for potential quirks, and
>>> rely on a generic compatible to allow for forward-compatibility as long
>>> as things don't break.
>> 
>> I vaguely remember a brief discussion about this and I think we thought about
>> using "t6000-asc", "t8103-asc" in this case since this specific mailbox hardware
>> was only introduced in the M1. I think Apple calls this variant ascwrap-v4
>> and m3wrap-v2.
>> 
>> Doing it like you suggested is also fine with me though.
>
> I think I remember that one... seems this is ascwrap-v4 in t8101 too, so 
> not quite introduced with M1. But that one doesn't have m3wraps (or 
> doesn't use them).
>
> Since Apple do have some kind of sane versioning for these it seems, 
> maybe we should follow their numbers and call them apple,asc-mailbox-v4 
> and apple,m3-mailbox-v2?

Sure, sounds good to me.


Sven
