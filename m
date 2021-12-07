Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1586E46C242
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbhLGSFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:05:24 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45769 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240013AbhLGSFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:05:24 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-106.corp.google.com [104.133.8.106] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B7I1V2e029335
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Dec 2021 13:01:33 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 242EA4205DB; Tue,  7 Dec 2021 13:01:31 -0500 (EST)
Date:   Tue, 7 Dec 2021 13:01:31 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] MAINTAINERS: co-maintain random.c
Message-ID: <Ya+he+CE/EkS2ekQ@mit.edu>
References: <20211130184315.258150-1-Jason@zx2c4.com>
 <1c2862682ff04463c7ca1f58f1c46aec4d6af03d.camel@perches.com>
 <CAHmME9q7kVREOGPpG+kafS25Ny1=geFPwLRREe+nkC=UkGQUHw@mail.gmail.com>
 <YauCkjsgDL4sdCId@mit.edu>
 <CAHmME9q_hYyiUKb+H82-njugXaruQc6=sVa3HCQHnOHEOsGVwQ@mail.gmail.com>
 <CAHmME9qECnsh0EhV8Zi0vFntqT4OaAbhfOXFFZBjQjzpReNAJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qECnsh0EhV8Zi0vFntqT4OaAbhfOXFFZBjQjzpReNAJg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 04:49:10PM +0100, Jason A. Donenfeld wrote:
> 
> We're all set now with
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/crng/random.git

Stephen, could you replace

https://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git

with

https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git

As the tree that you pull for linux-next?   Thanks!

       	    	     	      		    - Ted
