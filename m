Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349EB49B230
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355827AbiAYKqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:46:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44728 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359709AbiAYKnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:43:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDCF161679;
        Tue, 25 Jan 2022 10:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADEBC340E0;
        Tue, 25 Jan 2022 10:43:11 +0000 (UTC)
Message-ID: <c3202b1f-ff8f-8108-e8a3-8710c8c74d10@xs4all.nl>
Date:   Tue, 25 Jan 2022 11:43:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 0/2] Fix incorrect resolution detected
Content-Language: en-US
To:     Jammy Huang <jammy_huang@aspeedtech.com>, eajames@linux.ibm.com,
        mchehab@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        linux-media@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220118100729.7651-1-jammy_huang@aspeedtech.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220118100729.7651-1-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jammy,

On 18/01/2022 11:07, Jammy Huang wrote:
> This series fixes incorrect resolution detected.
> We found this problem happened occasionally in the switch between bios
> and bootloader.

Can you rebase this on top of:

https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=for-v5.18f

This series doesn't apply cleanly.

Regards,

	Hans

> 
> Changes in v4:
>  - Correct the subject of patch
> 
> Changes in v3:
>  - In v2, we tried to increase the min-required-count of stable signal
>    to avoid incorrect transient state in timing detection. But it is
>    not working for all conditions.
>    Thus, we go another way in v3. Use regs, which can represent the
>    signal status, to decide if we needs to do detection again.
>  
> Changes in v2:
>  - Separate the patch into two patches
> 
> Jammy Huang (2):
>   media: aspeed: Add macro for the fields of the mode-detect registers
>   media: aspeed: Fix unstable timing detection
> 
>  drivers/media/platform/aspeed-video.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 

