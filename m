Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149FD584C14
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiG2GhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiG2GhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:37:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AB6DE3;
        Thu, 28 Jul 2022 23:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A6C83CE28B8;
        Fri, 29 Jul 2022 06:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6909C433C1;
        Fri, 29 Jul 2022 06:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659076625;
        bh=8Jag/01ijItSPIUv7n1Jh6SzTpw7Iix7xqq9oajdk3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uU/zqLZF1rzNgDx3FapLWorVJ7YFQwPzNtGMH+dU5KO7C5yvpCprkVif5Dz7ZZ/zN
         boncG1BcFpmttuKXn6to2CwY4Uzu6OAc0k5hhxZ13K8cpqTZdtCpXCKbT3C15p2kmn
         t7lxXjhFaBpexaifmpLZbniXEMNWxQEBfAMMlmJxSt4ja0E5+vrjwKnjfz142w8lpS
         e9R5egQd+Uv0zuYdN+BEVXEuhIDN0MLmrv8o0DIA7CDC045LhxAi2DK9y143hq3i38
         6bU5RcxzftwG60gsLjae7dNUq8+0usuJeAB/eISeGBMIkht3IJsi7JYQFdu1SypcfA
         dipTuWOflKAhg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oHJcf-0004VL-Fx; Fri, 29 Jul 2022 08:37:21 +0200
Date:   Fri, 29 Jul 2022 08:37:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     sdlyyxy <sdlyyxy@bupt.edu.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Reinhard Speyerer <rspmn@arcor.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: usb-serial-simple: add new device id for OPPO R11
Message-ID: <YuOAIdKlJKyh9o2k@hovoldconsulting.com>
References: <20220715142444.4173681-1-gregkh@linuxfoundation.org>
 <119D7B0F-7809-464A-AFF1-DF72FFF9E63F@bupt.edu.cn>
 <YtKrbucYNulPEKUp@arcor.de>
 <YtRtswctFMLxeglu@kroah.com>
 <YtXG3EVrRKAG7WVx@arcor.de>
 <YtwjiWG5ZFBvCZ1M@hovoldconsulting.com>
 <Yt1QhCIiUf97Dl3D@kroah.com>
 <Yt1WfSZk03Plpnan@hovoldconsulting.com>
 <B47DDA3C-3CE2-4E25-B764-1744A4AA04A0@bupt.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B47DDA3C-3CE2-4E25-B764-1744A4AA04A0@bupt.edu.cn>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 02:13:56PM +0800, sdlyyxy wrote:
> 
> > On Jul 24, 2022, at 22:26, Johan Hovold <johan@kernel.org> wrote:
> > 
> > On Sun, Jul 24, 2022 at 04:00:36PM +0200, Greg Kroah-Hartman wrote:
> >> On Sat, Jul 23, 2022 at 06:36:25PM +0200, Johan Hovold wrote:
> >>> On Mon, Jul 18, 2022 at 10:47:24PM +0200, Reinhard Speyerer wrote:
> > 
> >>>> Please don't give the OPPO R11 diag port on Linux a bad name by letting
> >>>> the usb-serial-simple driver handle it.
> >>> 
> >>> So while I'm not sure bandwidth is really a problem, I still tend to
> >>> agree that we should add this one to the option driver for now as that
> >>> is how we handle (non-GOBI) Qualcomm modems and their QCDM ports.
> >> 
> >> If you want it to stay on the option driver, that's fine, but I still
> >> think it feels odd as it obviously does not follow the vendor-specific
> >> protocol that the option driver supports.
> > 
> > But we've been dumping modem device-id entries in there since forever.
> > 
> > The entries added to option have been for devices whose interfaces did
> > not follow any particular pattern (e.g. unlike the old GOBI modems).
> > 
> > And as Reinhard mentioned, the line-control requests (which follow CDC)
> > are actually required by some Qualcomm modems so moving things out would
> > need to be done carefully.
> > 
> > On the other hand, that request likely isn't needed for any QCDM/DIAG
> > ports, but who knows for sure.
> 
> Test result for bandwidth problem:
> Sending 0x1f mask (diag command: 0x7d0500001f000000) and running LTE
> speedtest on the device, both option and simple can dump more than 80Mbps.
> The CRC of diag packets is OK at this high speed, so it seems that
> there is no message loss. I think this bandwidth is enough.
> 
> For the flow control problem, it seems the SetControlLineState request
> send by option (usb_wwan) has no effect on the device. Both with and
> without this request the diag port works the same.
> 
> Hope this can help you decide which driver to choose :)

Thanks a lot for confirming! I'll try to revisit this next week and get
something merged for 5.20-rcN.

Johan
