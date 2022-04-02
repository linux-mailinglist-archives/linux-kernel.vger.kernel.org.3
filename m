Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F644F04DB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358047AbiDBQ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345180AbiDBQ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:29:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B2A158D9C;
        Sat,  2 Apr 2022 09:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E277DB80AB2;
        Sat,  2 Apr 2022 16:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D2BC340F3;
        Sat,  2 Apr 2022 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648916847;
        bh=m6wRN/Ozv9b5FQGVEHdRnB+vvT2QvfMHvXSoL21Mhc4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hn+y7TS8hLCS2OAWIiI17VtbVNBAVhCgS/91kyR+Xq7JA0MBeX+IInlwvj0hxTKNS
         JAHrg5T2sSPLxFRitJ3dqnfFdcDiV3Q3B335zPsPYozns8cNxuB8Lvjw5+I0Kx5zdF
         NbO5ouy+9XNBr+OSVTNm7RQa8eCfxQoO+YESQnecNl/Y2CSgM9oAA2+ZE/bcD/8CPZ
         8dbJphB5b+SZMI8hxpi6pqm4qhSlkw7/+jgjsG+1C8cgxAsI0iJj2+L9xR5Js5iENZ
         f+v7U7ZV1hXvuwthxnSnuyJ0gF9eq22ARVuWoKw9U3rx/Zx5IW/V+MEVMvvbNGu2JR
         eFy/eJv0N3erg==
Date:   Sat, 2 Apr 2022 17:35:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IIO: accel: fixed coding style issues
Message-ID: <20220402173510.2b38e261@jic23-huawei>
In-Reply-To: <YkIJ3/nkVNMy/qv8@hp-amd-paul>
References: <YkHOpCT2Gad1YaxN@hp-amd-paul>
        <20220328180623.1380d23e@jic23-huawei>
        <YkIJ3/nkVNMy/qv8@hp-amd-paul>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 14:17:51 -0500
Paul Lemmermann <thepaulodoom@thepaulodoom.com> wrote:

> On Mon, Mar 28, 2022 at 06:06:23PM +0100, Jonathan Cameron wrote:
> > On Mon, 28 Mar 2022 10:05:08 -0500
> > Paul Lemmermann <thepaulodoom@thepaulodoom.com> wrote:
> >   
> > > Fixed case statement issues and spacing issues.
> > > 
> > > Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>  
> > Hi Paul,
> > 
> > Thanks for the patch.
> > 
> > These are drivers written / maintained by different authors, so one
> > patch per driver preferred.  Particularly handy as people might not
> > agree with all of them so separate patches would allow me to pick
> > and choose which ones to pick up.
> > 
> > Comments inline.
> > 
> > Please state how you identified the changes btw.  Script?  
> 
> I used the checkpatch.pl script to identify these changes.
Please mention that in patch descriptions in future.
It's useful to anyone tracking this sort of information.

I added it to the broken out patches whilst applying.

Thanks,

Jonathan

> 
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/accel/bmc150-accel-core.c | 15 +++++++++++----
> > >  drivers/iio/accel/dmard09.c           |  2 +-
> > >  drivers/iio/accel/kxsd9-spi.c         |  4 ++--
> > >  3 files changed, 14 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> > > index d11f66801..f7dd7ec2c 100644
> > > --- a/drivers/iio/accel/bmc150-accel-core.c
> > > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > > @@ -432,10 +432,17 @@ static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
> > >  
> > >  		for (j = 0; j < 3; j++) {
> > >  			switch (val[j]) {
> > > -			case -1: str = "-1"; break;
> > > -			case 0:  str = "0";  break;
> > > -			case 1:  str = "1";  break;
> > > -			default: goto unknown_format;
> > > +			case -1:
> > > +				str = "-1";
> > > +				break;
> > > +			case 0:
> > > +				str = "0";
> > > +				break;
> > > +			case 1:
> > > +				str = "1";
> > > +				break;
> > > +			default:
> > > +				goto unknown_format;  
> > 
> > I'm not seeing any clear advantage to this change.
> >  
> The reason for this change is that most, if not all, case statements in
> the kernel are multiple lines. Also, in the kernel docs (https://docs.kernel.org/process/coding-style.html)
> it says, to not put multiple statements on one line.
> 
> Thanks,
> Paul
> >   
> > >  			}
> > >  			orientation->rotation[i * 3 + j] = str;
> > >  		}
> > > diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
> > > index e6e28c964..87bc38d4d 100644
> > > --- a/drivers/iio/accel/dmard09.c
> > > +++ b/drivers/iio/accel/dmard09.c
> > > @@ -24,7 +24,7 @@
> > >  #define DMARD09_AXIS_Y 1
> > >  #define DMARD09_AXIS_Z 2
> > >  #define DMARD09_AXIS_X_OFFSET ((DMARD09_AXIS_X + 1) * 2)
> > > -#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1 )* 2)
> > > +#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1) * 2)  
> > 
> > This is one is good.
> >   
> > >  #define DMARD09_AXIS_Z_OFFSET ((DMARD09_AXIS_Z + 1) * 2)
> > >  
> > >  struct dmard09_data {
> > > diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
> > > index 57c451cfb..989f53fb0 100644
> > > --- a/drivers/iio/accel/kxsd9-spi.c
> > > +++ b/drivers/iio/accel/kxsd9-spi.c
> > > @@ -44,8 +44,8 @@ static const struct spi_device_id kxsd9_spi_id[] = {
> > >  MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
> > >  
> > >  static const struct of_device_id kxsd9_of_match[] = {
> > > -        { .compatible = "kionix,kxsd9" },
> > > -        { },
> > > +	{ .compatible = "kionix,kxsd9" },  
> > 
> > Also good to clean up.
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> > > +	{ },
> > >  };
> > >  MODULE_DEVICE_TABLE(of, kxsd9_of_match);
> > >    
> >   

