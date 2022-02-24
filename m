Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1E4C38B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiBXW01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiBXW0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:26:25 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87B024776C;
        Thu, 24 Feb 2022 14:25:54 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l1-20020a7bcf01000000b0037f881182a8so655102wmg.2;
        Thu, 24 Feb 2022 14:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=5Hq+lkEI7xZAlQDIMuYtBf6mGhY9G0mOAIjlBDnfBJQ=;
        b=UmRLmKwpE1vdy/e/gx1tql3bdI9YzVWhMpPcU+NWPLBnuDoWgL1aO2Rlx5UDnW7HZ4
         WTN+x/0uEDZB9Q8AAVtYm+Hc1LFwTVPJtWC1HWryGizlzOZBx4BD9xpvbVoGN7rbxn+q
         GhHZzHqivndkrhTRy/QT6QLI45H//UB4k3kFyBMN3MMK5TpsaBzseujqJ8twOKRH4JUL
         8zaMJcdJ3uF80PJDGcQij9lBXEugImGeZqEbaxbZPaIamgGZC9fd6hBuj4UPQKVJwVuN
         jSSHHxIfRvcc2+JAMwrRxtgX0oU63/3ZuIsbunWnu0OZ+sovRWF1uHgbpKx2gke9qwH1
         k4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=5Hq+lkEI7xZAlQDIMuYtBf6mGhY9G0mOAIjlBDnfBJQ=;
        b=A7zPC1KXUb4OyQGrMZNtDyKmRELSWGGdgAqt/Xq3s/YQjEdArmzqy1cAQTfXRSpjqy
         C03O1nCoT6zsOiyTJ2eM2bYnXs2nY2beJMUJmY3tkMrT2MxflsckCnPVDIDJG8PuxvXs
         tN16fSctKXUiN4xlk8HxaJl+hTzipXkZ+BYrgzgv5dOD+LM5dVlIpWJUXBl3+88c7aAf
         rxKb9o4x4q3Q5YBPyiMO5qT2Dle0FYf+pZMiZcEM3GenFBJluwkJRkujFf4jb6Pg2V+N
         eGHxKjwUi2RW0g16+mptJ+K7mQfGm2t4NLFpUthv0f5b8SQKqZFjr6W7JqxdwsHMFUo7
         Gy2A==
X-Gm-Message-State: AOAM5309M7mEpS6ChzlOLPX+cZ9D7SEdKH/CmZhpNdOnSR1Rud/UH/aD
        J4pTRZLDpfxeW1wFXSzljxTiqTTRGwJ6YA==
X-Google-Smtp-Source: ABdhPJxAylXwKa6WLKIXu7tstKIYLTuu9eCaUqpuTayQnJ4/I+oczd3YohQZ1CirB2jbeWmzjPyq/A==
X-Received: by 2002:a05:600c:6019:b0:380:f8bc:ddf3 with SMTP id az25-20020a05600c601900b00380f8bcddf3mr168068wmb.117.1645741553544;
        Thu, 24 Feb 2022 14:25:53 -0800 (PST)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id k19-20020a05600c479300b00380e461a4d2sm4638224wmo.0.2022.02.24.14.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 14:25:53 -0800 (PST)
Message-ID: <13f987a0-197a-d0db-6f97-c7358d4723da@gmail.com>
Date:   Thu, 24 Feb 2022 22:25:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: platform/x86: Add Intel Software Defined Silicon driver
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis with clang scan has detected a potential issue in the 
following commit:

commit 2546c60004309ede8e2d1d5341e0decd90e057bf
Author: David E. Box <david.e.box@linux.intel.com>
Date:   Fri Feb 11 17:32:50 2022 -0800

     platform/x86: Add Intel Software Defined Silicon driver

The issue is as follows:

static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info 
*info, size_t *data_size)
{
         int ret;

         lockdep_assert_held(&priv->mb_lock);

         ret = sdsi_mbox_acquire(priv, info);
         if (ret)
                 return ret;

Note: the return above does not assign a value to *data_size


         return sdsi_mbox_cmd_read(priv, info, data_size);
}


static long state_certificate_read(struct file *filp, struct kobject *kobj,
                                    struct bin_attribute *attr, char 
*buf, loff_t off,
                                    size_t count)
{
         struct device *dev = kobj_to_dev(kobj);
         struct sdsi_priv *priv = dev_get_drvdata(dev);
         u64 command = SDSI_CMD_READ_STATE;
         struct sdsi_mbox_info info;
         size_t size;
                ^
Note: size is not initialized

         int ret;

         if (!priv->sdsi_enabled)
                 return -EPERM;

         if (off)
                 return 0;

         /* Buffer for return data */
         info.buffer = kmalloc(SDSI_SIZE_READ_MSG, GFP_KERNEL);
         if (!info.buffer)
                 return -ENOMEM;

         info.payload = &command;
         info.size = sizeof(command);

         ret = mutex_lock_interruptible(&priv->mb_lock);
         if (ret)
                 goto free_buffer;
         ret = sdsi_mbox_read(priv, &info, &size);

Note: a failure in scsi_mbox_read can lead to variable size not being 
assigned a value.

         mutex_unlock(&priv->mb_lock);
         if (ret < 0)
                 goto free_buffer;

Note: failure with ret < 0 going to free_buffer

         if (size > count)
                 size = count;

         memcpy(buf, info.buffer, size);

free_buffer:
         kfree(info.buffer);

         if (ret)
                 return ret;

         return size;

Note: uninitialized value in size being returned. This is an error.

}

