Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9327E48834E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 12:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiAHLxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 06:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiAHLxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 06:53:17 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEE1C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 03:53:17 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n6AHa-0000BO-KR; Sat, 08 Jan 2022 12:53:14 +0100
Message-ID: <cf5b69c6-532b-4c6e-c046-eaad65019e8f@leemhuis.info>
Date:   Sat, 8 Jan 2022 12:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fix 5.15 init regression for Intel Bluetooth
Content-Language: en-BS
To:     "An, Tedd" <tedd.an@intel.com>,
        "ortwin.glueck@logobject.ch" <ortwin.glueck@logobject.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <856c5dc7-9fb4-8438-3451-7b369832056a@odi.ch>
 <b0f6f66b-28aa-9d43-0aab-e6887ee0fda8@logobject.ch>
 <7b400964d7bcf052fb609bd1647936df03bdc667.camel@intel.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <7b400964d7bcf052fb609bd1647936df03bdc667.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1641642797;c3e13826;
X-HE-SMSGID: 1n6AHa-0000BO-KR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.01.22 03:08, An, Tedd wrote:
> On Mon, 2021-12-27 at 11:26 +0100, Ortwin Glück wrote:
>> On all 5.15 kernels the Intel Bluetooth no longer works. All was fine in 5.14.
>> Apparently the quirk is needed for this device.
>>
>> vanilla 5.15.5:
>>     Bluetooth: hci0: Reading Intel version command failed (-110)
>>     Bluetooth: hci0: command tx timeout
>>
>> with patch:
>>     Bluetooth: hci0: Legacy ROM 2.5 revision 1.0 build 3 week 17 2014
>>     Bluetooth: hci0: Intel device is already patched. patch num: 32
>>
>> Please apply to stable too.
> 
> The fix for this issue is in bluetooth-next and will be merged to mainline soon.
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=95655456e7cee858a23793f67025765b4c4c227b

Tedd, many thx for fixing this. Next time when you fix a issue, please
include a "Link:" tag to all issue reports on the list (IOW: the message
that started this thread) and in bug trackers, as explained in
Documentation/process/submitting-patches.rst. To quote:

```
If related discussions or any other background information behind the
change can be found on the web, add 'Link:' tags pointing to it. In case
your patch fixes a bug, for example, add a tag with a URL referencing
the report in the mailing list archives or a bug tracker;
```

This concept is old, but the text was reworked recently to make this use
case for the Link: tag clearer. For details see:
https://git.kernel.org/linus/1f57bd42b77c

These link help others that want to look into the issue now or in a year
from now. There are also tools out there that rely on these links to
connect reports and fixes. Regzbot, the regression tracking bot I use,
is one such tool which I'm running (there might be others). And because
the link was missing, I now have to tell the bot manually about the fix. :-/

#regzbot fixed-by:  95655456e7cee858a2

Ciao, Thorsten

