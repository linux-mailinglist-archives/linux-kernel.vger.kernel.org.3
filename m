Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6F64B3C16
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 16:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiBMPeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 10:34:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiBMPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 10:34:13 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ED35EDE8;
        Sun, 13 Feb 2022 07:34:07 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so16479380ooq.10;
        Sun, 13 Feb 2022 07:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TTiQHT20acu144OZlmLFojXyrRl0s6i5ybyA5nEDyWQ=;
        b=IuSJWfA9r2A0S68Qnuu6A3zna0L3S1lypgQ3u3Xv9l1XfUaaA0NpqNmCd/Gx9I13ZE
         1i0+ZG3PIiz52wS/eWsGAyvbhnKrN75SknJ7iYVcEAlqEocb35Peu61A7BToXBsMdVv2
         UT2JmZ/kM9ObPDhDEUzx5GFHqX6+FuWa9dnjPwwhRnNMDHspwPsQfknxN6/iW3QGTCrE
         zyGy5gE0nN6CRBRFtsvSmgqYst0+6qcHiMahus/57qBghfPVPQ45aazK1dps6QukjmoU
         qbnjs7Y0bCl+nrzSwTSn0tOS85EMxgKkC99gclxIZm3rUC+drXSHVpnkW2g4mW71bfuw
         TT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TTiQHT20acu144OZlmLFojXyrRl0s6i5ybyA5nEDyWQ=;
        b=5roaEnV5Sa+TZSc/w9qAKu/jkzCwzkOGaSLT+yax4fEIrnKK91RP+xidap6V3lJVoz
         GWMgcukYA1qrMbCzx3R4uOefBHFJG6+hti2pZ+BiSlLt0w5XP13NR+qmFHufynSmmDPz
         I6y3yB9Afki+kbhZRbw1mDdrYsGWOBDKpECQnx0AbhJ2l9by8phCfqNhp1ZHXiJIemVx
         nTQBFMhaYySNqP7Keh48FG1MPNPcialpcphiC8SrT9UFHDRBEFqy2yuK/WQU1sId30dn
         ZKJ4XMnsXg4VmdDkbpQi3BNgYibm8uN4BFCuA9tqGwRPck1DIUkwZWssOaEqUKzI1Vxz
         50HQ==
X-Gm-Message-State: AOAM531MCyFYuFzADN4hkiWfFLuu3ucCK8OaH6Yv30L6xCam9gMnV+Oq
        X3NwedyCFc03S6LK/5vDOSC3pJJVHo14uw==
X-Google-Smtp-Source: ABdhPJxl2GOuSjAoeUQDPmpd0FOOGnO8hPAFtAdh/ELWY51j5kRUVnmANZz84oDuN70jd9s/VHdubw==
X-Received: by 2002:a05:6870:9543:: with SMTP id v3mr2873456oal.136.1644766446526;
        Sun, 13 Feb 2022 07:34:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a10sm11282094otb.58.2022.02.13.07.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Feb 2022 07:34:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d2859be7-a1e4-9f6a-5df3-e050e42061b9@roeck-us.net>
Date:   Sun, 13 Feb 2022 07:34:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2] watchdog: Improve watchdog_dev function documentation
Content-Language: en-US
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <30378a03e9cd9b5f6e92ec9bf512edc38bad8627.1644589712.git.bristot@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <30378a03e9cd9b5f6e92ec9bf512edc38bad8627.1644589712.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 06:30, Daniel Bristot de Oliveira wrote:
> Adjust function comments to the kernel doc format. It
> also adjusts some variable names and adds return values.
> 
> No functional change.
> 
> Changes from V1:
>    Change "Returns" to "Return:" (Randy Dunlap)
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/watchdog_dev.c | 244 ++++++++++++++++----------------
>   1 file changed, 125 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 3a3d8b5c7ad5..54903f3c851e 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -171,17 +171,17 @@ static int __watchdog_ping(struct watchdog_device *wdd)
>   }
>   
>   /*
> - *	watchdog_ping: ping the watchdog.
> - *	@wdd: the watchdog device to ping
> + * watchdog_ping - ping the watchdog
> + * @wdd: The watchdog device to ping
>    *
> - *	The caller must hold wd_data->lock.
> + * If the watchdog has no own ping operation then it needs to be
> + * restarted via the start operation. This wrapper function does
> + * exactly that.
> + * We only ping when the watchdog device is running.
> + * The caller must hold wd_data->lock.
>    *
> - *	If the watchdog has no own ping operation then it needs to be
> - *	restarted via the start operation. This wrapper function does
> - *	exactly that.
> - *	We only ping when the watchdog device is running.
> + * Return: 0 on success, error otherwise.
>    */
> -
>   static int watchdog_ping(struct watchdog_device *wdd)
>   {
>   	struct watchdog_core_data *wd_data = wdd->wd_data;
> @@ -231,16 +231,14 @@ static enum hrtimer_restart watchdog_timer_expired(struct hrtimer *timer)
>   }
>   
>   /*
> - *	watchdog_start: wrapper to start the watchdog.
> - *	@wdd: the watchdog device to start
> + * watchdog_start - wrapper to start the watchdog
> + * @wdd: The watchdog device to start
>    *
> - *	The caller must hold wd_data->lock.
> + * Start the watchdog if it is not active and mark it active.
> + * The caller must hold wd_data->lock.
>    *
> - *	Start the watchdog if it is not active and mark it active.
> - *	This function returns zero on success or a negative errno code for
> - *	failure.
> + * Return: 0 on success or a negative errno code for failure.
>    */
> -
>   static int watchdog_start(struct watchdog_device *wdd)
>   {
>   	struct watchdog_core_data *wd_data = wdd->wd_data;
> @@ -274,17 +272,15 @@ static int watchdog_start(struct watchdog_device *wdd)
>   }
>   
>   /*
> - *	watchdog_stop: wrapper to stop the watchdog.
> - *	@wdd: the watchdog device to stop
> + * watchdog_stop - wrapper to stop the watchdog
> + * @wdd: The watchdog device to stop
>    *
> - *	The caller must hold wd_data->lock.
> + * Stop the watchdog if it is still active and unmark it active.
> + * If the 'nowayout' feature was set, the watchdog cannot be stopped.
> + * The caller must hold wd_data->lock.
>    *
> - *	Stop the watchdog if it is still active and unmark it active.
> - *	This function returns zero on success or a negative errno code for
> - *	failure.
> - *	If the 'nowayout' feature was set, the watchdog cannot be stopped.
> + * Return: 0 on success or a negative errno code for failure.
>    */
> -
>   static int watchdog_stop(struct watchdog_device *wdd)
>   {
>   	int err = 0;
> @@ -315,14 +311,14 @@ static int watchdog_stop(struct watchdog_device *wdd)
>   }
>   
>   /*
> - *	watchdog_get_status: wrapper to get the watchdog status
> - *	@wdd: the watchdog device to get the status from
> + * watchdog_get_status - wrapper to get the watchdog status
> + * @wdd: The watchdog device to get the status from
>    *
> - *	The caller must hold wd_data->lock.
> + * Get the watchdog's status flags.
> + * The caller must hold wd_data->lock.
>    *
> - *	Get the watchdog's status flags.
> + * Return: watchdog's status flags.
>    */
> -
>   static unsigned int watchdog_get_status(struct watchdog_device *wdd)
>   {
>   	struct watchdog_core_data *wd_data = wdd->wd_data;
> @@ -352,13 +348,14 @@ static unsigned int watchdog_get_status(struct watchdog_device *wdd)
>   }
>   
>   /*
> - *	watchdog_set_timeout: set the watchdog timer timeout
> - *	@wdd: the watchdog device to set the timeout for
> - *	@timeout: timeout to set in seconds
> + * watchdog_set_timeout - set the watchdog timer timeout
> + * @wdd:	The watchdog device to set the timeout for
> + * @timeout:	Timeout to set in seconds
> + *
> + * The caller must hold wd_data->lock.
>    *
> - *	The caller must hold wd_data->lock.
> + * Return: 0 if successful, error otherwise.
>    */
> -
>   static int watchdog_set_timeout(struct watchdog_device *wdd,
>   							unsigned int timeout)
>   {
> @@ -385,11 +382,12 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
>   }
>   
>   /*
> - *	watchdog_set_pretimeout: set the watchdog timer pretimeout
> - *	@wdd: the watchdog device to set the timeout for
> - *	@timeout: pretimeout to set in seconds
> + * watchdog_set_pretimeout - set the watchdog timer pretimeout
> + * @wdd:	The watchdog device to set the timeout for
> + * @timeout:	pretimeout to set in seconds
> + *
> + * Return: 0 if successful, error otherwise.
>    */
> -
>   static int watchdog_set_pretimeout(struct watchdog_device *wdd,
>   				   unsigned int timeout)
>   {
> @@ -410,15 +408,15 @@ static int watchdog_set_pretimeout(struct watchdog_device *wdd,
>   }
>   
>   /*
> - *	watchdog_get_timeleft: wrapper to get the time left before a reboot
> - *	@wdd: the watchdog device to get the remaining time from
> - *	@timeleft: the time that's left
> + * watchdog_get_timeleft - wrapper to get the time left before a reboot
> + * @wdd:	The watchdog device to get the remaining time from
> + * @timeleft:	The time that's left
>    *
> - *	The caller must hold wd_data->lock.
> + * Get the time before a watchdog will reboot (if not pinged).
> + * The caller must hold wd_data->lock.
>    *
> - *	Get the time before a watchdog will reboot (if not pinged).
> + * Return: 0 if successful, error otherwise.
>    */
> -
>   static int watchdog_get_timeleft(struct watchdog_device *wdd,
>   							unsigned int *timeleft)
>   {
> @@ -635,14 +633,15 @@ __ATTRIBUTE_GROUPS(wdt);
>   #endif
>   
>   /*
> - *	watchdog_ioctl_op: call the watchdog drivers ioctl op if defined
> - *	@wdd: the watchdog device to do the ioctl on
> - *	@cmd: watchdog command
> - *	@arg: argument pointer
> + * watchdog_ioctl_op - call the watchdog drivers ioctl op if defined
> + * @wdd: The watchdog device to do the ioctl on
> + * @cmd: Watchdog command
> + * @arg: Argument pointer
>    *
> - *	The caller must hold wd_data->lock.
> + * The caller must hold wd_data->lock.
> + *
> + * Return: 0 if successful, error otherwise.
>    */
> -
>   static int watchdog_ioctl_op(struct watchdog_device *wdd, unsigned int cmd,
>   							unsigned long arg)
>   {
> @@ -653,17 +652,18 @@ static int watchdog_ioctl_op(struct watchdog_device *wdd, unsigned int cmd,
>   }
>   
>   /*
> - *	watchdog_write: writes to the watchdog.
> - *	@file: file from VFS
> - *	@data: user address of data
> - *	@len: length of data
> - *	@ppos: pointer to the file offset
> + * watchdog_write - writes to the watchdog
> + * @file:	File from VFS
> + * @data:	User address of data
> + * @len:	Length of data
> + * @ppos:	Pointer to the file offset
>    *
> - *	A write to a watchdog device is defined as a keepalive ping.
> - *	Writing the magic 'V' sequence allows the next close to turn
> - *	off the watchdog (if 'nowayout' is not set).
> + * A write to a watchdog device is defined as a keepalive ping.
> + * Writing the magic 'V' sequence allows the next close to turn
> + * off the watchdog (if 'nowayout' is not set).
> + *
> + * Return: @len if successful, error otherwise.
>    */
> -
>   static ssize_t watchdog_write(struct file *file, const char __user *data,
>   						size_t len, loff_t *ppos)
>   {
> @@ -706,13 +706,15 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
>   }
>   
>   /*
> - *	watchdog_ioctl: handle the different ioctl's for the watchdog device.
> - *	@file: file handle to the device
> - *	@cmd: watchdog command
> - *	@arg: argument pointer
> + * watchdog_ioctl - handle the different ioctl's for the watchdog device
> + * @file:	File handle to the device
> + * @cmd:	Watchdog command
> + * @arg:	Argument pointer
>    *
> - *	The watchdog API defines a common set of functions for all watchdogs
> - *	according to their available features.
> + * The watchdog API defines a common set of functions for all watchdogs
> + * according to their available features.
> + *
> + * Return: 0 if successful, error otherwise.
>    */
>   
>   static long watchdog_ioctl(struct file *file, unsigned int cmd,
> @@ -819,15 +821,16 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
>   }
>   
>   /*
> - *	watchdog_open: open the /dev/watchdog* devices.
> - *	@inode: inode of device
> - *	@file: file handle to device
> + * watchdog_open - open the /dev/watchdog* devices
> + * @inode:	Inode of device
> + * @file:	File handle to device
> + *
> + * When the /dev/watchdog* device gets opened, we start the watchdog.
> + * Watch out: the /dev/watchdog device is single open, so we make sure
> + * it can only be opened once.
>    *
> - *	When the /dev/watchdog* device gets opened, we start the watchdog.
> - *	Watch out: the /dev/watchdog device is single open, so we make sure
> - *	it can only be opened once.
> + * Return: 0 if successful, error otherwise.
>    */
> -
>   static int watchdog_open(struct inode *inode, struct file *file)
>   {
>   	struct watchdog_core_data *wd_data;
> @@ -896,15 +899,16 @@ static void watchdog_core_data_release(struct device *dev)
>   }
>   
>   /*
> - *	watchdog_release: release the watchdog device.
> - *	@inode: inode of device
> - *	@file: file handle to device
> + * watchdog_release - release the watchdog device
> + * @inode:	Inode of device
> + * @file:	File handle to device
> + *
> + * This is the code for when /dev/watchdog gets closed. We will only
> + * stop the watchdog when we have received the magic char (and nowayout
> + * was not set), else the watchdog will keep running.
>    *
> - *	This is the code for when /dev/watchdog gets closed. We will only
> - *	stop the watchdog when we have received the magic char (and nowayout
> - *	was not set), else the watchdog will keep running.
> + * Always returns 0.
>    */
> -
>   static int watchdog_release(struct inode *inode, struct file *file)
>   {
>   	struct watchdog_core_data *wd_data = file->private_data;
> @@ -977,14 +981,15 @@ static struct class watchdog_class = {
>   };
>   
>   /*
> - *	watchdog_cdev_register: register watchdog character device
> - *	@wdd: watchdog device
> + * watchdog_cdev_register - register watchdog character device
> + * @wdd: Watchdog device
> + *
> + * Register a watchdog character device including handling the legacy
> + * /dev/watchdog node. /dev/watchdog is actually a miscdevice and
> + * thus we set it up like that.
>    *
> - *	Register a watchdog character device including handling the legacy
> - *	/dev/watchdog node. /dev/watchdog is actually a miscdevice and
> - *	thus we set it up like that.
> + * Return: 0 if successful, error otherwise.
>    */
> -
>   static int watchdog_cdev_register(struct watchdog_device *wdd)
>   {
>   	struct watchdog_core_data *wd_data;
> @@ -1074,13 +1079,12 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
>   }
>   
>   /*
> - *	watchdog_cdev_unregister: unregister watchdog character device
> - *	@watchdog: watchdog device
> + * watchdog_cdev_unregister - unregister watchdog character device
> + * @wdd: Watchdog device
>    *
> - *	Unregister watchdog character device and if needed the legacy
> - *	/dev/watchdog device.
> + * Unregister watchdog character device and if needed the legacy
> + * /dev/watchdog device.
>    */
> -
>   static void watchdog_cdev_unregister(struct watchdog_device *wdd)
>   {
>   	struct watchdog_core_data *wd_data = wdd->wd_data;
> @@ -1109,15 +1113,16 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
>   	put_device(&wd_data->dev);
>   }
>   
> -/*
> - *	watchdog_dev_register: register a watchdog device
> - *	@wdd: watchdog device
> +/**
> + * watchdog_dev_register - register a watchdog device
> + * @wdd: Watchdog device
> + *
> + * Register a watchdog device including handling the legacy
> + * /dev/watchdog node. /dev/watchdog is actually a miscdevice and
> + * thus we set it up like that.
>    *
> - *	Register a watchdog device including handling the legacy
> - *	/dev/watchdog node. /dev/watchdog is actually a miscdevice and
> - *	thus we set it up like that.
> + * Return: 0 if successful, error otherwise.
>    */
> -
>   int watchdog_dev_register(struct watchdog_device *wdd)
>   {
>   	int ret;
> @@ -1133,30 +1138,31 @@ int watchdog_dev_register(struct watchdog_device *wdd)
>   	return ret;
>   }
>   
> -/*
> - *	watchdog_dev_unregister: unregister a watchdog device
> - *	@watchdog: watchdog device
> +/**
> + * watchdog_dev_unregister - unregister a watchdog device
> + * @wdd: watchdog device
>    *
> - *	Unregister watchdog device and if needed the legacy
> - *	/dev/watchdog device.
> + * Unregister watchdog device and if needed the legacy
> + * /dev/watchdog device.
>    */
> -
>   void watchdog_dev_unregister(struct watchdog_device *wdd)
>   {
>   	watchdog_unregister_pretimeout(wdd);
>   	watchdog_cdev_unregister(wdd);
>   }
>   
> -/*
> - *	watchdog_set_last_hw_keepalive: set last HW keepalive time for watchdog
> - *	@wdd: watchdog device
> - *	@last_ping_ms: time since last HW heartbeat
> +/**
> + * watchdog_set_last_hw_keepalive - set last HW keepalive time for watchdog
> + * @wdd:		Watchdog device
> + * @last_ping_ms:	Time since last HW heartbeat
>    *
> - *	Adjusts the last known HW keepalive time for a watchdog timer.
> - *	This is needed if the watchdog is already running when the probe
> - *	function is called, and it can't be pinged immediately. This
> - *	function must be called immediately after watchdog registration,
> - *	and min_hw_heartbeat_ms must be set for this to be useful.
> + * Adjusts the last known HW keepalive time for a watchdog timer.
> + * This is needed if the watchdog is already running when the probe
> + * function is called, and it can't be pinged immediately. This
> + * function must be called immediately after watchdog registration,
> + * and min_hw_heartbeat_ms must be set for this to be useful.
> + *
> + * Return: 0 if successful, error otherwise.
>    */
>   int watchdog_set_last_hw_keepalive(struct watchdog_device *wdd,
>   				   unsigned int last_ping_ms)
> @@ -1180,12 +1186,13 @@ int watchdog_set_last_hw_keepalive(struct watchdog_device *wdd,
>   }
>   EXPORT_SYMBOL_GPL(watchdog_set_last_hw_keepalive);
>   
> -/*
> - *	watchdog_dev_init: init dev part of watchdog core
> +/**
> + * watchdog_dev_init - init dev part of watchdog core
>    *
> - *	Allocate a range of chardev nodes to use for watchdog devices
> + * Allocate a range of chardev nodes to use for watchdog devices.
> + *
> + * Return: 0 if successful, error otherwise.
>    */
> -
>   int __init watchdog_dev_init(void)
>   {
>   	int err;
> @@ -1218,12 +1225,11 @@ int __init watchdog_dev_init(void)
>   	return err;
>   }
>   
> -/*
> - *	watchdog_dev_exit: exit dev part of watchdog core
> +/**
> + * watchdog_dev_exit - exit dev part of watchdog core
>    *
> - *	Release the range of chardev nodes used for watchdog devices
> + * Release the range of chardev nodes used for watchdog devices.
>    */
> -
>   void __exit watchdog_dev_exit(void)
>   {
>   	unregister_chrdev_region(watchdog_devt, MAX_DOGS);

