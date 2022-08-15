Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1505A592B90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242142AbiHOKdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHOKdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:33:06 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1329A2181E;
        Mon, 15 Aug 2022 03:33:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B44A680FB;
        Mon, 15 Aug 2022 10:26:14 +0000 (UTC)
Date:   Mon, 15 Aug 2022 13:33:04 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 0/9] fw_devlink improvements
Message-ID: <Yvog4K0barAvvVeb@atomide.com>
References: <20220810060040.321697-1-saravanak@google.com>
 <YvYiF36M09dX9ASm@atomide.com>
 <CAGETcx-t0O0B+5i0FWwm5w2=ccOD5zVAaUvgQoP8PT9SOT_btw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-t0O0B+5i0FWwm5w2=ccOD5zVAaUvgQoP8PT9SOT_btw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Saravana Kannan <saravanak@google.com> [220813 00:45]:
> On Fri, Aug 12, 2022 at 2:49 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Saravana Kannan <saravanak@google.com> [220810 05:54]:
> > > Tony,
> > >
> > > This should handle the odd case of the child being the supplier of the
> > > parent. Can you please give this a shot? I want to make sure the cycle
> > > detection code handles this properly and treats it like it's NOT a cycle.
> >
> > Yup, this series works for me, so feel free to add:
> >
> > Tested-by: Tony Lindgren <tony@atomide.com>
> 
> Thanks for testing!
> 
> Btw, out of curiosity, how many different boards did you test this on?
> IIRC you had an issue only in one board, right? Not to say I didn't
> break anything else, I'm just trying to see how much confidence we
> have on this series so far. I'm hoping the rest of the folks I listed
> in the email will get around to testing this series.

Sorry if I was not clear earlier. The issue affects several generations
of TI 32-bit SoCs at least, not just one board.

> > I have some concerns though on how do we get a working -rc1 with the
> > earlier series applied? See the comments in the last patch of this
> > series.
> 
> I tried to reply, but not sure if it helps. We'll continue the discussion there.

Ack.

Tony
