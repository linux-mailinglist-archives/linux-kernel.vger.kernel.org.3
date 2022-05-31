Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3029538E13
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245391AbiEaJ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240788AbiEaJ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:57:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8285FC5;
        Tue, 31 May 2022 02:56:52 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LC6zY07rdz67cpv;
        Tue, 31 May 2022 17:53:29 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 11:56:49 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 31 May
 2022 10:56:49 +0100
Date:   Tue, 31 May 2022 10:56:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Joe Talbott <joetalbott@gmail.com>, <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iio: Prefer octal over symbolic permissions.
Message-ID: <20220531105647.00006c00@Huawei.com>
In-Reply-To: <CAL7gdfeoRM8APfLL77bbGiWWBa0qOF8g0rza+=7hCdo+jaYNLQ@mail.gmail.com>
References: <20220527185651.465204-1-joetalbott@gmail.com>
        <20220528183405.22b55033@jic23-huawei>
        <CAL7gdfeoRM8APfLL77bbGiWWBa0qOF8g0rza+=7hCdo+jaYNLQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 May 2022 10:08:21 -0400
Joe Talbott <joetalbott@gmail.com> wrote:

> On Sat, May 28, 2022 at 1:25 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri, 27 May 2022 14:56:52 -0400
> > Joe Simmons-Talbott <joetalbott@gmail.com> wrote:
> >  
> > > As reported by checkpatch.pl use ocatl permissions rather than symbolic
> > > permissions.
> > >
> > > Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>  
> >
> > Hi Joe,
> >
> > Why the resend?  Given change of description, I'm guessing this is v2
> > because of feedback on a similar patch elsewhere. If so, please
> > put the version number in the patch log and provide a changelog
> > below the ---  
> 
> 
> I sent the patch again because I neglected to include linux-kernel and
> you in the
> original patch's recipients.  I wasn't sure if I should include the v2
> but will in the future.

For that case, common choice is [RESEND PATCH ....
with a brief note in the cover letter that you missed some to/cc

> Should I use v3 for my updated patch?
v2 is fine given v2 doesn't yet exist - v3 also fine though...

Jonathan

> 
> Thanks,
> Joe
> 
> >
> >
> > Hmm. I guess I don't really mind cleaning this up though it is
> > some churn in core code which is usually something we try to avoid
> > for fairly trivial style reasons.
> >
> > One request inline (though I suspect it applies in several places,
> > I just haven't checked ;)
> >
> > Thanks,
> >
> > Jonathan
> >  
> > > ---
> > >  drivers/iio/industrialio-buffer.c  | 12 ++++++------
> > >  drivers/iio/industrialio-core.c    | 10 +++++-----
> > >  drivers/iio/industrialio-trigger.c |  4 ++--
> > >  3 files changed, 13 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > > index b078eb2f3c9d..c27f74a3c0f3 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -1391,17 +1391,17 @@ static ssize_t direction_show(struct device *dev,
> > >       }
> > >  }
> > >
> > > -static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
> > > +static DEVICE_ATTR(length, 0644, iio_buffer_read_length,
> > >                  iio_buffer_write_length);
> > >  static struct device_attribute dev_attr_length_ro = __ATTR(length,
> > > -     S_IRUGO, iio_buffer_read_length, NULL);
> > > -static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
> > > +     0444, iio_buffer_read_length, NULL);
> > > +static DEVICE_ATTR(enable, 0644,
> > >                  iio_buffer_show_enable, iio_buffer_store_enable);
> > > -static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
> > > +static DEVICE_ATTR(watermark, 0644,
> > >                  iio_buffer_show_watermark, iio_buffer_store_watermark);
> > >  static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
> > > -     S_IRUGO, iio_buffer_show_watermark, NULL);
> > > -static DEVICE_ATTR(data_available, S_IRUGO,
> > > +     0444, iio_buffer_show_watermark, NULL);
> > > +static DEVICE_ATTR(data_available, 0444,
> > >               iio_dma_show_data_available, NULL);  
> >
> > a side effect of this change a slight shortening of how long the above
> > two lines will be if combined into one.  It's now sub 80 chars
> > I think, so please make them a single line.  Also check for similar
> > cases elsewhere.
> >
> >  
> > >  static DEVICE_ATTR_RO(direction);
> > >
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > > index e1ed44dec2ab..35de348d686e 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -1114,12 +1114,12 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
> > >       dev_attr->attr.name = name;
> > >
> > >       if (readfunc) {
> > > -             dev_attr->attr.mode |= S_IRUGO;
> > > +             dev_attr->attr.mode |= 0444;
> > >               dev_attr->show = readfunc;
> > >       }
> > >
> > >       if (writefunc) {
> > > -             dev_attr->attr.mode |= S_IWUSR;
> > > +             dev_attr->attr.mode |= 0200;
> > >               dev_attr->store = writefunc;
> > >       }
> > >
> > > @@ -1401,7 +1401,7 @@ static ssize_t iio_show_dev_name(struct device *dev,
> > >       return sysfs_emit(buf, "%s\n", indio_dev->name);
> > >  }
> > >
> > > -static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
> > > +static DEVICE_ATTR(name, 0444, iio_show_dev_name, NULL);
> > >
> > >  static ssize_t iio_show_dev_label(struct device *dev,
> > >                                struct device_attribute *attr,
> > > @@ -1411,7 +1411,7 @@ static ssize_t iio_show_dev_label(struct device *dev,
> > >       return sysfs_emit(buf, "%s\n", indio_dev->label);
> > >  }
> > >
> > > -static DEVICE_ATTR(label, S_IRUGO, iio_show_dev_label, NULL);
> > > +static DEVICE_ATTR(label, 0444, iio_show_dev_label, NULL);
> > >
> > >  static ssize_t iio_show_timestamp_clock(struct device *dev,
> > >                                       struct device_attribute *attr,
> > > @@ -1509,7 +1509,7 @@ int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
> > >       return 0;
> > >  }
> > >
> > > -static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
> > > +static DEVICE_ATTR(current_timestamp_clock, 0644,
> > >                  iio_show_timestamp_clock, iio_store_timestamp_clock);
> > >
> > >  static int iio_device_register_sysfs(struct iio_dev *indio_dev)
> > > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > > index f504ed351b3e..e22a35634f2c 100644
> > > --- a/drivers/iio/industrialio-trigger.c
> > > +++ b/drivers/iio/industrialio-trigger.c
> > > @@ -54,7 +54,7 @@ static ssize_t iio_trigger_read_name(struct device *dev,
> > >       return sysfs_emit(buf, "%s\n", trig->name);
> > >  }
> > >
> > > -static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
> > > +static DEVICE_ATTR(name, 0444, iio_trigger_read_name, NULL);
> > >
> > >  static struct attribute *iio_trig_dev_attrs[] = {
> > >       &dev_attr_name.attr,
> > > @@ -494,7 +494,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
> > >       return ret;
> > >  }
> > >
> > > -static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
> > > +static DEVICE_ATTR(current_trigger, 0644,
> > >                  iio_trigger_read_current,
> > >                  iio_trigger_write_current);
> > >  
> >  

