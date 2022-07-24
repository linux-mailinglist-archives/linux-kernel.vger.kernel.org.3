Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67DD57F580
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 16:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiGXO0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 10:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiGXOZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 10:25:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAEE6454;
        Sun, 24 Jul 2022 07:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 335FC6110F;
        Sun, 24 Jul 2022 14:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D046C3411E;
        Sun, 24 Jul 2022 14:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658672756;
        bh=h7jrZwkYGrnkhPbTECXqkK1Cud9+sZlYjkmb2gYk2Yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N13+dGlh8AXdIr0uj1qUKJA5DlnjcKUHWS6Pz6jZCRYggluzcNDzec7yul/PkjfiC
         hmF0S/fb9V3LvRgv9oggbG77BhLc2LMbKQ9tbRo+B2KmtGOYhc1eLLum6hYODqqSpD
         UHgmMt7SwOPcWENFFaLtBh7cX4+HBuPBUCO2pw8KE8ICSSprnbiorOc0LGFXzh66TL
         xpTQyGs/ybb15pWK/Kqg+r4NQHDOAIKbirzmIZdutZW0/1dZ9e0BUov7TnFWtwnt1S
         iYOoQcOSoUTAuxFAODDMsEZCojSakFxUMgvWDmYYnu2+mWSY6EoHEu2LQ+aL6eNLxE
         VvmoYkEiyLZYA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFcYX-0003JW-Ab; Sun, 24 Jul 2022 16:26:05 +0200
Date:   Sun, 24 Jul 2022 16:26:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Reinhard Speyerer <rspmn@arcor.de>, sdlyyxy <sdlyyxy@bupt.edu.cn>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: usb-serial-simple: add new device id for OPPO R11
Message-ID: <Yt1WfSZk03Plpnan@hovoldconsulting.com>
References: <20220715142444.4173681-1-gregkh@linuxfoundation.org>
 <119D7B0F-7809-464A-AFF1-DF72FFF9E63F@bupt.edu.cn>
 <YtKrbucYNulPEKUp@arcor.de>
 <YtRtswctFMLxeglu@kroah.com>
 <YtXG3EVrRKAG7WVx@arcor.de>
 <YtwjiWG5ZFBvCZ1M@hovoldconsulting.com>
 <Yt1QhCIiUf97Dl3D@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt1QhCIiUf97Dl3D@kroah.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 04:00:36PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Jul 23, 2022 at 06:36:25PM +0200, Johan Hovold wrote:
> > On Mon, Jul 18, 2022 at 10:47:24PM +0200, Reinhard Speyerer wrote:

> > > Please don't give the OPPO R11 diag port on Linux a bad name by letting
> > > the usb-serial-simple driver handle it.
> > 
> > So while I'm not sure bandwidth is really a problem, I still tend to
> > agree that we should add this one to the option driver for now as that
> > is how we handle (non-GOBI) Qualcomm modems and their QCDM ports.
> 
> If you want it to stay on the option driver, that's fine, but I still
> think it feels odd as it obviously does not follow the vendor-specific
> protocol that the option driver supports.

But we've been dumping modem device-id entries in there since forever.

The entries added to option have been for devices whose interfaces did
not follow any particular pattern (e.g. unlike the old GOBI modems).

And as Reinhard mentioned, the line-control requests (which follow CDC)
are actually required by some Qualcomm modems so moving things out would
need to be done carefully.

On the other hand, that request likely isn't needed for any QCDM/DIAG
ports, but who knows for sure.

> To be fair, loads of the ids in that driver could move to the simple
> driver as they probably do not also support the line setting protocol
> that this driver was originally written for, so what's a few more ids
> added :)

Not sure about the simple driver, unless we want to handle say NMEA and
MODEM ports using different drivers. But either way, for now I think we
can add a few more to option.

If we start seeing patterns regarding the Qualcomm interface
descriptors, like the QCDM interface using 0xff/0xff/0x30, we could
implement something more generic in qcserial too.

But the lack of documentation and unification is just a pain to deal
with. So someone would need to be motivated enough to try to organise
this mess.

Johan
