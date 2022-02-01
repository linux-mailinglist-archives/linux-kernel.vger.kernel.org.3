Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C02C4A6469
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiBATAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:00:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51162 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242173AbiBATAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:00:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79BB2615BF;
        Tue,  1 Feb 2022 19:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8499EC340EC;
        Tue,  1 Feb 2022 19:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643742007;
        bh=4Az+r1WeuEMB6RWqn6rlJUiyuwhPZGNjYiCuFmFgGvg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EhpeIdsspcNjZOAaOcCEBl5SjOgOVxoFZMIRbOFdpQaRA9aS/AomDi3Zgq+0xW7Hq
         VAU/zKEJMw7UF/gyNXwG2MVE6+xvKwjic2iGpL0gF3mq/yea7jXYue0ZnQZErftnWE
         yjZFYRSYcJKEXN5XahdF13Vfe9JlC1giONuvNJcjmLH+84HD4fDIwFakVIFDXrGv2y
         mvtD50P8iy6dIOc05smNwUEZuCo3s38VLka8aosVgs7IgkqyDC9zaxTboHxVJrxgHp
         vwKu0eOW9cvRkvRWqZLlQaVJjXtWIVTYRmqKlbnwMEYXuRnU+KgYYaeae3aO0+ZexC
         BWyfnbk0/R0ww==
Message-ID: <58eab955-3c18-b56b-453e-e201df5e0f0c@kernel.org>
Date:   Tue, 1 Feb 2022 21:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-am64-main: Add GPMC & ELM nodes
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
Cc:     kishon@ti.com, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211208131536.23667-1-rogerq@kernel.org>
 <9250e5ed-6d4a-9eae-93d4-90e5906ae166@kernel.org>
 <20211223132822.nhujenxwmdwtjruw@viral>
 <20220201163341.u5etiz3zoi2t7h2x@briskly>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220201163341.u5etiz3zoi2t7h2x@briskly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 01/02/2022 18:33, Nishanth Menon wrote:
> On 07:28-20211223, Nishanth Menon wrote:
>> On 19:11-20211222, Roger Quadros wrote:
>>> Hi Nishanth,
>>>
>>> On 08/12/2021 15:15, Roger Quadros wrote:
>>>> Hi Nishanth,
>>>>
>>>> This series adds GPMC and ELM controller device tree nodes to
>>>> AM64 SoC's dtsi file.
>>>>
>>>> Changelog:
>>>> v2
>>>> - Fix register sizes for GPMC node.
>>>> - Disable GPMC and ELM nodes in board files. They will be enabled in
>>>> NAND card device tree overlay.
>>>
>>> Gentle reminder to pick this for -next
>>> GPMC + NAND side patches are already in queue for -next. Thanks.
>>
>> just responding to the main thread: lets hold this back for next window.
>> the bindings need to be in master rc1 prior to the dts getting picked up.
> 
> 
> Any updates?
> 
I'll send out a re-based patch-set soon.

cheers,
-roger
