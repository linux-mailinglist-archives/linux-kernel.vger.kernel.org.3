Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4E654FC64
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383228AbiFQRnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383234AbiFQRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:43:36 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7347F40E42
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:43:29 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id ECE8F5C0165;
        Fri, 17 Jun 2022 13:43:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 17 Jun 2022 13:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1655487808; x=
        1655574208; bh=QMRJ40+x2ByGreVRa6FhO/dGHMVKZkGnsJGWH3gZ5xQ=; b=X
        TfDhXYSO0ftQmx6uWLHqRONoUoSm8SeBUevNoI51kap0u5CA6JRKg550ga2WalCp
        1nx3bP6zlO1m3+WZ911dl/+43fC09Ow84ZKN8jp4cRQVmiiVs70uLGKidSllZXF9
        29Haw13OEt/5dkQwHNwQbFu0nC2xelKiZujirTyNNsABqZN7l7Qr0xzq1HEyaY1c
        mI7q03+l9yCibIbsLnB0TG2IoqOMVWVovxcGTxHuzgmj/6DePx8EHnmTTxOOjgef
        ZY4dE5AD3hAJGSQSIOscZyUbMg6t5geMeOgiJpr59Z5M6MG89SPbEXzPzhlxzNut
        iFxtZaEof2j9W3H64FLYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655487808; x=
        1655574208; bh=QMRJ40+x2ByGreVRa6FhO/dGHMVKZkGnsJGWH3gZ5xQ=; b=k
        2/AFBSKjRVukNogTbXK4bmgC/M8OPXUNaJie6P8BvCuxXsgS4Dbpz7sJSBzG2FbV
        Zi9Itz4FSboMAiFaaby5zVKEvYvHpwfWtd77JjiY3/PeKn/YiKXQC3WWDtTU7EjA
        OM3JkMD9DwPKyD17ytB9oYEriw1ISGIUuBwZfQkLKfY8bul2XoafR9CSZvg8iT7R
        lz8NfeAr/UUgEtoTDbKgVsqEfii6j3jkO7VL+Tzvnpf6PSGE3PB80RvL9iNIs8uh
        5NVC6dcXPkS+28B8mTv5Xu8v5LHahgxo1G/CQ/46GTD0xnuX9Glno2WRl42WV0uf
        8G52Ewo0hnZeoxfyXr+xA==
X-ME-Sender: <xms:QL2sYqdZVA3MnP0A5NnvEHwS6851yw8VBO-1flVNB1fa-S3PAFKs2w>
    <xme:QL2sYkNSYDWmzrvjJc8dYXl6SUyeCcaa-_ek0y9p3N0XoH4X67ivVZLBR45yy6qhO
    cYX7UhCNgOhRg>
X-ME-Received: <xmr:QL2sYriQDysnBC4aWT_1E88AX1Eh6h69_IclMlQZ7e940R0Qo4YfWbFMEhEofmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvhedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefufggjfhfkgggtgfesthhqmhdttderjeenucfhrhhomhepifhr
    vghgucfmqdfjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtfeelhfdtfefhkefgffdugeekgffgheefgeejfedtgeejjefftdevhfekhffhveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskh
    hrohgrhhdrtghomh
X-ME-Proxy: <xmx:QL2sYn9aKZBMRhxvuNOxnmVbME0jCUcMOBwrvnr11iLXAFbrGwA9KQ>
    <xmx:QL2sYmtmQVQMALn7_FFWVUBQ7_Yuu83R-oTo7Idnb57_vMYGRru7BQ>
    <xmx:QL2sYuFZZ1esKepQM1ddbSqrIvPg5T7psMF_vUtmCtYfS3DJTA-CNw>
    <xmx:QL2sYoKi0qM3VWDYrfidOMnvnNBD0EGbihdN6rxhcl8my1g15bFwqw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jun 2022 13:43:27 -0400 (EDT)
Date:   Fri, 17 Jun 2022 19:43:26 +0200
From:   Greg K-H <greg@kroah.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Char/Misc driver fixes 5.19-rc3
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wh59Decy5ksYBW1kD2pmcgo8T0JdKa37iaeaEO5LUN62g@mail.gmail.com>
References: <Yqw4Jujzz5ZzZ2Wg@kroah.com> <Yqywy+Md2AfGDu8v@dev-arch.thelio-3990X> <CAHk-=wh59Decy5ksYBW1kD2pmcgo8T0JdKa37iaeaEO5LUN62g@mail.gmail.com>
Message-ID: <CE205655-557F-486C-AF6A-099749208327@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On June 17, 2022 6:59:50 PM GMT+02:00, Linus Torvalds <torvalds@linux-foun=
dation=2Eorg> wrote:
>On Fri, Jun 17, 2022 at 9:50 AM Nathan Chancellor <nathan@kernel=2Eorg> w=
rote:
>>
>> I think you tagged the wrong branch (char-misc-next vs=2E char-misc-lin=
us)?
>> The commits below do not match the tag description above=2E
>
>Good catch=2E I verified the diffstat etc, but yeah, the actual
>explanation in the tag doesn't match the contents=2E
>
>It's pulled now, and the code changes look fairly harmless, but I
>suspect Greg will want to send a real pull for the changes that were
>intended to come in here=2E=2E
>
>                   Linus


Crap, i messed that up=2E I'm away from my laptop until Monday so I'll ver=
ify it then=2E The one time i go out of town for the weekend=2E=2E=2E

So sorry about that=2E

greg k-h
