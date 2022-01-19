Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B4F493541
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351900AbiASHJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:09:36 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49969 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230223AbiASHJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:09:31 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E91585C0051;
        Wed, 19 Jan 2022 02:09:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 19 Jan 2022 02:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=dsFZk3OV8wFHLwBUcIdejqKR+2u
        r7cWYhm0QCOUx9y4=; b=ldQ0dqI4JJPbTI7hYUcX4Ver9v0walFYsc6173VhOF2
        mFeIQOELr6sq4DbTIF6pIXUzZdUMaulLC+ggwDN52OgjgIVyU7sLg6JzsoRSGUU9
        7AG0Qp5lwvScjPRmkQteuZbD86wgo797zyDRlyRzgr3iFyyhtRatNlYH1mH1E8jn
        BulT21H+i7uSmqmwNgbrXCvec7jke7sZqAa9MbOz1Ceg0ySRU0yfy5Tag4kKbsku
        4GmVwYlaIj92FFec2WFoxpe8ytImTA8SlVhsvw5Z2HkaogLxwKLVtvIxV4JSpmyZ
        JID0BIIkguRq73UXY8KNqdltRXSNvbW6T8+eVrFb24g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dsFZk3
        OV8wFHLwBUcIdejqKR+2ur7cWYhm0QCOUx9y4=; b=Y7KYK+ScVvH/o1L+RwuK/C
        yWQe6IoPzmEbHjddN15rDgY7sl7Tg3z0e1ZvFLIWuWNoCY25qbPKAY9AcWggWcuM
        HRdUa7bCuZAoXKhFaf09jzNLtUJFF1OfBRw+INN0MPfOgySaV76fMmQW6QOcbpTu
        17bBeGFfzjr6PsTSFwW3WpJM9l7s7+x9wQSSy6hcF2Di1l1+i/EaH1563Inapacn
        Njjg0ysaDnoqRY7ZRIRnEUJMhz3JtCjEqs9ZGo8rmWtzjbj/Z9ONENZF+MvNkX9e
        3NN6z/CTiAlQwfQr/7qhLXeFmW66ah+HC/6kZhEf5ssYLmEPbRP0hs2SkuRKdmSw
        ==
X-ME-Sender: <xms:KbnnYdRz1zBKoi9DPrJ-eTTo4ZCLDPVVHVsnvtjN-hQMG_SKYkbcLQ>
    <xme:KbnnYWzlMkXrPss76YqqIgIz_SKa89kCH1m0CEwvjwIOSKnymfPzOT2VDPx5mgpsD
    E6K7BuzFzPE12PbFmA>
X-ME-Received: <xmr:KbnnYS0Pu08rScJr7HO20yXl7yKjhsFug3hOPteQSOzwvU_BxCr97g7Y-Ug2MezVQWfFygOIPlr75UBoA14RNXA36Xa1PkKGSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeggddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeegkeeuvdffieelledvleeufffhleduueeufefhieek
    ffehhfejgfeuleduffeggfenucffohhmrghinhepshhouhhrtggvfhhorhhgvgdrihhopd
    duhedrshhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:KbnnYVBQp0p7dWFpUrm6JXc0Ksm53cHQKto7EgSASIWw9QEW4r9T9w>
    <xmx:KbnnYWjWaMGHAwxoQXBGgGZEeqmKDH5U7VQotTufzYi_hapreaUYRA>
    <xmx:KbnnYZpWC-PHKdOzr5AFIoi0vDsQ2ZdRwue-2d0UF62TKRCru2QWQw>
    <xmx:KbnnYYbQXkZF7YxO78d09Cmli0fQXdxTbH0fcHtO027wW8NSdBAtMA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jan 2022 02:09:27 -0500 (EST)
Date:   Wed, 19 Jan 2022 16:09:24 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -next] Documentation: fix firewire.rst ABI file path error
Message-ID: <Yee5JHUa53dj2ErZ@workstation>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Akira Yokosawa <akiyks@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220118010517.20826-1-rdunlap@infradead.org>
 <dc527b05-2b65-cf88-c174-6fec6d458de4@gmail.com>
 <7f4e454c-5f79-7fd7-2866-8db682cc656b@infradead.org>
 <99e1e781-0761-2d47-954f-f75aac6e5049@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99e1e781-0761-2d47-954f-f75aac6e5049@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 18, 2022 at 03:30:40PM +0900, Akira Yokosawa wrote:
> (+Cc: Takashi)
> On Mon, 17 Jan 2022 22:05:21 -0800,
> Randy Dunlap wrote:
> > 
> > On 1/17/22 20:08, Akira Yokosawa wrote:
> >> On Mon, 17 Jan 2022 17:05:17 -0800,
> >> Randy Dunlap wrote:
> >>> Adjust the path of the ABI files for firewire.rst to prevent a
> >>> documentation build error. Prevents this problem:
> >>>
> >>> Sphinx parallel build error:
> >>> docutils.utils.SystemMessage: /work/lnx/next/linux-next-20220117/Documentation/driver-api/firewire.rst:22: (SEVERE/4) Problems with "include" directive path:
> >>> InputError: [Errno 2] No such file or directory: '../Documentation/driver-api/ABI/stable/firewire-cdev'.
> >>>
> >>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>> Cc: Jonathan Corbet <corbet@lwn.net>
> >>> Cc: linux-doc@vger.kernel.org
> >>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> >>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >>> ---
> >>> I don't see what is causing this problem...
> >>
> >> Randy, did you run "make SPHINXDIRS=driver-api htmldocs"?
> > 
> > Yes.
> > Does that cause a problem when just "make htmldocs" does not?
> 
> No, that should not cause such a problem.
> 
> https://docutils.sourceforge.io/docs/ref/rst/directives.html#include
> says (emphasis by me):
> 
>     The "include" directive reads a text file. The directive argument
>     is the path to the file to be included, *relative* to the document
>     containing the directive. 
> 
> So I think your patch is the right fix.
> You might like to add:
> 
> Fixes: 2f4830ef96d2 ("FireWire: add driver-api Introduction section")
> 
> And please feel free to add:
> 
> Tested-by: Akira Yokosawa <akiyks@gmail.com>
> 
>         Thanks, Akira
>
> > thanks.
> > 
> >> I remember seeing similar errors with v5.14 or v5.15.
> >> So I don't think this is a new issue.
> >>
> >> Without "SPHINXDIRS=driver-api", I don't get this error on -next.
> >>
> >> I didn't report it at the time as I was not sure it was expected
> >> or not.
> >>
> >>         Thanks, Akira
> >>
> >>>
> >>>  Documentation/driver-api/firewire.rst |    4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> --- linux-next-20220117.orig/Documentation/driver-api/firewire.rst
> >>> +++ linux-next-20220117/Documentation/driver-api/firewire.rst
> >>> @@ -19,7 +19,7 @@ of kernel interfaces is available via ex
> >>>  Firewire char device data structures
> >>>  ====================================
> >>>  
> >>> -.. include:: /ABI/stable/firewire-cdev
> >>> +.. include:: ../ABI/stable/firewire-cdev
> >>>      :literal:
> >>>  
> >>>  .. kernel-doc:: include/uapi/linux/firewire-cdev.h
> >>> @@ -28,7 +28,7 @@ Firewire char device data structures
> >>>  Firewire device probing and sysfs interfaces
> >>>  ============================================
> >>>  
> >>> -.. include:: /ABI/stable/sysfs-bus-firewire
> >>> +.. include:: ../ABI/stable/sysfs-bus-firewire
> >>>      :literal:
> >>>  
> >>>  .. kernel-doc:: drivers/firewire/core-device.c

I can regenerate the problem and check that the patch can solve it.

Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto
