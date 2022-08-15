Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D008592A51
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbiHOHSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiHOHS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:18:26 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3BA62E3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:17:47 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5AC065C0080;
        Mon, 15 Aug 2022 03:17:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 15 Aug 2022 03:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660547867; x=
        1660634267; bh=xTjcQfKNIop6djVdHsXKwdZ++OKwOX1hyxW0jZzeycI=; b=A
        2CtgTmo9IXc3gFSjBE4+rznOxRspGwQC7CMsRnhKJfdW9u8hlRT9hFsv5B1oyGvy
        Y3ydRIaj2ejebjZ1qw3XDJ39DbHbOqoS+ComhPnF0vi10Dtnd68DG4BUG122+aPC
        vkPadlBQZULrK5bwm4DSu1x5fmWAtGSdOdJkUw9A5cHA1+0G/T3838gQge1M6VwJ
        iReZSSPogIbDRz3aYP7WECO9+jGshFjaKNabiXWql8OULWSlNIq1NtV/aWhGlypP
        6DPjvPL3zabmFWcqcogWUX3hwxZ9EsyNQkAvGZfIPTQ3ogCViIhh+xYn9TFi6gF8
        Gv5HEP6UKD7MmC8Ug2lTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660547867; x=
        1660634267; bh=xTjcQfKNIop6djVdHsXKwdZ++OKwOX1hyxW0jZzeycI=; b=a
        RBV0y26XBJrsrPgRpD8jZ0Ch9zNADo5bsJ6jCwS/xiJytFZvt7toBnaeMAQe38Uu
        /YW0//P2OjHw3hn+d5n6Ce1IVMsislnMpp8fjHkN+0fWLee5Kuq6Hrs4TqgZJfCw
        vVm6AnEqeCSaI3NSXoD6r7Bo/hP9/r454AOilvsd/y2kOGptqb4Cqmpr2KGb60XG
        siNZwl85rYSlM05KE0ETc/d4K1Xny9I8Ml4R9+IsL9bHjN1cwqCMiitYxIm+APuh
        95MQpQt0U1Dcuivn3m8RlqjIJNPXjXkZJ1gf9P+mMkaggfKM4MnXB2gOE0K6YomL
        sLzg7S4Qwf6pFApFPtdog==
X-ME-Sender: <xms:GvP5YsUEBtPy7CtoLK0xu59upUNpZT7iKIMXB4zqRBKBg3TTajfh8Q>
    <xme:GvP5Ygkia8WwC9W1CGFwf9-aNIi96HoKwSy5sbryxQ_48xOsm8a30U4X7PEgTWnaY
    thQuRNs9IvNhkDmLw>
X-ME-Received: <xmr:GvP5Ygbs3XRtF6qgxpn90hBZErYdWwhl-Qj0DPXPaS6bRal978eSA34TgWhgsfjS5YrXsjlXo85-q_9Je8mziGtguC4itp-TQuGZmsvqg1lSj0Linek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefufggjfhfkgggtgfesthhqmhdttderjeenucfhrhhomheptehn
    ughrvghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecugg
    ftrfgrthhtvghrnhepudevgeekvddvkeeukedviedvleeugfeggeeltdevfeejfeehleff
    hfefgefhhfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgii
    vghlrdguvg
X-ME-Proxy: <xmx:GvP5YrVO9jKC8Ek6f3QPWW51lkFG6qZ7W_-8dCx76urvDgHuUyWW8g>
    <xmx:GvP5Ymnltb4nBcqJhqDCm3wOCBU-VW9HsjCiqpc9KmUe7eIoJ8aPLA>
    <xmx:GvP5YgegQase1kWZJ09uBiMcQ6Lp-fuFpwSALSo-DjylaHftsX22oA>
    <xmx:G_P5YkYlQlWtwSYLQzPWTQdsIeV_TmY6tBgSNB-Mhky27l6qRITylQ>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 03:17:46 -0400 (EDT)
Date:   Mon, 15 Aug 2022 00:17:44 -0700
From:   Andres Freund <andres@anarazel.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
User-Agent: K-9 Mail for Android
In-Reply-To: <20220815022711-mutt-send-email-mst@kernel.org>
References: <20220814212610.GA3690074@roeck-us.net> <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com> <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de> <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com> <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk> <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de> <20220815022711-mutt-send-email-mst@kernel.org>
Message-ID: <D887C3E7-4C2A-4576-8F63-4CFFF8479069@anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

On August 14, 2022 11:36:55 PM PDT, "Michael S=2E Tsirkin" <mst@redhat=2Ec=
om> wrote:
>On Sun, Aug 14, 2022 at 06:36:51PM -0700, Andres Freund wrote:
>> Hi,
>>=20
>> On 2022-08-14 19:04:22 -0600, Jens Axboe wrote:
>> > I took a quick look and added more SCSI bits to my vm images, but
>> > haven't been able to hit it=2E
>>=20
>> Didn't immediately hit anything locally in a vm either=2E=2E=2E
>>=20
>>=20
>> > Sounds like Andres is already bisecting this, so I guess we'll be wis=
er
>> > soon enough=2E
>>=20
>> I started bisecting the network issue, as it occurred first, and who kn=
ows
>> what else it could affect=2E Will bisect the other range after=2E
>>=20
>> Due to the serial console issue mentioned upthread it's pretty slow
>> going=2E Each iteration I create a new gcp snapshot and vm=2E Adds like=
 ~10min=2E
>> Doesn't help if intermediary steps don't boot with different symptoms a=
nd
>> another doesn't immediately build=2E=2E=2E
>
>Just so we can stop pestering everyone, could you try
>
>git revert --no-edit 0b6fd46ec5f5=2E=2Ea335b33f4f35 ?
>
>Equivalently I pushed it here:
>
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/mst/vhost=2Egit test

Saw this too late - I assume you don't need this anymore now that I pinpoi=
nted the one commit?

Andres
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
