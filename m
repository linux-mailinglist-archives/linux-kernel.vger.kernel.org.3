Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908924C1582
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbiBWOhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241635AbiBWOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:37:17 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB40B3ED09;
        Wed, 23 Feb 2022 06:36:48 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C87302AE;
        Wed, 23 Feb 2022 14:36:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C87302AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645627007; bh=4p6KEbofRbMYhdOb2vatXNsLo3CH5ucyHVIfnyIPNIw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=C6QPLhKkYGWfNEKPTdWWALp/Etvi5fadDYV4Pip5To1tzugylg9g2WjaXnXxzpDD5
         2wrkyE3/JcjJpQ7vaG3Z5R1y/7gau0kGrvp3NsPGvgWFwK1gyEsEfl8wIbybHzR4+m
         sTIAdplIg4U1FUh1skr5y8Prtur74w3UClWgAbB17d/sf3f65qDLahBXEtDLJBH/dh
         87yztfdAL9KAzC0XX9OmFAlN2zpIcnZULWczZcLdQ0qIUdHoSJ+t8sNTmwpfEkxeJF
         Ir4q6QxsbRgUlhiEKxJrmBfZflCt4YJZJjk5vC5P9tmPnAGsmdgKodbebSsaP822hC
         Xlc2wLwZZ/e8w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: Check existence of FILE arg
In-Reply-To: <20220223151702.55a3a7a5@fuji.fritz.box>
References: <1c71e5d2-f87e-6c8e-6176-e5ce42e4d41b@gmail.com>
 <20220223144713.6e2284e3@fuji.fritz.box>
 <721f860a-a662-0f0c-a82d-eacf80841eb3@gmail.com>
 <20220223151702.55a3a7a5@fuji.fritz.box>
Date:   Wed, 23 Feb 2022 07:36:47 -0700
Message-ID: <87tucpr6o0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

> But I'm not sure this is the right moment to do this. Have you seen
> my RFC thread? I'd wait until the water stabilises and see the result.
> This script may be phased out - how soon, I don't know. Unless you want
> to do this purely for sport.

Unless somebody steps up to do the work, I don't see that phasing out
happening any time really soon.  I know I'll not be able to find the
time to take on a project like that...so I certainly wouldn't be turning
away improvements to the current script on that basis.

Thanks,

jon
