Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257094628F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhK3ATm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhK3ATl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:19:41 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D9CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=EwykYvWN8YnSwIQ3myJ9bi7OawmTY6LVqM+iZEWeJyc=; b=XJyTzv6r1kx7GDO6l7yL0zRDln
        qElcXINvJUV2XxthstweAzGugncG+qT95TG+M6a9TdvKXXQCf/dWyIcm4HRnFNfpEgH8h7v2U2Mpm
        PrxTsqd90MG+zwcXGahdfKuNkoeeyIxbKI8vUimDu1gFlwj7iml0os79QmXaAbfgxVrgGIZDRKchN
        B+F7T8MQUHEZabM4F8NdJyx4v5yrKZePXmVpSjJRnrFR3CFUXXCXu0PL8QDlfHTAHZyaaNJs90rLg
        aP4v+WPNft3B3gKBqfB0myXYBMzd+2ztBumIkjeG42DP4+VMcHQq/QxvY58WFq5eBB6+FfN0P099R
        UImnW5Tw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrqom-001LJE-Pk; Tue, 30 Nov 2021 00:16:21 +0000
Message-ID: <e6de22e4-93ae-1dd8-7589-df75d395c920@infradead.org>
Date:   Mon, 29 Nov 2021 16:16:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: =?UTF-8?Q?Re=3a_Kernel_driver=3a_W1_DALLAS=e2=80=99S_1-WIRE_BUS_inv?=
 =?UTF-8?Q?alid_calculation?=
Content-Language: en-US
To:     linux-kernel@miltschek.de, linux-kernel@vger.kernel.org,
        Evgeniy Polyakov <zbr@ioremap.net>
References: <5be0e863-cb9b-c448-9089-6a95f59b8f74@miltschek.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5be0e863-cb9b-c448-9089-6a95f59b8f74@miltschek.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/29/21 11:26, K. wrote:
> Dear kernel-driver developers,
> 
> I believe there is a mistake in calculation of the fine part of the temperature value as received from 1-Wire DS18x20-family sensors.
> 
> The current implementation does indeed follow the official datasheet, but exactly the datasheet seems to be incorrect in this place.
> 
> Datasheet: https://datasheets.maximintegrated.com/en/ds/DS18S20.pdf
> says two different things on Page 6:
> 

[snip]

> For your info: I have contacted Evgeniy P. as an author of the driver, but according to the response, he is not maintaining the driver anymore. That's why a question to all of you, if anyone could take a look at this please.

Evgeniy, if this is correct, please send a patch to update the W1 entry in the MAINTAINERS file
to Orphan status.  (or at a minimum, reply and ask someone else to do that [e.g., me])

I don't have any idea who could take over as being the W1 maintainer.

Thanks.

-- 
~Randy
