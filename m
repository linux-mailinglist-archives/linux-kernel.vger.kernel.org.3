Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4E24CC95C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbiCCWpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbiCCWpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:45:09 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD04F15C1A7;
        Thu,  3 Mar 2022 14:44:21 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6E5225807C5;
        Thu,  3 Mar 2022 17:44:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 03 Mar 2022 17:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LJYVvuKLawnkE6Wm/
        j6OKnAtK1dk2wwP7VL303McoIQ=; b=HHiFURfSb0KxCAm5OFX1e4gkqvdZqugiY
        xWJkml7nJNE0fPPncMw3UCvlzaG/5rEDOleTqYWfBy4Y/Vh4BU1Hdc+iECf3Le5B
        pTj4f0sxGYl5B1ogjKd2V054S9P+8LULe4X//FWdkEonYD4gVDVYNqCp/9BPr0Cv
        onaCbkbLHUikPTpltEXJQFWEl9qO9USnoglYdbpJXwS4TdlmKoiT3QS+ckiWndE6
        LADM1iWhAc/D8R/pAHDkPGUAraFcHa+0+I7zgg+z10x+BJ18suivOuZg1lquiPJJ
        wLKArw2GFmRH5TbmQUxN/4mqQNKmserUyMyghIcCxBmK9F95cXYJA==
X-ME-Sender: <xms:xEQhYsVxE1kne7ZxLY-qmuMx7ZcY_hccE4XVb7csyokdT9BHTccDIg>
    <xme:xEQhYgmLEGVgxjdvitlkAn1MB7MLAk8qDVhi6a80sqwCl0qZNQgfMDTittmtLJCCH
    GxI8pRC726c7F_NdSs>
X-ME-Received: <xmr:xEQhYgahodaUoRYauOkc_RsnyRtXoWMwSLyVL783iN7KJBmSYrHw_BzO_9dDKU-M9K4KKhdqrQx-W4nW4Fk-XvupSFRupkJ7r6E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtjedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffetffekiefhfeevfeetuedtteeugeelhedvueejhefftdejieduleetffev
    ffeunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhn
    sehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:xEQhYrVf6IN6ExMECwgmw9jiG8TK8bABA4Yi-6Zttqa75jcPWjeuRw>
    <xmx:xEQhYmkiDV0yHjuPBZiQ9CzM88bU8SYEmJynDR2180EWXP_-srbQgA>
    <xmx:xEQhYgeZNLONre-W8j-kx_o8XyipnWAMDt0v2bPXfe-HaXiJkIlONw>
    <xmx:xEQhYh_m2iWGgNaLOM_GrHtuLQUTNbBit7cHU5jXuHknAidBjj8zJw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Mar 2022 17:44:17 -0500 (EST)
Date:   Fri, 4 Mar 2022 09:44:12 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Konrad Wilhelm Kleine <kkleine@redhat.com>
cc:     Tom Rix <trix@redhat.com>, Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
In-Reply-To: <CABRYuGk+1AGpvfkR7=LTCm+bN4kt55fwQnQXCjidSXWxuMWsiQ@mail.gmail.com>
Message-ID: <95f5be1d-f5f3-478-5ccb-76556a41de78@linux-m68k.org>
References: <20220127151945.1244439-1-trix@redhat.com> <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org> <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com> <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com> <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com>
 <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com> <233660d0-1dee-7d80-1581-2e6845bf7689@linux-m68k.org> <CABRYuGk+1AGpvfkR7=LTCm+bN4kt55fwQnQXCjidSXWxuMWsiQ@mail.gmail.com>
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

Hi Konrad,

On Thu, 3 Mar 2022, Konrad Wilhelm Kleine wrote:

> On Thu, 3 Mar 2022 at 09:40, Finn Thain <fthain@linux-m68k.org> wrote:
> 
> > On Wed, 2 Mar 2022, Tom Rix wrote:
> >
> > > >>> Long term, it would be good have a reliable way to automatically 
> > > >>> fix either new files or really broken old files.
> > > >> That's really a maintainer preference no?
> > > >>
> > > >> Especially so for any automation.
> > > >
> > > > In practice everything is up to the maintainer.
> > > >
> > > > If some maintainer wants fix their formatting then clang-format 
> > > > should just work
> > > >
> > > > It isn't likely they will have time to hand fix every file.
> > >
> > > A follow up issue in the clang project has been raised by Konrad, 
> > > here
> > >
> > > https://github.com/llvm/llvm-project/issues/54137
> > >
> >
> > Why request a "leave" option for every style rule? Why not just a 
> > "leave" option for the most contentious rules?
> >
> 
> Getting to the point that every style option can be disabled 
> individually is not an operation done in one go. I plan on presenting 
> the changes required to exactly one style option and from there I'm all 
> ears if you have style options that you consider "contentious". 

Sure, I'll provide an example of that below in case you're interested in 
what I happen to find contentious. But this isn't about my taste.

The issue is really about removing an obstacle to wider adoption of 
clang-formt. Therefore, shouldn't you be asking, what style rules have 
already proven to be contentious within the project?

You can look to kernel subsystem style rules for examples of that. E.g. 
some might argue that comments should always be left unmolested (where 
they exist for the benefit of human readers and not tooling).

Others might argue that they should always be changed from,

/*
 * this style
 * of multiline comment
 */

to 

/* this style
 * of multiline comment
 */

For another example, the mailing lists recently saw another style rule 
difference between subsystems:
https://lore.kernel.org/all/20220301055231.GI2812@kadam/

Joe said, in effect, "leave" whereas others seem to have different views.

Finally, here's an example that I personally found contentious. 
drivers/scsi/NCR5380.c line 2306:
		dsprintk(NDEBUG_ABORT, instance,
		         "abort: removed %p from sense queue\n", cmd);

Note the spaces (for alignment) following the tabs (for scope). I mention 
this example not because I expect the world to "wake up and smell the 
coffee" one day and embrace spaces-after-tabs.

I mention it because I expect the tabs/spaces/both issue to remain 
contentious indefinitely (within any sufficiently large project).

I can think of another good example (line wrap) but I'll stop here.
