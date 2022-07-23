Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF6957EC72
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 09:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiGWH0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 03:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiGWH0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:26:43 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16E2388F;
        Sat, 23 Jul 2022 00:26:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C000132008FB;
        Sat, 23 Jul 2022 03:26:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 23 Jul 2022 03:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1658561198; x=
        1658647598; bh=5Ir+MjFNAiyfriqu201Q2DsSmCwNyWbos3Bln1LDuEY=; b=R
        wM+zTeDX2Rh5aCnfspDGdokKpWDm8poehxkcTiVh1/R3GPX9hMDZRtYCPNsjZdMp
        uXB8YScVK6o9Pws7j8b8EKKyYDilZ9pdM96lORr6oYQK4RnpmtcKqk5f6zQmJy59
        zX4YgYQwPavAZI0fTmM80zrX65HrmtXBwMktw8btIikLo1GCKjPQgNP5DEOIc3CU
        aTLNXtg0bHh2a6Dmwdx9dZukBRu9pu1rAFgqHyXHraa6cP1f9tEAOOXmT8CmAJWD
        KntkVBhfCbM7bbHm0JWRQxbgrjLZaC4ETT24YbXalafqhBP8k0wAB2Nyq0zEJid/
        lBHAosASE4/17SeODzaPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1658561198; x=
        1658647598; bh=5Ir+MjFNAiyfriqu201Q2DsSmCwNyWbos3Bln1LDuEY=; b=q
        r2vEBdIfhBrUmnn4QOiFmxtadMeICfZjUUSZFYIwdFpm0ImmY18iv8giOBnQud72
        dQucaW1RYj0XfFijWxgO9pCq2Xu3JPeXPmfBZudsQYfPoXrHR+kB12kukkElxc/5
        9igumapg4xJYR2krCsjgrjqcPVmB6YTnQWGuvrEcHva1AJvvlCpsBF39U/P1dTun
        wbupFv98RiyN9lsSbt3mXloYji8FEgtqvFXJ87jI+3rom04vXXAlV5iCozAArvnR
        y2lQynoSzT/vzIpW2Kdr3K2YrHR7ozP2qZYShzaWghJaKSPgyvlf32wFtYDSOS6v
        RBZNf4yTpAxBPLxFkRNaQ==
X-ME-Sender: <xms:raLbYrvlngzjuz-yC2mA1TEd3oDkG75P2eTGdnQSkSbLnJSgyjnZXA>
    <xme:raLbYsfuZ1zJdqdhAOURunf-ickMEYhGjjN_0EJC2Nb3n51o8jSmyGTJzlTWC5zyX
    9Cskd8e9_8szA>
X-ME-Received: <xmr:raLbYuzMm2Gy0BF1pFfnSqh59t0qoifWUiEXWS_jsOHE4kU5v3SL_Wj8Wz8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtfedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgf
    ekffeifeeiveekleetjedvtedvtdeludfgvdfhteejjeeiudeltdefffefvdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrh
    horghhrdgtohhm
X-ME-Proxy: <xmx:raLbYqO05V-_8ugduzUeFvzs83wf7vPFFwULgsOrD4JPBCi7hY27Gw>
    <xmx:raLbYr8foFGVfKgCietIly8f9TqPJvAMsbyQ0OzAXxpTeDUU2007aw>
    <xmx:raLbYqW6rQS9ZFtQbMEXdRRnrfBz1PAKcv5-UaKZpAkNh51VP92zRQ>
    <xmx:rqLbYrwvTVYr2X8YUUh-ICSNMdGj3ox82XtqWvh9pHqdWYeXmjvxTw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Jul 2022 03:26:37 -0400 (EDT)
Date:   Sat, 23 Jul 2022 09:26:31 +0200
From:   Greg KH <greg@kroah.com>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <Ytuip1C2LPmAxQxV@kroah.com>
References: <20220719194337.64c490e0@canb.auug.org.au>
 <20220719132559.3348c163@reki>
 <YtaUYmzTfKmx0Ek0@kroah.com>
 <20220723101428.347d941e@reki>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220723101428.347d941e@reki>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 10:14:28AM +0300, Maxim Devaev wrote:
> On Tue, 19 Jul 2022 13:24:18 +0200
> Greg KH <greg@kroah.com> wrote:
> 
> > On Tue, Jul 19, 2022 at 01:25:59PM +0300, Maxim Devaev wrote:
> > > В Tue, 19 Jul 2022 19:43:37 +1000
> > > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >   
> > > > Hi all,
> > > > 
> > > > After merging the usb tree, today's linux-next build (htmldocs) produced
> > > > this warning:
> > > > 
> > > > Documentation/ABI/testing/configfs-usb-gadget-mass-storage:17: WARNING: Malformed table.
> > > > Text in column margin in table line 14.
> > > > 
> > > > ===========     ==============================================
> > > > file            The path to the backing file for the LUN.
> > > >                 Required if LUN is not marked as removable.
> > > > ro              Flag specifying access to the LUN shall be
> > > >                 read-only. This is implied if CD-ROM emulation
> > > >                 is enabled as well as when it was impossible
> > > >                 to open "filename" in R/W mode.
> > > > removable       Flag specifying that LUN shall be indicated as
> > > >                 being removable.
> > > > cdrom           Flag specifying that LUN shall be reported as
> > > >                 being a CD-ROM.
> > > > nofua           Flag specifying that FUA flag
> > > >                 in SCSI WRITE(10,12)
> > > > forced_eject    This write-only file is useful only when
> > > >                 the function is active. It causes the backing
> > > >                 file to be forcibly detached from the LUN,
> > > >                 regardless of whether the host has allowed it.
> > > >                 Any non-zero number of bytes written will
> > > >                 result in ejection.
> > > > ===========     ==============================================
> > > > 
> > > > Introduced by commit
> > > > 
> > > >   421c8d9a20da ("usb: gadget: f_mass_storage: forced_eject attribute")
> > > >   
> > > 
> > > Sorry. Should I send a patch?  
> > 
> > Yes please.
> 
> JFYI the patch has been sent to linux-docs@, etc. I forgot to add you to CC.

Then I'll not be able to take it into my tree to fix this up :(
