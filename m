Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9CF548341
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiFMJRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiFMJR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:17:29 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF6521BE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:17:25 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y196so5215024pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=fL1j1efpFgcUa5n46LNkWIKztxiREU7CdQEoDgZf0iE=;
        b=k16Q4OcIegK/SjWCU9iPqRnQs+Qa78J6qCQzkehCt3HVEoJUowYZ6KFZNrU3SOsAbx
         Z3qfalvxEtEWXJqXwhdaTSSJR/HFrEAmlCcjy/paEc8Ipj0QBmq42SGnS0eSReZ2IWeH
         OvNt4/+YlIQ076AqZqTDNXvY9LfHgkL9iOtTTvustMcvvMQ8efwRZ+Lcva1jT4vTh5IX
         IkD5OdRcIinGNgh2kcCdejlywfnytVbiKT2Lp1Zk0Oum4ZS8DYgGeVvUzoTVW8lyuGE0
         aDDMGRNa5DMJNi8miEsGifZWnrsj1913JLl+UkHB1zEd75ZTSiZ+0mrPZ9WUpKTpL9LM
         LB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fL1j1efpFgcUa5n46LNkWIKztxiREU7CdQEoDgZf0iE=;
        b=wI9+K+1Ln4qSdWOA4pF7aCr5tEQoTFhbcj6z6TVNlCTL8Kcz518IsMdQhijdf27UF6
         RxOalBk9XOYb4/jhgHuonFgqPz4fHUm/FGkTs6yx3Q+7v4CisLziDR1lnc4CZ/lfz/Xn
         Ug+7lJt2iqW9Ax2TPR+tTg2lu3T0a/q/XS0oOyf9H3s7ClGJdDsj1g2cqr8IYXH/Xldj
         USMcnRr/Oph91eAHDAs1qqZumfMLDyPy1duyxVTq4eP5ClfyLgz9VwgJzHpSoI+K724d
         S0/XATo/y9DiUJsWG3EqA6defnQsclUlZhhHU1rbDPFaDvv/9Afr7zbqR54ehXdOTyCD
         YniQ==
X-Gm-Message-State: AOAM530+d1Wc+lD507uzrMwrKYg2wESA8TyeMGcTt7fcqb6isl5s0bCD
        41bVGq8ODYGDV3SnmjmbNcik1lAR090Miw==
X-Google-Smtp-Source: ABdhPJyhTGwI2Q0c/FfrUPqtmLyLJayfjZfFihYfeKSEihVNjaGMMK9P7aDxC9shRK88yrNrn3eKlg==
X-Received: by 2002:a63:f002:0:b0:3fd:8a00:817c with SMTP id k2-20020a63f002000000b003fd8a00817cmr38256995pgh.167.1655111845004;
        Mon, 13 Jun 2022 02:17:25 -0700 (PDT)
Received: from [10.115.0.6] ([199.101.192.37])
        by smtp.gmail.com with ESMTPSA id a10-20020a62d40a000000b0051b416c065esm4809466pfh.8.2022.06.13.02.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 02:17:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] uacce: supports device isolation feature
To:     Kai Ye <yekai13@huawei.com>, gregkh@linuxfoundation.org,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, wangzhou1@hisilicon.com
References: <20220611070808.49219-1-yekai13@huawei.com>
 <20220611070808.49219-2-yekai13@huawei.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <4aee9c31-1fd0-609a-00d5-198f092051a8@linaro.org>
Date:   Mon, 13 Jun 2022 17:17:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220611070808.49219-2-yekai13@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/11 下午3:08, Kai Ye via Linux-accelerators wrote:
> UACCE add the hardware error isolation API. Users can configure
> the error frequency threshold by this vfs node. This API interface
> certainly supports the configuration of user protocol strategy. Then
> parse it inside the device driver. UACCE only reports the device
> isolate state. When the error frequency is exceeded, the device
> will be isolated. The isolation strategy should be defined in each
> driver module.
>
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>   drivers/misc/uacce/uacce.c | 76 ++++++++++++++++++++++++++++++++++++++
>   include/linux/uacce.h      | 21 ++++++++++-
>   2 files changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index b6219c6bfb48..26c07f6f2f7c 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -12,6 +12,38 @@ static dev_t uacce_devt;
>   static DEFINE_MUTEX(uacce_mutex);
>   static DEFINE_XARRAY_ALLOC(uacce_xa);
>   
> +static int cdev_get(struct device *dev, void *data)
> +{
> +	struct uacce_device *uacce;
> +	struct device **t_dev = data;
> +
> +	uacce = container_of(dev, struct uacce_device, dev);
> +	if (uacce->parent == *t_dev) {
> +		*t_dev = dev;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * dev_to_uacce - Get structure uacce device from its parent device
> + * @dev: the device
> + */
> +struct uacce_device *dev_to_uacce(struct device *dev)
> +{
> +	struct device **tdev = &dev;
> +	int ret;
> +
> +	ret = class_for_each_device(uacce_class, NULL, tdev, cdev_get);
> +	if (ret) {
> +		dev = *tdev;
> +		return container_of(dev, struct uacce_device, dev);
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(dev_to_uacce);
Not find dev_to_uacce user.
> +
>   static int uacce_start_queue(struct uacce_queue *q)
>   {
>   	int ret = 0;
> @@ -54,6 +86,7 @@ static int uacce_put_queue(struct uacce_queue *q)
>   		uacce->ops->put_queue(q);
>   
>   	q->state = UACCE_Q_ZOMBIE;
> +	atomic_dec(&uacce->ref);
>   out:
>   	mutex_unlock(&uacce_mutex);
>   
> @@ -155,6 +188,7 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
>   			goto out_with_bond;
>   	}
>   
> +	atomic_inc(&uacce->ref);
Use uacce->ref is strange here, also no dec in release.
How about hidden this in driver itself, like via qm->state, to make 
uacce itslef clean.

>   	init_waitqueue_head(&q->wait);
>   	filep->private_data = q;
>   	uacce->inode = inode;
> @@ -346,12 +380,52 @@ static ssize_t region_dus_size_show(struct device *dev,
>   		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
>   }
>   
> +static ssize_t isolate_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +
> +	return sysfs_emit(buf, "%d\n", uacce->ops->get_isolate_state(uacce));
> +}
> +
> +static ssize_t isolate_strategy_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +
> +	return sysfs_emit(buf, "%s\n", uacce->isolate_strategy);
> +}
> +
> +static ssize_t isolate_strategy_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +	int ret;
> +
> +	if (atomic_read(&uacce->ref))
> +		return -EBUSY;
> +
> +	if (!buf || sizeof(buf) > UACCE_MAX_ISOLATE_STRATEGY_LEN)
> +		return -EINVAL;
> +
> +	memcpy(uacce->isolate_strategy, buf, strlen(buf));
> +
> +	ret = uacce->ops->isolate_strategy_write(uacce, buf);
> +	if (ret)
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
>   static DEVICE_ATTR_RO(api);
>   static DEVICE_ATTR_RO(flags);
>   static DEVICE_ATTR_RO(available_instances);
>   static DEVICE_ATTR_RO(algorithms);
>   static DEVICE_ATTR_RO(region_mmio_size);
>   static DEVICE_ATTR_RO(region_dus_size);
> +static DEVICE_ATTR_RO(isolate);
> +static DEVICE_ATTR_RW(isolate_strategy);
Need update Documentation/ABI/testing/sysfs-driver-uacce as well.

isolate_strategy is confusing, what strategy can be chosen, need doc.

Thanks


>   
>   static struct attribute *uacce_dev_attrs[] = {
>   	&dev_attr_api.attr,
> @@ -360,6 +434,8 @@ static struct attribute *uacce_dev_attrs[] = {
>   	&dev_attr_algorithms.attr,
>   	&dev_attr_region_mmio_size.attr,
>   	&dev_attr_region_dus_size.attr,
> +	&dev_attr_isolate.attr,
> +	&dev_attr_isolate_strategy.attr,
>   	NULL,
>   };
>   
> diff --git a/include/linux/uacce.h b/include/linux/uacce.h
> index 48e319f40275..30b1595b3f85 100644
> --- a/include/linux/uacce.h
> +++ b/include/linux/uacce.h
> @@ -8,6 +8,7 @@
>   #define UACCE_NAME		"uacce"
>   #define UACCE_MAX_REGION	2
>   #define UACCE_MAX_NAME_SIZE	64
> +#define UACCE_MAX_ISOLATE_STRATEGY_LEN	256
>   
>   struct uacce_queue;
>   struct uacce_device;
> @@ -30,6 +31,8 @@ struct uacce_qfile_region {
>    * @is_q_updated: check whether the task is finished
>    * @mmap: mmap addresses of queue to user space
>    * @ioctl: ioctl for user space users of the queue
> + * @get_isolate_state: get the device state after set the isolate strategy
> + * @isolate_strategy_store: stored the isolate strategy to the device
>    */
>   struct uacce_ops {
>   	int (*get_available_instances)(struct uacce_device *uacce);
> @@ -43,6 +46,8 @@ struct uacce_ops {
>   		    struct uacce_qfile_region *qfr);
>   	long (*ioctl)(struct uacce_queue *q, unsigned int cmd,
>   		      unsigned long arg);
> +	enum uacce_dev_state (*get_isolate_state)(struct uacce_device *uacce);
> +	int (*isolate_strategy_write)(struct uacce_device *uacce, const char *buf);
>   };
>   
>   /**
> @@ -57,6 +62,12 @@ struct uacce_interface {
>   	const struct uacce_ops *ops;
>   };
>   
> +enum uacce_dev_state {
> +	UACCE_DEV_ERR = -1,
> +	UACCE_DEV_NORMAL,
> +	UACCE_DEV_ISOLATE,
> +};
> +
>   enum uacce_q_state {
>   	UACCE_Q_ZOMBIE = 0,
>   	UACCE_Q_INIT,
> @@ -99,6 +110,7 @@ struct uacce_queue {
>    * @dev: dev of the uacce
>    * @priv: private pointer of the uacce
>    * @queues: list of queues
> + * @ref: reference of the uacce
>    * @queues_lock: lock for queues list
>    * @inode: core vfs
>    */
> @@ -114,9 +126,11 @@ struct uacce_device {
>   	struct cdev *cdev;
>   	struct device dev;
>   	void *priv;
> +	atomic_t ref;
>   	struct list_head queues;
>   	struct mutex queues_lock;
>   	struct inode *inode;
> +	char isolate_strategy[UACCE_MAX_ISOLATE_STRATEGY_LEN];
>   };
>   
>   #if IS_ENABLED(CONFIG_UACCE)
> @@ -125,7 +139,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
>   				 struct uacce_interface *interface);
>   int uacce_register(struct uacce_device *uacce);
>   void uacce_remove(struct uacce_device *uacce);
> -
> +struct uacce_device *dev_to_uacce(struct device *dev);
>   #else /* CONFIG_UACCE */
>   
>   static inline
> @@ -142,6 +156,11 @@ static inline int uacce_register(struct uacce_device *uacce)
>   
>   static inline void uacce_remove(struct uacce_device *uacce) {}
>   
> +static inline struct uacce_device *dev_to_uacce(struct device *dev)
> +{
> +	return NULL;
> +}
> +
>   #endif /* CONFIG_UACCE */
>   
>   #endif /* _LINUX_UACCE_H */

