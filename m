Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6800E5AB4BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiIBPM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbiIBPMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:12:01 -0400
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED8B716EECF;
        Fri,  2 Sep 2022 07:41:56 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowADn70tLFBJj3kOoAA--.21300S2;
        Fri, 02 Sep 2022 22:33:47 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: Re: [PATCH v3] USB: serial: ftdi_sio: Convert to use dev_groups
Date:   Fri,  2 Sep 2022 22:33:46 +0800
Message-Id: <20220902143346.4120012-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADn70tLFBJj3kOoAA--.21300S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr47Zry8ZryDur1UWF13twb_yoW8AF4fpF
        sxGay3KF4ktFnxXw4a9r4UX34rtw4kKrWfG3yIy34rW3Z8J3srKFW5ta48WF1rAry8G3W2
        qFsavr90kr4rArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Xryl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUxDGnUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 05:56:13PM +0800, Greg KH wrote:
>>  drivers/usb/serial/ftdi_sio.c | 101 +++++++++++++++++-----------------
>>  1 file changed, 51 insertions(+), 50 deletions(-)
>> 
>> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
>> index d5a3986dfee7..479c3a5caaf8 100644
>> --- a/drivers/usb/serial/ftdi_sio.c
>> +++ b/drivers/usb/serial/ftdi_sio.c
>> @@ -1107,11 +1107,40 @@ static u32 ftdi_232bm_baud_base_to_divisor(int baud, int base);
>>  static u32 ftdi_232bm_baud_to_divisor(int baud);
>>  static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base);
>>  static u32 ftdi_2232h_baud_to_divisor(int baud);
>> +static umode_t ftdi_sio_attr_is_visible(struct kobject *kobj,
>> +					 struct attribute *attr, int idx);
>> +static ssize_t latency_timer_store(struct device *dev,
>> +				   struct device_attribute *attr,
>> +				   const char *valbuf, size_t count);
>> +static ssize_t event_char_store(struct device *dev,
>> +	struct device_attribute *attr, const char *valbuf, size_t count);
>> +static ssize_t latency_timer_show(struct device *dev,
>> +				  struct device_attribute *attr, char *buf);
>> +
> 
> Please work with the code so that you do not have to pre-define these
> functions.  It should be possible.  Worst case, you pre-define the
> structure for the driver, that should be it.

Without pre-definition of the functions, compilation errors will occur,
such as 'ftdi_sio_attr_is_visible' undeclared here.
I have no idea why they are not necessary.
Please explain in detail.

> And again, have you tested this change?

Every time I change the code, I recomplie it and check whether there are
errors.
Are there any other tests I need to do?

Thanks,
Jiang

