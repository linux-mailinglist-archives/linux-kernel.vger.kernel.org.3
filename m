Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C907495105
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358037AbiATPHm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Jan 2022 10:07:42 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35692 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiATPHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:07:40 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id A3E1ECECF6;
        Thu, 20 Jan 2022 16:07:38 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: Apply initial command workaround for more
 Intel chips
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <6c194b50-84f6-a554-140c-174cb658813a@leemhuis.info>
Date:   Thu, 20 Jan 2022 16:07:37 +0100
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, Takashi Iwai <tiwai@suse.de>,
        Fernando Ramos <greenfoo@u92.eu>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tedd Ho-Jeong An <tedd.an@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <ACC75B0C-E755-4041-8C07-CB87C8BCC566@holtmann.org>
References: <20211202162256.31837-1-tiwai@suse.de>
 <acc7b5b4-72cc-9f3b-90a6-6fbf6c3a71e7@molgen.mpg.de>
 <s5h7dcnt0lp.wl-tiwai@suse.de> <YayVYIAi56097Ltl@zacax395.localdomain>
 <1D49EE9C-42D4-45C9-AE37-F4C508FD2D64@holtmann.org>
 <s5hk0gch9ve.wl-tiwai@suse.de>
 <7886757f-60f4-b63e-95a6-52dc7dcb86d8@molgen.mpg.de>
 <6c194b50-84f6-a554-140c-174cb658813a@leemhuis.info>
To:     Thorsten Leemhuis <linux@leemhuis.info>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

> Could the bluetooth maintainers please provide a status update? I wonder
> if it's time to bring this regression to Linus attention, as it seems to
> be an issue that hits quite a few users -- and at the same takes quite a
> long time to get fixed for a issue where a patch with a workaround was
> already proposed one and a half months ago.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95655456e7cee858a23793f67025765b4c4c227b

Regards

Marcel

