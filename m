Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B365303BA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 17:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347652AbiEVPFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 11:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiEVPFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 11:05:51 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B4733A2D;
        Sun, 22 May 2022 08:05:50 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6B3541C0B82; Sun, 22 May 2022 17:05:48 +0200 (CEST)
Date:   Sun, 22 May 2022 17:05:47 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pablo Ceballos <pceballos@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH] HID: Driver for Google Hangouts Meet Speakermic
Message-ID: <20220522150546.GA8071@localhost>
References: <20220405183953.2094007-1-pceballos@google.com>
 <nycvar.YFH.7.76.2204210947590.30217@cbobk.fhfr.pm>
 <CAKdAkRQ7yxFFGJg41UxptxapKiP4bmHsfw7dRNE+LPzs1PRk=A@mail.gmail.com>
 <nycvar.YFH.7.76.2205121252090.28985@cbobk.fhfr.pm>
 <CAO9JgFwA5ZhwOOY0cU3HpMOV69CTumQ50zEgU6SPNAF0zDbCGg@mail.gmail.com>
 <Yn2OlQAa9I++N80B@penguin>
 <CAO-hwJ+Rs=LYseLP7Vvr00vLvm+fTCRdh8pQ-rEduj4izSyiYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+Rs=LYseLP7Vvr00vLvm+fTCRdh8pQ-rEduj4izSyiYA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > No, that is exactly what I had in mind, thank you. Please submit this
> > entry to upstream systemd/udev project (and we can cherry-pick it into
> > our udev as well).
> >
> > In general I think we should try to avoid trivial "fixup" HID drivers if
> > it is possible. I also wondered if we could be supplying fixed-up HID
> > descriptors via request_firmware() for HID devices.
> 
> Just FYI, in case you haven't noticed it :)
> I am currently working on supporting exactly this kind of fixups
> through eBPF. I had in the past a request_firmware() patch for wacom

Is that good idea? eBPF is fairly dangerous thing, so I'd preffer
basic functionality not depend on it...

Best regards,
							Pavel
