Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D89515512
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379345AbiD2UEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380506AbiD2UD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:03:58 -0400
Received: from twin.jikos.cz (twin.jikos.cz [91.219.245.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DC9F654C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:00:36 -0700 (PDT)
Received: from twin.jikos.cz (dave@localhost [127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id 23TJxqce021173
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 29 Apr 2022 21:59:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=jikos.cz; s=twin;
        t=1651262393; bh=VzLGIghLtW44gaV6piRFTko5CkCVGLje8VzOmGvSv9I=;
        h=Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:
         Mail-Followup-To:References:MIME-Version:Content-Type:
         Content-Disposition:In-Reply-To:User-Agent; b=Of48yY/gsil0Fi9ss77I
        BasrlP3ehM2uPO8+pQXXT9JQhWG4aaeDR1RhhKXSEZ1MPOk+ZIiCEP/KNfYc7hgJIDX
        0laaGG0aFQvyLJTpWPZF2J7AoBXPoA1T6eN/kt7dEGlt7KXMqTFReuO1utYmBVdWvGi
        EQdGFyi16QxwOP7hU=
Received: (from dave@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) id 23TJxonk021168;
        Fri, 29 Apr 2022 21:59:50 +0200
Date:   Fri, 29 Apr 2022 21:59:50 +0200
From:   David Sterba <dave@jikos.cz>
To:     Kari Argillander <kari.argillander@stargateuniverse.net>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, "Theodore Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NTFS3 driver is orphan already. What we do?
Message-ID: <20220429195950.GQ3658@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: Kari Argillander <kari.argillander@stargateuniverse.net>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <da20d32b-5185-f40b-48b8-2986922d8b25@stargateuniverse.net>
 <CAHk-=wihuvzVTozzNLZT=uFzJH6uM7ZNKN7fYVpm0v2KkY6Jxg@mail.gmail.com>
 <CAKYAXd89Ypc09ZkuZT+w3TDscpB8_=wHY=JpZJb7LY1LDg+7Uw@mail.gmail.com>
 <0bf74850-fa56-9dbe-7b08-f66a9fcd39e2@stargateuniverse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf74850-fa56-9dbe-7b08-f66a9fcd39e2@stargateuniverse.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 07:45:42PM +0300, Kari Argillander wrote:
> On 28.4.2022 3.47, Namjae Jeon wrote:
> > 2022-04-28 2:47 GMT+09:00, Linus Torvalds <torvalds@linux-foundation.org>:
> >> [ Sad state of affairs mostly edited out ]
> >>
> >> On Tue, Apr 26, 2022 at 2:22 AM Kari Argillander
> >> <kari.argillander@stargateuniverse.net> wrote:
> >>>
> >>> I also did suggest that I could co maintain this driver to take burden
> >>> from
> >>> Konstantin, but haven't got any replay.
> >>
> >> If you are willing to maintain it (and maybe find other like-minded
> >> people to help you), I think that would certainly be a thing to try.
> > I can help him.
> 
> We have now discuss with Namjae and we will start this and let's see
> where it goes. I will get my PGP signed soon. I really want code to be
> in kernel.org so that maintainership is easily transfer if necessary,
> but let's hope long and steady route now on.
> 
> Hopefully we are ready to start by next merge window.

Feel free to ping me if you have questions regarding the pull requests
or would like to have it checked before sending. It would be
disappointing to see the NTFS3 module removed, thanks for taking up the
torch.
