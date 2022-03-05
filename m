Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1E4CE269
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 04:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiCEDXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 22:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiCEDXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 22:23:19 -0500
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5741410D6;
        Fri,  4 Mar 2022 19:22:29 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 3651C2B00280;
        Fri,  4 Mar 2022 22:22:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 04 Mar 2022 22:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=g2DFTZBQJCQ8omAwV
        T2kyLVqv1zNBk5+KkcL67mGkNs=; b=ihlX5LX0de4QxBmUnvzMaSNTIzRzf/Vye
        b6ZdkscFcp5bbs+8Y2eemX5X0MeaKIl2aHi5okdZjX+JzIapbxQmc9He3Y22MWWP
        Qppn7uYug4c/DK0siXYY8XLSAl6Ui98TV4Om+eWAtoNduH+Z+wmLq24Lni+FNStv
        70WQqS4G/eQk0IDYFeGY1Ou7yMeqFewNV8FmcGELnOlA4rvE+TmISW5JBHSbLL+w
        1vtT7BB4Xhdr2VMVvguVmoNcHIzIwy7XgbiHFeubg8zO6e22hBvUG/9oQQmbB+/f
        X05yXFGWA+TtDystE9iS2TSlP+ghNUPMViSsoiUFcrlmvRJkBufJg==
X-ME-Sender: <xms:ctciYkrU_RS-bXxEK1vvFyR6naEa73rQsU7kZ2WTAeJtXBB2Vtziug>
    <xme:ctciYqr7-yQAgA7WeOxf5TYISAqG5b54qCro7IaHKEdu7o17uVMdh7eYsJRdnYQzy
    6bqST0AughCum_WIQU>
X-ME-Received: <xmr:ctciYpM7fYfcVMTxXReQ-cyNqn6sStd7fq02Lfx3x0-pr8hRVAd9AvCw_3kX_VAX1CwVGXjT-Go0xMlHDE21AGXQ3XRx7tY-5rQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtledgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffduhfegfedvieetudfgleeugeehkeekfeevfffhieevteelvdfhtdevffet
    uedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:ctciYr7bP95dRCHmluDelJX5nvDmO2VTTQdEnYkXwICuSFUvPPAp9A>
    <xmx:ctciYj4ICZSk8SJXAnxS-JxNCLYaexDkXTCiM43bJyp_P5leRcGosg>
    <xmx:ctciYrjSTgNS5YFPzGZJug3pjyeMQa-3C2wxcX8jDmdYHsB4wOk8rw>
    <xmx:ctciYqL8axDzoAXF3z0gezA8B5j8MDuChQybtEXuDsvNy_yrrgWich4SaPY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Mar 2022 22:22:23 -0500 (EST)
Date:   Sat, 5 Mar 2022 14:22:17 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Bart Van Assche <bvanassche@acm.org>
cc:     Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Konrad Wilhelm Kleine <kkleine@redhat.com>,
        Tom Rix <trix@redhat.com>, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        megaraidlinux.pdl@broadcom.com, scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
In-Reply-To: <e7e99791-aade-55fd-ac75-71478699cbe0@acm.org>
Message-ID: <714bb187-f87-39b7-19a1-f45e95699ba0@linux-m68k.org>
References: <20220127151945.1244439-1-trix@redhat.com> <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org> <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com> <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com> <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com>
 <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com> <233660d0-1dee-7d80-1581-2e6845bf7689@linux-m68k.org> <CABRYuGk+1AGpvfkR7=LTCm+bN4kt55fwQnQXCjidSXWxuMWsiQ@mail.gmail.com> <95f5be1d-f5f3-478-5ccb-76556a41de78@linux-m68k.org>
 <CANiq72kOJh_rGg6cT+S833HYqwHnZJzZss8v+kQDcgz_cZUfBQ@mail.gmail.com> <7368bc3ea6dece01004c3e0c194abb0d26d4932b.camel@perches.com> <e7e99791-aade-55fd-ac75-71478699cbe0@acm.org>
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

Hi Bart,

On Thu, 3 Mar 2022, Bart Van Assche wrote:

> On 3/3/22 15:38, Joe Perches wrote:
> > One argument is that churn leads to difficulty in backporting fixes to 
> > older 'stable' versions.
> > 
> > I think the churn argument is overstated.
> 
> I'm often backporting patches to older kernels and I think the churn 
> argument has not been emphasized enough. Backporting patches is a normal 
> aspect of a product lifecycle since a kernel version is chosen when 
> development of a product starts and bugfixes are cherry-picked from 
> upstream selectively.
> 

That should not be an issue. One of the benefits of having a canonical 
form for source code is that you also get a canonical form for patches.

Let's say you receive a patch (or wish to cherry-pick one) that could be 
applied to your backport branch, except for superficial changes that cause 
a (canonical) patch to be rejected.

In principle, you can still apply the patch automatically. You "only" 
require a canonical reformatter that preserves line numbering, and a tree 
close to the tree on which the patch was based.

The process goes like this:

1. Checkout base tree
2. Reformat all the files mentioned in the bad patch, but confined to 
   those lines that appear in the patch.
3. Apply the patch and commit

Finally you'd cherry-pick that commit for your backport branch.

In case you receive a patch that's whitespace-damaged, you can do this 
first:

1. Checkout base tree
2. Damage all the files mentioned in the bad patch
   $ perl -i -p -e 's/\s+/ /g' ...
3. Do the same to the bad patch
4. Apply the bad patch
5. Reformat the files changed by the patch into canonical form
6. Tag that as "B"
7. Checkout base tree
8. Reformat the same files into canonical form
9. Tag that as "A"
10. Produce a good patch
    $ git diff A..B

You can now apply the good patch to your branch. Since it is in canonical 
form, it may still fail to apply (but see above for the solution).

This second example is not really a job for reviewers/maintainers but it 
could be performed automatically by tooling like patchwork.
