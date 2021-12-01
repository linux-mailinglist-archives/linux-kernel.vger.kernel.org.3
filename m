Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613D5464A43
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348077AbhLAJD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:03:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:62925 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242056AbhLAJDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:03:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236361932"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="236361932"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 01:00:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="654693452"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 01 Dec 2021 00:59:58 -0800
Subject: Re: [PATCH] xhci: Remove CONFIG_USB_DEFAULT_PERSIST to prevent xHCI
 from runtime suspending
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        mathias.nyman@intel.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211119092628.677935-1-kai.heng.feng@canonical.com>
 <CAAd53p4CpEQR0Y5XDN5E7xZ-iw2GG=gGMSm2Vd=V_M1LLEuuCA@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <b7595524-1041-8b8b-dc61-9ee0acbc8307@linux.intel.com>
Date:   Wed, 1 Dec 2021 11:01:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAAd53p4CpEQR0Y5XDN5E7xZ-iw2GG=gGMSm2Vd=V_M1LLEuuCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.12.2021 2.19, Kai-Heng Feng wrote:
> On Fri, Nov 19, 2021 at 5:27 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>>
>> When the xHCI is quirked with XHCI_RESET_ON_RESUME, runtime resume
>> routine also resets the controller.
>>
>> This is bad for USB drivers without reset_resume callback, because
>> there's no subsequent call of usb_dev_complete() ->
>> usb_resume_complete() to force rebinding the driver to the device. For
>> instance, btusb device stops working after xHCI controller is runtime
>> resumed, if the controlled is quirked with XHCI_RESET_ON_RESUME.
>>
>> So always take XHCI_RESET_ON_RESUME into account to solve the issue.
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> A gentle ping...

Thanks
Adding to queue

-Mathias
