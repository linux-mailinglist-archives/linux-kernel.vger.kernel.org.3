Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD0B5068AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241213AbiDSK2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350669AbiDSK1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:27:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA57389E;
        Tue, 19 Apr 2022 03:24:49 -0700 (PDT)
Received: from localhost ([31.220.114.252]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MCbMz-1npJkn4351-009fUR; Tue, 19 Apr 2022 12:24:27 +0200
Date:   Tue, 19 Apr 2022 12:24:26 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: proximity: mb1232: Switch to use
 fwnode_irq_get()
Message-ID: <Yl6N2rnZsdJ9WJ6q@arbad>
References: <20220413183123.20292-1-andriy.shevchenko@linux.intel.com>
 <20220416120726.0ba78960@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416120726.0ba78960@jic23-huawei>
X-Provags-ID: V03:K1:h28I5PaIB1AGwZVfL+JEIK0W7L2gRQU9pIM8fijwncou7OulhXQ
 i0QT2/BlAmO8EpRN7HVoeQDoPn+4cux2VnJyYPR2syiR1Kl1TossTGE3g+sC8AvhKtF1QE5
 oYYbKWSjVqZd7Z9wVa4uESUIMgTWti9GTmlZTEQ+3g9Fp5xK9yneilMoOG7l04O1b4TQ1gM
 5lIiD23u9tIMNcXyZKzUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:otICPBEuBO0=:00N7IK7k89SMBuOxXaHP50
 IV1cN06/tnBYlHpdSe/U2DX3I46714cy+SHR06+RIH9wwvAIkCZ/oPZPmgPeCFw7XL04xlMwc
 NsTieuByThtsDyoj66X4NmhPSSkExWawGkzn233vVvagXPi9olBAXX5xOo1ufJfc891UHeSMP
 raAUN84+i3j6PrLEfnLlBk835uoFIehkK+77KQ0fnPAPIhksa1czlYtokb0QKCQP0qKqdLRkj
 5ZERZQXwKeFT6zAEtbzJTtI8Bic5z0p0Q/o5X3VaKg+n7+GrUfp3VYTlBUDk79D26HljKZpP/
 SnJaQxCR6rvB0MQgXYMrFspGVx/Fq6SMlZG35tROJHWbvtarmAWwW1dTkGHThfKp+Omt2viV1
 i2jB4sP8F2uePmYE3vnVlGbogIsm2cO+rE+RyEN/iLSYrE8uPhT7r3RUrmW2tSEJW/j4V5D23
 dLffRvHLAWrhugHaZrFMFCnKR7fRrG1l8vZvRR8mMbP1L0CQoAh4TUi47ufxo6oVcjAE9FRwn
 fotXrDAQ8I95MTOP/KJTfP24tGvVDMGhat6cM0f7ZwyAaNo+lbXNd6kkt7/zOuYb++hjdF0wi
 lLAnejuYtNaYOTYZ+wq5QQrsybzFJZyywn2quxMKLcBMVgB9qCdJoPY53HKaYp5WYH1g8Awof
 IE9I4BKKOcwqGckHGulsT8Wicu309iL+Tvitsvf850PyvMKTPvwHlpH0tg3JpVSYxEIU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Cameron <jic23@kernel.org> schrieb am Sa, 16. Apr 12:07:
> On Wed, 13 Apr 2022 21:31:23 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > We have OF-centric variant of fwnode_irq_get() in the driver.
> > Replace it with a call to an agnostic implementation.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Whilst I 'think' this ends up being functionally identical
> I'd like to leave it a little longer to see if Andreas has
> time to take a look and verify this change is fine.
> 
> There seem to be subtle differences in the irq setup as the
> new code does a sanity check on the domain being available
> and defers if not which I don't think happens with the
> existing code.

Anyway interrupts are optional and the driver will work without i don't see any
issue here.

Acked-by: Andreas Klinger <ak@it-klinger.de>

> 
> Thanks,
> 
> Jonathan
> 
> 
> > ---
> >  drivers/iio/proximity/mb1232.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
> > index ad4b1fb2607a..0bca5f74de68 100644
> > --- a/drivers/iio/proximity/mb1232.c
> > +++ b/drivers/iio/proximity/mb1232.c
> > @@ -10,12 +10,14 @@
> >   * https://www.maxbotix.com/documents/I2CXL-MaxSonar-EZ_Datasheet.pdf
> >   */
> >  
> > +#include <linux/bitops.h>
> >  #include <linux/err.h>
> >  #include <linux/i2c.h>
> > -#include <linux/of_irq.h>
> >  #include <linux/delay.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> > -#include <linux/bitops.h>
> > +#include <linux/property.h>
> > +
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/iio/buffer.h>
> > @@ -209,7 +211,7 @@ static int mb1232_probe(struct i2c_client *client,
> >  
> >  	init_completion(&data->ranging);
> >  
> > -	data->irqnr = irq_of_parse_and_map(dev->of_node, 0);
> > +	data->irqnr = fwnode_irq_get(dev_fwnode(&client->dev), 0);
> >  	if (data->irqnr <= 0) {
> >  		/* usage of interrupt is optional */
> >  		data->irqnr = -1;
> 

-- 
Andreas Klinger
Grabenreith 27
84508 Burgkirchen
+49 8623 919966
ak@it-klinger.de
www.it-klinger.de
www.grabenreith.de
