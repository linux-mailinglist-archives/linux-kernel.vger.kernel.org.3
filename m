Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99898537143
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 16:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiE2OIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 10:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiE2OIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 10:08:34 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF663D1F1;
        Sun, 29 May 2022 07:08:32 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c15-20020a9d684f000000b0060b097c71ecso6128008oto.10;
        Sun, 29 May 2022 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYWhm9xB1LTG5O3MGX/4oGQAwJ+vLe8Swt2u52JO6fY=;
        b=g5p4aiYLtIujwQU6dC5+FS2anDm07L0CRSLU3ywaBNMRV48E5JGkEtQn3mryu5K21o
         BVKqyH8aRyaFiwNiO9PLAyJgDqZB2rk0eqRRXZuvbjhip2lLjnfUkuEKTfp9RbW6GUwz
         k2iB3C/z0lYY4rUTRKjXDaOQW3NiskdalGLoH6OvTNKchM9/kq3rZTPkZFqdvNg//gCQ
         FbT2T96RKftANTuhXKTDbt6svapLq4xpfCEPIR18gLeOkSohZmli6bMuHefJg6+OeUWL
         w7mha0yKKMY15gSw1R3vDAzcD2wrWmiZXJvMO45qSmVbVhBAFtXHgFZ8X+Crs/0beUIN
         sVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYWhm9xB1LTG5O3MGX/4oGQAwJ+vLe8Swt2u52JO6fY=;
        b=rvlniT+26Lk1HeKrhMmfx/gZ23cqdECSJNpKl551CkyYKHq3ZrHp5S+RhLnEoKrscV
         I7NtuZJXhZFg2gZPz+x9dPH3zlXQbqVFyC3K/ymT5Xt4tofNzsYpZs8YNWhXIEk7s9Em
         jm1KkDhltSodrl/WCbqDY0dRjN9uzwubIdfYeQRkp9sjFSFLsUG1tJkGYxubkrh68Lo9
         Suvq4pFkuHSqr8431LS3WfZEzAfpIIgLvtKyteDEDiVdU2Rlj0iEI0pjJYCK8CRpkzYL
         rKxZoyxPV0dxeyx3e2BL+2Wj4we+0C8TS4IPE3k6aqyQo9eyM7ItF0Vg7XUl+Lsb/K5T
         ehUg==
X-Gm-Message-State: AOAM532uQ4+hJLnlgBRGlSgmdbTCbX+pjzDPeyNRzNhg97vgYxYIO8QL
        iuKlcwG4T6wZDNA/VYD2Z8IuNedx6PJC/8ng1xgc0D2b
X-Google-Smtp-Source: ABdhPJyjzze8Wf0gYOmwQEta012XFihGRxjELTJ9dGxX9MO9ig69OQqulOBrVoU0GVNd5zTBdSSp5NA4KLfqEXv9hSc=
X-Received: by 2002:a9d:c4a:0:b0:60a:e6e7:796 with SMTP id 68-20020a9d0c4a000000b0060ae6e70796mr18010907otr.266.1653833311843;
 Sun, 29 May 2022 07:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220527185651.465204-1-joetalbott@gmail.com> <20220528183405.22b55033@jic23-huawei>
In-Reply-To: <20220528183405.22b55033@jic23-huawei>
From:   Joe Talbott <joetalbott@gmail.com>
Date:   Sun, 29 May 2022 10:08:21 -0400
Message-ID: <CAL7gdfeoRM8APfLL77bbGiWWBa0qOF8g0rza+=7hCdo+jaYNLQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] iio: Prefer octal over symbolic permissions.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 1:25 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 27 May 2022 14:56:52 -0400
> Joe Simmons-Talbott <joetalbott@gmail.com> wrote:
>
> > As reported by checkpatch.pl use ocatl permissions rather than symbolic
> > permissions.
> >
> > Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
>
> Hi Joe,
>
> Why the resend?  Given change of description, I'm guessing this is v2
> because of feedback on a similar patch elsewhere. If so, please
> put the version number in the patch log and provide a changelog
> below the ---


I sent the patch again because I neglected to include linux-kernel and
you in the
original patch's recipients.  I wasn't sure if I should include the v2
but will in the future.
Should I use v3 for my updated patch?

Thanks,
Joe

>
>
> Hmm. I guess I don't really mind cleaning this up though it is
> some churn in core code which is usually something we try to avoid
> for fairly trivial style reasons.
>
> One request inline (though I suspect it applies in several places,
> I just haven't checked ;)
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/industrialio-buffer.c  | 12 ++++++------
> >  drivers/iio/industrialio-core.c    | 10 +++++-----
> >  drivers/iio/industrialio-trigger.c |  4 ++--
> >  3 files changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index b078eb2f3c9d..c27f74a3c0f3 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1391,17 +1391,17 @@ static ssize_t direction_show(struct device *dev,
> >       }
> >  }
> >
> > -static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
> > +static DEVICE_ATTR(length, 0644, iio_buffer_read_length,
> >                  iio_buffer_write_length);
> >  static struct device_attribute dev_attr_length_ro = __ATTR(length,
> > -     S_IRUGO, iio_buffer_read_length, NULL);
> > -static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
> > +     0444, iio_buffer_read_length, NULL);
> > +static DEVICE_ATTR(enable, 0644,
> >                  iio_buffer_show_enable, iio_buffer_store_enable);
> > -static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
> > +static DEVICE_ATTR(watermark, 0644,
> >                  iio_buffer_show_watermark, iio_buffer_store_watermark);
> >  static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
> > -     S_IRUGO, iio_buffer_show_watermark, NULL);
> > -static DEVICE_ATTR(data_available, S_IRUGO,
> > +     0444, iio_buffer_show_watermark, NULL);
> > +static DEVICE_ATTR(data_available, 0444,
> >               iio_dma_show_data_available, NULL);
>
> a side effect of this change a slight shortening of how long the above
> two lines will be if combined into one.  It's now sub 80 chars
> I think, so please make them a single line.  Also check for similar
> cases elsewhere.
>
>
> >  static DEVICE_ATTR_RO(direction);
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index e1ed44dec2ab..35de348d686e 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1114,12 +1114,12 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
> >       dev_attr->attr.name = name;
> >
> >       if (readfunc) {
> > -             dev_attr->attr.mode |= S_IRUGO;
> > +             dev_attr->attr.mode |= 0444;
> >               dev_attr->show = readfunc;
> >       }
> >
> >       if (writefunc) {
> > -             dev_attr->attr.mode |= S_IWUSR;
> > +             dev_attr->attr.mode |= 0200;
> >               dev_attr->store = writefunc;
> >       }
> >
> > @@ -1401,7 +1401,7 @@ static ssize_t iio_show_dev_name(struct device *dev,
> >       return sysfs_emit(buf, "%s\n", indio_dev->name);
> >  }
> >
> > -static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
> > +static DEVICE_ATTR(name, 0444, iio_show_dev_name, NULL);
> >
> >  static ssize_t iio_show_dev_label(struct device *dev,
> >                                struct device_attribute *attr,
> > @@ -1411,7 +1411,7 @@ static ssize_t iio_show_dev_label(struct device *dev,
> >       return sysfs_emit(buf, "%s\n", indio_dev->label);
> >  }
> >
> > -static DEVICE_ATTR(label, S_IRUGO, iio_show_dev_label, NULL);
> > +static DEVICE_ATTR(label, 0444, iio_show_dev_label, NULL);
> >
> >  static ssize_t iio_show_timestamp_clock(struct device *dev,
> >                                       struct device_attribute *attr,
> > @@ -1509,7 +1509,7 @@ int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
> >       return 0;
> >  }
> >
> > -static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
> > +static DEVICE_ATTR(current_timestamp_clock, 0644,
> >                  iio_show_timestamp_clock, iio_store_timestamp_clock);
> >
> >  static int iio_device_register_sysfs(struct iio_dev *indio_dev)
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > index f504ed351b3e..e22a35634f2c 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -54,7 +54,7 @@ static ssize_t iio_trigger_read_name(struct device *dev,
> >       return sysfs_emit(buf, "%s\n", trig->name);
> >  }
> >
> > -static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
> > +static DEVICE_ATTR(name, 0444, iio_trigger_read_name, NULL);
> >
> >  static struct attribute *iio_trig_dev_attrs[] = {
> >       &dev_attr_name.attr,
> > @@ -494,7 +494,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
> >       return ret;
> >  }
> >
> > -static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
> > +static DEVICE_ATTR(current_trigger, 0644,
> >                  iio_trigger_read_current,
> >                  iio_trigger_write_current);
> >
>
