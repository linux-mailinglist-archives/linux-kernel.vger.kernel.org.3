Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BC4592D28
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiHOIeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHOIep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:34:45 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973761FCE0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:34:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E82365C0099;
        Mon, 15 Aug 2022 04:34:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 15 Aug 2022 04:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660552483; x=
        1660638883; bh=V94L1Rwai/o/RkITqRUSO6O18tRp+Txm6IH8EaOIsnM=; b=Y
        jfUhU9yD3G6lm7UPlCFovrVD5R24zps5ziMuJqAvFGIprV0ywmYMdjndIpidNGj4
        IVHr6rfZXLZr3akWYoJ2UAf4DirctE928sDZIonEebIYgTUjXpZCfCd4MqdiJCat
        MyOrw1NZeSyjp+MRTxzzwJugNWsLq1nmvgMyqQIun5iUpFFXudqBQCPaLS6Vtv03
        CBhUMbXwQwOCgFYZkawI2ot9wgHCkBGB2hjsJzvpraBf9SNCN7+UYiHTe1EyLCSV
        30PjrglWZpFk7bV+Ph2DpOs8zBV6tq/nRzaJ3RsC8MJtdNOXHhCM384jwRpjxKsa
        RXytg7kQO+NDAjoE0huaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660552483; x=
        1660638883; bh=V94L1Rwai/o/RkITqRUSO6O18tRp+Txm6IH8EaOIsnM=; b=i
        SVUYE1W9Bc4729/lhe5IruvdhKoRyC5t491AImwq8r+lLkkTdBwvSsDej4dquwCu
        9v87SMa5B90k6yChA4Z3yMyYMgfQrtM+rpVl6KAHHJtnAxYOIHW6pI2Pfq9nEmob
        kXxn0wV8Np3QOphuWxZzqlyYGPhEXWzeLJaOat+eJQY/YtFWQZZjRrFObnbwlGSi
        Pl1k7hth/4sDfP5UpO8Hn6+dfznuHxHIsMEq2yQ3S1j+jts+FqeJpjDcpkyIuhdf
        559OR2+vJfj8uhxXkXbsm+987V9Br1PpVchMUxetps1quKU2VRioGQifRbBxB+FV
        2fo68+5LqdPxgSSvod26Q==
X-ME-Sender: <xms:IwX6Yp6TZxszybtsIP2D7NMXpmpM9FCpXkmerCOCfUg3mCb8wPiHGg>
    <xme:IwX6Ym7qVxvVbbGS1emUh6xhAnksGK70fhvL2Ybejkk1Q-RM5d5y4EUOsn0ND20f7
    5rvJZoxrfCX7xfcYQ>
X-ME-Received: <xmr:IwX6Ygf91RmGoHUGRS1M3juy53iZlDLBaX9IShV5COFBtkdRy2s5wEZOUXl1Uhk00YIAYUyXBf9JQspDfrxlbTzccC6mTPGAydRpKekR5vlMGhihXdc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgfjghfkfggtgfgsehtqhhmtddtreejnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpeduveegkedvvdekueekvdeivdeluefggeegledtveefjeefheelfffh
    feeghffhteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigv
    lhdruggv
X-ME-Proxy: <xmx:IwX6YiJyyNrtEoNYhIuQXmUnLvfnknpHwrDrilmt-qGiDg8HOm7ZKA>
    <xmx:IwX6YtLofi0CDWKKq1TFq5Ru3rrIExR26EfgGkayVZlCQCZKT3vnRQ>
    <xmx:IwX6YrxptKIIkYDY09zMJ6vjrmmFLtkn8Fv8xtLBIxQ6beVie7ANNg>
    <xmx:IwX6Yl8ceZOPiQWmcboBsydcYZPBr9cpDzIombtagpdHdcBgO93bEA>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 04:34:43 -0400 (EDT)
Date:   Mon, 15 Aug 2022 01:34:41 -0700
From:   Andres Freund <andres@anarazel.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
User-Agent: K-9 Mail for Android
In-Reply-To: <20220815042623-mutt-send-email-mst@kernel.org>
References: <20220814212610.GA3690074@roeck-us.net> <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com> <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de> <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com> <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk> <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de> <CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com> <20220815071143.n2t5xsmifnigttq2@awork3.anarazel.de> <20220815034532-mutt-send-email-mst@kernel.org> <20220815081527.soikyi365azh5qpu@awork3.anarazel.de> <20220815042623-mutt-send-email-mst@kernel.org>
Message-ID: <FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE@anarazel.de>
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

On August 15, 2022 1:28:29 AM PDT, "Michael S=2E Tsirkin" <mst@redhat=2Eco=
m> wrote:
>On Mon, Aug 15, 2022 at 01:15:27AM -0700, Andres Freund wrote:
>> Hi,
>>=20
>> On 2022-08-15 03:51:34 -0400, Michael S=2E Tsirkin wrote:
>> > It is possible that GCP gets confused if ring size is smaller than th=
e
>> > device maximum simply because no one did it in the past=2E
>> >=20
>> > So I pushed just the revert of 762faee5a267 to the test branch=2E
>> > Could you give it a spin?
>>=20
>> Seems to fix the issue, at least to the extent I can determine at 1am=
=2E=2E=2E :)
>>=20
>> Greetings,
>>=20
>> Andres Freund
>
>So you tested this:
>
>commit 13df5a7eaeb22561d39354b576bc98a7e2c389f9 (HEAD, kernel=2Eorg/test)
>Author: Michael S=2E Tsirkin <mst@redhat=2Ecom>
>Date:   Mon Aug 15 03:44:38 2022 -0400
>
>    Revert "virtio_net: set the default max ring size by find_vqs()"
>   =20
>    This reverts commit 762faee5a2678559d3dc09d95f8f2c54cd0466a7=2E
>   =20
>    Signed-off-by: Michael S=2E Tsirkin <mst@redhat=2Ecom>
>
>and it fixes both issues right? No crashes no networking issue?

Correct=2E I only did limited testing, but it's survived far longer / more=
 reboots than anything since the commit=2E

Andres
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
