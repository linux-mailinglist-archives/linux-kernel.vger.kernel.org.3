Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45A35A7CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiHaMN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiHaMNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:13:25 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FA9D2769
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:13:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D8463580469;
        Wed, 31 Aug 2022 08:13:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 31 Aug 2022 08:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1661948000; x=1661951600; bh=PwHKpVPJmM
        UmUrzEC5wfEwU2vtgowOlvFWw9meu7ZZI=; b=LnQqu8M2MveQUmyS+/mKijGNEZ
        LvA1dXxbxJ5tbX8N7d5ECV86C6tCcYUvSm7qbdusUJZczGN+O276+pTomUqApjYc
        2iDIzyCJw57HNp4k5oew9PCTBl4U6XGh4HfFLkMgxs7xfs/N32MHV1JvuYdClnTG
        gZVx5Jovcgvk79mmUaEI+ovyXtHPCbtojR/6ZmFfC9fiE9MbhC+LHs5e1qktbRj3
        oInoXOk2+AWsJRNNTgbuuqlrP/rxN3on+Ziy+YbvI7LFzOktv/75PlYoWqr+v/8t
        eznmjPvhQQ/sXgrJ7GbB3AjNg/fyXqP6xqaguqjAUb/KNIoPv3f8wcyxDuSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i56a14606.fm1; t=1661948000; x=1661951600; bh=PwHKpVPJmMUmUrzEC5
        wfEwU2vtgowOlvFWw9meu7ZZI=; b=JulZysPIyyY6WOOwRIu/Dzy6xwpTz6y+C9
        q4OioxpJwBb2rStOMqN3hfKZ+CnFOnGdgembcokJNJ/lFXrKfwu7QK0BDw5m+Tje
        +gp2c4yO+YeVNlHA25CWbDhj1LEfD1EJAU/yAJ4yK/9K29qXeFY0drrz+2X2VUuz
        X7aFoO9jGvsbAl//27gZQzBwKadANCClBHNdOwSg+wZttvxW3uDdNn9yJJKGIdkV
        0JX5pwsoWuDl6gb3mGVS0ef/ZFAHGiixiRFz3VOTnrKicox47QU5897yrN+xCkZZ
        bUcLKmyCI0R8CY9JtlwJKZgz9Y+pAhvfYDgtg2XCOjstN1UjI49A==
X-ME-Sender: <xms:X1APY6JfgN_PcfNrF-bVdDD_lTXUtXNSGxLQi_YVqOfLdEGAwX5IgQ>
    <xme:X1APYyJg4mzXcGraDVa6ucFLj1zJ32id5xXd9G3A0xVeIjuhi_hUdq__Jc1Iq7NfC
    Sz91hqUOWrDQNuOyeI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekiedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:X1APY6vSedG5ktQePDJKhpYYdtNpEl25bCvd-9ifk2f8dlFXLErOoA>
    <xmx:X1APY_bAq2htx5EfBG_j3WFjDREYqgnndq7r8H4LiFlj116fQdFg9w>
    <xmx:X1APYxbxiVPkDLEtx5MzrZzyWuvMzvGr-KKVXbX_ShcIilkGf2q1dg>
    <xmx:YFAPY-LyF5BNHAta84pdv5r1wXRl8eruHHZg1KQqDzd-PwZmkZ2A5Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 360BEB60083; Wed, 31 Aug 2022 08:13:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <b48f5edd-7f6e-48e3-9f72-61cd8e1a21e7@www.fastmail.com>
In-Reply-To: <20220831041731.3836322-1-yuzhao@google.com>
References: <20220815071332.627393-1-yuzhao@google.com>
 <20220831041731.3836322-1-yuzhao@google.com>
Date:   Wed, 31 Aug 2022 14:12:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org, "Yu Zhao" <yuzhao@google.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Aneesh Kumar" <aneesh.kumar@linux.ibm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Hillf Danton" <hdanton@sina.com>, "Jens Axboe" <axboe@kernel.dk>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "Michael Larabel" <Michael@michaellarabel.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tejun Heo" <tj@kernel.org>, "Vlastimil Babka" <vbabka@suse.cz>,
        "Will Deacon" <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        page-reclaim@google.com
Subject: Re: OpenWrt / MIPS benchmark with MGLRU
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022, at 6:17 AM, Yu Zhao wrote:
>
> Rational
> ========
> 1. OpenWrt is the most popular distro for WiFi routers; many of its
>    targets use big endianness [1].
> 2. 4 out of the top 5 bestselling WiFi routers in the US use MIPS [2];
>    MIPS uses software-managed TLB.
> 3. Memcached is the best available memory benchmark on OpenWrt;
>    admittedly such a use case is very limited in the real world.
>
> Hardware
> ========
> DUT: Ubiquiti EdgeRouter (ER-8) [3]

I don't know if it makes any difference to your findings, but
I would point out the test hardware is neither representative
of most devices supported by OpenWRT, nor those on the amazon
best-seller list that I see looking from Germany:

Five of the top-10 devices on that list are arm64 (little-endian,
hardware TLB walker, typically 512MB of RAM), the others are
mips32 (typically only 128MB, mostly single-core) and only
the oldest one (Archer C7) of them is big-endian. I would not
expect endianness to make any difference, but the 16x smaller
memory of typical mips devices (ath79, mt76) might.

       Arnd
