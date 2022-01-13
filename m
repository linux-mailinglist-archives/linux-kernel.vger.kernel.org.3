Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3006F48D4FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiAMJ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:27:58 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:35690 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiAMJ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:27:57 -0500
Received: from [IPV6:2a01:e0a:169:7140:2ab9:bf59:c61a:cf11] (unknown [IPv6:2a01:e0a:169:7140:2ab9:bf59:c61a:cf11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9754797;
        Thu, 13 Jan 2022 10:27:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642066075;
        bh=jZwNUuB0RkUpIVsIVx20fm0PYu8Gumih0ZisNs+gWYA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=shMJ3AUPJ5hsEZfKXmibxhQXzMG4eW7UCuGEmtiGXjHlkRUy8DKq/e6gL9zcg7uJR
         P4fLr5rGZJYeQC97lDW57wWNWKfn2YqwzwPNOUYTEJFLhuWLDWi3l8NzG3jIsSdQmi
         nfNooz+kJa8L4LNiafM0z9f1VKSRf4QaIpicTb38=
Message-ID: <bcd1b7f6-e18c-d01c-aaea-b98026056c71@ideasonboard.com>
Date:   Thu, 13 Jan 2022 10:27:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 0/3] Add 12bit and 14bit luma-only formats
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        dave.stevenson@raspberrypi.com
References: <20220112161014.972076-1-jeanmichel.hautbois@ideasonboard.com>
 <be18b2bb-f334-1f31-50df-9935929281f6@xs4all.nl>
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
In-Reply-To: <be18b2bb-f334-1f31-50df-9935929281f6@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans !

On 13/01/2022 10:15, Hans Verkuil wrote:
> Hi Jean-Michel,
> 
> On 12/01/2022 17:10, Jean-Michel Hautbois wrote:
>> Hello,
>>
>> While working on adding the V4L2-PIX-FMT-Y12P and V4L2-PIX-FMT-Y14P
>> formats, I noticed an issue in the way V4L2-PIX-FMT-Y10P is described.
>> This series aims to solve it before adding Y12P and Y14P.
>>
>> Those two formats are needed for the next-to-come bcm2835 unicam driver.
>>
>> Jean-Michel Hautbois (3):
>>    media: doc: pixfmt-yuv: Fix V4L2-PIX-FMT-Y10P format
>>    media: v4l: Add V4L2-PIX-FMT-Y12P format
>>    media: v4l: Add V4L2-PIX-FMT-Y14P format
>>
>>   .../media/v4l/pixfmt-yuv-luma.rst             | 48 ++++++++++++++++++-
>>   drivers/media/v4l2-core/v4l2-ioctl.c          |  2 +
>>   include/uapi/linux/videodev2.h                |  2 +
>>   3 files changed, 50 insertions(+), 2 deletions(-)
>>
> 
> I'll take the first patch, but it is better to add patches 2 and 3 to the unicam RFC
> series. Adding pixelformats that are not used by any existing driver isn't a good idea
> and I'd like to avoid that.

Thanks, I will take those two patches back in the unicam RFC v2 series then.

> 
> Regards,
> 
> 	Hans
> 
