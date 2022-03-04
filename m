Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5560D4CCF3D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbiCDHsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbiCDHsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:48:04 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54C6194161;
        Thu,  3 Mar 2022 23:47:17 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 0A3102B001D7;
        Fri,  4 Mar 2022 02:47:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 04 Mar 2022 02:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=JFmveES9yGraX8tcj
        DkZfjs9hZsHUkbzqHVDGYMDG+0=; b=bq8QbjhFSiTRXSpG6SIKROYvFt/3W6M4c
        5CV3tDTrUoA1J482bDNdXZjDdwhc6f5h2ucr23D24AWw4Wp6pA6K9L/1lsUCbgth
        DjcdNgcljNZGXMYFSM1E2Ta1KRe4gzsp5gN+IiU5RAomsF7LJmhMCIow5dAZI23J
        TFEmp3vAD2NzP7qhkP+9wfRBx7Oo8T/GJGfP0NXqlOyzaBkIvr5YSBdybksEZSk8
        lWHyTlH8+fSvcKGjq0NN1SofajUb6YXN7GLcpH7lOCmaRKRZSzw5DDkr5VOo/Npp
        MnlAaLFYaQuQ9/8SHATYHt3EOXe++snxcUBTTJPVblxW1mJi5+FBA==
X-ME-Sender: <xms:AMQhYqzEdc1-jX8s308ofiOWQM-0jSnh4VUhISpWPx9OOqlGeaoMfQ>
    <xme:AMQhYmRhXQicOf3qF4LugcgXBJYsrNWpgSZ50hKUpDNOZ193VdRlcyJXP6w4dGBx-
    Y9pKoOTsSQ6bm37YKI>
X-ME-Received: <xmr:AMQhYsWn0uxdaPehSQ26qh5LBezBJw8SC9nKA3GH2wOTArUTTomrhN-dUUodh5dwvwVmUsQFcD-ktdOyLoizJzAl_OfCcwZ7HSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtjedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeffudfhgeefvdeitedugfelueegheekkeefveffhfeiveetledvhfdtveff
    teeuudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:AMQhYgjZ69wZsVi294Sc0s1Dd4NOZBq2AJueI-IpcFeNZTLabmVY4g>
    <xmx:AMQhYsBcDDXE4HZvE0QkB_qV4TMRptBoM6Ct8vuOttXSZknYjSbgug>
    <xmx:AMQhYhKafjOrhv9lEK06EGwKXTLyCfVgnLYvD9viD5UEflHrkTCkQw>
    <xmx:AMQhYgwTuB5Fs3ylXV5myNO1XmcJ0VWzqO3Xyq04uzrAKdf_JWhE8iY2RGA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Mar 2022 02:47:09 -0500 (EST)
Date:   Fri, 4 Mar 2022 18:47:06 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
cc:     Konrad Wilhelm Kleine <kkleine@redhat.com>,
        Tom Rix <trix@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        megaraidlinux.pdl@broadcom.com, scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
In-Reply-To: <7368bc3ea6dece01004c3e0c194abb0d26d4932b.camel@perches.com>
Message-ID: <1dccb035-5f85-d9fd-7c10-3f9cd395deeb@linux-m68k.org>
References: <20220127151945.1244439-1-trix@redhat.com>  <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>  <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com>  <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>  <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com>
  <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com>  <233660d0-1dee-7d80-1581-2e6845bf7689@linux-m68k.org>  <CABRYuGk+1AGpvfkR7=LTCm+bN4kt55fwQnQXCjidSXWxuMWsiQ@mail.gmail.com>  <95f5be1d-f5f3-478-5ccb-76556a41de78@linux-m68k.org> 
 <CANiq72kOJh_rGg6cT+S833HYqwHnZJzZss8v+kQDcgz_cZUfBQ@mail.gmail.com> <7368bc3ea6dece01004c3e0c194abb0d26d4932b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022, Joe Perches wrote:

> On Fri, 2022-03-04 at 00:17 +0100, Miguel Ojeda wrote:
> > On Thu, Mar 3, 2022 at 11:44 PM Finn Thain wrote:
> > > 
> > > Others might argue that they should always be changed from,
> > > 
> > > /*
> > >  * this style
> > >  * of multiline comment
> > >  */
> > > 
> > > to
> > > 
> > > /* this style
> > >  * of multiline comment
> > >  */
> > 
> > In general, for things that the coding style guide talks about, we 
> > should follow them, even if some subsystems do not (they can always 
> > override in their folder if they really, really want it). So, here for 
> > instance, the first one should be used.
> 
> It's up to individual maintainers to each decide on what might be 
> considered unnecessary churn for the subsystems they control.
> 
> One argument is that churn leads to difficulty in backporting fixes to 
> older 'stable' versions.
> 
> I think the churn argument is overstated.
> 

If you would have clang-format override the committer and retrospectively 
apply subsystem style rules (rather than the rules used by a majority of 
subsystems or those preferred by Linus for example) it would add friction 
to code re-use, movement, comparison, any tree-wide program 
transformation, and also subsystem boundary changes.

Per-subsystem style rules are inherently contentious and therefore good 
candidates for the "leave alone" functionality discussed in the issue 
tracker.
