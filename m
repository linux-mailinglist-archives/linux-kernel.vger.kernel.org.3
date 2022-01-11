Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F118048A476
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343731AbiAKAhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:37:09 -0500
Received: from ms.lwn.net ([45.79.88.28]:51112 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243194AbiAKAhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:37:08 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AEEBC378;
        Tue, 11 Jan 2022 00:37:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AEEBC378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641861427; bh=061YdezqR5dKI/s7KvDyFuJ0KmD4Akd4qE617b2KoiA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AnWixQy2UwGOWY3tLumAeQQ9tG6hGqHXUUGsDECy2YnZnPPoEA6XlBCYywS3TQif/
         NKqJ+1JMdqu9exJllhs+j1iJksUKr+uKs0nmuH+nt74FkTOwcu8wgJ8goxFZu/tynm
         BPFUMYu0+aC0wzDvB+wzlydiZH4WqClekNuWgHILIdh71/Vfb36vcEwhuu1xYZ7ZqL
         3mD3OBUdML/LCTwMVZv9ChhAtevF6xxH9SBiZyPj9Zbx+4nZnNfEyiEPHDkGhPCtvO
         WEeZWtarx1iKsPKfxaBEnPSOiQd/Q/Tp52WQynAaMVlHFWXfs19msAVa68zUVHbhio
         PUchTDGb0GSQA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] docs: consolidate sysfs-block into
 Documentation/ABI/
In-Reply-To: <fff11146-f759-2887-5c80-6449dbc16717@kernel.dk>
References: <20211209003833.6396-1-ebiggers@kernel.org>
 <YcH1uxfdTRHIwl7Y@quark> <YdMQ6rfSZWSOLptA@quark>
 <YddiJFr+ba7Veh82@sol.localdomain>
 <65376e36-579b-76c4-0642-4582d6679914@acm.org>
 <ef487b83-a1cc-d8a5-8a45-d0fec5eed94b@kernel.dk>
 <YdtS3x0M1qFcN3R1@sol.localdomain>
 <fff11146-f759-2887-5c80-6449dbc16717@kernel.dk>
Date:   Mon, 10 Jan 2022 17:37:19 -0700
Message-ID: <87k0f7hzuo.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 1/9/22 2:25 PM, Eric Biggers wrote:
>> I think it makes much more sense for subsystems to be responsible for
>> their own documentation; that's why patch 8 in this series adds the
>> block layer documentation to the block layer MAINTAINERS entry.  Do
>> you disagree with that?
>
> I agree, but then we often end up with merge conflicts between the doc
> tree and others. That's why it's usually punted there. As a maintainer,
> any conflicts is a pain in the butt to deal with, something the
> contributor doesn't necessarily see or understand.
>
> If there are no conflicts this time around, I can queue them up.

[Docs maintainer not copied on any of this, but you can't escape :)]

Maintaining docs is a bit of a challenge for the reason Jens mentions:
everybody puts their fingers into it, and the result is lots of merge
conflicts.  For that reason, I'd prefer that big changes go through the
docs tree.  Changes to directories like Documentation/ABI can be
especially prone to conflicts, FWIW.

I also tend to be a bit more attentive to things like the addition of
docs-build warnings than maintainers from other subsystems.

That said, the real goal is to get more and better documentation merged,
and it often does make the most sense for docs changes to go through
other trees.  Forcing the separation of documentation changes from the
code changes they reflect would be kind of silly at best, for example.
So if the block tree is the best path for these changes, then all I can
say is:

  Acked-by: Jonathan Corbet <corbet@lwn.net>

Thanks,

jon
