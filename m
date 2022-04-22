Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBF250B0AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444429AbiDVGfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444424AbiDVGfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:35:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9C050B34;
        Thu, 21 Apr 2022 23:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0DEF61E83;
        Fri, 22 Apr 2022 06:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3234EC385A0;
        Fri, 22 Apr 2022 06:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650609160;
        bh=lalQc1VEKRTVWs2GqXvLF+tWm/dV5uDBEwlrHFlqQHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ld45dnmTVZo0eb4k7APe18gDMPOweSZ2XajmngIReqeR7S1JMRkdLzt9lYf2lvXeG
         EgSewXuh+9KSDejcyBx8jGdgQffdnaGGLs4/imyRkHZUnKKw3HWNo/tdVhO+YErdUr
         rsgotDoVqIThJkBvmqV9zwKDZUZEP6/Tgpb+i7zlavB5y3ndhcXUu3OQS/0xb13iE1
         w91gJ+5Ei7pFdJuWBuNQa1WnLERfMkCmYsPgnDTpdLcU8FeDfq3OMBBmHPOwlTHqKj
         4WfI7R+4YqJW7atrO9azvzMroJlbv74yeKLR4K/hibSoukh6E75cV3lgAnfR0jyC5z
         dWNarfE0MMpsg==
Date:   Thu, 21 Apr 2022 23:32:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the random tree with the jc_docs tree
Message-ID: <YmJMBnBV8wO4aco9@sol.localdomain>
References: <20220422135927.7fa82fa4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422135927.7fa82fa4@canb.auug.org.au>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:59:27PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the random tree got a conflict in:
> 
>   Documentation/security/siphash.rst
> 
> between commits:
> 
>   dc701cfc5b26 ("Documentation: siphash: convert danger note to warning for HalfSipHash")
>   561fb3cd5ec2 ("Documentation: siphash: enclose HalfSipHash usage example in the literal block")
> 
> from the jc_docs tree and commit:
> 
>   91afe794c070 ("siphash: update the hsiphash documentation")
> 
> from the random tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc Documentation/security/siphash.rst
> index 06d793e68086,79ac8101406c..000000000000
> --- a/Documentation/security/siphash.rst
> +++ b/Documentation/security/siphash.rst
> @@@ -121,15 -121,23 +121,25 @@@ even scarier, uses an easily brute-forc
>   instead of SipHash's 128-bit key. However, this may appeal to some
>   high-performance `jhash` users.
>   
> + HalfSipHash support is provided through the "hsiphash" family of functions.
> + 
>  -**Danger!** Do not ever use the hsiphash functions except for as a hashtable key
>  -function, and only then when you can be absolutely certain that the outputs will
>  -never be transmitted out of the kernel. This is only remotely useful over
>  -`jhash` as a means of mitigating hashtable flooding denial of service attacks.
>  +.. warning::
>  +   Do not ever use HalfSipHash except for as a hashtable key function, and
>  +   only then when you can be absolutely certain that the outputs will never
>  +   be transmitted out of the kernel. This is only remotely useful over
>  +   `jhash` as a means of mitigating hashtable flooding denial of service
>  +   attacks.

That's not exactly the correct resolution, since it dropped the change to the
text of this paragraph that my patch made ("HalfSipHash" => "the hsiphash
functions").

We should get the updates to this file to go through one tree.  Jason, probably
you'd want it to be yours?

- Eric
