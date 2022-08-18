Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2322A5990F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 01:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244947AbiHRXLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 19:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbiHRXLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:11:13 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D97CE469;
        Thu, 18 Aug 2022 16:11:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w138so234108pfc.10;
        Thu, 18 Aug 2022 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=oO4Bc2hWKfVwXdlktiQE0jBPW25iYRkPbwFVfrYw1rQ=;
        b=JQuWyaiCbdfm4q7rdAUBaYGXABfyu6g7jJP8XT0ZFn2i7em6oGtpQ626yXJS/IC7mt
         UnAO6uMMKGBmlv2M38QCdTXuD1IbAJBSni4s7Tia8dMUAFMQ5JMnN7ggrf4DO+jGiFl/
         suaAnQFNmffAZJrYYVHLcBqHN44FWNgn8U5hY5gondQOpMZCSQqNFmTGcXHP3u+0i2Wl
         mIr8cWkVa3tPWEDOpPdINO8MUIGSZ2Udw6rdChDz9TYYrzhfk7H5r7hiNvB9QPhZsmz+
         Eyd0YEnEODLEZJDZ++0YZz6fLq3a3bbrKgMwJPnq6292IK9lDdEeFaT/A/yyjPRM/q29
         ctkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=oO4Bc2hWKfVwXdlktiQE0jBPW25iYRkPbwFVfrYw1rQ=;
        b=1Bjo8flT2Qh+SuvSv675ZX+16x0HGIG58Jj3/sALGomUn3JXwKJdNghM+s9dkg4T9o
         UtdFzm+BGx6UBhao/bpfH76N5/mOxUcsNnOg6yzeZ5uiXqZLr8ZGd5CJI7oQjRRqYTAF
         9FJbYQmCXw1sD8BkSYwL6AV6m8EIkXYXSX5btqtAPBVlMCF1McjtXNcxMB5FZ5JP0NlM
         zEpUZmu2OXMSHhu0zsB4S5LQJq1yXgFqdlPo7G2CFQVKJLhdpAX5I2p6Gb2g8PGhbT3C
         t8e/XlvUy3f+6RaHWuA6Mmv7puFa8VKPbbno/3dEbRiKc3LM0rnP5w8llln9ldBYojr/
         dK5Q==
X-Gm-Message-State: ACgBeo2XOBD3KrhRf7NoQqJQiRgJCbXEH9oucAptTL7v3prNkNFsOTFK
        vlsdhmZ9YcmKSKS0Hws1wXs=
X-Google-Smtp-Source: AA6agR5joEcXdVJZVS7Q2KreZvxoBSDoC8abh7gvhtYJOQriux0crv7KcIKjdUMBbYniIRC1llBTJQ==
X-Received: by 2002:a63:1a53:0:b0:41f:5298:9b5f with SMTP id a19-20020a631a53000000b0041f52989b5fmr4009107pgm.244.1660864271773;
        Thu, 18 Aug 2022 16:11:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e8-20020aa79808000000b0052d8b663c37sm2150757pfl.195.2022.08.18.16.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 16:11:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 16:11:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 16/16] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Message-ID: <20220818231106.GA3505191@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-17-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817054321.6519-17-farbere@amazon.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 05:43:21AM +0000, Eliav Farber wrote:
> This change adds debugfs to read and write TS coefficients - g, h, j and
> cal5.
> 
> The coefficients can vary between product and product, so to calibrate
> them it can be very useful to to be able to modify them on the fly.
> 
> e.g.
> 
> cat /sys/kernel/debug/940f23d0000.pvt/ts_coeff_cal5
> 4096
> 
> echo 83000 > sys/kernel/debug/940f23d0000.pvt/ts_coeff_g
> 

What happens if you write 0 into all those attributes, or 0xffffffff ?

Guenter

> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  drivers/hwmon/mr75203.c | 196 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 196 insertions(+)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 2898565afaab..ce34a44237e8 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -9,6 +9,7 @@
>   */
>  #include <linux/bits.h>
>  #include <linux/clk.h>
> +#include <linux/debugfs.h>
>  #include <linux/hwmon.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> @@ -127,6 +128,7 @@ struct pvt_device {
>  	struct clk		*clk;
>  	struct reset_control	*rst;
>  	struct voltage_device	*vd;
> +	struct dentry		*dbgfs_dir;
>  	u32			t_num;
>  	u32			p_num;
>  	u32			v_num;
> @@ -139,6 +141,198 @@ struct pvt_device {
>  	u8			vm_ch_total;
>  };
>  
> +static ssize_t pvt_ts_coeff_h_read(struct file *file,
> +				   char __user *user_buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct pvt_device *pvt = file->private_data;
> +	char buf[16];
> +	unsigned int len;
> +
> +	len = sprintf(buf, "%u\n", pvt->ts_coeff_h);
> +
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
> +}
> +
> +static ssize_t pvt_ts_coeff_h_write(struct file *file,
> +				    const char __user *user_buf,
> +				    size_t count, loff_t *ppos)
> +{
> +	struct pvt_device *pvt = file->private_data;
> +	int ret;
> +	u32 coeff;
> +
> +	ret = kstrtou32_from_user(user_buf, count, 0, &coeff);
> +	if (ret)
> +		return ret;
> +
> +	pvt->ts_coeff_h = coeff;
> +
> +	return count;
> +}
> +
> +static const struct file_operations pvt_ts_coeff_h_fops = {
> +	.read = pvt_ts_coeff_h_read,
> +	.write = pvt_ts_coeff_h_write,
> +	.open = simple_open,
> +	.owner = THIS_MODULE,
> +	.llseek = default_llseek,
> +};
> +
> +static ssize_t pvt_ts_coeff_g_read(struct file *file,
> +				   char __user *user_buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct pvt_device *pvt = file->private_data;
> +	char buf[16];
> +	unsigned int len;
> +
> +	len = sprintf(buf, "%u\n", pvt->ts_coeff_g);
> +
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
> +}
> +
> +static ssize_t pvt_ts_coeff_g_write(struct file *file,
> +				    const char __user *user_buf,
> +				    size_t count, loff_t *ppos)
> +{
> +	struct pvt_device *pvt = file->private_data;
> +	int ret;
> +	u32 coeff;
> +
> +	ret = kstrtou32_from_user(user_buf, count, 0, &coeff);
> +	if (ret)
> +		return ret;
> +
> +	pvt->ts_coeff_g = coeff;
> +
> +	return count;
> +}
> +
> +static const struct file_operations pvt_ts_coeff_g_fops = {
> +	.read = pvt_ts_coeff_g_read,
> +	.write = pvt_ts_coeff_g_write,
> +	.open = simple_open,
> +	.owner = THIS_MODULE,
> +	.llseek = default_llseek,
> +};
> +
> +static ssize_t pvt_ts_coeff_j_read(struct file *file,
> +				   char __user *user_buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct pvt_device *pvt = file->private_data;
> +	char buf[16];
> +	unsigned int len;
> +
> +	len = sprintf(buf, "%d\n", pvt->ts_coeff_j);
> +
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
> +}
> +
> +static ssize_t pvt_ts_coeff_j_write(struct file *file,
> +				    const char __user *user_buf,
> +				    size_t count, loff_t *ppos)
> +{
> +	struct pvt_device *pvt = file->private_data;
> +	int ret;
> +	s32 coeff;
> +
> +	ret = kstrtos32_from_user(user_buf, count, 0, &coeff);
> +	if (ret)
> +		return ret;
> +
> +	pvt->ts_coeff_j = coeff;
> +
> +	return count;
> +}
> +
> +static const struct file_operations pvt_ts_coeff_j_fops = {
> +	.read = pvt_ts_coeff_j_read,
> +	.write = pvt_ts_coeff_j_write,
> +	.open = simple_open,
> +	.owner = THIS_MODULE,
> +	.llseek = default_llseek,
> +};
> +
> +static ssize_t pvt_ts_coeff_cal5_read(struct file *file,
> +				      char __user *user_buf,
> +				      size_t count, loff_t *ppos)
> +{
> +	struct pvt_device *pvt = file->private_data;
> +	char buf[16];
> +	unsigned int len;
> +
> +	len = sprintf(buf, "%u\n", pvt->ts_coeff_cal5);
> +
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
> +}
> +
> +static ssize_t pvt_ts_coeff_cal5_write(struct file *file,
> +				       const char __user *user_buf,
> +				       size_t count, loff_t *ppos)
> +{
> +	struct pvt_device *pvt = file->private_data;
> +	int ret;
> +	u32 coeff;
> +
> +	ret = kstrtou32_from_user(user_buf, count, 0, &coeff);
> +	if (ret)
> +		return ret;
> +
> +	if (coeff == 0)
> +		return -EINVAL;
> +
> +	pvt->ts_coeff_cal5 = coeff;
> +
> +	return count;
> +}
> +
> +static const struct file_operations pvt_ts_coeff_cal5_fops = {
> +	.read = pvt_ts_coeff_cal5_read,
> +	.write = pvt_ts_coeff_cal5_write,
> +	.open = simple_open,
> +	.owner = THIS_MODULE,
> +	.llseek = default_llseek,
> +};
> +
> +static void devm_pvt_ts_dbgfs_remove(void *data)
> +{
> +	struct pvt_device *pvt = (struct pvt_device *)data;
> +
> +	debugfs_remove_recursive(pvt->dbgfs_dir);
> +	pvt->dbgfs_dir = NULL;
> +}
> +
> +static int pvt_ts_dbgfs_create(struct pvt_device *pvt, struct device *dev)
> +{
> +	int ret;
> +
> +	pvt->dbgfs_dir = debugfs_create_dir(dev_name(dev), NULL);
> +	if (!pvt->dbgfs_dir) {
> +		dev_err(dev, "Failed to create dbgfs_dir\n");
> +		return -EINVAL;
> +	}
> +
> +	debugfs_create_file("ts_coeff_h", 0644, pvt->dbgfs_dir, pvt,
> +			    &pvt_ts_coeff_h_fops);
> +	debugfs_create_file("ts_coeff_g", 0644, pvt->dbgfs_dir, pvt,
> +			    &pvt_ts_coeff_g_fops);
> +	debugfs_create_file("ts_coeff_j", 0644, pvt->dbgfs_dir, pvt,
> +			    &pvt_ts_coeff_j_fops);
> +	debugfs_create_file("ts_coeff_cal5", 0644, pvt->dbgfs_dir,  pvt,
> +			    &pvt_ts_coeff_cal5_fops);
> +
> +	ret = devm_add_action_or_reset(dev, devm_pvt_ts_dbgfs_remove, pvt);
> +	if (ret) {
> +		dev_err(dev, "failed to add action to remove pvt dbgfs (%d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static umode_t pvt_is_visible(const void *data, enum hwmon_sensor_types type,
>  			      u32 attr, int channel)
>  {
> @@ -655,6 +849,8 @@ static int mr75203_probe(struct platform_device *pdev)
>  		dev_dbg(dev, "ts-coeff: h = %u, g = %u, j = %d, cal5 = %u\n",
>  			pvt->ts_coeff_h, pvt->ts_coeff_g, pvt->ts_coeff_j,
>  			pvt->ts_coeff_cal5);
> +
> +		pvt_ts_dbgfs_create(pvt, dev);
>  	}
>  
>  	if (pd_num) {
