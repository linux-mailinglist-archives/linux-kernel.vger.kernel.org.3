Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C9548752F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346643AbiAGKEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:04:52 -0500
Received: from foss.arm.com ([217.140.110.172]:37836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346620AbiAGKEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:04:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A698D13D5;
        Fri,  7 Jan 2022 02:04:46 -0800 (PST)
Received: from [10.57.38.163] (unknown [10.57.38.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3C213F66F;
        Fri,  7 Jan 2022 02:04:45 -0800 (PST)
Subject: Re: [PATCH v2 1/1] docs: automarkup.py: Fix invalid HTML link output
 and broken URI fragments
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     mchehab+huawei@kernel.org, linux-kernel@vger.kernel.org,
        nfraprado@protonmail.com, n@nfraprado.net,
        linux-doc@vger.kernel.org
References: <20220105143640.330602-1-james.clark@arm.com>
 <20220105143640.330602-2-james.clark@arm.com> <87h7agpkn4.fsf@meer.lwn.net>
From:   James Clark <james.clark@arm.com>
Message-ID: <0fce859e-4ac5-3e41-a4cf-ec1c22f2c3cc@arm.com>
Date:   Fri, 7 Jan 2022 10:04:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87h7agpkn4.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/01/2022 22:25, Jonathan Corbet wrote:
> James Clark <james.clark@arm.com> writes:
> 
>> Since commit d18b01789ae5 ("docs: Add automatic cross-reference for
>> documentation pages"), references that were already explicitly defined
>> with "ref:" and referred to other pages with a path have been doubled.
>> This is reported as the following error by Firefox:
> [...]
>> The fix is to check that nodes in the document to be modified are not
>> already references. A reference is counted as any text that is a
>> descendant of a reference type node. Only plain text should be converted
>> to new references, otherwise the doubling occurs.
> 
> This seems like a good fix.  Applied, thanks.
> 
> jon
> 

Thanks Jonathan. Do you have a git repo that these get applied to?
I wasn't able to find it on https://git.kernel.org/

