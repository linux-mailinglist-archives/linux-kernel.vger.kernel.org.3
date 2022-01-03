Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AC44837E1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 21:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiACUEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 15:04:09 -0500
Received: from ms.lwn.net ([45.79.88.28]:51058 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229651AbiACUEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 15:04:08 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E8A41380;
        Mon,  3 Jan 2022 20:04:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E8A41380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641240248; bh=CUz5wuJiPEm91tSMrn8AMl5xdvPNXqlrO5SupqnGfhg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AiIobKdBuCpZb/mmN72asEJgtMVoByyuSfckMD6nfIuGAoGakRDe00hTZIY4e1qRE
         /5fz0yQz8S0z5WMdxLBsGqKOf2TzTUR1dOkx5z6HI0lSsvdpdu08W/Sb3fTUOzuikN
         X88NwHzMLGOSVacqRs+Kr107ky9Wsqzc9XfMqF25vb99GXY0HGv+1Ef+mfmTN4lCHY
         90nqM44ycnjVJRdh/ikcQYrbEMB1+qrcpwuSOSMgwQsnIOImd4mgP/gmTcThkdIJ8k
         potzuvMXI77J+g1N4hko7fH+qvvMUfrfTjYhiFBQhc0Xh1pH3Mdv3tM9jG0MygD7oh
         8iqB9rjQz5Ncw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: transform documentation into POD
In-Reply-To: <20220103183034.77ba8a8c@fuji.fritz.box>
References: <20211209225549.69010-1-tomasz.warniello@gmail.com>
 <87h7b8cfg0.fsf@meer.lwn.net>
 <0796a780-f5ee-0b6c-e7ef-544ba5f6a429@gmail.com>
 <87pmp9tcju.fsf@intel.com> <20220103183034.77ba8a8c@fuji.fritz.box>
Date:   Mon, 03 Jan 2022 13:04:09 -0700
Message-ID: <87bl0sziva.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

> On Mon, 03 Jan 2022 11:04:53 +0200
> Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> In kernel, tabs are 8 characters.
>>=20
>> See Documentation/process/coding-style.rst
>>=20
>
> I am a heretic then.
>
> Except for the initial dogma, I understand and agree with the rationale
> in coding-style.rst.
>
> Only what if I have stared at the screen not for 20 hours, but for
> 40 hours? Now I want to have indentation even deeper, of 16 spaces.
> And how do I get this having 8 spaces here and there instead of tabs?
> The system begins to fall apart.
>
> The misleading statement is that tabs are 8 characters long. No. They
> are exactly 1 character long. And that's ASCII 9.

This is not particularly helpful.

I would like to get your work in, but need some cooperation to get
there.

Please:

 - Post your patch series as a single thread with a coherent cover
   letter.

 - Stick with current coding conventions

 - Avoid snide comments to reviewers.

Thanks,

jon
