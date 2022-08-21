Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2659B533
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiHUPti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiHUPtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:49:36 -0400
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE091F2FE
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thepaulodoom.com;
        s=mail; t=1661096972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHgkvCFu+7/5o2QsPt7iXfrSWbO/n4tp4Oajyx2o5CI=;
        b=QMj/FwExxxD9klUU0LWqOv3XprFUUcsb+tl/dTQFIKOQ5wzjk1c90X9U1eGQKNsCLh46gB
        tBO9jSGJEDYZkgRbTzKC+8bw51qdBuHLM6VHi6V8vpQKtW7r9gWJqMNF624lUojeB3WS9Q
        muYgYN+6IrrYjjAmytFDDNHRPK7aM2Y+5xFRFB9t2uAB4TFig1vHA8qgkvn3Yr4H17Qgyx
        FkjeP6gmbTZDuUSNWjzU/2qqRjedxqzZ7mIBa6nxc+2E+TlyhQ4raEhFMfuBH6Ga0laxYK
        BZLu+5bgEtsDxjt/tA9ti/mYObZvRxSgreGwScaEvnpjo0e0Cmez8R1OTxcVYgw9l59kas
        l4Y4mIx/1RI2s3c75vTJHIMBR92I3QrGywe7xIcntCoyLrvD3vUDl/PiUM5+uhGfFGnVRm
        AyDYrIav2LhDVMl+2z0pRvh7iqAS9GLEQTPocfIGX3aKJfTEX31TzzyNRWuD6WKb0gCVwu
        EqJB4sQ1oB7A6PYfPolHodxTkH1WGmGx6bbajWUD0vlQYUmxTyVKjHf2rZhOEPvpYlKV7h
        XL1VlojAQwfV1czMQYWnAkAwrMfGpnqZ9W5MhSat6lsSVejQ8dFlnh6HasF15QInfYOLfr
        qKG98ZCU41I8bu/emzKdNjvzP05fAEi8C1noDVkqg46ZLOOBbFulY=
Received: from [127.0.0.1] (h185.16.131.174.dynamic.ip.windstream.net [174.131.16.185])
        by vultr.guest (OpenSMTPD) with ESMTPSA id 04288e26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 21 Aug 2022 15:49:31 +0000 (UTC)
Date:   Sun, 21 Aug 2022 15:49:28 +0000
From:   ThePaulODoom <thepaulodoom@thepaulodoom.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: char: mem: changed 'unsigned' to 'unsigned int'
In-Reply-To: <YwHuSyur7AQ7PUsC@kroah.com>
References: <YvxF0yn07ztg9r4A@gus-fring.localdomain> <Yv5SG8XMR2mZGAqG@kroah.com> <Yv7s5dedhRaDlsAC@gus-fring.localdomain> <YwHuSyur7AQ7PUsC@kroah.com>
Message-ID: <BA62DE39-AFED-47BC-964C-8AF150A0B9F1@thepaulodoom.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 21, 2022 8:35:23 AM UTC, Greg KH <gregkh@linuxfoundation=2Eorg> =
wrote:
>On Thu, Aug 18, 2022 at 08:52:37PM -0500, Paul Lemmermann wrote:
>> On Thu, Aug 18, 2022 at 04:52:11PM +0200, Greg KH wrote:
>> > On Tue, Aug 16, 2022 at 08:35:31PM -0500, Paul Lemmermann wrote:
>> > > found with checkpatch=2Epl
>> >=20
>> > That is a very sparse changelog text=2E
>> >=20
>> > Why make this change?  Please be descriptive=2E
>> >=20
>> I wanted to make this change to be more fitting with the kernel coding
>> guidelines, and to reduce a WARNING made with checkpatch preferring the
>> use of 'unsigned int' over 'unsigned'=2E With NOMMU_MAP_COPY defined in
>> 'include/linux/fs=2Eh' as an unsigned integer, I felt like the change w=
as
>> fitting=2E I was quickly reminded that the changelog was not properly d=
one,=20
>> and I now understand that, and will learn from my mistake in the future=
=2E
>> As I am a new kernel contributor, and looking to hone my skills, what a=
re=20
>> my next steps?=20
>>=20
>> Should I:
>>=20
>> o Drop the patch and resubmit it,
>> o Simply drop the patch,
>> o Could I change it somehow?,
>> o Or something else?
>
>Try something else=2E  Start out by working in drivers/staging/ on basic
>coding style fixes and other things listed in the drivers/staging/*/TODO
>files=2E  That's the best place for new developers to get started and the=
n

That's what I'll do=2E Again, thank you for being patient and guiding me i=
n the right direction!=20

Many thanks,
- Paul
