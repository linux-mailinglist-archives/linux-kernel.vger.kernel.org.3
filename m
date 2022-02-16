Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE4E4B8C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiBPP0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:26:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiBPP0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:26:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BB025FE6F;
        Wed, 16 Feb 2022 07:26:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 024B1B81F1A;
        Wed, 16 Feb 2022 15:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428C2C004E1;
        Wed, 16 Feb 2022 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645025164;
        bh=Ou52iRiRLz7OENHYEtdXNdD+r15floyf6qR4WAeGsrc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=CnQa1VHD8SSUONFJzIBUJakD2sKHDYgVwfWPnq/SKzHjQ9hqNUzNXVERZRq/i6CAh
         IPm2GVCXj2/0mpjV2+CiOMpRX92HeaxchBZZUCh7VpqR6Xbxl1BKJs2jgBYd5oUytx
         iJ74UxsWpt/ZpU4Mqbr//VwlzpQGHSeepjlwzhJR0ng/tueYdA1q2IiDukzmW7PRTi
         Fp2WVyBIaUAU7AC0Fuuwj426jLr1tRMbPJVI50DwSR4HCDqzqtMFAo+oLEafhH1lt7
         yrYS6x3Wj5vyhe7hadD9A03+xfiencuTtqzefV0Bj91CzW/Ky5UylyL2sqYDTkyJJN
         9ToSLgjflc5Ew==
Date:   Wed, 16 Feb 2022 16:26:00 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Nestor Lopez Casado <nlopezcasad@logitech.com>
cc:     =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Lucas Zampieri <lzampier@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: logitech-dj: add new lightspeed receiver id
In-Reply-To: <CAE7qMro-ies_7DXhvqWE=aNhGcZKTFGxj9xmU38w12jHTOWbmA@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2202161625300.11721@cbobk.fhfr.pm>
References: <20220126144400.130797-1-lzampier@redhat.com> <CAO-hwJ+KyV+Ks38DDF8EuT9kEc9jd9SvNn=nGyTwjkD3GOQ+RA@mail.gmail.com> <15ef80cc2ecdcc993043aa0c1d5ea88f41f9b67b.camel@riseup.net> <CAE7qMro-ies_7DXhvqWE=aNhGcZKTFGxj9xmU38w12jHTOWbmA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022, Nestor Lopez Casado wrote:

> > > > As of logitech lightspeed receiver fw version 04.02.B0009,
> > > > HIDPP_PARAM_DEVICE_INFO is being reported as 0x11.
> > > >
> > > > With patch "HID: logitech-dj: add support for the new lightspeed receiver
> > > > iteration", the mouse starts to error out with:
> > > >   logitech-djreceiver: unusable device of type UNKNOWN (0x011) connected on
> > > >   slot 1
> > > > and becomes unusable.
> > > >
> > > > This has been noticed on a Logitech G Pro X Superlight fw MPM 25.01.B0018.
> > >
> > > The patch looks good to me.
> > >
> > > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >
> > > Ideally, Nestor, can you confirm this is expected and that we won't
> > > have any bad surprises there?
> Yes, I confirm this matches our specifications, this is an iteration
> of Lightspeed 1.2
> No objections on my side.

Thanks. Based on this, I've applied this with

	Acked-by: Nestor Lopez Casado <nlopezcasad@logitech.com>

then. Please shout out loudly if you're not ok with that :)

-- 
Jiri Kosina
SUSE Labs

