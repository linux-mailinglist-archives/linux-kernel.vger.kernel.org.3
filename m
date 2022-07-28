Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EBE583E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbiG1MKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiG1MKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6218691D4;
        Thu, 28 Jul 2022 05:10:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82BE461C1E;
        Thu, 28 Jul 2022 12:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF29C433D6;
        Thu, 28 Jul 2022 12:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659010200;
        bh=QuAukCkxiWR/SUA+vxyoVL+LmxWsioU7cNOrz2AK0co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WjTTZak1v6sCeOffSGHiVS8RZ9mOzk4vS4sJm+ZXDR+G2DE+ksjP6ZyOhr/yJuu39
         JqJXlCwjIZT7AfCJJJAFZLyjYHWOnvnF2m0Gmu1BmGCRpOOyWumP0D7OQal6cju5cw
         nZOCMXxkYQrYPd/LwAsXSzx7FOXHRkDH5TEh+/bA=
Date:   Thu, 28 Jul 2022 14:09:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gary Guo <gary@garyguo.net>
Cc:     Olliver Schinagl <oliver+list@schinagl.nl>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] [RFC] Rust support
Message-ID: <YuJ8lWGKXEk03u3M@kroah.com>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
 <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com>
 <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
 <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
 <5c0bb1db-5589-32ca-ac22-4aafb3c15751@schinagl.nl>
 <20220728112114.0000003a@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728112114.0000003a@garyguo.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:21:14AM +0100, Gary Guo wrote:
> Rust requires braces around branches of if expression, and C doesn't.
> So in kernel coding style you often have:
> 
> 	if (condition) do_something();

That is not a valid kernel coding style, and our tools should catch this
and prevent it from being added to the kernel tree.

thanks,

greg k-h
