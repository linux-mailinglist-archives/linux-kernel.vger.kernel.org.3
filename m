Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E29495127
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376530AbiATPNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242860AbiATPNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:13:34 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6170C061574;
        Thu, 20 Jan 2022 07:13:33 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nAZ7x-0003up-Hz; Thu, 20 Jan 2022 16:13:29 +0100
Message-ID: <343accce-e361-3154-409d-78ecc2736024@leemhuis.info>
Date:   Thu, 20 Jan 2022 16:13:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-BZ
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, Takashi Iwai <tiwai@suse.de>,
        Fernando Ramos <greenfoo@u92.eu>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tedd Ho-Jeong An <tedd.an@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
References: <20211202162256.31837-1-tiwai@suse.de>
 <acc7b5b4-72cc-9f3b-90a6-6fbf6c3a71e7@molgen.mpg.de>
 <s5h7dcnt0lp.wl-tiwai@suse.de> <YayVYIAi56097Ltl@zacax395.localdomain>
 <1D49EE9C-42D4-45C9-AE37-F4C508FD2D64@holtmann.org>
 <s5hk0gch9ve.wl-tiwai@suse.de>
 <7886757f-60f4-b63e-95a6-52dc7dcb86d8@molgen.mpg.de>
 <6c194b50-84f6-a554-140c-174cb658813a@leemhuis.info>
 <ACC75B0C-E755-4041-8C07-CB87C8BCC566@holtmann.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH] Bluetooth: Apply initial command workaround for more
 Intel chips
In-Reply-To: <ACC75B0C-E755-4041-8C07-CB87C8BCC566@holtmann.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1642691613;ce65283e;
X-HE-SMSGID: 1nAZ7x-0003up-Hz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.22 16:07, Marcel Holtmann wrote:
> 
>> Could the bluetooth maintainers please provide a status update? I wonder
>> if it's time to bring this regression to Linus attention, as it seems to
>> be an issue that hits quite a few users -- and at the same takes quite a
>> long time to get fixed for a issue where a patch with a workaround was
>> already proposed one and a half months ago.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95655456e7cee858a23793f67025765b4c4c227b

Ahh, okay, many thx for the update, it wasn't clear enough to me that
this should fix the issue. Would have been nice if the commit would have
had "Link:" tags to all reports about the issue (as explained in
Documentation/process/submitting-patches.rst and
Documentation/process/5.Posting.rst ), as that would have avoided confusion.

Anyway, to close this:

#regzbot introduced: ffcba827c0a1d
#regzbot fixed-by: 95655456e7cee858a23793f67025765b4c4c227b

Ciao, Thorsten
