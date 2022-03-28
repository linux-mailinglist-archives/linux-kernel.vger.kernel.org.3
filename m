Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F04E9FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243161AbiC1TTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiC1TTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:19:38 -0400
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A88766C9A;
        Mon, 28 Mar 2022 12:17:55 -0700 (PDT)
Received: from hp-amd-paul (c-98-240-189-147.hsd1.mn.comcast.net [98.240.189.147])
        by vultr.guest (OpenSMTPD) with ESMTPSA id 19d4373f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Mar 2022 19:17:53 +0000 (UTC)
Date:   Mon, 28 Mar 2022 14:17:51 -0500
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IIO: accel: fixed coding style issues
Message-ID: <YkIJ3/nkVNMy/qv8@hp-amd-paul>
References: <YkHOpCT2Gad1YaxN@hp-amd-paul>
 <20220328180623.1380d23e@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328180623.1380d23e@jic23-huawei>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 06:06:23PM +0100, Jonathan Cameron wrote:
> On Mon, 28 Mar 2022 10:05:08 -0500
> Paul Lemmermann <thepaulodoom@thepaulodoom.com> wrote:
> 
> > Fixed case statement issues and spacing issues.
> > 
> > Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
> Hi Paul,
> 
> Thanks for the patch.
> 
> These are drivers written / maintained by different authors, so one
> patch per driver preferred.  Particularly handy as people might not
> agree with all of them so separate patches would allow me to pick
> and choose which ones to pick up.
> 
> Comments inline.
> 
> Please state how you identified the changes btw.  Script?

I used the checkpatch.pl script to identify these changes.

> 
> Jonathan
> 
> > ---
> >  drivers/iio/accel/bmc150-accel-core.c | 15 +++++++++++----
> >  drivers/iio/accel/dmard09.c           |  2 +-
> >  drivers/iio/accel/kxsd9-spi.c         |  4 ++--
> >  3 files changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> > index d11f66801..f7dd7ec2c 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -432,10 +432,17 @@ static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
> >  
> >  		for (j = 0; j < 3; j++) {
> >  			switch (val[j]) {
> > -			case -1: str = "-1"; break;
> > -			case 0:  str = "0";  break;
> > -			case 1:  str = "1";  break;
> > -			default: goto unknown_format;
> > +			case -1:
> > +				str = "-1";
> > +				break;
> > +			case 0:
> > +				str = "0";
> > +				break;
> > +			case 1:
> > +				str = "1";
> > +				break;
> > +			default:
> > +				goto unknown_format;
> 
> I'm not seeing any clear advantage to this change.
>
The reason for this change is that most, if not all, case statements in
the kernel are multiple lines. Also, in the kernel docs (https://docs.kernel.org/process/coding-style.html)
it says, to not put multiple statements on one line.

Thanks,
Paul
> 
> >  			}
> >  			orientation->rotation[i * 3 + j] = str;
> >  		}
> > diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
> > index e6e28c964..87bc38d4d 100644
> > --- a/drivers/iio/accel/dmard09.c
> > +++ b/drivers/iio/accel/dmard09.c
> > @@ -24,7 +24,7 @@
> >  #define DMARD09_AXIS_Y 1
> >  #define DMARD09_AXIS_Z 2
> >  #define DMARD09_AXIS_X_OFFSET ((DMARD09_AXIS_X + 1) * 2)
> > -#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1 )* 2)
> > +#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1) * 2)
> 
> This is one is good.
> 
> >  #define DMARD09_AXIS_Z_OFFSET ((DMARD09_AXIS_Z + 1) * 2)
> >  
> >  struct dmard09_data {
> > diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
> > index 57c451cfb..989f53fb0 100644
> > --- a/drivers/iio/accel/kxsd9-spi.c
> > +++ b/drivers/iio/accel/kxsd9-spi.c
> > @@ -44,8 +44,8 @@ static const struct spi_device_id kxsd9_spi_id[] = {
> >  MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
> >  
> >  static const struct of_device_id kxsd9_of_match[] = {
> > -        { .compatible = "kionix,kxsd9" },
> > -        { },
> > +	{ .compatible = "kionix,kxsd9" },
> 
> Also good to clean up.
> 
> Thanks,
> 
> Jonathan
> 
> 
> > +	{ },
> >  };
> >  MODULE_DEVICE_TABLE(of, kxsd9_of_match);
> >  
> 
