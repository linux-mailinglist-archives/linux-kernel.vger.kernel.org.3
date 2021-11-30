Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04432462DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbhK3Hqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:46:48 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:3424 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234235AbhK3Hqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638258209; x=1669794209;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XtNs5P1lQ25usXDwgWkMhdgcJrs80sI61JAMIb/ZdDs=;
  b=hkOE6RqHorPm6UZfRCalZeupSlXqsHJaKKENxwJzYx2WsQEEivBjAue3
   3SgUfRFC13nqwNDzmTNqDXgd/CI7UbtzSs270s19lf1HKCs8iThnKalxe
   zohFJmOUOGV86TUi6TS6+bd2H5XBjNQ8CDA7Hzp8DVc7AQy8o3AViBwVA
   0wxsmzw/Ceq8iB9G5fYgY1CWBsZ2y7lFmkTjPhWo3armRhTSHGNT9y5wu
   N17S79m1QBZMjFETQK3NGPb8/6fdsha5cDc3xLqham2Z4idKuiQVpIhaa
   O8c34iQse037gPg6EKsKEKb41wV/qx4GFJTULrw3lZHpdIhdqro1S+jJx
   A==;
X-IronPort-AV: E=Sophos;i="5.87,275,1631570400"; 
   d="scan'208";a="20746155"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 30 Nov 2021 08:43:28 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 30 Nov 2021 08:43:28 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 30 Nov 2021 08:43:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638258208; x=1669794208;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XtNs5P1lQ25usXDwgWkMhdgcJrs80sI61JAMIb/ZdDs=;
  b=Z7g7XCFuE6/9KjX4OzBUPKyVfP9AUWlpV9A+HcHTBeZqG9adELwhgjgb
   HHoQdUX54RCib02aXdJfcH3vM1383ES9ECDurnUqL6Ukp1/gy6uSN4Hde
   O6THaZrPe5/LfUitQm89z/y5BFsv79CmrpzbOXJSfUOPW/98kmpMSYt7t
   QSgAdft0BpobSfG2cgyhU4ezWN16Fyep+WBgg5SwjRz1yUWXVq9lMkThZ
   Ai66mUiFgI2nutba/CIqnIRNEwa/I+me2RqBEwmUKRugmbDAFk+IKoOx4
   OwuBfHMWwOwHlCk49iSQEOC/qyVHgCnbTUUvXthyQoHtIGrGiQ9PAYnR2
   g==;
X-IronPort-AV: E=Sophos;i="5.87,275,1631570400"; 
   d="scan'208";a="20746154"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 30 Nov 2021 08:43:28 +0100
Received: from steina-w (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id D7C1A280065;
        Tue, 30 Nov 2021 08:43:27 +0100 (CET)
Message-ID: <b1ddf6f61179c2445710d8540dd42ed6d71ae353.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH] media: Add 16-bit Bayer formats
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date:   Tue, 30 Nov 2021 08:43:25 +0100
In-Reply-To: <YaWNkcljqIR6BSdZ@pendragon.ideasonboard.com>
References: <20211019114718.827400-1-dorota.czaplejewicz@puri.sm>
         <163820077159.3059017.10242072140890692995@Monstersaurus>
         <20211129170356.7258d6db.dorota.czaplejewicz@puri.sm>
         <YaWNkcljqIR6BSdZ@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 30.11.2021 um 04:33 +0200 schrieb Laurent Pinchart:
> Hi Dorota,
> 
> On Mon, Nov 29, 2021 at 05:05:23PM +0100, Dorota Czaplejewicz wrote:
> > On Mon, 29 Nov 2021 15:46:11 +0000 Kieran Bingham wrote:
> > > Quoting Dorota Czaplejewicz (2021-10-19 12:59:29)
> > > > 16-bit bayer formats are used by the i.MX driver.  
> > > 
> > > Can we expand upon this at all?
> > > 
> > > The Subject says "Add 16-bit Bayer formats" but this isn't adding
> > > the
> > > format, it's purely extending the v4l2_format_info table with the
> > > information for that format which is otherwise missing.
> > 
> > What do you suggest for a better commit message? My reasoning was
> > that
> > I'm adding entries to a table.
> 
> The format is defined by V4L2 but isn't present in that table. I'd
> state
> the this patch is fixing an oversight, and reference the commit that
> forgot to add these formats in a Fixes: tag. While at it, I'd also
> add
> at least the 14bpp Bayer formats, and possibly the packed formats
> too.
> 
> > > I wonder what other formats are missing from that table too?
> > > 
> > > > Signed-off-by: Dorota Czaplejewicz <
> > > > dorota.czaplejewicz@puri.sm
> > > > >
> > > > ---
> > > > Hello,
> > > > 
> > > > While working on the i.MX8 video driver, I discovered that
> > > > `v4l2_fill_pixfmt` will fail when using 10-bit sensor formats.
> > > > (For background, see the conversation at
> > > > https://lkml.org/lkml/2021/10/17/93
> > > >  .)
> > > > 
> > > > It appears that the video hardware will fill a 16-bit-per-pixel
> > > > buffer when fed 10-bit-per-pixel Bayer data, making
> > > > `v4l2_fill_pixfmt` effectively broken for this case.  
> > > 
> > > This statement is confusing to me. Are you saying you're
> > > programming the
> > > hardware with 10 bit, and it's using 16 bits per pixel to store
> > > that
> > > data? (Which is simply 'unpacked' I think ?)
> > 
> > I know the sensor I'm dealing with sends 10-bit data. I'm observing
> > that the data arriving at this stage of the pipeline is encoded
> > with
> > 16 bits per pixel. As far as I understand, that's what i.MX8 does
> > at
> > some stage of the MIPI/CSI2 pipeline by design, but I can't
> > elaborate
> > at the moment, and I don't think it affects the validity of the
> > addition.
> 
> Is the 10 bit data stored in the MSB or LSB of the 2 bytes ?

Oh, I get a dejavu here. I assume this is on an i.MX8QM or i.MX8QXP,
but not one of the other i.MX8 ones. They have a similar name, but are
very (!) diffeent in some aspects.

To answer your question, neither of those two alignments. The RM for
i.MX8QM and i.MX8QXP states:
> NOTE
> The CSI data is right LSB aligned and zero padded depending
> on data format. When interfacing ISI, CSI data is shifted 6-bits
> due to ISI bits [5:0] always being zero
> (0bxxCSIDATAxxxxxx). All RAW14, RAW12, RAW10,
> RAW8, and RAW6 video data is filled from BIT[13] to LSB,
> the remaining bits are zero padded. Only RAW16 input data
> will be saved to memory from BIT[15] to LSB.

See also [1]. 

This essentially means, unless you use RAW16, you will get RAW14 with a
different amount of LSB bits set to 0.
IIRC there was some patchset to introduce a RAW14 format ([2]) for
exactly this use cas.
There is also some kind of demo doing post-processing ([3]).

Best regards,
Alexander

[1] 
https://community.nxp.com/t5/i-MX-Processors/i-MX8QM-MIPI-Raw-formats-not-working-correctly/m-p/1040832/highlight/true#M153336
[2] 
https://yhbt.net/lore/all/20200226151431.GY5379@paasikivi.fi.intel.com/T/
[3] 
https://community.nxp.com/t5/i-MX-Processors-Knowledge-Base/i-MX8QXP-capture-raw-bayer-data-and-debayer/ta-p/1098963


