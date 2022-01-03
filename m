Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9EB4838A8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiACV5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:57:47 -0500
Received: from ms.lwn.net ([45.79.88.28]:51060 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbiACV5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:57:46 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C4E5C380;
        Mon,  3 Jan 2022 21:57:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C4E5C380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641247065; bh=4SLkoZXFBd/sKi00qfUbatTwfM4c2vYvStIucRWJsR4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sr41kgPOBKmdsy8q/c9C5Kkd3HG9pe/xGB6Nah0STD6zKGHQytq/Dq9vTKyyS9CF4
         gcjKUTnao+1HOAyiTi7PD6dGU0gTh9kyeiB5tfRfWEerPh4rDIhuPPBhjK9RUXlJZv
         X/xds7B3REpR6tcUQeqN2gYAl0TSJ6Drq4zY55WYhxHDPIENwRhqNqYsJAr3UvzRY6
         rwSDRSOjsOuBV5a9gyQFHRJO9EB5fdS6wBLtnw/YjWlmGbwpbihk6rmG/CQeDCivJS
         vi3VKKe90b+FQlCOfMRRvCutxraJ1o8aedGjWm+orbj5jUyJOdYiZ3kJEq8KdxODSU
         9KlTamsqQW2Lg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: transform documentation into POD
In-Reply-To: <20220103224806.2932bac2@fuji.fritz.box>
References: <20211209225549.69010-1-tomasz.warniello@gmail.com>
 <87h7b8cfg0.fsf@meer.lwn.net>
 <0796a780-f5ee-0b6c-e7ef-544ba5f6a429@gmail.com>
 <87pmp9tcju.fsf@intel.com> <20220103183034.77ba8a8c@fuji.fritz.box>
 <87bl0sziva.fsf@meer.lwn.net> <20220103224806.2932bac2@fuji.fritz.box>
Date:   Mon, 03 Jan 2022 14:57:48 -0700
Message-ID: <8735m4zdlv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

>>  - Post your patch series as a single thread with a coherent cover
>>    letter.
>
> Sorry, I'm a newbie in this business. I need to figure out how emails
> work. Is this just one thread per version or one thread per all versions?
> Can you please direct me to some documentation about this?

One thread per version is good; please do not post new versions to old
threads.  A tool like "git send-email" can be your friend here.  See
Documentation/process/submitting-patches.rst for lots of details on how
to submit patches.

Along these lines, I appreciate that you broke up the series as I
requested, but you overdid it a bit.  Think in terms of logical changes
and making things easy to review, and you should be able to coalesce
things a bit.

>>  - Stick with current coding conventions
>
> To be honest, I need to think this over.

Think hard; if you're unable to work with the kernel project's
conventions, there's not a lot of point in resubmitting the patches.=20

Thanks,

jon
