Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A853A910
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354765AbiFAOVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356129AbiFAOUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:20:38 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D744E15EC;
        Wed,  1 Jun 2022 07:09:28 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c8so1230278qtj.1;
        Wed, 01 Jun 2022 07:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dsbaIM6WigkoITIKWnOycXGrqyEVNssC8hn3uOsuVrc=;
        b=Dqzj+615k9JDlf5h3LQiHgGSuWdTcb5des9J5Z7TdoUAYH+2EefV05woXSe+Y2WEPM
         UORYWuyyctB9oXyqOhWQ+zPcnB1ixbKNXMjKVef9ibxdJ9hUfvbnDDIXFEml/EOOE+HU
         gnpO7ODwFApHRqCmj536jbI7x8fyBzIhbkbcKWP7bIo0vlrCGUpTxJzR3t2Wxc3QC9kr
         2EuEmz8TDdYUhw++hdJSEKDGgqzRHiw7BRGQ3GpDIRCBuN6dvcULQ4XH2k+tPsdezF1s
         QGXqxZtyF2Gk2g9gpha6bRR0E6yZSMOFEs8cclpUZ8x/Gmh+0w8iDDqf8JJ4xB+JJ19y
         RA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dsbaIM6WigkoITIKWnOycXGrqyEVNssC8hn3uOsuVrc=;
        b=2bpwMQQZPsWrvBiBx/qpeQklWQKWTVe/eElBH19GxVJ/isMYgZ4ImvDOG2pbyt0U+F
         yfmstndw5DYi4ziN489X1U3YprKm/6DhPaYItxctzk4V+/pzAKnWH73njeO/WFBFF4/K
         MBMGR5YEaz6iJr9TQXXMVGX19Wtu3NO0Abi+kGCYOB5/2pUx6Bu25I+dRl05TXaFcpfS
         grcDk3gfA2dbSJEPoVkUbx+5RI52jyr8eIQsieT/EKRyjQFsdODbnQ9oZ3OGasH/27GE
         di2Qbvm2cTX6vsJg+XstVh72WymcEgWH5rU4p+foKVz37EZ/qsDuj00ROnxvL3FL8xrd
         xqAA==
X-Gm-Message-State: AOAM533g2GXuhe4PHNNMjgOzBquJqWh9dfWPuhplQhftB9NbjOzA01eK
        Gj42XVP5bpBHkTWmntzzUhY=
X-Google-Smtp-Source: ABdhPJxm/bOXNFKIExhb1jHpxM6h1VcWwZT1kUP244ZKyQYrB6DaQ5SzA9F6Fhse+afxYAXGArEjaw==
X-Received: by 2002:ac8:7f85:0:b0:303:8309:1cb6 with SMTP id z5-20020ac87f85000000b0030383091cb6mr12755649qtj.473.1654092565979;
        Wed, 01 Jun 2022 07:09:25 -0700 (PDT)
Received: from spruce (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id 2-20020a05620a040200b0069fd12a957bsm1314918qkp.17.2022.06.01.07.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 07:09:25 -0700 (PDT)
Date:   Wed, 1 Jun 2022 10:09:23 -0400
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: Prefer octal over symbolic permissions.
Message-ID: <YpdzExJGBI88Udzy@spruce>
References: <20220527185651.465204-1-joetalbott@gmail.com>
 <20220528183405.22b55033@jic23-huawei>
 <CAL7gdfeoRM8APfLL77bbGiWWBa0qOF8g0rza+=7hCdo+jaYNLQ@mail.gmail.com>
 <20220531105647.00006c00@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531105647.00006c00@Huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 10:56:47AM +0100, Jonathan Cameron wrote:
> On Sun, 29 May 2022 10:08:21 -0400
> Joe Talbott <joetalbott@gmail.com> wrote:
> 
> > On Sat, May 28, 2022 at 1:25 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Fri, 27 May 2022 14:56:52 -0400
> > > Joe Simmons-Talbott <joetalbott@gmail.com> wrote:
> > >  
> > > > As reported by checkpatch.pl use ocatl permissions rather than symbolic
> > > > permissions.
> > > >
> > > > Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>  
> > >
> > > Hi Joe,
> > >
> > > Why the resend?  Given change of description, I'm guessing this is v2
> > > because of feedback on a similar patch elsewhere. If so, please
> > > put the version number in the patch log and provide a changelog
> > > below the ---  
> > 
> > 
> > I sent the patch again because I neglected to include linux-kernel and
> > you in the
> > original patch's recipients.  I wasn't sure if I should include the v2
> > but will in the future.
> 
> For that case, common choice is [RESEND PATCH ....
> with a brief note in the cover letter that you missed some to/cc
> 
> > Should I use v3 for my updated patch?
> v2 is fine given v2 doesn't yet exist - v3 also fine though...

Thanks for the info.  I've resubmitted the patch as:
[PATCH v2] iio: Use octal permissions and DEVICE_ATTR_{RO,RW}.

Thanks,
Joe
> 
> Jonathan
> 
> > 
> > Thanks,
> > Joe
> > 
> > >
> > >
> > > Hmm. I guess I don't really mind cleaning this up though it is
> > > some churn in core code which is usually something we try to avoid
> > > for fairly trivial style reasons.
> > >
> > > One request inline (though I suspect it applies in several places,
> > > I just haven't checked ;)
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >  
> > > > ---
> > > >  drivers/iio/industrialio-buffer.c  | 12 ++++++------
> > > >  drivers/iio/industrialio-core.c    | 10 +++++-----
> > > >  drivers/iio/industrialio-trigger.c |  4 ++--
> > > >  3 files changed, 13 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > > > index b078eb2f3c9d..c27f74a3c0f3 100644
> > > > --- a/drivers/iio/industrialio-buffer.c
> > > > +++ b/drivers/iio/industrialio-buffer.c
> > > > @@ -1391,17 +1391,17 @@ static ssize_t direction_show(struct device *dev,
> > > >       }
> > > >  }
> > > >
> > > > -static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
> > > > +static DEVICE_ATTR(length, 0644, iio_buffer_read_length,
> > > >                  iio_buffer_write_length);
> > > >  static struct device_attribute dev_attr_length_ro = __ATTR(length,
> > > > -     S_IRUGO, iio_buffer_read_length, NULL);
> > > > -static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
> > > > +     0444, iio_buffer_read_length, NULL);
> > > > +static DEVICE_ATTR(enable, 0644,
> > > >                  iio_buffer_show_enable, iio_buffer_store_enable);
> > > > -static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
> > > > +static DEVICE_ATTR(watermark, 0644,
> > > >                  iio_buffer_show_watermark, iio_buffer_store_watermark);
> > > >  static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
> > > > -     S_IRUGO, iio_buffer_show_watermark, NULL);
> > > > -static DEVICE_ATTR(data_available, S_IRUGO,
> > > > +     0444, iio_buffer_show_watermark, NULL);
> > > > +static DEVICE_ATTR(data_available, 0444,
> > > >               iio_dma_show_data_available, NULL);  
> > >
> > > a side effect of this change a slight shortening of how long the above
> > > two lines will be if combined into one.  It's now sub 80 chars
> > > I think, so please make them a single line.  Also check for similar
> > > cases elsewhere.
> > >
> > >  
> > > >  static DEVICE_ATTR_RO(direction);
> > > >
> > > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > > > index e1ed44dec2ab..35de348d686e 100644
> > > > --- a/drivers/iio/industrialio-core.c
> > > > +++ b/drivers/iio/industrialio-core.c
> > > > @@ -1114,12 +1114,12 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
> > > >       dev_attr->attr.name = name;
> > > >
> > > >       if (readfunc) {
> > > > -             dev_attr->attr.mode |= S_IRUGO;
> > > > +             dev_attr->attr.mode |= 0444;
> > > >               dev_attr->show = readfunc;
> > > >       }
> > > >
> > > >       if (writefunc) {
> > > > -             dev_attr->attr.mode |= S_IWUSR;
> > > > +             dev_attr->attr.mode |= 0200;
> > > >               dev_attr->store = writefunc;
> > > >       }
> > > >
> > > > @@ -1401,7 +1401,7 @@ static ssize_t iio_show_dev_name(struct device *dev,
> > > >       return sysfs_emit(buf, "%s\n", indio_dev->name);
> > > >  }
> > > >
> > > > -static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
> > > > +static DEVICE_ATTR(name, 0444, iio_show_dev_name, NULL);
> > > >
> > > >  static ssize_t iio_show_dev_label(struct device *dev,
> > > >                                struct device_attribute *attr,
> > > > @@ -1411,7 +1411,7 @@ static ssize_t iio_show_dev_label(struct device *dev,
> > > >       return sysfs_emit(buf, "%s\n", indio_dev->label);
> > > >  }
> > > >
> > > > -static DEVICE_ATTR(label, S_IRUGO, iio_show_dev_label, NULL);
> > > > +static DEVICE_ATTR(label, 0444, iio_show_dev_label, NULL);
> > > >
> > > >  static ssize_t iio_show_timestamp_clock(struct device *dev,
> > > >                                       struct device_attribute *attr,
> > > > @@ -1509,7 +1509,7 @@ int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
> > > >       return 0;
> > > >  }
> > > >
> > > > -static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
> > > > +static DEVICE_ATTR(current_timestamp_clock, 0644,
> > > >                  iio_show_timestamp_clock, iio_store_timestamp_clock);
> > > >
> > > >  static int iio_device_register_sysfs(struct iio_dev *indio_dev)
> > > > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > > > index f504ed351b3e..e22a35634f2c 100644
> > > > --- a/drivers/iio/industrialio-trigger.c
> > > > +++ b/drivers/iio/industrialio-trigger.c
> > > > @@ -54,7 +54,7 @@ static ssize_t iio_trigger_read_name(struct device *dev,
> > > >       return sysfs_emit(buf, "%s\n", trig->name);
> > > >  }
> > > >
> > > > -static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
> > > > +static DEVICE_ATTR(name, 0444, iio_trigger_read_name, NULL);
> > > >
> > > >  static struct attribute *iio_trig_dev_attrs[] = {
> > > >       &dev_attr_name.attr,
> > > > @@ -494,7 +494,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
> > > >       return ret;
> > > >  }
> > > >
> > > > -static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
> > > > +static DEVICE_ATTR(current_trigger, 0644,
> > > >                  iio_trigger_read_current,
> > > >                  iio_trigger_write_current);
> > > >  
> > >  
> 
