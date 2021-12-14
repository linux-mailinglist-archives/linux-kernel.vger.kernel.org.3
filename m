Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494EA474A28
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbhLNR5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:57:55 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:51262 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbhLNR5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:57:53 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id xC3hmDtUWIEdlxC3hmHzWx; Tue, 14 Dec 2021 18:57:51 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 14 Dec 2021 18:57:51 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH v2] xen-blkfront: Use the bitmap API when applicable
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, axboe@kernel.dk,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel.janitors,gmane.comp.emulators.xen.devel,gmane.linux.block,gmane.linux.kernel
References: <d6f31db1d2542e1b4ba66d4cea80d3891678aa5a.1638476031.git.christophe.jaillet@wanadoo.fr>
 <Ybh5G2ziyRXkz3WF@Air-de-Roger> <Ybh7KgtQt0/MFtyw@Air-de-Roger>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <14dbcf69-afc1-c11b-e1ad-e8453a80cc6e@wanadoo.fr>
Date:   Tue, 14 Dec 2021 18:57:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ybh7KgtQt0/MFtyw@Air-de-Roger>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/12/2021 à 12:08, Roger Pau Monné a écrit :
> On Tue, Dec 14, 2021 at 11:59:39AM +0100, Roger Pau Monné wrote:
>> On Thu, Dec 02, 2021 at 09:16:04PM +0100, Christophe JAILLET wrote:
>>> Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid some
>>> open-coded arithmetic in allocator arguments.
>>>
>>> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
>>> consistency.
>>>
>>> Use 'bitmap_copy()' to avoid an explicit 'memcpy()'
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>
>> Acked-by: Roger Pau Monné <roger.pau@citrix.com>
> 
> Oh, I see there's been further discussion on this to avoid relying
> implicitly on the size of the bitmap being rounded to the size of an
> unsigned long. I think a new version is expected then?
> 
> Thanks, Roger.
> 

Yes, I'll send a patch in order to add a 'bitmap_size()'
I'll update this patch when/if it is merged.

You can drop it for now.

CJ
