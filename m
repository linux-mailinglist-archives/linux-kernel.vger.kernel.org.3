Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C05652B0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 05:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiERDj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 23:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiERDjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 23:39:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E8467D04;
        Tue, 17 May 2022 20:39:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5EE4B81E5F;
        Wed, 18 May 2022 03:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B52C385AA;
        Wed, 18 May 2022 03:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652845181;
        bh=cGE6K8BSkWYEYJzcC+LvrmjnjPeuC6gmrfEOgB9kGas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/eaztojNKZJ1+GUcrbryjyyzu4mhCTGtl6zMcSqJDsNEjg2LEFtEKWvy2RzntjIX
         jd4HrkDPwNbju62Kf1HXGXrrtAwcL1sTNxc4aAIrpP4MwTWdNGn2jARxHvg9ToWFaP
         7rkmimQsgxlbGFjB7xCT5vqwEjO3fG3LX/mvOOZPSUPkZarUNfplWv51Q5GGKoDXre
         nKaeN1r+3EB7kzwnqU5mVS4N1HYX1oY9TCPJOjzEsEpl/kEacMTrhkJny9TGfTmtXQ
         xlsL5H5KSuY2Nhb/tY6iX1665kyrtweOXQ8jXbuYyh2q18aQeeoM9ZqN7+1RaWLK/5
         yxkLqMQvlz+Rg==
Date:   Wed, 18 May 2022 11:39:37 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the chrome-platform tree
Message-ID: <YoRqeYlk8vJaFKFS@google.com>
References: <20220516213832.19127535@canb.auug.org.au>
 <5d148732-c14d-4e96-f8fc-31acc8932534@collabora.com>
 <b159beea-c7ab-b175-26c2-496f82443470@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b159beea-c7ab-b175-26c2-496f82443470@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 10:23:28AM +0700, Bagas Sanjaya wrote:
> On 5/17/22 20:09, Muhammad Usama Anjum wrote:
> > I've found these warnings in local build. But I'm unable to fix them.
> > Apparently, there doesn't seem any unexpected indentation. This kind of
> > same warnings have also appeared on some more files before this commit
> > without any reason.
> > 
> 
> Hi,
> 
> I've figured out the fix on [1]. Please review.
> 
> [1]: https://lore.kernel.org/linux-next/20220518031750.21923-2-bagasdotme@gmail.com/

Thanks for figuring it out.  I was also investigating on the issue but got no clues.

Reviewed on [1].
