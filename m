Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8144CB9F6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiCCJQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiCCJQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:16:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0522311985B;
        Thu,  3 Mar 2022 01:15:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B103B82460;
        Thu,  3 Mar 2022 09:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E7DC004E1;
        Thu,  3 Mar 2022 09:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646298945;
        bh=fWn/6Uo6c7wBZusQRJKxDw4ss93qfGuobVS5kHNpmko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gkhNofCpsZQ01kLX+ckXQsmqGF6mnFMZR2x/JCP4D54/iDl90cqjH4/rD2LvM22oq
         zX873AeVkT9XYvofUSu1yyEQpzKQR7+o7JTeLPB2Ma+aqZJkmcfElTJ4haWMRQh1NC
         xQcN5JNX60yhdUc5Wcskw/fXDTre25RUE99K2GgH5xS0yh24j0uKoA8ZOpEpgRfOBQ
         8ok5tqKoA8Iktwh2l4ujcpQZK5EvSJVRWKQcRVaI7FBDSk+7n5AtcAUwnMJypyYpXB
         cnqBiK9sMTONlbPQXQIPtmbIMDc43tyJgWa6HuC3LkucS2nSMCiyp5DS3MwH+b7cTY
         IMOJgOtPvbVgQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nPhYk-0002IB-68; Thu, 03 Mar 2022 10:15:42 +0100
Date:   Thu, 3 Mar 2022 10:15:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Eddie James <eajames@linux.ibm.com>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] USB: serial: pl2303: Add IBM device IDs
Message-ID: <YiCHPuNkMuO4uARu@hovoldconsulting.com>
References: <20220301224446.21236-1-eajames@linux.ibm.com>
 <YiB7gz0GJ1Uz0mE2@hovoldconsulting.com>
 <CACPK8XfoCXisL=udkuO-x4LZ3r-9iKA2d7oLb7KmXs3+LkQgnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XfoCXisL=udkuO-x4LZ3r-9iKA2d7oLb7KmXs3+LkQgnQ@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 08:52:29AM +0000, Joel Stanley wrote:
> On Thu, 3 Mar 2022 at 08:25, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Tue, Mar 01, 2022 at 04:44:46PM -0600, Eddie James wrote:
> > > IBM manufactures a PL2303 device for UPS communications. Add the vendor
> > > and product IDs so that the PL2303 driver binds to the device.
> > >
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > > ---
> > > Changes since v1:
> > >  - Fix commit message Signed-off-by ordering.
> >
> > Almost there. You're still missing a Co-developed-by tag, a From line,
> > or both.
> 
> It's neither. This patch was applied to a tree by myself, and I asked
> Eddie to send it to mainline for merging.

Then you are missing a From line. As the patch looks like know, Eddie is
considered the author and not you.

> Given it's come through me, and now has been sent to you, I think the
> chain of s-o-b is appropriate.

So the chain of SoB is correct, but the authorship is not.

You can use git-format-patch and git-send-email to avoid this kind of
problems, but just manually inserting a From line in the body of the
mail works too.

Johan
