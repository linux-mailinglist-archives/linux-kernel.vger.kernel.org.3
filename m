Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3B14633B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhK3MBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:01:45 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:38637 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236368AbhK3MBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:01:34 -0500
Received: from [192.168.0.2] (ip5f5aeac2.dynamic.kabel-deutschland.de [95.90.234.194])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1C59D61E5FE00;
        Tue, 30 Nov 2021 12:58:11 +0100 (CET)
Message-ID: <ccdbb0d7-d043-d41f-508b-4a464ffa5fe9@molgen.mpg.de>
Date:   Tue, 30 Nov 2021 12:58:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     linux-raid@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-accelerators@lists.ozlabs.org, linux-nvme@lists.infradead.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Using aGPU for RAID calculations (proprietary GRAID SupremeRAID)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Linux folks,


I read about GRAID SupremeRAID [1], which seems to be an Nvidia T1000 
card and software to use the card for RAID calculations.

> GRAID SupremeRAID works by installing a virtual NVMe controller onto
> the operating system and integrating a PCIe device into the system
> equipped with a high-performance AI processor to handle all RAID
> operations of the virtual NVMe controller

According to the review *GRAID SupremeRAID SR-1000 Review* [2] it 
performs quite well. I couldn’t find any driver files online.

Now I am wondering, why a graphics card seems to help so much. What 
operations are there, modern CPUs cannot keep up with?

If GPUs are that much better, are people already working on a FLOSS 
solution for the Linux kernel, so people can “just” plug in a graphics 
card to increase the speed?

Does the Linux kernel already have an API to offload calculations to 
accelerator cards, so it’s basically plug and play (with AMD graphics 
cards for example using HSA/KFD)? Entropy sources, like the ChaosKey 
[3], work like that. If not, would the implementation go under `lib/raid6`?


Kind regards,

Paul


[1]: 
https://www.graidtech.com/post/graid-reveals-the-next-generation-of-enterprise-data-protection-nvme-ssds
[2]: https://www.storagereview.com/review/graid-supremeraid-sr-1000-review
[3]: https://altusmetrum.org/ChaosKey/
