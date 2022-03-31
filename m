Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E6F4ED8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiCaLyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiCaLyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:54:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB720826F;
        Thu, 31 Mar 2022 04:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1177B81BE2;
        Thu, 31 Mar 2022 11:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B859CC340ED;
        Thu, 31 Mar 2022 11:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648727532;
        bh=a9mOGUgdT7iAt7EJjQ3oddc3bHbgvXVhoDNeftyXSOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g1WjV00TzByu4odN/Jd/wbIsLJYni8j06eg/1pLy691kCqk1pKR+81SFXT90QA5c9
         oOO4qprKkNn4qnzzmGB7GIIT09rX3qEQdDQ3alsFRQ2D4Xr9ysZqcm/tu1QV2TeQv0
         0T3UUlJx0wJNoUOBvlnh56UBEeox6oMGhXAgme78=
Date:   Thu, 31 Mar 2022 13:52:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Nas Chung <nas.chung@chipsnmedia.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dafna3@gmail.com" <dafna3@gmail.com>,
        "bob.beckett@collabora.com" <bob.beckett@collabora.com>,
        "kiril.bicevski@collabora.com" <kiril.bicevski@collabora.com>,
        "lafley.kim" <lafley.kim@chipsnmedia.com>,
        Scott Woo <scott.woo@chipsnmedia.com>,
        "olivier.crete@collabora.com" <olivier.crete@collabora.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH v6 4/6] staging: media: wave5: Add TODO file
Message-ID: <YkWV6HGkGHvgSwCj@kroah.com>
References: <SL2P216MB12463DE2E1E100E2498A5C33FBE19@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <SL2P216MB1246D7900A0B9620F1E1A038FBE19@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <YkWRN4ac0ivRn4aB@kroah.com>
 <CAFr9PXm3Mvr0guGoPDKmashMhFG6OQMvXHxwX-SD5ZHPi_sw4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXm3Mvr0guGoPDKmashMhFG6OQMvXHxwX-SD5ZHPi_sw4g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 08:42:40PM +0900, Daniel Palmer wrote:
> Hi Greg,
> 
> On Thu, 31 Mar 2022 at 20:32, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > > +  Until we can test and resolve any issues on final silicon (due 2H 2021)
> > > +  this driver should remain in staging.
> >
> > Then why not just wait?  Why merge this now?  What is the benifit of us
> > taking this code at this point in time for hardware that is no one has
> > as it is not even created?
> 
> FWIW there is an SoC that is supported (if console from initramfs on
> uart counts..) in mainline, Sigmastar ssd202d, that has this IP so it
> exists in the wild.
> I have tried to get this driver running on it and it did something but
> didn't get far enough to actually decode video.

According to the text in this driver, it will not work on these hardware
as it is broken.  Unless that text is incorrect?

greg k-h
