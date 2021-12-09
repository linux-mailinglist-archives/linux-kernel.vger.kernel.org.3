Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC6846E383
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhLIHz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:55:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:38704 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232321AbhLIHz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:55:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="301424989"
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="301424989"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 23:51:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="658675694"
Received: from imihalc-mobl1.ger.corp.intel.com (HELO [10.252.52.209]) ([10.252.52.209])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 23:51:51 -0800
Subject: Re: [RFCv3 0/7] USI stylus support series
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
References: <20211201164301.44653-1-tero.kristo@linux.intel.com>
 <CAO-hwJJRXrMAxi_cWng=vuQv4Ej7_AFweZTxVqu9_uy+C6sfzg@mail.gmail.com>
From:   Tero Kristo <tero.kristo@linux.intel.com>
Message-ID: <8e35543a-78f0-985f-808c-b07622ba814e@linux.intel.com>
Date:   Thu, 9 Dec 2021 09:51:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAO-hwJJRXrMAxi_cWng=vuQv4Ej7_AFweZTxVqu9_uy+C6sfzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 08/12/2021 17:30, Benjamin Tissoires wrote:
> Hi Tero,
>
> On Wed, Dec 1, 2021 at 5:43 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>> Hi,
>>
>> Another update here based on received feedback. Main change compared to v2:
> If that's OK with you, I'd like to cherry-pick some patches from the
> series: 1/7, 2/7 (the version from v4 because I requested changes),
> 4/7 and a lighter 5/7 where we don't have the MSC events we are still
> discussing.
>
> So Ideally, can you post a v4 based on top of hid.git/for-next
> (without my hid-bpf changes) with those 4 patches?

Yes, I can post these.

>
> Patch 3 is still up for discussion, and patches 6 and 7 are obviously RFC.
>
> Actually, Patch 3 could be split into a part where you add the HID
> usages and a part with the mapping of them. The HID usages part can be
> integrated now too, and we'll have the USI mapping that would require
> Dmitry's ack in a separate patch.
Ok, I'll take a look at this part also.
>
> But if you prefer having everything in one series, that's fine by me too.

No, I am fine with splitting things up and start getting things integrated.

-Tero

>
> Cheers,
> Benjamin
>
>> - Dropped patch #5 : HID: core: map USI pen style reports directly
>>    This is not needed anymore, as the same result can be reached by
>>    modifying the flags of the relevant field in rdesc. This is done now
>>    as part of patch #7 in the BPF code.
>>
>> I also dropped one of the fixes from my test branch [1] as pointed out
>> by Benjamin, it is not needed if the BPF program is executed with the
>> modalias link.
>>
>> Updated test branch can be found from [2].
>>
>> -Tero
>>
>> [1]
>> https://github.com/t-kristo/linux/commit/81b27fd46780ce67c2706d586c0f4a437e87dbf6
>> (HID: bpf: fix file mapping)
>> [2] https://github.com/t-kristo/linux/commits/usi-5.16-rfc-v3-bpf
>>
>>
