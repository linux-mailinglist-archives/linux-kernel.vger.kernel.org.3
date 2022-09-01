Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8BE5A9ADB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiIAOu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiIAOu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:50:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B68627154
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1656EB826EA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333C7C433C1;
        Thu,  1 Sep 2022 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662043822;
        bh=BoGf59hOampb5HCumLLSOAlkqzHK6UnMybBZlK+tHP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATobOqmi+scsqk63XtfRbw1ZYT8b4n8ZIZY2MPGNMYe3ypjEJCA9eA0Hi7lWBxWsn
         VlMseG+KF0YTL6Gy3cLZTJ+9WT7A//v2vJTQHFIVYJV3SuacGiGE44yTgFO1SFHB2t
         2CFVeYvI3vMcDfy/AeKs+hE//sXCp9pOXm0OKEGP/jzlgOpkQ2kB+QWNv7F+hP7x7a
         XDuPC0I5vtkKGTaJYxtNmtanHGjpYwZwFJgdGZxllF5p1FCO0do0PWkeA3O9B9THto
         8xwfo880dsheRu1mKVcrX5H5tSVdMw/82XZ+ONUhap7yPwf/AWbR9bmI84jFrXQycq
         ozQWebVf3e+jg==
Date:   Thu, 1 Sep 2022 15:50:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 2/3] regmap: trace: Remove explicit castings
Message-ID: <YxDGqdzv3uvEgALv@sirena.org.uk>
References: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
 <20220901132336.33234-2-andriy.shevchenko@linux.intel.com>
 <YxC0SYShl14TSw2o@sirena.org.uk>
 <CAHp75VcrBS=+bxXz62HB6joB3+6meVK9YJtJOYSS3PNrY13AVg@mail.gmail.com>
 <20220901104601.01773fb8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PzN2XMb6HYYWhfeJ"
Content-Disposition: inline
In-Reply-To: <20220901104601.01773fb8@gandalf.local.home>
X-Cookie: This bag is recyclable.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PzN2XMb6HYYWhfeJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 01, 2022 at 10:46:01AM -0400, Steven Rostedt wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> > Perhaps that (dark) magic disappeared a long time ago since in my
> > practice of adding trace events this is the first (and probably
> > oldest) one which has these castings. Perhaps Steven can shed a light.

> There was no dark magic for those castings. The trace events never needed
> them. It was added from the original commit:

> fb2736bbaee0e ("regmap: Add basic tracepoints")

Right, they were added in the original commit because as far as I could
tell at that time they were needed for things to build (or possibly
build cleanly, it's been a while).

--PzN2XMb6HYYWhfeJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMQxqgACgkQJNaLcl1U
h9Cqvwf7BfUoPtz5b+L8B95REcq9gP1zV0/53V7vfzwKjVt5RTLwxXZHUZNK1jcT
pvvNN8ryljfqTGBmmyBAum4Xle04WiLXfXy1CBOjLVuvEzYZmRoWBenJbBn0rVmp
9K3ne1z/tIfE7K0/rJk9s6fw+ijX/iA3VI6m0NZk9APU/IOt3TtSk5PB8mWD9epg
Rtl7jDmR4KbpXqM7RHuUAnVkH/xLEqkdb0knDJY64eNonIo4pPl4Z4FrU/hSZesB
KUoANp+ftIYyARoJ+xlCuH7fkAseC/oh62v6grqMv7dqytZbYJH8ucPcttBZ+HNY
mx3gZq9U6hSnDcLxIPOwiUdOYKK/FQ==
=mKQL
-----END PGP SIGNATURE-----

--PzN2XMb6HYYWhfeJ--
