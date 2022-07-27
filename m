Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046D65832B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiG0TDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiG0TCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:02:36 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA27624E;
        Wed, 27 Jul 2022 11:19:27 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f14so13927391qkm.0;
        Wed, 27 Jul 2022 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nEd7dseFbDtfUvUd6FnM8ULF2DOAHEX1K0BhzerKVg=;
        b=D1yN8TX647mmlCmQrhoypA516wTafMg9xHgs0sc5gckZ/OyeKa2dIy8PzhYGqZRVYN
         FML+KzKtitTOZOz49pqDDoFLnbVWqPgc1UY8WSbhfCeeJu2CpPBoRRzBHC1MV6f/Q53u
         NQvf4sCDSyrKnRZOu7j5jJdxySkA22SpHHJt9NfHdie1AiLEGEcysP6EHH4QGHA0xysD
         q/an8T80N2ZVC5KnQuJ9usjfE7BDi5fBWXt43KG2GH+WH4/hydkvdJ+TYSlVzFOx4kho
         qKVpZNkfF+4u2+2wIMirTfbmI4yXJrNV1vkx47eOyj9yH1M7wsP0B0uXl+MBV5oUDINd
         WtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nEd7dseFbDtfUvUd6FnM8ULF2DOAHEX1K0BhzerKVg=;
        b=X7V0jUtsMWz930Z3wwi1QV4+EEeAhK7fa5C5D0A8hwrttcFDhuAppoGrub7j1Jay58
         f7QoDtWi+iMmcEAf08Tecj+tNjLBw7Pe80SPqAltJkt37lQCah/QUWTgiLYtcb4LL/SU
         lkbJxdXGwQxyGd7o6pmuKSIeXTTWdol8xUqkr0gzuiTLDjAqTEQMF7Tj1zjnjssa2+zH
         Rae1xTW7Q/e8Qfk0NYHoYFFNTVnfLir8e0D/eDLw+i76tIfiRDlywc70q9AIrB5bRPmr
         1xgKvIE/v+c0vAgnMNIZrBdd0xQ1hqiCn6+INZPrOKblJghogxuHh8fHPa4a7+TGVADX
         TkcQ==
X-Gm-Message-State: AJIora/Jr4EdKXMxuM6J5pmsUoSdlwHVx0TLCVEZuZCpG5xpMxGHBFOk
        60F7TN2cYEgEWUEPynTriLc=
X-Google-Smtp-Source: AGRyM1t+MFIyDzilY4q6pSE0QC2uhfUDA5VjKkgVfl595cUBsosWuir5FTpJ+mrEh0rI7kgdCn6YSg==
X-Received: by 2002:a05:620a:2f8:b0:6b5:e8a2:cf3d with SMTP id a24-20020a05620a02f800b006b5e8a2cf3dmr16676748qko.447.1658945966891;
        Wed, 27 Jul 2022 11:19:26 -0700 (PDT)
Received: from spruce.. (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id bk27-20020a05620a1a1b00b006af1f0af045sm13195972qkb.107.2022.07.27.11.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 11:19:26 -0700 (PDT)
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>
Subject: [PATCH 1/2] iio: Add blank lines after declarations.
Date:   Wed, 27 Jul 2022 14:18:54 -0400
Message-Id: <20220727181855.589052-2-joetalbott@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220727181855.589052-1-joetalbott@gmail.com>
References: <20220727181855.589052-1-joetalbott@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by checkpatch.pl add blank lines after declarations.

Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
---
 drivers/iio/industrialio-buffer.c  | 1 +
 drivers/iio/industrialio-core.c    | 7 +++++++
 drivers/iio/industrialio-trigger.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index acc2b6c05d57..47a6e97f8e48 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -940,6 +940,7 @@ struct iio_demux_table {
 static void iio_buffer_demux_free(struct iio_buffer *buffer)
 {
 	struct iio_demux_table *p, *q;
+
 	list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
 		list_del(&p->l);
 		kfree(p);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 0f4dbda3b9d3..40ebc63b7919 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -236,6 +236,7 @@ static int iio_sysfs_match_string_with_gaps(const char * const *array, size_t n,
 struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
 	return iio_dev_opaque->debugfs_dentry;
 }
 EXPORT_SYMBOL_GPL(iio_get_debugfs_dentry);
@@ -447,6 +448,7 @@ static const struct file_operations iio_debugfs_reg_fops = {
 static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
 	debugfs_remove_recursive(iio_dev_opaque->debugfs_dentry);
 }
 
@@ -1021,6 +1023,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 	int ret = 0;
 	char *name = NULL;
 	char *full_postfix;
+
 	sysfs_attr_init(&dev_attr->attr);
 
 	/* Build up postfix of <extend_name>_<modifier>_postfix */
@@ -1355,6 +1358,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 
 	if (chan->ext_info) {
 		unsigned int i = 0;
+
 		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
 			ret = __iio_add_chan_devattr(ext_info->name,
 					chan,
@@ -1403,6 +1407,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+
 	return sysfs_emit(buf, "%s\n", indio_dev->name);
 }
 
@@ -1412,6 +1417,7 @@ static ssize_t label_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+
 	return sysfs_emit(buf, "%s\n", indio_dev->label);
 }
 
@@ -1777,6 +1783,7 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
 	struct iio_dev_opaque *iio_dev_opaque =
 		container_of(inode->i_cdev, struct iio_dev_opaque, chrdev);
 	struct iio_dev *indio_dev = &iio_dev_opaque->indio_dev;
+
 	kfree(ib);
 	clear_bit(IIO_BUSY_BIT_POS, &iio_dev_opaque->flags);
 	iio_device_put(indio_dev);
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index b78814d869b7..6885a186fe27 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -50,6 +50,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
+
 	return sysfs_emit(buf, "%s\n", trig->name);
 }
 
-- 
2.36.1

