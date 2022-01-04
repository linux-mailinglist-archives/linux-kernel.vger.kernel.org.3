Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EAD483E1E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiADIae convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jan 2022 03:30:34 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55069 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiADIad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:30:33 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 875BFE000B;
        Tue,  4 Jan 2022 08:30:26 +0000 (UTC)
Date:   Tue, 4 Jan 2022 09:30:25 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM SPECIFIC AMBA DRIVER (BCMA)" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM STB NAND FLASH DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH 4/9] mtd: rawnand: brcmnand: Move OF operations out of
 brcmnand_init_cs()
Message-ID: <20220104093025.0fc39928@xps13>
In-Reply-To: <00d8af2f-45ff-48d7-43e7-14c59a0aca62@gmail.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
        <20211223002225.3738385-5-f.fainelli@gmail.com>
        <20220103175606.71a4eb93@xps13>
        <00d8af2f-45ff-48d7-43e7-14c59a0aca62@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

f.fainelli@gmail.com wrote on Mon, 3 Jan 2022 09:27:28 -0800:

> On 1/3/2022 8:56 AM, Miquel Raynal wrote:
> > Hi Florian,
> > 
> > f.fainelli@gmail.com wrote on Wed, 22 Dec 2021 16:22:20 -0800:
> >   
> >> In order to initialize a given chip select object for use by the
> >> brcmnand driver, move all of the Device Tree specific routines outside
> >> of brcmnand_init_cs() in order to make it usable in a platform data
> >> configuration which will be necessary for supporting BCMA chips.  
> > 
> > TBH I'm note a big fan of the idea. I'm not sure going back to
> > supporting platform data this way really is a good idea... There are so
> > much things that are well described with DT that we now rely upon that
> > I am not entirely convinced by these changes :-/ The move is generally
> > in the other direction: getting rid of the legacy platform data.  
> 
> In the cover letter there is an explanation as to why we need to introduce platform data/device support here: the platforms on which this NAND controller shim is used do not have Device Tree support, and won't have it in the future either. They are old platforms (first SoC supported by bcm47xx is maybe 15 years old now) but they are still in active and wide use by the OpenWrt, dd-wrt communities.

Yeah, I read the cover letter, I understand these platforms won't ever
be updated so you're stuck. I'll close my eyes.

Thanks,
Miquèl
