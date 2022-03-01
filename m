Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0F74C856F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiCAHsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiCAHsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:48:36 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E415B10FF3;
        Mon, 28 Feb 2022 23:47:55 -0800 (PST)
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 1 Mar
 2022 15:47:53 +0800
Message-ID: <96dc5932-7a4c-4f92-b33b-bfd7fc4477e8@amlogic.com>
Date:   Tue, 1 Mar 2022 15:47:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V3] tty: serial: meson: Fix the compile link error
 reported by kernel test robot
Content-Language: en-US
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220228135530.6918-1-yu.tu@amlogic.com>
 <29b34655-f820-39c9-4363-878481cd3f63@baylibre.com>
 <Yh087tJhakKHs88e@kroah.com>
 <8747c5c6-a129-3a26-8ebb-9e21a18236ec@baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <8747c5c6-a129-3a26-8ebb-9e21a18236ec@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 2022/3/1 15:23, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Greg,
> 
> Le 28/02/2022 à 22:21, Greg Kroah-Hartman a écrit :
>> On Mon, Feb 28, 2022 at 03:13:48PM +0100, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On 28/02/2022 14:55, Yu Tu wrote:
>>>> Describes the calculation of the UART baud rate clock using a clock
>>>> frame. Forgot to add in Kconfig kernel test Robot compilation error
>>>> due to COMMON_CLK dependency.
>>>>
>>>> Fixes: ("tty: serial:meson: Describes the calculation of the UART 
>>>> baud rate clock using a clock frame“)
>>>
>>> As I already replied on V2 of this patch, you're invited to apply 
>>> these fixes directly
>>> on the next version of your "Use CCF to describe the UART baud rate 
>>> clock" patchset
>>> and not as a separate patch.
>>
>> No, this is broken in linux-next now as the path listed here is in my
>> tree right now.
> 
> Oh, I wasn't aware you took this patchset.
> 
>>
>> I need a fix for it, or I can revert the original.
> 
> Please revert the whole patchset, it's not ready yet, neither fully 
> reviewed ands buggy
> on old SoCs.
I have tested that there is no problem with G12A and S4 boards. Can I 
merge them first and fix them later if there is any problem?
> 
> Thanks,
> Neil
> 
>>
>> thanks,
>>
>> greg k-h
> 
