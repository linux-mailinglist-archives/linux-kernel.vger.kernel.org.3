Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4823147B1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbhLTRCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbhLTRCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:02:11 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B66C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:02:11 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id v13so9300181pfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aEjxTchweWdgUbwWE5t4ZKBhw1mYWwXBAOFdGYABgWc=;
        b=fxUeSQ8lhNgLTeS10fOwHKWDLkHztpczk2R/Nr6tpW5fgY+PwAugktBix2+GgKoBbu
         YLlw8TLP+D2l/T0Mav1f2qCWPiOu2ft4wics7uGwG10rdOx8jbhxwLIaRqxxC3Rp73Yv
         K81EYel3s7vY0f//Ihm4bE2S3Hn2E6cus56vrufULycSmrqe9TR7I1R6BGjwpg7xpcyk
         WMV8Jw1fppR/3w1ARt6EY/ctqoXS14Z0TDaq/VGIdOoMAIcShXTPkYqN2JinUkv0/+48
         x/sTO6qInLFY1MOOkZ/4VHRSMx1g99Cc18WlvUSQMoJ5fH69bLRL3qeMEKteaLImRa07
         bu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aEjxTchweWdgUbwWE5t4ZKBhw1mYWwXBAOFdGYABgWc=;
        b=0k7f+5f5oRAWI4KmwxSaXRalkglR/fZZRt+EkDUEpoVWkr45hrfWRGk6IFwzQMxMX0
         QoFu1LvyRlAamyXG0wQbWhM+OiojiEi7oZSlqGrRAtxEAOUchs6vjc4CLyaluQBysVMv
         tG0XBQca+U2W/5fyP/XqGIWPMjMPUvKujDoQM2cgQVbdfNwT/OBCel+xIAet1+PwjJ+b
         SGMldz/xR+zaCbqzMy37cMOt7A3CdVap9wgMFR0KLwBgotbbhTfE06O05UTGmgsS7aZl
         PoHIjSiySdQNlTNQzN9lkaZTlkim1MZtlTdPF/s06+xMiCxxZ14z7JA1GMFPKvful4ki
         dT8Q==
X-Gm-Message-State: AOAM530hLLLbCEnddikHwYa4olGylxLywUeFJ13oVWtRrKi8U1suAnOS
        JHLmpM+nDQpbGNZRTP/g4mJIoa58PVmapA==
X-Google-Smtp-Source: ABdhPJx9iZfTC1rk4cc3VHhUte32n0fi31hzaHsRsV/lI04PKg57kABrUqnqcdiibLYzemFmPv6rZQ==
X-Received: by 2002:a63:700d:: with SMTP id l13mr13210059pgc.333.1640019730896;
        Mon, 20 Dec 2021 09:02:10 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p17sm21441996pfh.86.2021.12.20.09.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 09:02:09 -0800 (PST)
Date:   Mon, 20 Dec 2021 10:02:07 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        "Lucas, Jonathan" <Jonathan_Lucas@mentor.com>
Subject: Re: [PATCH v3] drivers/coresight: Add Ultrasoc System Memory Buffer
 driver
Message-ID: <20211220170207.GB241456@p14s>
References: <20211118110016.40398-1-liuqi115@huawei.com>
 <20211124015505.GA16135@p14s>
 <2c31d2d3-c95a-e78f-45db-caa0752afd78@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c31d2d3-c95a-e78f-45db-caa0752afd78@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

[...]

> > > +obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
> > > diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
> > > new file mode 100644
> > > index 000000000000..b477fc51fbbb
> > > --- /dev/null
> > > +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
> > > @@ -0,0 +1,607 @@
> > > +// SPDX-License-Identifier: MIT
> > > +/*
> > > + * Copyright (C) 2021 HiSilicon Limited.
> > > + *
> > > + * Code herein communicates with and accesses proprietary hardware which is
> > > + * licensed intellectual property (IP) belonging to Siemens Digital Industries
> > > + * Software Ltd.
> > > + *
> > > + * Siemens Digital Industries Software Ltd. asserts and reserves all rights to
> > > + * their intellectual property. This paragraph may not be removed or modified
> > > + * in any way without permission from Siemens Digital Industries Software Ltd.
> > 
> > I consulted with people in the Linux community and the above two paragraphs need
> > to be removed.  I will wait to hear back from you before I continue to review
> > this patch.
> > 
> > The Copyright can stay the way it is, and as I commented earlier the SPDX has to
> > include GPLv2 and MIT.
> > 
> > Thanks,
> > Mathieu
> > 
> 
> Hi Mthieu,
> 
> I've asked people in Siemens and made sure the file header could be modified
> according to community specifications, like this:
> 
> // SPDX-License-Identifier: MIT/GPL
> /*
>  * Siemens System Memory Buffer driver.
>  * Copyright(c) 2021, HiSilicon Limited.
>  */
> 
> Could you continue to review this patch if you have time, thanks.
> 

I won't have time before January.  As such I suggest you address the comments I
have already made and send another revision.


> Best Regards,
> Qi
> 
> > > + */
> > > +
> > > +#include <linux/acpi.h>
> > > +#include <linux/circ_buf.h>
> > > +#include <linux/err.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#include "ultrasoc-smb.h"
> > > +
> > > +DEFINE_CORESIGHT_DEVLIST(sink_devs, "sink_smb");
> > > +
> > > +static bool smb_buffer_is_empty(struct smb_drv_data *drvdata)
> > > +{
> > > +	u32 buf_status = readl(drvdata->base + SMB_LB_INT_STS);
> > > +
> > > +	return buf_status & BIT(0) ? false : true;
> > > +}
> > > +
> > > +static bool smb_buffer_cmp_pointer(struct smb_drv_data *drvdata)
> > > +{
> > > +	u32 wr_offset, rd_offset;
> > > +
> > > +	wr_offset = readl(drvdata->base + SMB_LB_WR_ADDR);
> > > +	rd_offset = readl(drvdata->base + SMB_LB_RD_ADDR);
> > > +	return wr_offset == rd_offset;
> > > +}
> > > +
> > > +static void smb_reset_buffer_status(struct smb_drv_data *drvdata)
> > > +{
> > > +	writel(0xf, drvdata->base + SMB_LB_INT_STS);
> > > +}
> > > +
> > > +/* Purge data remaining in hardware path to SMB. */
> > > +static void smb_purge_data(struct smb_drv_data *drvdata)
> > > +{
> > > +	writel(0x1, drvdata->base + SMB_LB_PURGE);
> > > +}
> > > +
> > > +static void smb_update_data_size(struct smb_drv_data *drvdata)
> > > +{
> > > +	struct smb_data_buffer *sdb = &drvdata->sdb;
> > > +	u32 write_offset;
> > > +
> > > +	smb_purge_data(drvdata);
> > > +	if (smb_buffer_cmp_pointer(drvdata)) {
> > > +		if (smb_buffer_is_empty(drvdata))
> > > +			sdb->data_size = 0;
> > > +		else
> > > +			sdb->data_size = sdb->buf_size;
> > > +		return;
> > > +	}
> > > +
> > > +	write_offset = readl(drvdata->base + SMB_LB_WR_ADDR) - sdb->start_addr;
> > > +	sdb->data_size = CIRC_CNT(write_offset, sdb->rd_offset, sdb->buf_size);
> > > +}
> > > +
> > > +static int smb_open(struct inode *inode, struct file *file)
> > > +{
> > > +	struct smb_drv_data *drvdata = container_of(file->private_data,
> > > +						    struct smb_drv_data, miscdev);
> > > +
> > > +	if (local_cmpxchg(&drvdata->reading, 0, 1))
> > > +		return -EBUSY;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static ssize_t smb_read(struct file *file, char __user *data, size_t len, loff_t *ppos)
> > > +{
> > > +	struct smb_drv_data *drvdata = container_of(file->private_data,
> > > +						    struct smb_drv_data, miscdev);
> > > +	struct smb_data_buffer *sdb = &drvdata->sdb;
> > > +	struct device *dev = &drvdata->csdev->dev;
> > > +	unsigned long flags;
> > > +	int to_copy = 0;
> > > +
> > > +	spin_lock_irqsave(&drvdata->spinlock, flags);
> > > +
> > > +	if (!sdb->data_size) {
> > > +		smb_update_data_size(drvdata);
> > > +		if (!sdb->data_size)
> > > +			goto out;
> > > +	}
> > > +
> > > +	if (atomic_read(drvdata->csdev->refcnt)) {
> > > +		to_copy = -EBUSY;
> > > +		goto out;
> > > +	}
> > > +
> > > +	to_copy = min(sdb->data_size, len);
> > > +
> > > +	/* Copy parts of trace data when the read pointer will wrap around SMB buffer. */
> > > +	if (sdb->rd_offset + to_copy > sdb->buf_size)
> > > +		to_copy = sdb->buf_size - sdb->rd_offset;
> > > +
> > > +	if (copy_to_user(data, (void *)sdb->buf_base + sdb->rd_offset, to_copy)) {
> > > +		dev_dbg(dev, "Failed to copy data to user.\n");
> > > +		to_copy = -EFAULT;
> > > +		goto out;
> > > +	}
> > > +
> > > +	*ppos += to_copy;
> > > +	sdb->data_size -= to_copy;
> > > +	sdb->rd_offset += to_copy;
> > > +	sdb->rd_offset %= sdb->buf_size;
> > > +	writel(sdb->start_addr + sdb->rd_offset, drvdata->base + SMB_LB_RD_ADDR);
> > > +	dev_dbg(dev, "%d bytes copied.\n", to_copy);
> > > +out:
> > > +	if (!sdb->data_size)
> > > +		smb_reset_buffer_status(drvdata);
> > > +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> > > +	return to_copy;
> > > +}
> > > +
> > > +static int smb_release(struct inode *inode, struct file *file)
> > > +{
> > > +	struct smb_drv_data *drvdata = container_of(file->private_data,
> > > +						    struct smb_drv_data, miscdev);
> > > +	local_set(&drvdata->reading, 0);
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct file_operations smb_fops = {
> > > +	.owner		= THIS_MODULE,
> > > +	.open		= smb_open,
> > > +	.read		= smb_read,
> > > +	.release	= smb_release,
> > > +	.llseek		= no_llseek,
> > > +};
> > > +
> > > +smb_simple_func(struct smb_drv_data, read_pos, SMB_LB_RD_ADDR);
> > > +smb_simple_func(struct smb_drv_data, write_pos, SMB_LB_WR_ADDR);
> > > +smb_simple_func(struct smb_drv_data, buf_status, SMB_LB_INT_STS);
> > > +
> > > +static ssize_t buf_size_show(struct device *dev, struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct smb_drv_data *drvdata = dev_get_drvdata(dev->parent);
> > > +
> > > +	return sysfs_emit(buf, "0x%lx\n", drvdata->sdb.buf_size);
> > > +}
> > > +static DEVICE_ATTR_RO(buf_size);
> > > +
> > > +static struct attribute *smb_sink_attrs[] = {
> > > +	&dev_attr_read_pos.attr,
> > > +	&dev_attr_write_pos.attr,
> > > +	&dev_attr_buf_status.attr,
> > > +	&dev_attr_buf_size.attr,
> > > +	NULL,
> > > +};
> > > +
> > > +static const struct attribute_group smb_sink_group = {
> > > +	.attrs = smb_sink_attrs,
> > > +	.name = "status",
> > > +};
> > > +
> > > +static const struct attribute_group *smb_sink_groups[] = {
> > > +	&smb_sink_group,
> > > +	NULL,
> > > +};
> > > +
> > > +static int smb_set_perf_buffer(struct perf_output_handle *handle)
> > > +{
> > > +	struct cs_buffers *buf = etm_perf_sink_config(handle);
> > > +	u32 head;
> > > +
> > > +	if (!buf)
> > > +		return -EINVAL;
> > > +
> > > +	/* Wrap head around to the amount of space we have */
> > > +	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
> > > +
> > > +	/* Find the page to write to and offset within that page */
> > > +	buf->cur = head / PAGE_SIZE;
> > > +	buf->offset = head % PAGE_SIZE;
> > > +
> > > +	local_set(&buf->data_size, 0);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void smb_enable_hw(struct smb_drv_data *drvdata)
> > > +{
> > > +	writel(0x1, drvdata->base + SMB_GLOBAL_EN);
> > > +}
> > > +
> > > +static void smb_disable_hw(struct smb_drv_data *drvdata)
> > > +{
> > > +	writel(0x0, drvdata->base + SMB_GLOBAL_EN);
> > > +}
> > > +
> > > +static int smb_enable_sysfs(struct smb_drv_data *drvdata)
> > > +{
> > > +	if (drvdata->mode == CS_MODE_PERF)
> > > +		return -EBUSY;
> > > +
> > > +	if (drvdata->mode == CS_MODE_SYSFS)
> > > +		return 0;
> > > +
> > > +	smb_enable_hw(drvdata);
> > > +	drvdata->mode = CS_MODE_SYSFS;
> > > +	return 0;
> > > +}
> > > +
> > > +static int smb_enable_perf(struct smb_drv_data *drvdata, void *data)
> > > +{
> > > +	struct device *dev = &drvdata->csdev->dev;
> > > +	struct perf_output_handle *handle = data;
> > > +	pid_t pid;
> > > +
> > > +	if (drvdata->mode == CS_MODE_SYSFS) {
> > > +		dev_err(dev, "Device is already in used by sysfs.\n");
> > > +		return -EBUSY;
> > > +	}
> > > +
> > > +	/* Get a handle on the pid of the target process*/
> > > +	pid = task_pid_nr(handle->event->owner);
> > > +	if (drvdata->pid != -1 && drvdata->pid != pid) {
> > > +		dev_err(dev, "Device is already in used by other session.\n");
> > > +		return -EBUSY;
> > > +	}
> > > +	/* The sink is already enabled by this session. */
> > > +	if (drvdata->pid == pid)
> > > +		return 0;
> > > +
> > > +	if (smb_set_perf_buffer(handle))
> > > +		return -EINVAL;
> > > +
> > > +	smb_enable_hw(drvdata);
> > > +	drvdata->pid = pid;
> > > +	drvdata->mode = CS_MODE_PERF;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int smb_enable(struct coresight_device *csdev, u32 mode, void *data)
> > > +{
> > > +	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
> > > +	unsigned long flags;
> > > +	int ret = -EINVAL;
> > > +
> > > +	/* Do nothing if trace data is reading by other interface now. */
> > > +	if (local_read(&drvdata->reading))
> > > +		return -EBUSY;
> > > +
> > > +	spin_lock_irqsave(&drvdata->spinlock, flags);
> > > +
> > > +	if (mode == CS_MODE_SYSFS)
> > > +		ret = smb_enable_sysfs(drvdata);
> > > +
> > > +	if (mode == CS_MODE_PERF)
> > > +		ret = smb_enable_perf(drvdata, data);
> > > +
> > > +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> > > +
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	atomic_inc(csdev->refcnt);
> > > +	dev_dbg(&csdev->dev, "Ultrasoc SMB enabled.\n");
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int smb_disable(struct coresight_device *csdev)
> > > +{
> > > +	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&drvdata->spinlock, flags);
> > > +
> > > +	if (atomic_dec_return(csdev->refcnt)) {
> > > +		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> > > +		return -EBUSY;
> > > +	}
> > > +
> > > +	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
> > > +	smb_disable_hw(drvdata);
> > > +
> > > +	/*
> > > +	 * Data remaining in hardware path will be sent to SMB after purge, so needs to
> > > +	 * synchronize the read pointer to write pointer in perf mode.
> > > +	 */
> > > +	smb_purge_data(drvdata);
> > > +	if (drvdata->mode == CS_MODE_PERF)
> > > +		writel(readl(drvdata->base + SMB_LB_WR_ADDR), drvdata->base + SMB_LB_RD_ADDR);
> > > +
> > > +	/* Dissociate from the target process. */
> > > +	drvdata->pid = -1;
> > > +	drvdata->mode = CS_MODE_DISABLED;
> > > +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> > > +
> > > +	dev_dbg(&csdev->dev, "Ultrasoc SMB disabled.\n");
> > > +	return 0;
> > > +}
> > > +
> > > +static void *smb_alloc_buffer(struct coresight_device *csdev,
> > > +			      struct perf_event *event, void **pages,
> > > +			      int nr_pages, bool overwrite)
> > > +{
> > > +	struct cs_buffers *buf;
> > > +	int node;
> > > +
> > > +	node = (event->cpu == -1) ? NUMA_NO_NODE : cpu_to_node(event->cpu);
> > > +	buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
> > > +	if (!buf)
> > > +		return NULL;
> > > +
> > > +	buf->snapshot = overwrite;
> > > +	buf->nr_pages = nr_pages;
> > > +	buf->data_pages = pages;
> > > +
> > > +	return buf;
> > > +}
> > > +
> > > +static void smb_free_buffer(void *config)
> > > +{
> > > +	struct cs_buffers *buf = config;
> > > +
> > > +	kfree(buf);
> > > +}
> > > +
> > > +static void smb_sync_perf_buffer(struct smb_drv_data *drvdata,
> > > +				 struct cs_buffers *buf, unsigned long data_size)
> > > +{
> > > +	struct smb_data_buffer *sdb = &drvdata->sdb;
> > > +	char **dst_pages = (char **)buf->data_pages;
> > > +	unsigned long buf_offset = buf->offset;
> > > +	unsigned int cur = buf->cur;
> > > +	unsigned long to_copy;
> > > +
> > > +	while (data_size) {
> > > +		/* Copy parts of trace data when the read pointer will wrap around SMB buffer. */
> > > +		if (sdb->rd_offset + PAGE_SIZE - buf_offset > sdb->buf_size)
> > > +			to_copy = sdb->buf_size - sdb->rd_offset;
> > > +		else
> > > +			to_copy = min(data_size, PAGE_SIZE - buf_offset);
> > > +
> > > +		memcpy_fromio(dst_pages[cur] + buf_offset, sdb->buf_base + sdb->rd_offset, to_copy);
> > > +
> > > +		buf_offset += to_copy;
> > > +		if (buf_offset >= PAGE_SIZE) {
> > > +			buf_offset = 0;
> > > +			cur++;
> > > +			cur %= buf->nr_pages;
> > > +		}
> > > +		data_size -= to_copy;
> > > +		/* ensure memcpy finished before update the read pointer */
> > > +		sdb->rd_offset += to_copy;
> > > +		sdb->rd_offset %= sdb->buf_size;
> > > +	}
> > > +
> > > +	sdb->data_size = 0;
> > > +	writel(sdb->start_addr + sdb->rd_offset, drvdata->base + SMB_LB_RD_ADDR);
> > > +	smb_reset_buffer_status(drvdata);
> > > +}
> > > +
> > > +static unsigned long smb_update_buffer(struct coresight_device *csdev,
> > > +				       struct perf_output_handle *handle,
> > > +				       void *sink_config)
> > > +{
> > > +	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
> > > +	struct smb_data_buffer *sdb = &drvdata->sdb;
> > > +	struct cs_buffers *buf = sink_config;
> > > +	unsigned long data_size = 0;
> > > +	unsigned long flags;
> > > +	bool lost = false;
> > > +
> > > +	if (!buf)
> > > +		return 0;
> > > +
> > > +	spin_lock_irqsave(&drvdata->spinlock, flags);
> > > +
> > > +	/* Don't do anything if another tracer is using this sink. */
> > > +	if (atomic_read(csdev->refcnt) != 1)
> > > +		goto out;
> > > +
> > > +	smb_update_data_size(drvdata);
> > > +	data_size = sdb->data_size;
> > > +	if (data_size > handle->size) {
> > > +		sdb->rd_offset += data_size - handle->size;
> > > +		sdb->rd_offset %= sdb->buf_size;
> > > +		data_size = handle->size;
> > > +		lost = true;
> > > +	}
> > > +
> > > +	smb_sync_perf_buffer(drvdata, buf, data_size);
> > > +	if (!buf->snapshot && lost)
> > > +		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> > > +
> > > +out:
> > > +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> > > +	return data_size;
> > > +}
> > > +
> > > +static const struct coresight_ops_sink smb_cs_ops = {
> > > +	.enable		= smb_enable,
> > > +	.disable	= smb_disable,
> > > +	.alloc_buffer	= smb_alloc_buffer,
> > > +	.free_buffer	= smb_free_buffer,
> > > +	.update_buffer	= smb_update_buffer,
> > > +};
> > > +
> > > +static const struct coresight_ops cs_ops = {
> > > +	.sink_ops	= &smb_cs_ops,
> > > +};
> > > +
> > > +static int smb_init_data_buffer(struct platform_device *pdev, struct smb_data_buffer *sdb)
> > > +{
> > > +	struct resource *res;
> > > +	void __iomem *base;
> > > +
> > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > +	if (IS_ERR(res)) {
> > > +		dev_err(&pdev->dev, "SMB device failed to get resource.\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	sdb->start_addr = res->start & SMB_BASE_LOW_MASK;
> > > +	sdb->buf_size = resource_size(res);
> > > +	if (sdb->buf_size == 0)
> > > +		return -EINVAL;
> > > +
> > > +	base = devm_ioremap_resource(&pdev->dev, res);
> > > +	if (IS_ERR(base))
> > > +		return PTR_ERR(base);
> > > +
> > > +	sdb->buf_base = base;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void smb_init_hw(struct smb_drv_data *drvdata)
> > > +{
> > > +	u32 value;
> > > +
> > > +	/* First disable smb and clear the status of SMB buffer */
> > > +	smb_reset_buffer_status(drvdata);
> > > +	smb_disable_hw(drvdata);
> > > +	smb_purge_data(drvdata);
> > > +
> > > +	/* Using smb in single-end mode, and set other configures default */
> > > +	value = SMB_BUF_CFG_STREAMING | SMB_BUF_SINGLE_END | SMB_BUF_EN;
> > > +	writel(value, drvdata->base + SMB_LB_CFG_LO);
> > > +	value = SMB_MSG_FILTER(0x0, 0xff);
> > > +	writel(value, drvdata->base + SMB_LB_CFG_HI);
> > > +
> > > +	writel(SMB_GLOBAL_CFG, drvdata->base + SMB_CFG_REG);
> > > +	writel(SMB_GLB_INT_CFG, drvdata->base + SMB_GLOBAL_INT);
> > > +	writel(SMB_BUF_INT_CFG, drvdata->base + SMB_LB_INT_CTRL);
> > > +}
> > > +
> > > +static int smb_register_sink(struct platform_device *pdev, struct smb_drv_data *drvdata)
> > > +{
> > > +	struct coresight_platform_data *pdata = NULL;
> > > +	struct coresight_desc desc = { 0 };
> > > +	int ret;
> > > +
> > > +	pdata = coresight_get_platform_data(&pdev->dev);
> > > +	if (IS_ERR(pdata))
> > > +		return PTR_ERR(pdata);
> > > +
> > > +	desc.type = CORESIGHT_DEV_TYPE_SINK;
> > > +	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
> > > +	desc.ops = &cs_ops;
> > > +	desc.pdata = pdata;
> > > +	desc.dev = &pdev->dev;
> > > +	desc.groups = smb_sink_groups;
> > > +	desc.name = coresight_alloc_device_name(&sink_devs, &pdev->dev);
> > > +	if (!desc.name) {
> > > +		dev_err(&pdev->dev, "Failed to alloc coresight device name.");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	drvdata->csdev = coresight_register(&desc);
> > > +	if (IS_ERR(drvdata->csdev))
> > > +		return PTR_ERR(drvdata->csdev);
> > > +
> > > +	drvdata->miscdev.name = desc.name;
> > > +	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
> > > +	drvdata->miscdev.fops = &smb_fops;
> > > +	ret = misc_register(&drvdata->miscdev);
> > > +	if (ret) {
> > > +		coresight_unregister(drvdata->csdev);
> > > +		dev_err(&pdev->dev, "Failed to register misc, ret=%d.\n", ret);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void smb_unregister_sink(struct smb_drv_data *drvdata)
> > > +{
> > > +	misc_deregister(&drvdata->miscdev);
> > > +	coresight_unregister(drvdata->csdev);
> > > +}
> > > +
> > > +/*
> > > + * Send ultrasoc messge to control hardwares on the tracing path,
> > > + * using DSM calls to avoid exposing ultrasoc message format.
> > > + */
> > > +static int smb_config_inport(struct device *dev, bool enable)
> > > +{
> > > +	u32 flag = enable ? 1 : 0;
> > > +	union acpi_object *obj;
> > > +	guid_t guid;
> > > +
> > > +	if (guid_parse("82ae1283-7f6a-4cbe-aa06-53e8fb24db18", &guid)) {
> > > +		dev_err(dev, "Get GUID failed.\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &guid, 0, flag, NULL);
> > > +	if (!obj)
> > > +		dev_err(dev, "ACPI handle failed!\n");
> > > +	else
> > > +		ACPI_FREE(obj);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int smb_probe(struct platform_device *pdev)
> > > +{
> > > +	struct smb_drv_data *drvdata;
> > > +	int ret;
> > > +
> > > +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> > > +	if (!drvdata)
> > > +		return -ENOMEM;
> > > +
> > > +	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(drvdata->base)) {
> > > +		dev_err(&pdev->dev, "Failed to ioremap resource.\n");
> > > +		return PTR_ERR(drvdata->base);
> > > +	}
> > > +
> > > +	ret = smb_init_data_buffer(pdev, &drvdata->sdb);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "Failed to init buffer, ret = %d.\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	smb_init_hw(drvdata);
> > > +	spin_lock_init(&drvdata->spinlock);
> > > +	drvdata->pid = -1;
> > > +
> > > +	ret = smb_register_sink(pdev, drvdata);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "Failed to register smb sink.\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = smb_config_inport(&pdev->dev, true);
> > > +	if (ret) {
> > > +		smb_unregister_sink(drvdata);
> > > +		return ret;
> > > +	}
> > > +
> > > +	platform_set_drvdata(pdev, drvdata);
> > > +	return 0;
> > > +}
> > > +
> > > +static int smb_remove(struct platform_device *pdev)
> > > +{
> > > +	struct smb_drv_data *drvdata = platform_get_drvdata(pdev);
> > > +	int ret;
> > > +
> > > +	ret = smb_config_inport(&pdev->dev, false);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	smb_unregister_sink(drvdata);
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct acpi_device_id ultrasoc_smb_acpi_match[] = {
> > > +	{"HISI03A1", 0},
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(acpi, ultrasoc_smb_acpi_match);
> > > +
> > > +static struct platform_driver smb_driver = {
> > > +	.driver = {
> > > +		.name = "ultrasoc,smb",
> > > +		.acpi_match_table = ACPI_PTR(ultrasoc_smb_acpi_match),
> > > +		.suppress_bind_attrs = true,
> > > +	},
> > > +	.probe = smb_probe,
> > > +	.remove = smb_remove,
> > > +};
> > > +module_platform_driver(smb_driver);
> > > +
> > > +MODULE_DESCRIPTION("Ultrasoc smb driver");
> > > +MODULE_LICENSE("Dual MIT/GPL");
> > > +MODULE_AUTHOR("Jonathan Zhou <jonathan.zhouwen@huawei.com>");
> > > +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
> > > diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.h b/drivers/hwtracing/coresight/ultrasoc-smb.h
> > > new file mode 100644
> > > index 000000000000..0b725db88f84
> > > --- /dev/null
> > > +++ b/drivers/hwtracing/coresight/ultrasoc-smb.h
> > > @@ -0,0 +1,116 @@
> > > +// SPDX-License-Identifier: MIT
> > > +/*
> > > + * Copyright (C) 2021 HiSilicon Limited.
> > > + *
> > > + * Code herein communicates with and accesses proprietary hardware which is
> > > + * licensed intellectual property (IP) belonging to Siemens Digital Industries
> > > + * Software Ltd.
> > > + *
> > > + * Siemens Digital Industries Software Ltd. asserts and reserves all rights to
> > > + * their intellectual property. This paragraph may not be removed or modified
> > > + * in any way without permission from Siemens Digital Industries Software Ltd.
> > > + */
> > > +
> > > +#ifndef _ULTRASOC_SMB_H
> > > +#define _ULTRASOC_SMB_H
> > > +
> > > +#include <linux/coresight.h>
> > > +#include <linux/list.h>
> > > +#include <linux/miscdevice.h>
> > > +
> > > +#include "coresight-etm-perf.h"
> > > +#include "coresight-priv.h"
> > > +
> > > +/* Offset of SMB logical buffer registers */
> > > +#define SMB_CFG_REG			0X0
> > > +#define SMB_GLOBAL_EN			0X4
> > > +#define SMB_GLOBAL_INT			0X8
> > > +#define SMB_LB_CFG_LO			0X40
> > > +#define SMB_LB_CFG_HI			0X44
> > > +#define SMB_LB_INT_CTRL			0X48
> > > +#define SMB_LB_INT_STS			0X4C
> > > +#define SMB_LB_LIMIT			0X58
> > > +#define SMB_LB_RD_ADDR			0X5C
> > > +#define SMB_LB_WR_ADDR			0X60
> > > +#define SMB_LB_PURGE			0X64
> > > +
> > > +/* Set SMB_CFG_REG register */
> > > +#define SMB_IDLE_PRD(period)		(((period - 216) & 0xf) << 12)
> > > +#define SMB_MEM_WR(credit, rate)	(((credit) << 16) | ((rate) << 18))
> > > +#define SMB_MEM_RD(credit, rate)	(((credit) << 22) | ((rate) << 24))
> > > +#define SMB_BURST_LEN(len)		((len - 1) << 4)
> > > +#define SMB_GLOBAL_CFG			(SMB_IDLE_PRD(231) | SMB_MEM_WR(0x3, 0x0) |   \
> > > +					 SMB_MEM_RD(0x3, 0x6) | SMB_BURST_LEN(16))
> > > +
> > > +/* Set SMB_GLOBAL_INT register */
> > > +#define SMB_INT_EN			BIT(0)
> > > +#define SMB_INT_TYPE_PULSE		BIT(1)
> > > +#define SMB_INT_POLARITY_HIGH		BIT(2)
> > > +#define SMB_GLB_INT_CFG			(SMB_INT_EN | SMB_INT_TYPE_PULSE | SMB_INT_POLARITY_HIGH)
> > > +
> > > +/* Set SMB_LB_CFG_LO register */
> > > +#define SMB_BUF_EN			BIT(0)
> > > +#define SMB_BUF_SINGLE_END		BIT(1)
> > > +#define SMB_BUF_INIT			BIT(8)
> > > +#define SMB_BUF_CONTINUOUS		BIT(11)
> > > +#define SMB_FLOW_MASK			GENMASK(19, 16)
> > > +#define SMB_BUF_CFG_STREAMING		(SMB_BUF_INIT | SMB_BUF_CONTINUOUS | SMB_FLOW_MASK)
> > > +#define SMB_BASE_LOW_MASK		GENMASK(31, 0)
> > > +
> > > +/* Set SMB_LB_CFG_HI register */
> > > +#define SMB_MSG_FILTER(lower, upper)	((lower & 0xff) | ((upper & 0xff) << 8))
> > > +#define SMB_BUF_INT_EN			BIT(0)
> > > +#define SMB_BUF_NOTE_MASK		GENMASK(11, 8)
> > > +#define SMB_BUF_INT_CFG			(SMB_BUF_INT_EN | SMB_BUF_NOTE_MASK)
> > > +
> > > +/**
> > > + * struct smb_data_buffer - Details of the buffer used by SMB
> > > + * @buf_base	: Memory mapped base address of SMB.
> > > + * @start_addr	: SMB buffer start Physical address.
> > > + * @buf_size	: Size of the buffer.
> > > + * @data_size	: Size of Trace data copy to userspace.
> > > + * @rd_offset	: Offset of the read pointer in the buffer.
> > > + */
> > > +struct smb_data_buffer {
> > > +	void __iomem *buf_base;
> > > +	u32 start_addr;
> > > +	unsigned long buf_size;
> > > +	unsigned long data_size;
> > > +	unsigned long rd_offset;
> > > +};
> > > +
> > > +/**
> > > + * struct smb_drv_data - specifics associated to an SMB component
> > > + * @base:	Memory mapped base address for SMB component.
> > > + * @csdev:	Component vitals needed by the framework.
> > > + * @sdb:	Data buffer for SMB.
> > > + * @miscdev:	Specifics to handle "/dev/xyz.tmc" entry.
> > > + * @spinlock:	Only one at a time pls.
> > > + * @reading:	Synchronise user space access to SMB buffer.
> > > + * @pid:	Process ID of the process being monitored by the session
> > > + *		that is using this component.
> > > + * @mode:	how this SMB is being used, perf mode or sysfs mode.
> > > + */
> > > +struct smb_drv_data {
> > > +	void __iomem *base;
> > > +	struct coresight_device	*csdev;
> > > +	struct smb_data_buffer sdb;
> > > +	struct miscdevice miscdev;
> > > +	spinlock_t spinlock;
> > > +	local_t reading;
> > > +	pid_t pid;
> > > +	u32 mode;
> > > +};
> > > +
> > > +#define smb_simple_func(type, name, offset)				\
> > > +static ssize_t name##_show(struct device *_dev,				\
> > > +			   struct device_attribute *attr, char *buf)	\
> > > +{									\
> > > +	type *drvdata = dev_get_drvdata(_dev->parent);			\
> > > +	u32 val = readl(drvdata->base + offset);				\
> > > +									\
> > > +	return sysfs_emit(buf, "0x%x\n", val);			\
> > > +}									\
> > > +static DEVICE_ATTR_RO(name)
> > > +
> > > +#endif
> > > -- 
> > > 2.33.0
> > > 
> > .
> > 
