Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87FC5303CA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 17:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347828AbiEVPUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 11:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiEVPUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 11:20:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214EA13F09
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 08:20:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1D5260FDE
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 15:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A365C385AA;
        Sun, 22 May 2022 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653232832;
        bh=SWE2SZXviYHJb3fNQDeOWauK0tH4udqCDq6KTNopSuk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=u0EraHkQKmwe76AVYlZ0QfFV8bz81Y0Xn88jmW9xTwq/MYOIr8yX8GccCYsqSNaGw
         pwASnPM2tFRwqDKACDXopjG4S2P61OGaygxKZJlYudBYbKfZA0ih7OyrkI+S8LrPEJ
         596u00mcHY/sK6Ohk63lJBz9uJ39Tfv4sAZFrnvL/zQirpDn9t8HlUegQFZiShbKbh
         U3T7/gXHf+MUt+uJ1FaAOnMdhG5AQznNuWcfRsIe9ImcV9AVkCi6tv2JHtbVkOLN0K
         WxAuylUp8210t8kldxltmGJMzU7mWepZEwn+0/ndU3Wn68TMJAW3sKlwtd96FvQzqQ
         yOpunhFwsmqUg==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id F031A27C0054;
        Sun, 22 May 2022 11:20:28 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Sun, 22 May 2022 11:20:29 -0400
X-ME-Sender: <xms:ulSKYpF8tqYGarKUwR_XWMcOABhsH8bH0k4pfn6q5nwHGvuWuNPZTA>
    <xme:ulSKYuVrP8vQ-Rfe-0ktCjsIj0sUB0bmC-roX2-MJze3aIZ8VjlO_khzVcN5HoUcS
    NkpZAtnhXguNirLI1I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrieekgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudevffdvgedvfefhgeejjeelgfdtffeukedugfekuddvtedvudei
    leeugfejgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:ulSKYrIGbYkWolY_VIGHitGUrYBda-75WuihnM-LPsQavBC3BPt6Dg>
    <xmx:ulSKYvExa0Q4tzQQJycXeiZ5769tHBDP6yT7rSer0NDy7uOro6wmHg>
    <xmx:ulSKYvWN8rSa_CVZs6ValpcRz0e7wBrKznnFGGsOLzE9ORLTs2YOHw>
    <xmx:vFSKYtfZfRkbxQTZ3SNBki4GZ5TUp5qjuJc_ovowYHlMvaop9AzAnTG8ozE>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BE05431A005D; Sun, 22 May 2022 11:20:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <c82ac102-7935-4b07-9d8c-82a2efe59956@www.fastmail.com>
In-Reply-To: <YomERsAM3gF7XxRZ@casper.infradead.org>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <d1810538-9b4c-7f19-852f-7f6d255533c7@redhat.com>
 <YolHr1GwfA++i9jj@casper.infradead.org>
 <64d0da08-6ffd-4bce-bc66-5097913937b4@kernel.org>
 <YomERsAM3gF7XxRZ@casper.infradead.org>
Date:   Sun, 22 May 2022 08:20:05 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "David Hildenbrand" <david@redhat.com>,
        "Chih-En Lin" <shiyn.lin@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        "Christian Brauner" <brauner@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "William Kucharski" <william.kucharski@oracle.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Yunsheng Lin" <linyunsheng@huawei.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Suren Baghdasaryan" <surenb@google.com>,
        "Colin Cross" <ccross@google.com>,
        "Feng Tang" <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Daniel Axtens" <dja@axtens.net>,
        "Jonathan Marek" <jonathan@marek.ca>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>,
        "Peter Xu" <peterx@redhat.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Kaiyang Zhao" <zhao776@purdue.edu>,
        "Huichun Feng" <foxhoundsk.tw@gmail.com>,
        "Jim Huang" <jserv.tw@gmail.com>
Subject: Re: [RFC PATCH 0/6] Introduce Copy-On-Write to Page Table
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, May 21, 2022, at 5:31 PM, Matthew Wilcox wrote:
> On Sat, May 21, 2022 at 03:19:24PM -0700, Andy Lutomirski wrote:
>> I can see a rather different use for this type of shared-pagetable
>> technology, though: monstrous MAP_SHARED mappings.  For database and =
some VM
>> users, multiple processes will map the same file.  If there was a way=
 to
>> ensure appropriate alignment (or at least encourage it) and a way to =
handle
>> mappings that don't cover the whole file, then having multiple mappin=
gs
>> share the same page tables could be a decent efficiently gain.  This =
doesn't
>> even need COW -- it's "just" pagetable sharing.
>
> The mshare proposal did not get a warm reception at LSFMM ;-(
>
> The conceptual model doesn't seem to work for the MM developers who we=
re
> in the room.  "Fear" was the most-used word.  Not sure how we're going
> to get to a model of sharing page tables that doesn't scare people.

FWIW, I didn=E2=80=99t like mshare.  mshare was weird: it seemed to have=
 one mm own some page tables and other mms share them.  I=E2=80=99m talk=
ing about having a *file* own page tables and mms map them.  This seems =
less fear-inducing to me.  Circular dependencies are impossible, mmap ca=
lls don=E2=80=99t need to propagate, etc.

It would still be quite a change, though.
