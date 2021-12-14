Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DD0474958
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhLNR0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:26:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:46456 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233723AbhLNRZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:25:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236566472"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="236566472"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 09:25:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="604415299"
Received: from rtwoods-mobl.amr.corp.intel.com (HELO [10.213.169.152]) ([10.213.169.152])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 09:25:58 -0800
Subject: Re: linux-next: Tree for Dec 13 (SND_AMD_ACP_CONFIG)
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211214030215.3181149-1-broonie@kernel.org>
 <8ff9d4b2-1905-2efa-cb86-e8f6cef06ef2@infradead.org>
 <CAEnQRZB9E4uBDuUidiJ+QJnQhGZp43jig4q93Pkw3pSr=K48YQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <11ed7f0f-ad5a-cae1-035c-23e5d3736818@linux.intel.com>
Date:   Tue, 14 Dec 2021 11:25:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAEnQRZB9E4uBDuUidiJ+QJnQhGZp43jig4q93Pkw3pSr=K48YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/21 11:21 AM, Daniel Baluta wrote:
> Hi Randy,
> 
> This should be fixed by https://github.com/thesofproject/linux/pull/3284

no, this was precisely the change that exposed a new problem.

https://github.com/thesofproject/linux/pull/3335 contains the suggested
fix posted earlier. We should know tomorrow if the 0day bot finds any
other issues.

> 
> Let me quickly send this to alsa-devel.
> 
> 
> On Tue, Dec 14, 2021 at 12:08 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 12/13/21 19:02, broonie@kernel.org wrote:
>>> Hi all,
>>>
>>> Non-merge commits (relative to Linus' tree): 5960
>>>  6555 files changed, 277265 insertions(+), 120864 deletions(-)
>>>
>>> ----------------------------------------------------------------------------
>>>
>>
>> on i386 or x86_64:
>>
>> when # CONFIG_ACPI is not set,
>> so SND_SOC_ACPI is not set:
>>
>> WARNING: unmet direct dependencies detected for SND_AMD_ACP_CONFIG
>>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_ACPI [=n]
>>   Selected by [y]:
>>   - SND_SOC_AMD_ACP_COMMON [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && X86 [=y] && PCI [=y]
>>
>>
>> Full randconfig file is attached
>>
>> --
>> ~Randy
