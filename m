Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6F5576DBF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 14:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiGPMOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 08:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGPMOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 08:14:17 -0400
Received: from mr3.vodafonemail.de (mr3.vodafonemail.de [145.253.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ECC1EAFC;
        Sat, 16 Jul 2022 05:14:14 -0700 (PDT)
Received: from smtp.vodafone.de (unknown [10.0.0.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mr3.vodafonemail.de (Postfix) with ESMTPS id 4LlRwh1dSLz1ym7;
        Sat, 16 Jul 2022 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arcor.de;
        s=vfde-mb-mr2-21dec; t=1657973652;
        bh=o7UjNYKMl3/3hSFoi5VWZ2IA2hFagmEsJbxcjetH77Q=;
        h=Date:From:To:Subject:Message-ID:References:Content-Type:
         In-Reply-To:From;
        b=MGRy9PSZVYZVjOIygl9dU7cFagxn3PbeEe2j2N7PWYrTR5YOd0wdqmp0Rmfp1Sr5W
         K2UROpzcG+q0JaJWEBRH4OJoK+ViddBsq1dX0qi0e6uRrlCnVmdUUy34uHo7lWYI/8
         Z4r9V4bSFp8KxA5VRCY241vSJYqoKh4HGCrUqits=
Received: from arcor.de (p57a23d6e.dip0.t-ipconnect.de [87.162.61.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.vodafone.de (Postfix) with ESMTPSA id 4LlRwK1CBtzMmvP;
        Sat, 16 Jul 2022 12:13:49 +0000 (UTC)
Date:   Sat, 16 Jul 2022 14:13:34 +0200
From:   Reinhard Speyerer <rspmn@arcor.de>
To:     sdlyyxy <sdlyyxy@bupt.edu.cn>
Cc:     johan@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: usb-serial-simple: add new device id for OPPO R11
Message-ID: <YtKrbucYNulPEKUp@arcor.de>
References: <20220715142444.4173681-1-gregkh@linuxfoundation.org>
 <119D7B0F-7809-464A-AFF1-DF72FFF9E63F@bupt.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119D7B0F-7809-464A-AFF1-DF72FFF9E63F@bupt.edu.cn>
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 2217
X-purgate-ID: 155817::1657973645-1C2F12A7-43E28DD5/0/0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:59:13PM +0800, sdlyyxy wrote:
> 
> > On Jul 15, 2022, at 22:24, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > The Oppo R11 diagnostic USB connection needs to be bound to the
> > usb-serial-simple driver as it just wants to use a dumb pipe to
> > communicate to the host.
> > 
> > usb-devices output:
> > T: Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 10 Spd=480 MxCh= 0
> > D: Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
> > P: Vendor=22d9 ProdID=276c Rev=04.04
> > S: Manufacturer=OPPO
> > S: Product=SDM660-MTP _SN:09C6BCA7
> > S: SerialNumber=beb2c403
> > C: #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
> > I: If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30
> > 
> > Reported-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> > Cc: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > drivers/usb/serial/usb-serial-simple.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
> > index 4c6747889a19..eb832b94aa3a 100644
> > --- a/drivers/usb/serial/usb-serial-simple.c
> > +++ b/drivers/usb/serial/usb-serial-simple.c
> > @@ -60,7 +60,9 @@ DEVICE(flashloader, FLASHLOADER_IDS);
> > 	{ USB_VENDOR_AND_INTERFACE_INFO(0x18d1,			\
> > 					USB_CLASS_VENDOR_SPEC,	\
> > 					0x50,			\
> > -					0x01) }
> > +					0x01) },		\
> > +	{ USB_DEVICE_AND_INTERFACE_INFO(0x22d9, 0x276c,		\
> > +					0xff, 0xff, 0x30) }
> > DEVICE(google, GOOGLE_IDS);
> > 
> > /* Libtransistor USB console */
> > -- 
> > 2.37.1
> Tested-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>

While this may work sufficiently well for real low-volume diag traffic I'd
expect a significant percentage of diag messages to be lost in practice
with the usb-serial-simple driver.

According to the usb-devices output this looks like the Qualcomm USB gadget
in the DIAG + ADB composition to me.

Since the option driver uses the usb-wwan framework my suggestion would be
for the original patch to be applied instead similar to what has been done
e.g. for the Quectel RM500Q diag port.

Regards,
Reinhard
