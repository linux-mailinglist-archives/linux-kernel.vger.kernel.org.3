Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6DB4CB126
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbiCBVTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244789AbiCBVTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:19:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B20747071;
        Wed,  2 Mar 2022 13:19:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE29C61987;
        Wed,  2 Mar 2022 21:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2756EC004E1;
        Wed,  2 Mar 2022 21:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646255942;
        bh=QWYFjNcvQTfY+YtFSmf2UYt24f74I0kgvcEW3PVNDe4=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=SseMZuIiTPsEeEDa3QNFuu2ZOTjdw0dANmwff1gUa6ZxUv1Phonwc4xJ0rSPa8lwV
         LcVc+sYZJmXZ5nwiLavTRtzdagq2DpIrdaNAQKPSbtJ3elKd5GZq60spHeByKeFcpl
         6PezJIStDXAri37/cAr6sqALiUQk4rcn4ilMnhJzS7bR/6J3M8PWUVu8Zo8pZK4+YF
         NlQ91kGACn4vmspgq4AP7ZpCoP8IRpaFMtkAKYAJT4nsgHKmmMX+RBP4UgpOunL9+C
         tGlFwKA18DW8l4JV+X8Pjjizyk2pEfZUdxCVcdajejdBPWs998JT4GxhCzshTC3Z+k
         GTxkJtRnslO8w==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id D3B2D27C0054;
        Wed,  2 Mar 2022 16:18:59 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Wed, 02 Mar 2022 16:18:59 -0500
X-ME-Sender: <xms:Q98fYnlx5xkkDz-9hc7NxAVXSn2oGEQh-CSeOZb4cb705yBBoCISYg>
    <xme:Q98fYq0iAMnzYiIHSwB84QECz7awOG8VoKo2cMG1tujvz3_7CzyeDMrJuwF6h-6ix
    wjd7J5hX83kOrPrNOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:Q98fYtqJEqk96supIOOfDZ6MFEKnexjywz0tki-SaKQiEUWITp2lnQ>
    <xmx:Q98fYvn5mQpBWBmRojd4nndxZih2-rAJU-a0tgD3_ZN7JlhGyyZQKQ>
    <xmx:Q98fYl3p9HXfjx5tbAF8kB5QvUCfhsFnmGHsfcAo-LsCW3Zkyn_KOA>
    <xmx:Q98fYh7Kd72wN8PvUv3DFfnTD6Y6XcDlvbUVXlOPQR_LPIvDHyqilyS5Fpk>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0232121E006E; Wed,  2 Mar 2022 16:18:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4778-g14fba9972e-fm-20220217.001-g14fba997
Mime-Version: 1.0
Message-Id: <bdc14f77-98e0-4af8-9bef-5dd3d41f22c2@www.fastmail.com>
In-Reply-To: <Yh/Tt50Y8ubGNwS6@agluck-desk3.sc.intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <1b793ead-a47c-4719-b7b5-cba7d49633f2@www.fastmail.com>
 <Yh/Tt50Y8ubGNwS6@agluck-desk3.sc.intel.com>
Date:   Wed, 02 Mar 2022 13:18:37 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Tony Luck" <tony.luck@intel.com>
Cc:     "Jithu Joseph" <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Raj Ashok" <ashok.raj@intel.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [RFC 00/10] Introduce In Field Scan driver
Content-Type: text/plain
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Mar 2, 2022, at 12:29 PM, Luck, Tony wrote:
> On Wed, Mar 02, 2022 at 05:59:59AM -0800, Andy Lutomirski wrote:
>> > /sys/devices/system/cpu/ifs/reload
>> >   Writing "1" to this file will reload the tests from
>> >   /lib/firmware/intel/ifs/{ff-mm-ss}.scan
>> 
>> IMO this interface is wrong.  /lib/firmware is for firmware (or
>> ucode, etc) files that should be provided by a distribution and loaded,
>> as needed, by a driver so the hardware can function.  This is not at
>> all what IFS does. For IFS, an administrator wants to run a specific
>> test, and the test blob is part of the instruction to run the test.
>> The distribution should not be involved, and this should work even on
>> systems where /lib/firmware is immutable.
>
> "so the hardware can function"
>
> Data center customers want to know which aging systems in their
> data centers are not functioning correctly. So this is not just
> a random test that people might run when they suspect they have
> a problem. It is expected that every core will run this test
> periodically (period dependent on paranoia level of the system
> owner ... maybe daily ... perhaps even more often).
>
> This is so that the data centre can function.
>

How does this work?  Is there an Intel IFS blob v1.17 that is expected to be *the* blob for a given CPU until an update happens?  Or is the expectation that several different blobs might all useful on the same system and operators might want to run different blobs under different circumstances?

>> 
>> So either the blob should be written to a file in sysfs or it should
>> be supplied by write or ioctl to a device node.
>
> I don't see the drive to create a new mechanism for the kernel
> to load from a file when the firmware loader already exists.
>
> If the problem is just immuatbility of /lib ... then make
> an immutable symlink from /lib/firmware/intel/ifs to some
> other place in the file system (which is what some OS
> vendors already do for microcode).
>
> -Tony
