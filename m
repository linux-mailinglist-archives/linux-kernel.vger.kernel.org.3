Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D734BB1A9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 06:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiBRFwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 00:52:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiBRFwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:52:20 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D078BD75
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 21:52:03 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id x6-20020a4a4106000000b003193022319cso2353224ooa.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 21:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=37LqJlAII0gNSeXhOoelok3IoDv3jBdLaQwDPZu3lnU=;
        b=QI3QCP4LxeDhf0tpTQ32F84AFm0agQQD2sXKDULqfW3zs3QmRsIymHAsZ+mrYgtusW
         FKVcEUIo0DGZn5rTKKvVDdIH0oG34GTDqJbR0wRd0S/cWJlFXSeknq2oEsEZXnFParLI
         WITIyQK4wsI4GsKFRGdzntV1N/oz7sRnUDhbJ81EOgzmSula6oxxAbl0o2Sc7kijtDql
         hqOASrj3lS98BKDUl6gRyvah4I8n29RYumN7S4gJvZrOwF9W7vJVK8nSyxRm6oGXbgfW
         wgsui+qW57jPksRpcNcykr21tbvoCT6poELEe8b6pQ5SiIlL4Nv762lqgGEm4BYNn0Wb
         tDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=37LqJlAII0gNSeXhOoelok3IoDv3jBdLaQwDPZu3lnU=;
        b=aIjxgsd+KYUp9CXwN133HcT7B/up3dvWc7rM7zoLUo9BUKt5vjKDaajxwiq1A1bWYb
         De9wWwKToVMGrYrnTgUJKEC0rgeFNIq9C7dBaKBeLTnR+s3SKuXh2F1GxI8gCZhOByS1
         QMUK1sy3CqZsITKkCkdshULBZdWZ/D4Ig9KuxlLEeGASGd8ecK/HpbvFvMJp9Xwh+QrJ
         GKEVUbr+2pT8mAa7uV5J8q6CyGXL2BVaOJYFwHdIUFP70JdF5rYTPnkpcWUCP6oU4C/S
         TsBwVL/WFDN1ze09hLVOlwSXIpibbs3pXL1Lc3D/8A1sA8XBLpw9GgRJPu21796mVXvq
         9p0g==
X-Gm-Message-State: AOAM532VyNRIUBK7L4Ljh7L5SXAxq/BqaR0AlRgkrz3JsFU4UCkVwJ5C
        sJUqMqaf3m1cOqySC1B4TR06Qg==
X-Google-Smtp-Source: ABdhPJyQwFdbYvNKshqmyjoKxw8YQOrjhyUXqtqiz8ZsiTq4LQu1uyfb1aOcCVtjX8CIictiEWlPcA==
X-Received: by 2002:a05:6870:d3cc:b0:c4:7dc0:d72f with SMTP id l12-20020a056870d3cc00b000c47dc0d72fmr2536288oag.258.1645163522558;
        Thu, 17 Feb 2022 21:52:02 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id y3sm1239422oiv.21.2022.02.17.21.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 21:52:01 -0800 (PST)
Date:   Thu, 17 Feb 2022 21:54:08 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Puranjay Mohan <p-mohan@ti.com>, vigneshr@ti.com, s-anna@ti.com,
        mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/2] remoteproc: Introduce sysfs_read_only flag
Message-ID: <Yg80gABeszDDN/m6@ripper>
References: <20220216081224.9956-1-p-mohan@ti.com>
 <20220216081224.9956-2-p-mohan@ti.com>
 <0d44d73f-d882-83db-9cf2-09f7cdc91ab2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d44d73f-d882-83db-9cf2-09f7cdc91ab2@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Feb 21:00 PST 2022, Kishon Vijay Abraham I wrote:

> 
> 
> On 16/02/22 1:42 pm, Puranjay Mohan wrote:
> > The remoteproc framework provides sysfs interfaces for changing
> > the firmware name and for starting/stopping a remote processor
> > through the sysfs files 'state' and 'firmware'. The 'coredump'
> > file is used to set the coredump configuration. The 'recovery'
> > sysfs file can also be used similarly to control the error recovery
> > state machine of a remoteproc. These interfaces are currently
> > allowed irrespective of how the remoteprocs were booted (like
> > remoteproc self auto-boot, remoteproc client-driven boot etc).
> > These interfaces can adversely affect a remoteproc and its clients
> > especially when a remoteproc is being controlled by a remoteproc
> > client driver(s). Also, not all remoteproc drivers may want to
> > support the sysfs interfaces by default.
> > 
> > Add support to make the remoteproc sysfs files read only by
> > introducing a state flag 'sysfs_read_only' that the individual
> > remoteproc drivers can set based on their usage needs. The default
> > behavior is to allow the sysfs operations as before.
> > 
> > Implement attribute_group->is_visible() to make the sysfs
> > entries read only when 'sysfs_read_only' flag is set.
> > 
> > Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> > Changes in v4->v5:
> > Rename deny_sysfs_ops to sysfs_read_only.
> > Make coredump readonly with other files.
> > 
> > Changes in v3->v4:
> > Use mode = 0444 in rproc_is_visible() to make the sysfs entries
> > read-only when the deny_sysfs_ops flag is set.
> > ---
> >  drivers/remoteproc/remoteproc_sysfs.c | 19 ++++++++++++++++++-
> >  include/linux/remoteproc.h            |  2 ++
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> > index ea8b89f97d7b..abf0cd05d5e1 100644
> > --- a/drivers/remoteproc/remoteproc_sysfs.c
> > +++ b/drivers/remoteproc/remoteproc_sysfs.c
> > @@ -230,6 +230,22 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(name);
> >  
> > +static umode_t rproc_is_visible(struct kobject *kobj, struct attribute *attr,
> > +				int n)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct rproc *rproc = to_rproc(dev);
> > +	umode_t mode = attr->mode;
> > +
> > +	if (rproc->sysfs_read_only && (attr == &dev_attr_recovery.attr ||
> > +				       attr == &dev_attr_firmware.attr ||
> > +				       attr == &dev_attr_state.attr ||
> > +				       attr == &dev_attr_coredump.attr))
> > +		mode = 0444;
> 
> Nitpick: use S_IRUGO instead of 0444.
> 

Thanks for the suggestion Kishon, but I like 0444, it has direct meaning
to me.

So unless there's some directive to use S_I*** throughout the kernel I
would prefer this.

Regards,
Bjorn

> Thanks,
> Kishon
> > +
> > +	return mode;
> > +}
> > +
> >  static struct attribute *rproc_attrs[] = {
> >  	&dev_attr_coredump.attr,
> >  	&dev_attr_recovery.attr,
> > @@ -240,7 +256,8 @@ static struct attribute *rproc_attrs[] = {
> >  };
> >  
> >  static const struct attribute_group rproc_devgroup = {
> > -	.attrs = rproc_attrs
> > +	.attrs = rproc_attrs,
> > +	.is_visible = rproc_is_visible,
> >  };
> >  
> >  static const struct attribute_group *rproc_devgroups[] = {
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index e0600e1e5c17..93a1d0050fbc 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -523,6 +523,7 @@ struct rproc_dump_segment {
> >   * @table_sz: size of @cached_table
> >   * @has_iommu: flag to indicate if remote processor is behind an MMU
> >   * @auto_boot: flag to indicate if remote processor should be auto-started
> > + * @sysfs_read_only: flag to make remoteproc sysfs files read only
> >   * @dump_segments: list of segments in the firmware
> >   * @nb_vdev: number of vdev currently handled by rproc
> >   * @elf_class: firmware ELF class
> > @@ -562,6 +563,7 @@ struct rproc {
> >  	size_t table_sz;
> >  	bool has_iommu;
> >  	bool auto_boot;
> > +	bool sysfs_read_only;
> >  	struct list_head dump_segments;
> >  	int nb_vdev;
> >  	u8 elf_class;
> > 
