Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C50E579858
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbiGSLYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiGSLYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:24:24 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37E422BD9;
        Tue, 19 Jul 2022 04:24:23 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id AD9505C00DA;
        Tue, 19 Jul 2022 07:24:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 19 Jul 2022 07:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1658229860; x=
        1658316260; bh=YPg2p7ZkJ19niAOLzOQ3N7cpJngdqDGzBZd0ivZIw/Q=; b=P
        Ob6SkSVtdd4l7FeK45g4x8xul5U9/5ZE4xZp45yEvjWvCwnoOkS++8GkHgkYF8aI
        bmR5OPtzLUWh2hcq51yQpIKkpbJWy+8C8OxosLvGkGav+Dhb+zE4VYWSk0jhcC6/
        Cjs7fOD50lLw02HP+eSRQQYOnkrz9HdOfa1QQ2+06jyRAHSB5dzWUSMCiVlyRrUF
        PZHajCLQqtYwU8/FDoaNxagXaUMHy4X0b3QyNZeZuXbfZb3KYUsdO7QkGOuQaILo
        LF/40WtuxqJNkgbwxszu1X9VGSFTsw5K32m2R7vauZdcOKxrNDIdcr+RUCd93Bs/
        ueKT3Qzm9IAKiKlPFKyNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1658229860; x=
        1658316260; bh=YPg2p7ZkJ19niAOLzOQ3N7cpJngdqDGzBZd0ivZIw/Q=; b=o
        DdkFYjfQqwU/flglwh7Eyru0SpGUjAKEnysIlLN61htJdG76t2vUFer7cuVZskSk
        c/NPSZVqM4+rL+rV1y9yk0GUc4xAykO2aJ1XMIAYhdsZH09+b3xR0HWMlPU6SwgN
        wAK+BDELmX9mCDq0oJJLnrkdh4CZT6oPF/qY05oy8rsmOxs+CvufhU34oAUWZESp
        l2OjhGDSOJS6cwbRrOMh9as5SsrCCvtVIL8uhxG6WchIdnCd8T/RAV6vy0yWnHne
        C4nWfPezVrxUkL9JLXiz/IuxtCeLy2gomAWnBVfsNrtuJD22yGfGgD3UGn5uIjmz
        esHrxzEhAjJDGQhttITbg==
X-ME-Sender: <xms:ZJTWYj9CoUVzwX-nFSJky_YP7DaMVJU1UvMcJGNh14qiHJC9JMj16Q>
    <xme:ZJTWYvvqN4PiKrp959earfJ4GWx8A6VF6HZ0VS0lYW1OV6K4RCFOxQ5nX9iCESsI1
    kJu4XTrnBm2mQ>
X-ME-Received: <xmr:ZJTWYhDnsFxgwWMyfHRKKR4LjyWp2RQm1Pv1q0zeDSorNRvJBziakVAbhnB3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeltddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgke
    ffieefieevkeelteejvdetvddtledugfdvhfetjeejieduledtfefffedvieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:ZJTWYvctjo7lLFj5gU0qQyimXstOsSUZtWu4iRx3K-XUXv_RTz-yrQ>
    <xmx:ZJTWYoNAzT2bd12Eu6ai3qQ-ouOQGgEvJanhYv7GD6Itm5Mldrxamg>
    <xmx:ZJTWYhnGBEzbkAxmfHY0ACMPs5NBLnnf_yF5GdHCEwzV3iDhtEMaog>
    <xmx:ZJTWYkC1b0B-Y6Xe2lsszRD05TqyOe7An4zyzk_oDwdR8re7xf4viA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Jul 2022 07:24:19 -0400 (EDT)
Date:   Tue, 19 Jul 2022 13:24:18 +0200
From:   Greg KH <greg@kroah.com>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <YtaUYmzTfKmx0Ek0@kroah.com>
References: <20220719194337.64c490e0@canb.auug.org.au>
 <20220719132559.3348c163@reki>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220719132559.3348c163@reki>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 01:25:59PM +0300, Maxim Devaev wrote:
> В Tue, 19 Jul 2022 19:43:37 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > After merging the usb tree, today's linux-next build (htmldocs) produced
> > this warning:
> > 
> > Documentation/ABI/testing/configfs-usb-gadget-mass-storage:17: WARNING: Malformed table.
> > Text in column margin in table line 14.
> > 
> > ===========     ==============================================
> > file            The path to the backing file for the LUN.
> >                 Required if LUN is not marked as removable.
> > ro              Flag specifying access to the LUN shall be
> >                 read-only. This is implied if CD-ROM emulation
> >                 is enabled as well as when it was impossible
> >                 to open "filename" in R/W mode.
> > removable       Flag specifying that LUN shall be indicated as
> >                 being removable.
> > cdrom           Flag specifying that LUN shall be reported as
> >                 being a CD-ROM.
> > nofua           Flag specifying that FUA flag
> >                 in SCSI WRITE(10,12)
> > forced_eject    This write-only file is useful only when
> >                 the function is active. It causes the backing
> >                 file to be forcibly detached from the LUN,
> >                 regardless of whether the host has allowed it.
> >                 Any non-zero number of bytes written will
> >                 result in ejection.
> > ===========     ==============================================
> > 
> > Introduced by commit
> > 
> >   421c8d9a20da ("usb: gadget: f_mass_storage: forced_eject attribute")
> > 
> 
> Sorry. Should I send a patch?

Yes please.
