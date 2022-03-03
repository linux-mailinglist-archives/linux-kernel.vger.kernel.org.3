Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AA54CB92F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiCCIge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiCCIgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:36:32 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9F313DE02;
        Thu,  3 Mar 2022 00:35:47 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 533612B0025D;
        Thu,  3 Mar 2022 03:35:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 03 Mar 2022 03:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=atfxuid6e0L2hecp7
        attQXvPKmB6bGaKLyrJYHTr/dU=; b=DTsFBzSKEjzfDla//Pr0bprESm1H5jLIn
        lpW76snRUIOeG5sLR+37XtEcEUgvz7aJbp+j1Sl2d+v1Im9nHGHI4H2b2CXqR5o+
        PboPnPV2s6L4XCSfbVUEYAXREHDY7HZ2a7llI+0jlrFzulNkZX+9YgBbt1TwqHIw
        3h1wL8GX0wTTi7z32x3fTSbA7odkE8GZFRyOUp/WogvfIA97HoDF3Xez+SVnJXzb
        BzjdjccIn7LZn1s31iTrnpDQmZOw/Zpe/WejW+2BwBhYT6XYfHNRWmkCWpBNesAU
        upqgMLezCtReekEhrZQBsvx/jfwCwdtDIUYRFCTpy8ALX6pl/uk2A==
X-ME-Sender: <xms:330gYvmVuFWompH0N8GPsdbsfdyk1z6Y3VwKPmOOYB1BQQsm4XBNxg>
    <xme:330gYi2t182I-mgvweKhIQ38DHTGLDKr8qjOEruN63rZXT3vuFbb00hFDg0BuySSd
    ukVnORiZVibyk6oG0k>
X-ME-Received: <xmr:330gYlqCRw1Si4zaWjbs3ArMUvgjpQry9ij5_sYPpQ-Um_iffvAS5WqaTcgRNt9mOLjesMoH28z2ve4raWuTs1v0oXBMEvwdX5I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddthedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpefgtdegudfgheehhfeugeeffefhvefgjeevffegfeduffdugeekkeffffej
    jeehtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieek
    khdrohhrgh
X-ME-Proxy: <xmx:330gYnnIamJb1Mmv0EFPliA3N07S8ejNbeT0zaqVdpsVSuEOK0CYAw>
    <xmx:330gYt3VY9GU1C3Hlyvs-1xN6QhLrs8pyNjbzVy--ModPBzZmpsFtQ>
    <xmx:330gYms5SSizU6GFcJW-ttjBXL2Hw2_dXpfL9CY7i6rI9nbE2EHXfA>
    <xmx:330gYrPVyu_93Arj84MiOEUzNIYTTbD5fy-LIwvfch9JD6CYOOd7xPY4GcQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Mar 2022 03:35:34 -0500 (EST)
Date:   Thu, 3 Mar 2022 19:35:25 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Tom Rix <trix@redhat.com>
cc:     Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, Konrad Kleine <kkleine@redhat.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
In-Reply-To: <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com>
Message-ID: <233660d0-1dee-7d80-1581-2e6845bf7689@linux-m68k.org>
References: <20220127151945.1244439-1-trix@redhat.com> <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org> <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com> <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com> <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com>
 <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com>
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


On Wed, 2 Mar 2022, Tom Rix wrote:

> >>> Long term, it would be good have a reliable way to automatically fix 
> >>> either new files or really broken old files.
> >> That's really a maintainer preference no?
> >>
> >> Especially so for any automation.
> >
> > In practice everything is up to the maintainer.
> >
> > If some maintainer wants fix their formatting then clang-format should 
> > just work
> >
> > It isn't likely they will have time to hand fix every file.
> 
> A follow up issue in the clang project has been raised by Konrad, here
> 
> https://github.com/llvm/llvm-project/issues/54137
> 

Why request a "leave" option for every style rule? Why not just a "leave" 
option for the most contentious rules?

The response from the developers that anyone who wants to leave existing 
code unmolested by certain rules should "wake up and smell the coffee" is 
obnoxious, IMO.

Presumably clang-format must grow until it has sufficient program logic 
and config options to cater to every exception to every rule. How long 
will that take? Some carefully chosen "leave" options might make the 
program much more useful in the near term.

> Tom
> 
> 
> >
> > Tom
> >
> >>
> >>
> 

