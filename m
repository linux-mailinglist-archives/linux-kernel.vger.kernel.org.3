Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84C8560EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiF3CEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiF3CEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:04:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2045B3B571
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79AD7B826A8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA3BC34114;
        Thu, 30 Jun 2022 02:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656554688;
        bh=GtdBoKOokWarrldoZgOzYh8XTSyehxtzazmyNXJqCkQ=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=KhGs07lKCOcrjUU6P9heOO6gYVdTcQ2eI1H5AXZ158zVRUuohGBRYgGKeHL1Ojdm6
         GOjswBoP5zyW+rCnlMIlYgRoxoRd/Pk8XsP2sioMgQg4oA3zxXCy4TqwO3r8dMG7ut
         3HaYatALZYJ/ve9Mj9Y/laE99036uz7XesrFK8lKL52lryZY55R8hkGKvj4b3AlvyR
         V33BQXKH0GxZDd/Aie6csR7tfFmr3lNlwQ3c3ytTdSATJ6lg/CEU7p+tVjt62jrAMO
         QkeEUeV5MD7Lg+RWpTf/GqkkuaCaWDhun2fjvZ8OWocf7FfuK7Iy/qhVhG1rtREnF/
         I0YavpE19z20g==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8161327C0054;
        Wed, 29 Jun 2022 22:04:46 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Wed, 29 Jun 2022 22:04:46 -0400
X-ME-Sender: <xms:vgS9YkxTN1Ukp9SkWWpJcIeDZrlMAK0z1yymT-rj2kUDIHXSBLk-dg>
    <xme:vgS9YoTbavcxeMeJ0lMH4OmChdLJKZXHs22gacFmz5fsZuBZpl9zGs_8kQppzy_8p
    ztg19dvrWSAbzxkLEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehtddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:vgS9YmVnyCZEaM6Ro9gX8I1Vic9Ve9XbkU92UG8hgpWJOSv0z1OvPQ>
    <xmx:vgS9YigwOLyUK5KTFnx7edr5bcWV4DXC-AXFfmHdy7welai1U3oliw>
    <xmx:vgS9YmA1VPBDksrXmEvRv1xA0R0lENqU0PwICJDDHgSgxg0vdqjlRQ>
    <xmx:vgS9YnKZBbfiR-uTKFFs_GDft8tJjr0L7YTVHdbl4n-MyvWFVT_UKg>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1EAD331A0062; Wed, 29 Jun 2022 22:04:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-713-g1f035dc716-fm-20220617.001-g1f035dc7
Mime-Version: 1.0
Message-Id: <5a92ba37-69ae-477e-9747-315d41d3206e@www.fastmail.com>
In-Reply-To: <20220616165413.c35yliaxbxvmwsqw@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
 <c3b4f3ccf8ee547a588bf8a971064e4d62b6a44c.camel@intel.com>
 <20220610180635.l44opq2votd3gxpl@black.fi.intel.com>
 <5b56c88e477d879e5a0e3c15627cb05901a812f4.camel@intel.com>
 <dda083610d4c8b8d8d0b09021345e9cc0cb35bbe.camel@intel.com>
 <5d3b281f-3d8b-4bbd-9681-b226810c3e8b@www.fastmail.com>
 <Yqr7mzvX1+hWM8NL@hirez.programming.kicks-ass.net>
 <20220616165413.c35yliaxbxvmwsqw@black.fi.intel.com>
Date:   Wed, 29 Jun 2022 19:04:24 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kcc@google.com" <kcc@google.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Content-Type: text/plain
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Jun 16, 2022, at 9:54 AM, Kirill A. Shutemov wrote:
> On Thu, Jun 16, 2022 at 11:44:59AM +0200, Peter Zijlstra wrote:
>> > get_nr_threads() is the wrong thing.  Either look at mm->mm_users or
>> > find a way to get rid of this restriction entirely.
>> 
>> mm->mm_users should indeed be sufficient here.
>
> Hm. kthread_use_mm() doesn't bump mm_users. Do we care?

I think the idea is that the kthread in question is expected to hold an mm_users reference. 

>
> -- 
>  Kirill A. Shutemov
