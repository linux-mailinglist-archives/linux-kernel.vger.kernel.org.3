Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8DE5ACF76
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiIEKBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiIEKBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:01:07 -0400
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6C2B1F2F3;
        Mon,  5 Sep 2022 03:01:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowADHQ1PeyBVjDZynAQ--.30103S2;
        Mon, 05 Sep 2022 18:01:03 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: Re: [PATCH v3] USB: serial: ftdi_sio: Convert to use dev_groups
Date:   Mon,  5 Sep 2022 18:01:01 +0800
Message-Id: <20220905100101.343861-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADHQ1PeyBVjDZynAQ--.30103S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urW3Zw48uF47trW5uFyUWrg_yoW8tFWfpF
        43JayakFWkJFnxX342vw45X3s3tw4kJryfGr4ft34rWwn8J347GFW8Ja4UC3W8Jry8G3W7
        XF4kurZIkFWrArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4D
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXAw3UUUU
        U==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:52:52PM +0800, Greg KH wrote:
>>>>  drivers/usb/serial/ftdi_sio.c | 101 +++++++++++++++++-----------------
>>>>  1 file changed, 51 insertions(+), 50 deletions(-)
>>>> 
>>>> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
>>>> index d5a3986dfee7..479c3a5caaf8 100644
>>>> --- a/drivers/usb/serial/ftdi_sio.c
>>>> +++ b/drivers/usb/serial/ftdi_sio.c
>>>> @@ -1107,11 +1107,40 @@ static u32 ftdi_232bm_baud_base_to_divisor(int baud, int base);
>>>>  static u32 ftdi_232bm_baud_to_divisor(int baud);
>>>>  static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base);
>>>>  static u32 ftdi_2232h_baud_to_divisor(int baud);
>>>> +static umode_t ftdi_sio_attr_is_visible(struct kobject *kobj,
>>>> +					 struct attribute *attr, int idx);
>>>> +static ssize_t latency_timer_store(struct device *dev,
>>>> +				   struct device_attribute *attr,
>>>> +				   const char *valbuf, size_t count);
>>>> +static ssize_t event_char_store(struct device *dev,
>>>> +	struct device_attribute *attr, const char *valbuf, size_t count);
>>>> +static ssize_t latency_timer_show(struct device *dev,
>>>> +				  struct device_attribute *attr, char *buf);
>>>> +
>>> 
>>> Please work with the code so that you do not have to pre-define these
>>> functions.  It should be possible.  Worst case, you pre-define the
>>> structure for the driver, that should be it.
>> 
>> Without pre-definition of the functions, compilation errors will occur,
>> such as 'ftdi_sio_attr_is_visible' undeclared here.
>> I have no idea why they are not necessary.
> 
> If you move the code around that asks for those functions, you will not
> need to define them.
> 

Fine, I have already revised the patch and submitted a v4.

>>> And again, have you tested this change?
>> 
>> Every time I change the code, I recomplie it and check whether there are
>> errors.
>> Are there any other tests I need to do?
> 
> Yes, boot with the device and make sure that the sysfs files are still
> there.  You do have access to one of these devices, right?  They are
> very very common.

Sorry, I still have no idea how to boot with the device.
But if there is any wrong with the patch, you can tell me and I will continue
to revise it.

Thanks,
Jiang

