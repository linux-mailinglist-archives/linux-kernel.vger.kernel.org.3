Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EFC595BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiHPMm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiHPMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:42:26 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379DEA0603;
        Tue, 16 Aug 2022 05:42:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id AEBDE3200909;
        Tue, 16 Aug 2022 08:42:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 16 Aug 2022 08:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660653743; x=
        1660740143; bh=ky0kxryxzgBQxj79y+IZat+dQ+Oo6flqFYfzcpKMIA4=; b=c
        4vU59iwxGCl8M4ZmetRzeJ/eZJRnXBJs9cZDy9HAxoGwZaBs5mjEppLC60EUVTAo
        i/DmHxvUyc5w/fASYhgvMJF/xqG5L5qlymeFf1w4tt5WOdm9hMrgdSmGM7+aUFPr
        MsjIim1+fp3s9tWf42mhv2f0KAB3C320Qwj7TJxJ+vgMRXhGB1raICmVoBIvtKvG
        OCkVQaS22hDU7Ue7JGAbEKU/91vdVFRv8qC1MT//zOSMB5uLF8Vdz6vl8giPNQLs
        jCWjgTNXf/p8VyUn4oz+PHen9DKd3w/dEZThvcmts8mDWWdIXUqIF37oi7ORACGV
        SyMHkg52FtFYmuHdMiSLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660653743; x=
        1660740143; bh=ky0kxryxzgBQxj79y+IZat+dQ+Oo6flqFYfzcpKMIA4=; b=v
        xZ+437SagXEit2LSOBnDfTa1yW6teiVy02VaAgMzycWp/NtszNGkP4Nq9xqD3EnG
        33W08NEkOr2FW+SrQGChkfKLj6yZhbXoQdA74KhQAAujVBuTrRoDB1fgFMwC8mAQ
        NpmCqfOEXRJc2h8LE/L/+HJHqJdAqUiPjJjCNEhus8+sDsBbAMhXTdQCGpQ6woCV
        cqcd59TwcDuR3e37tSZLrluqNrPZ4BkERfQtZC70Eek+a9el1cewM/xuQClJlUyB
        czGDzIrslWYBHqmNSfYoA6DS+0leg4OpZH4C/q8IQrC29JML8yd4aISGLJkztp2N
        XwvWcScr07sfYsG25yuhw==
X-ME-Sender: <xms:r5D7YlyCKjVWdTNa0JhWsJ0ohD2fdC4bcOD5TjJvIgJ3_P5UHx0ccw>
    <xme:r5D7YlRF_hA5URVTaMg1HAfOBgIcsRhSsSrYT3X26dzVxB3BEYzxm6MigccSFdaok
    LK69km7DlBi5w>
X-ME-Received: <xmr:r5D7YvVUXWeR0vGb3Yj5srD7PRHFqIcaxCbLDh0Op88WftF9pVpuTW7jkbRVaNXbDsjWxlcCWcblPY2qwPVZZ8_k-Mguaj-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeortddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhe
    fgveehuddtkeefkefhhfehtefhkeffteetudeiffekveevffeiudfhvdejleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:r5D7Yni20Ok4Y-Rd8s_A88R5qgJHnPSF0n8zkZmPXWkiFEZ21iiSfA>
    <xmx:r5D7YnBFsZQs-KGEdpa-Z58FCVDtrNJMho9pmkvsQF83XdWluDRZAg>
    <xmx:r5D7YgLNAzguIXLEr9Wip_JIFKhkmssxMP4E65B3oayb4_LL0aEAfg>
    <xmx:r5D7Yr4TtCraCb29WwuVm_hT6PqkJryxo6Ej4oDkFaG8TUvb69HgFQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Aug 2022 08:42:22 -0400 (EDT)
Date:   Tue, 16 Aug 2022 14:42:20 +0200
From:   Greg KH <greg@kroah.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-api@vger.kernel.org, f.fainelli@gmail.com
Subject: Re: [PATCH v4] MIPS: Expose prid and globalnumber to sysfs
Message-ID: <YvuQrCgMVwTTyyHX@kroah.com>
References: <20220816091258.9571-1-jiaxun.yang@flygoat.com>
 <YvthfQUfv0TiO/bK@kroah.com>
 <c17cdcf9-14bd-4287-9525-287dfc908fa2@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c17cdcf9-14bd-4287-9525-287dfc908fa2@www.fastmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 01:38:27PM +0100, Jiaxun Yang wrote:
> 
> 
> 在2022年8月16日八月 上午10:21，Greg KH写道：
> > On Tue, Aug 16, 2022 at 09:12:58AM +0000, Jiaxun Yang wrote:
> >> Some application would like to know precise model and rev of processor
> >> to do errata workaround or optimization.
> >> 
> >> Expose them in sysfs as:
> >> /sys/devices/system/cpu/cpuX/regs/identification/prid
> >> /sys/devices/system/cpu/cpuX/regs/identification/globalnumber
> >> 
> >> Reusing AArch64 CPU registers directory.
> >> 
> >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> ---
> >> v2: Drop static qualifier for kobj (gregkh)
> >> v3: Use kzalloc to allocate struct cpuregs.
> >>     note: When Greg mentioned about static I was thinking about
> >>     static qualifier of percpu variable. After reading documents
> >>     again it turns out kobjs should be allocated at runtime. Arm64's
> >>     cpuinfo kobj is also on a percpu variable... I guess that was a
> >>     intentional use?
> >> v4: Properly handle err of kobj creation. (gregkh)
> >
> > Nothing was fixed :(
> 
> [Resending due to previous mail contains HTML. I just got a Macbook
> and was trying to use it's built-in mail client. Turns out that it's
> sending HTML even with "Plain Text" selected...
> Now turning back to mutt. Apologise for inconvinence.]
> 
> Hi Greg,
> 
> Sorry for misinterpret your comments again :(
> 
> Hmm I just use kobject_put to replace kobject_del.
> I thought that was what you were trying to say?

Yes, I think that is correct (I have no context here), but you can't
then call kfree() as the memory is now gone from the last put, right?

Try it and see :)

thanks,

greg k-h
