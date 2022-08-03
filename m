Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCF6588FEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbiHCP5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbiHCP5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:57:17 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071CE63BA;
        Wed,  3 Aug 2022 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659542236; x=1691078236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qy45FE7dmAaRWyuLIVGMQubcRE/KMHL+erBcXt/YXdQ=;
  b=IpVL2oOhIcyUpxil5AluU9Zt3EciuPJaE9mnFFd5GCjrV7gTmHfkUtVh
   j4PNEzLG1EBfNnuSA4iQCErQojNxsZoftDNWDpLs8WhyzUCt0U0ZOJ0zi
   PLRDjLjf3MIz0S2xC/XwshD/YlcsaE8jnwgETefjB0yN3ecfRngIJuKTU
   o=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 03 Aug 2022 08:57:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 08:57:14 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 3 Aug 2022 08:57:01 -0700
Received: from [10.216.16.162] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 3 Aug 2022
 08:56:58 -0700
Message-ID: <d0f1c9ae-91aa-2c52-b86a-f111908d6b22@quicinc.com>
Date:   Wed, 3 Aug 2022 21:26:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [GIT PULL] USB / Thunderbolt driver changes for 6.0-rc1
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Andrey Strachuk <strochuk@ispras.ru>
References: <YuqB0tl2hjT3x7a4@kroah.com>
 <YuqXtcaUPflINBd6@dev-arch.thelio-3990X> <YuqZU/JJyMQJxva0@kroah.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <YuqZU/JJyMQJxva0@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/3/2022 9:20 PM, Greg KH wrote:
> On Wed, Aug 03, 2022 at 08:43:49AM -0700, Nathan Chancellor wrote:
>> On Wed, Aug 03, 2022 at 04:10:26PM +0200, Greg KH wrote:
>>> Andrey Strachuk (1):
>>>        usb: cdns3: change place of 'priv_ep' assignment in cdns3_gadget_ep_dequeue(), cdns3_gadget_ep_enable()
>> For the record, this breaks allmodconfig with clang (I haven't seen a
>> formal report on it anywhere and this missed -next coverage because
>> Stephen is on vacation):
>>
>>      drivers/usb/cdns3/cdns3-gadget.c:2290:11: error: variable 'priv_dev' is uninitialized when used here [-Werror,-Wuninitialized]
>>                      dev_dbg(priv_dev->dev, "usbss: invalid parameters\n");
>>                              ^~~~~~~~
>>      include/linux/dev_printk.h:155:18: note: expanded from macro 'dev_dbg'
>>              dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>>                              ^~~
>>      include/linux/dynamic_debug.h:167:7: note: expanded from macro 'dynamic_dev_dbg'
>>                              dev, fmt, ##__VA_ARGS__)
>>                              ^~~
>>      include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
>>              __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
>>                                                                  ^~~~~~~~~~~
>>      include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
>>                      func(&id, ##__VA_ARGS__);               \
>>                                  ^~~~~~~~~~~
>>      drivers/usb/cdns3/cdns3-gadget.c:2278:31: note: initialize the variable 'priv_dev' to silence this warning
>>              struct cdns3_device *priv_dev;
>>                                          ^
>>                                          = NULL
>>      1 error generated.
>>
>> I know you don't take patches during the merge window, so I guess we'll
>> just have to have x86_64 allmodconfig be broken with clang for -rc1? :/
> I can send fix-up patches that break the build before -rc1 if you have
> it.  Also you can send it and Linus can pick it up directly if it breaks
> his workflow.
>
> Odd that this was never reported, 0-day didn't even say anything?
>
> thanks,
>
> greg k-h
Hi Greg,
   On a similar note. There was another issue reported in which 
randconfig for i386 build breaks as usb_hub_find_child API is not 
present as usbcore isn't compiled in that config (CONFIG_USB isn't set).
Patch to fix has been pushed recently and is in review:
https://lore.kernel.org/linux-usb/1659337215-20421-1-git-send-email-quic_kriskura@quicinc.com/

Would it be possible to pick it up in rc1 to make sure nothing breaks 
further because of it.
I can respin patch if something is off in it.

Regards,
Krishna,
