Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156A348D4E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiAMJPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:15:55 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.168]:43774 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiAMJPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:15:50 -0500
X-KPN-MessageId: 4d6d0fcc-7451-11ec-8862-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 4d6d0fcc-7451-11ec-8862-005056aba152;
        Thu, 13 Jan 2022 10:15:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=TQ7FE+1TjZcJGjtMAVu+kQkmET1q3eqI0l54ENHmGms=;
        b=jFf9n6j//i//fR56AiPlDynZ5khCa/Ljcw/Yt4FgbewWc/i2aPGiFWvWVsoXoZjB/HBm5L3SbTrkm
         Y0qsxmF37VlCoisr3jpi92BDbo2ESimXFnxZOJiArFQh0Anwdkvi9usan9rjVN/znOR80LqJ12CwzU
         Abs+Gssx4iIi5jgvG2BLE5tYVhQzype7PcoA9RHQm8qdB3F436fBdJklfTQV0yXUL78LvR8jGtG1Ku
         0xjSRvMZHFkc695HkSdDXz5g9fymKV2EaVTmPkE2DGbLsn8sgDh70p31pkMqFzvNqr1e1O2u3e3CnJ
         2LN6yCYd9JhW2JxS5lMKoGZrrx7wDpg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|NoljMPYKvCOOH3Wb/96mqwbwjcPoL5W9Jbh+BtI7FHq1T2UXLepcez+3Q9QFmcq
 MD9v85OzErt64FGF0rMeP4w==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 65606294-7451-11ec-81f5-005056ab7447;
        Thu, 13 Jan 2022 10:15:48 +0100 (CET)
Message-ID: <be18b2bb-f334-1f31-50df-9935929281f6@xs4all.nl>
Date:   Thu, 13 Jan 2022 10:15:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH 0/3] Add 12bit and 14bit luma-only formats
Content-Language: en-US
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        dave.stevenson@raspberrypi.com
References: <20220112161014.972076-1-jeanmichel.hautbois@ideasonboard.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220112161014.972076-1-jeanmichel.hautbois@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

On 12/01/2022 17:10, Jean-Michel Hautbois wrote:
> Hello,
> 
> While working on adding the V4L2-PIX-FMT-Y12P and V4L2-PIX-FMT-Y14P
> formats, I noticed an issue in the way V4L2-PIX-FMT-Y10P is described.
> This series aims to solve it before adding Y12P and Y14P.
> 
> Those two formats are needed for the next-to-come bcm2835 unicam driver.
> 
> Jean-Michel Hautbois (3):
>   media: doc: pixfmt-yuv: Fix V4L2-PIX-FMT-Y10P format
>   media: v4l: Add V4L2-PIX-FMT-Y12P format
>   media: v4l: Add V4L2-PIX-FMT-Y14P format
> 
>  .../media/v4l/pixfmt-yuv-luma.rst             | 48 ++++++++++++++++++-
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  2 +
>  include/uapi/linux/videodev2.h                |  2 +
>  3 files changed, 50 insertions(+), 2 deletions(-)
> 

I'll take the first patch, but it is better to add patches 2 and 3 to the unicam RFC
series. Adding pixelformats that are not used by any existing driver isn't a good idea
and I'd like to avoid that.

Regards,

	Hans
