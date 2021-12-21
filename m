Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C05847BFE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbhLUMkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbhLUMkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:40:01 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41526C061401;
        Tue, 21 Dec 2021 04:40:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w16so23087042edc.11;
        Tue, 21 Dec 2021 04:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IcB2BjW/je/z2W0QLJ5NHEYQ0lcg6pJsIYClTsB+508=;
        b=iGVwW/gcp13Lf/qugV37HY3XYTYotylcxpUaWyFad+xJ25j6f4VftJN+vVgKlfE9eL
         0VJj9kvHBGDoDFG+aIT9UQkfU1Y8fWd2x1m8bsbpNdvrzomAEyTPDX0rx5JFDVUa00pp
         ZUvfhjBt/hndX+Lwg1IPbrkBBVVCVkf8pI3/HlfFHfHveFAo9Afhid3dPZrAbMmpaQst
         F5wAbAJDIgQj3OnqNVhz+ymBYlXzn7JxMyX2G2IvJlhCW+7zqTvjSs59t6INK56o+Lmk
         NJFna+zYBG9sza3qPH6yj2MdMbai+qbuDJZBX1ntvo59Oh3YKn/7/Xb6yBYHm9fZelgs
         4Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IcB2BjW/je/z2W0QLJ5NHEYQ0lcg6pJsIYClTsB+508=;
        b=tHVYcQch6JoqLjUnXij5Wj88Zc1BGnj3HKLd1y3y1YfkG1FJQf3HuqD+I8efWSlPuK
         +zStZtTlJp1LoTKnhdluRFNfAa2e/UL5uuTRJwwMDKnnGBDN65im4CxKMv5vaGSAyFI+
         YmokOL+sQmAGcuHqlijdw81VJnGmCdJqwTXlxIWYuvBcSjdhuojFKX3d0cz5G9kgOW2q
         6KLOJ/GtODw/gxEilZTtjG509EwWeB42MxDuDc2HWG1eigSIpJTqyk9yjXcTk9bauFgn
         mTMMyIZ/1aDTlmysz+Vc1NUoRWHyr/WQZhlXit+gOeQQaVWvk7dR/XTypj3aGVnDiLhJ
         7dEw==
X-Gm-Message-State: AOAM531dyteG1qYQqAFycgioCXm+ZhxACmhktJyxpBmdnAzHSYcTFd+Y
        8aJ+XQW0bv8sBg731bAu8j8=
X-Google-Smtp-Source: ABdhPJwb60KFw5+WUwAN7WIqnP22dg1Z/yN2by40cdR6lbFcchg2Scf3oHhKqE5uzIf5mBXhmrLS8A==
X-Received: by 2002:a50:ec89:: with SMTP id e9mr3134208edr.162.1640090399475;
        Tue, 21 Dec 2021 04:39:59 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id bx6sm2849438edb.78.2021.12.21.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:39:59 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/10] hwmon: adt7x10: remove attrs
Date:   Tue, 21 Dec 2021 14:39:41 +0200
Message-Id: <20211221123944.2683245-7-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221123944.2683245-1-demonsingur@gmail.com>
References: <20211221123944.2683245-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

These will be replaced by hwmon read and write callbacks.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 124 +---------------------------------------
 1 file changed, 1 insertion(+), 123 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 32ea9438ad64..2d36088e1a07 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -236,21 +236,6 @@ static int adt7x10_temp_read(struct adt7x10_data *data, int index, long *val)
 	return 0;
 }
 
-static ssize_t adt7x10_temp_show(struct device *dev,
-				 struct device_attribute *da, char *buf)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct adt7x10_data *data = dev_get_drvdata(dev);
-	long val;
-	int ret;
-
-	ret = adt7x10_temp_read(data, attr->index, &val);
-	if (ret)
-		return ret;
-
-	return sprintf(buf, "%ld\n", val);
-}
-
 static int adt7x10_temp_write(struct adt7x10_data *data, unsigned int nr,
 			      long temp)
 {
@@ -265,25 +250,6 @@ static int adt7x10_temp_write(struct adt7x10_data *data, unsigned int nr,
 	return ret;
 }
 
-static ssize_t adt7x10_temp_store(struct device *dev,
-				  struct device_attribute *da,
-				  const char *buf, size_t count)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct adt7x10_data *data = dev_get_drvdata(dev);
-	int nr = attr->index;
-	long temp;
-	int ret;
-
-	ret = kstrtol(buf, 10, &temp);
-	if (ret)
-		return ret;
-
-	ret = adt7x10_temp_write(data, nr, temp);
-
-	return ret ?: count;
-}
-
 static int adt7x10_hyst_read(struct adt7x10_data *data, unsigned int nr,
 			     long *val)
 {
@@ -303,22 +269,6 @@ static int adt7x10_hyst_read(struct adt7x10_data *data, unsigned int nr,
 	return 0;
 }
 
-static ssize_t adt7x10_t_hyst_show(struct device *dev,
-				   struct device_attribute *da, char *buf)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct adt7x10_data *data = dev_get_drvdata(dev);
-	int nr = attr->index;
-	long val;
-	int ret;
-
-	ret = adt7x10_hyst_read(data, nr, &val);
-	if (ret)
-		return ret;
-
-	return sprintf(buf, "%ld\n", val);
-}
-
 static int adt7x10_hyst_write(struct adt7x10_data *data, long hyst)
 {
 	struct device *dev = data->bus_dev;
@@ -332,23 +282,6 @@ static int adt7x10_hyst_write(struct adt7x10_data *data, long hyst)
 	return adt7x10_write_byte(dev, ADT7X10_T_HYST, data->hyst);
 }
 
-static ssize_t adt7x10_t_hyst_store(struct device *dev,
-				    struct device_attribute *da,
-				    const char *buf, size_t count)
-{
-	struct adt7x10_data *data = dev_get_drvdata(dev);
-	int ret;
-	long hyst;
-
-	ret = kstrtol(buf, 10, &hyst);
-	if (ret)
-		return ret;
-
-	ret = adt7x10_hyst_write(data, hyst);
-
-	return ret ?: count;
-}
-
 static int adt7x10_alarm_read(struct adt7x10_data *data, unsigned int index,
 			      long *val)
 {
@@ -364,53 +297,6 @@ static int adt7x10_alarm_read(struct adt7x10_data *data, unsigned int index,
 	return 0;
 }
 
-static ssize_t adt7x10_alarm_show(struct device *dev,
-				  struct device_attribute *da, char *buf)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct adt7x10_data *data = dev_get_drvdata(dev);
-	long val;
-	int ret;
-
-	ret = adt7x10_alarm_read(data, attr->index, &val);
-	if (ret)
-		return ret;
-
-	return sprintf(buf, "%ld\n", val);
-}
-
-static SENSOR_DEVICE_ATTR_RO(temp1_input, adt7x10_temp, 0);
-static SENSOR_DEVICE_ATTR_RW(temp1_max, adt7x10_temp, 1);
-static SENSOR_DEVICE_ATTR_RW(temp1_min, adt7x10_temp, 2);
-static SENSOR_DEVICE_ATTR_RW(temp1_crit, adt7x10_temp, 3);
-static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, adt7x10_t_hyst, 1);
-static SENSOR_DEVICE_ATTR_RO(temp1_min_hyst, adt7x10_t_hyst, 2);
-static SENSOR_DEVICE_ATTR_RO(temp1_crit_hyst, adt7x10_t_hyst, 3);
-static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, adt7x10_alarm,
-			     ADT7X10_STAT_T_LOW);
-static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, adt7x10_alarm,
-			     ADT7X10_STAT_T_HIGH);
-static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, adt7x10_alarm,
-			     ADT7X10_STAT_T_CRIT);
-
-static struct attribute *adt7x10_attributes[] = {
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_max.dev_attr.attr,
-	&sensor_dev_attr_temp1_min.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit.dev_attr.attr,
-	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group adt7x10_group = {
-	.attrs = adt7x10_attributes,
-};
-
 int adt7x10_probe(struct device *dev, const char *name, int irq,
 		  const struct adt7x10_ops *ops)
 {
@@ -455,15 +341,10 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 	if (ret)
 		goto exit_restore;
 
-	/* Register sysfs hooks */
-	ret = sysfs_create_group(&dev->kobj, &adt7x10_group);
-	if (ret)
-		goto exit_restore;
-
 	hdev = hwmon_device_register(dev);
 	if (IS_ERR(hdev)) {
 		ret = PTR_ERR(hdev);
-		goto exit_remove;
+		goto exit_restore;
 	}
 
 	if (irq > 0) {
@@ -482,8 +363,6 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 
 exit_hwmon_device_unregister:
 	hwmon_device_unregister(hdev);
-exit_remove:
-	sysfs_remove_group(&dev->kobj, &adt7x10_group);
 exit_restore:
 	adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);
 	return ret;
@@ -495,7 +374,6 @@ void adt7x10_remove(struct device *dev, int irq)
 	struct adt7x10_data *data = dev_get_drvdata(dev);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&dev->kobj, &adt7x10_group);
 	if (data->oldconfig != data->config)
 		adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);
 }
-- 
2.34.1

