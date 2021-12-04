Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8314685CF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 16:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242841AbhLDPEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 10:04:08 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51563 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231150AbhLDPEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 10:04:06 -0500
Received: from callcc.thunk.org (96-65-121-81-static.hfc.comcastbusiness.net [96.65.121.81])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B4F0YGA030968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 4 Dec 2021 10:00:35 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 158174205DB; Sat,  4 Dec 2021 10:00:34 -0500 (EST)
Date:   Sat, 4 Dec 2021 10:00:34 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: co-maintain random.c
Message-ID: <YauCkjsgDL4sdCId@mit.edu>
References: <20211130184315.258150-1-Jason@zx2c4.com>
 <1c2862682ff04463c7ca1f58f1c46aec4d6af03d.camel@perches.com>
 <CAHmME9q7kVREOGPpG+kafS25Ny1=geFPwLRREe+nkC=UkGQUHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9q7kVREOGPpG+kafS25Ny1=geFPwLRREe+nkC=UkGQUHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:05:31AM -0500, Jason A. Donenfeld wrote:
> Hi Joe,
> 
> On Tue, Nov 30, 2021 at 8:01 PM Joe Perches <joe@perches.com> wrote:
> > I suggest you reverse the entry order too as Ted really
> > hasn't done much to random.c for quite awhile.
> 
> Linus applied this already, but also, I both don't think the order
> really matters that much, and I'd really rather this be a "co-" thing,
> rather than rocking the boat.

Jason,

Thanks for stepping up.  There's no question that this Fall has been
insanely busy for me, and for the past 3 weeks or so, I've been on
vacation and Thanksgiving travel, and I'm still catching up on a
mountain of e-mail.

Something that I think would make sense is that we set up a joint git
tree on git.kernel.org, for which we would both have access to push
to, and use a group maintainership model much like what other teams
have done.  Do you agree?

						- Ted
