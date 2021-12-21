Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CBA47B84A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhLUCPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:15:00 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:50868 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhLUCO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:14:58 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BL28DUG011549;
        Tue, 21 Dec 2021 10:08:13 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Dec
 2021 10:13:34 +0800
Message-ID: <d9dc2375-e4a8-9bb2-bb70-7104fa8186a7@aspeedtech.com>
Date:   Tue, 21 Dec 2021 10:13:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 00/10] add aspeed-jpeg support for aspeed-video
Content-Language: en-US
To:     "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
CC:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211118074030.685-1-jammy_huang@aspeedtech.com>
 <5ab806d1-e407-1fa4-83ec-93ebe8df7db4@xs4all.nl>
 <b6ba49f3-a9ed-f5e6-959c-309db8cce7f6@aspeedtech.com>
 <6e0da74e-ddce-3c94-42a1-f98833489d60@xs4all.nl>
 <549aaf9a-cd72-e200-0329-30f6c71b8ed7@aspeedtech.com>
 <e61856d5-c371-ab52-2814-d0d8aabee0f0@aspeedtech.com>
 <YcDfl9V1oJFMebfF@paasikivi.fi.intel.com>
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <YcDfl9V1oJFMebfF@paasikivi.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1BL28DUG011549
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 2021/12/21 上午 03:55, sakari.ailus@linux.intel.com wrote:
> Hi Jammy,
>
> On Tue, Dec 07, 2021 at 11:03:00AM +0800, Jammy Huang wrote:
>> Hi Hans,
>>
>> The implementation of decoder for this format as been available here.
>> https://github.com/AspeedTech-BMC/aspeed_codec
> The format documentation should point to this, as well as other
> documentation there is.
OK, I will add this into format documentation as well.
>
> I'm not sure there have been specific requirements of license, but it's the
> first time I see MPL 2.0 being used in such context. It's eventually
> convertible to GPL (or LGPL) although the route is inconvenient at best.
> Or would people be happy with MPL code in v4l-utils?

In order to have aspeed-jpeg format to work on openbmc's KVM, I was 
working on noVNC.
And this codec library is part of the code to make it work.

Before I put this source on github, I am not sure which kind of license 
is suitable. So I check
what noVNC used, https://github.com/novnc/noVNC/blob/master/LICENSE.txt. 
That's why I
adapted MPL 2.0.

If you think GPL(or LGPL) is more suitable, I can make a switch.


>
> I wonder what others think.
>
-- 
Best Regards
Jammy

