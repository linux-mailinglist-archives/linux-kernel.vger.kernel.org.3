Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9386514269
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354564AbiD2GhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiD2GhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF75078FFE;
        Thu, 28 Apr 2022 23:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B13661D10;
        Fri, 29 Apr 2022 06:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A915C385A7;
        Fri, 29 Apr 2022 06:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651214034;
        bh=tycC/zOW2yFKpGweWIJOd97KwA/m8/yHfO9vb8YCToA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xMIDLE6yeaSE2dObG25RQPxnHLRGbVhID/pg8WnMawdleHGthYO8nHNFQBWslDnGe
         4GcxSLTYU1tuIvzZwqm8B69eFbfIIP1xkKh8FRn1/7tlzz37LyC0sG30dAcXla/YKK
         dlUf99JrkhmWIZSKkFpxzBkBx2eW4+aUTZJx5a04=
Date:   Fri, 29 Apr 2022 08:33:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>
Cc:     John Stultz <jstultz@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] firmware_loader: use kernel credentials when reading
 firmware
Message-ID: <YmuGyhWHnFie7koT@kroah.com>
References: <20220428061707.768468-1-tweek@google.com>
 <YmpQOSf0bdOcIZSU@kroah.com>
 <CA+zpnLcV40ciweXMr+W+qT0xGgKAsUq47x26JGYaiOiQYcshfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+zpnLcV40ciweXMr+W+qT0xGgKAsUq47x26JGYaiOiQYcshfg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 02:54:24PM +1000, Thiébaud Weksteen wrote:
> > As stated before, should this go to stable kernels?  If so, how far
> > back?
> 
> Yes, it should go to stable kernels. It should apply cleanly on 5.10.
> Ideally, up to 4.19 but it will require a fixup. I can send a
> backported patch for 5.4 and 4.19 branches once it lands in the main
> tree.

Great, can you resend it with a cc: stable tag added to it?

> > And you forgot to cc: John?
> 
> Done

On the patch itself?  Or just this email?

confused,

greg k-h
