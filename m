Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E9B46C084
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbhLGQRf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Dec 2021 11:17:35 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51925 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhLGQRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:17:34 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1FFA6CED0C;
        Tue,  7 Dec 2021 17:14:03 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH] Bluetooth: Apply initial command workaround for more
 Intel chips
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <YayVYIAi56097Ltl@zacax395.localdomain>
Date:   Tue, 7 Dec 2021 17:14:02 +0100
Cc:     Takashi Iwai <tiwai@suse.de>, Paul Menzel <pmenzel@molgen.mpg.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tedd Ho-Jeong An <tedd.an@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1D49EE9C-42D4-45C9-AE37-F4C508FD2D64@holtmann.org>
References: <20211202162256.31837-1-tiwai@suse.de>
 <acc7b5b4-72cc-9f3b-90a6-6fbf6c3a71e7@molgen.mpg.de>
 <s5h7dcnt0lp.wl-tiwai@suse.de> <YayVYIAi56097Ltl@zacax395.localdomain>
To:     Fernando Ramos <greenfoo@u92.eu>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fernando,

>> Thanks, so this seems depending on the hardware, maybe a subtle
>> difference matters.  As far as I read the code changes, the workaround
>> was applied in the past unconditionally, so it must be fairly safe
>> even if the chip works as is.
>> 
>> Or, for avoiding the unnecessarily application of the workaround,
>> should it be changed as a fallback after the failure at the first
>> try...?
> 
> I don't know if this helps, but I started experiencing this same issue ("hci0:
> command 0xfc05 tx timeout") yesterday after a kernel upgrade.
> 
> My controller is a different one:
> 
>    8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Adapter
>    ^^^^^^^^^
> 
> I tried with different (older) versions of the v5.15.x kernel but none worked.
> 
> Now, this is the interesting (?) part: today, when I switched on the computer
> to keep testing, the bluetooth was *already* working once again.
> 
> I have reviewed my bash history to try to figure out what is it that I did, and
> the only thing I see is that yesterday, before going to sleep, I did a full
> poweroff instead of a reset (which is what I used yesterday to try different
> kernels).
> 
> This does not make any sense... but then I found this [1] post from someone else
> who experienced the same.
> 
> Is there any reasonable explanation for this? Could this be the reason why you
> seem to have different results with the same controller (8087:0a2a)?

we trying to figure out what went wrong here. This should be really only an issue on the really early Intel hardware like Wilkens Peak. However it seems it slipped into later parts now as well. We are investigating what happened and see if this can be fixed via a firmware update or if we really have to mark this hardware as having a broken boot loader.

Regards

Marcel

