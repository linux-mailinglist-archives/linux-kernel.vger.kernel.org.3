Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263704EAE9C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbiC2Niv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiC2Nip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:38:45 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2504D622;
        Tue, 29 Mar 2022 06:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1648561022; x=1680097022;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FLEOBRkzAfL2PZRc8RnlDc3tQ904HRcvIZPvcxUbURY=;
  b=QZv0NETnCcdvkfnYXiUOmmDi5omZJEvlgwhkSQC9zxOeO1BK74Zh2H3M
   Y3Fjvjj0gK2XLsdCeGEqq2x0Vg1RF750fdy/DILwjXkdbLrc33oTnkFTT
   VL5tMR57yEtqXyr2A268269Po/zOe0Lbwdjlr/aYTUHwxaFRNskkCuVq/
   6kiQHJuGPBEBQ34oKbGeBaIjyUrq30SpGNQbKNEnAgvGt9SR+ZNvwWO3V
   UvY7Qey7PbGZSiqidgo92tx6zl5489osGW7gf2dD8eCigbXwomuSrv2at
   AbKPgI7Zg4k1EMT1dgjp9BJkFTYwh0UW19sL7CKgi4YcUCXVT7KHsU7Q6
   w==;
X-IronPort-AV: E=Sophos;i="5.90,220,1643670000"; 
   d="scan'208";a="22963306"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 29 Mar 2022 15:37:00 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 29 Mar 2022 15:37:00 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 29 Mar 2022 15:37:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1648561020; x=1680097020;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FLEOBRkzAfL2PZRc8RnlDc3tQ904HRcvIZPvcxUbURY=;
  b=GmYeNLeXFB7lSAZNTL8jQETB1zjYVuckdROH/ap769zBDepLJ1cH+jcC
   SNtdHAqQLTLHz7WElCRDDiru2L0S7/ZR4NShmj43X42FkBaxAetlxF+UG
   36mY4ZFkGAzAGgGm/SS7oKJjzOdrVRdox0yTQ0OD+6YiKkRupto0ixTZU
   pAOsU4uk51ieC2ntJmv0dTkoiB0sUq3zPEPVxiB05NYddWYE4E5Xg6tnn
   Lc72ggXblIsV0h1w6n7D9XHpNUtGpQKIXadrWzz1jO+JIasLvqR8W8Fb4
   jll6YfSwhCTVysDyHRW10KsNvsBvunqkD5tvmgoVxQuBiUlwWszhFOIDM
   A==;
X-IronPort-AV: E=Sophos;i="5.90,220,1643670000"; 
   d="scan'208";a="22963305"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Mar 2022 15:37:00 +0200
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id EEA58280065;
        Tue, 29 Mar 2022 15:36:59 +0200 (CEST)
Message-ID: <c6178cd21a61d47d399cbee79d2c2f4b62dfa479.camel@ew.tq-group.com>
Subject: Re: (EXT) RE: [PATCH] serial: Revert RS485 polarity change on UART
 open
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Lukas Wunner <lukas@wunner.de>
Date:   Tue, 29 Mar 2022 15:36:59 +0200
In-Reply-To: <df0034da2db14b6b9993c37422a6711d@AcuMS.aculab.com>
References: <20220329085050.311408-1-matthias.schiffer@ew.tq-group.com>
         <20220329100328.GA2090@wunner.de>
         <b2f29129f966685105e09781620b85c8f4f1a88e.camel@ew.tq-group.com>
         <749eee7dd2c7464a8c4d9ea5972205fa@AcuMS.aculab.com>
         <82266d339e09ad16963e16014cd836fa670b3a0c.camel@ew.tq-group.com>
         <df0034da2db14b6b9993c37422a6711d@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-29 at 13:19 +0000, David Laight wrote:
> From: Matthias Schiffer
> > Sent: 29 March 2022 14:03
> > 
> > On Tue, 2022-03-29 at 12:55 +0000, David Laight wrote:
> > > From: Matthias Schiffer
> > > > Sent: 29 March 2022 11:39
> > > ...
> > > > I guess that would work. The fact that even the different
> > > > variants of the 8250 are implemented inconsistently makes this
> > > > especially ugly... It certainly puts a damper on the efforts to
> > > > make
> > > > the handling of RS485 in serial drivers more generic.
> > > 
> > > One thing to remember is that RS232 (IIRC really V.38) line
> > > driver
> > > chips are typically inverting.
> > > 
> > > So the modem signals on a TTL level output will have the
> > > opposite polarity to that required on the actual connector.
> > > 
> > > Normally a UART will have an 'active high' register bit for
> > > a modem signal that drives and 'active low' pin so you get
> > > the correct polarity with an inverting line driver.
> > > 
> > > 	David
> > > 
> > 
> > Indeed. As far as I can tell, this property of UARTs is what got us
> > into this mess: Some people interpreted SER_RS485_RTS_ON_SEND as
> > "set
> > the RTS flag in the MCR register on send", while other thought it
> > should mean "set the RTS pin to high on send", leading to opposite
> > behaviours in different UART drivers (and even different UART
> > variants
> > in the same driver, in the case of the 8250 family).
> 
> Hmmm... A complete mess.
> The 'RTS pin' that needs to go high is the one on the (typically) 'D'
> connector after the inverting line driver.
> Not the pin on the uart package.
> I'd expect TTL level serial interfaces to require active low
> modem signals.
> 
> If RS485 is trying to do half duplex using RTS (request to send)
> and CTS (clear to send) you've typically got bigger problems
> than asserting RTS before a transmit.
> The real problem is removing RTS once the last transmit data bit
> (the stop bit) has left the UART pin.
> I've used local loopback (tx to rx) to detect that in the past.
> 
> Of course, if it is just doing flow control that should use RFS
> (ready for sending) to indicate space in the receive fifo but
> using the RTS pin instead that is a different matter.
> 
> 	David
> 


I'm aware of the difficulties of deasserting RTS after the transmission
is complete, but that's completely orthogonal to the issue I'm trying
to solve right now :)

Regards,
Matthias

