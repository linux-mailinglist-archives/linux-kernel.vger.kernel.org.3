Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5923471FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 04:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhLMDzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 22:55:48 -0500
Received: from marcansoft.com ([212.63.210.85]:33182 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhLMDzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:55:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D3E2C4258C;
        Mon, 13 Dec 2021 03:55:41 +0000 (UTC)
Subject: Re: [PATCH 0/2] Apple mailbox fixup: switch to generic compatibles
To:     Sven Peter <sven@svenpeter.dev>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211209055049.99205-1-marcan@marcan.st>
 <3fb087c1-2d67-4527-ad63-1f8ce54e6965@www.fastmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <caf8a7a4-bdb9-e1c9-871d-12c8d146376c@marcan.st>
Date:   Mon, 13 Dec 2021 12:55:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3fb087c1-2d67-4527-ad63-1f8ce54e6965@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 01.33, Sven Peter wrote:
> On Thu, Dec 9, 2021, at 06:50, Hector Martin wrote:
>> Hi folks,
>>
>> Just a quick fix for the Apple mailbox compatible. Similar to [1], we
>> intend to use SoC-specific compatibles only for potential quirks, and
>> rely on a generic compatible to allow for forward-compatibility as long
>> as things don't break.
> 
> I vaguely remember a brief discussion about this and I think we thought about
> using "t6000-asc", "t8103-asc" in this case since this specific mailbox hardware
> was only introduced in the M1. I think Apple calls this variant ascwrap-v4
> and m3wrap-v2.
> 
> Doing it like you suggested is also fine with me though.

I think I remember that one... seems this is ascwrap-v4 in t8101 too, so 
not quite introduced with M1. But that one doesn't have m3wraps (or 
doesn't use them).

Since Apple do have some kind of sane versioning for these it seems, 
maybe we should follow their numbers and call them apple,asc-mailbox-v4 
and apple,m3-mailbox-v2?

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
