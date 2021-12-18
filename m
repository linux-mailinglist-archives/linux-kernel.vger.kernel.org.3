Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF62479BEA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhLRSEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhLRSEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:04:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A277DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 10:04:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4555F60BCB
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 18:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09046C36AE0;
        Sat, 18 Dec 2021 18:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639850672;
        bh=NmSe5QZRGiOBIbU3dJneyDvlbqXLcBIxOxNopx5DF24=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=D9euVgWARUZI5Vdf72bwXbLtY/KvRUUhJE4ZmI1UlpX5ToplX9TyQKZ6Z0tMchLxK
         ZDvrwAfO2pVA9g6bVOjHfb5wwUCqXmZRrPPl2j/PU9M+wyU47L1mz8fCLYZhvwpt+A
         oF2n/StLcLmBL1VD/OTrNQqze08RqnsbnIp/1TMFVzVspcv9pbiIMtaVHkcooKH2Ba
         p25e0qs+RbwHmjaIzJKJTL16oJVhyJxPMOdW/0D3KIpHbO49MuPCegn/9UWNNEjstw
         RBCadt/WvRQ7ij+oJfsNflKv0NY5Bl+Gr5vs57A1kbbw3qGLtxhtpzovo+mBnOfSAX
         rB43NCT3Pq+rA==
Message-ID: <bbfb9c184aaf75536fb7bb8acf7ae35fe3c77545.camel@kernel.org>
Subject: Re: [GIT PULL 2/3] bcm2835-dt-fixes-2021-12-13
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Sat, 18 Dec 2021 19:04:27 +0100
In-Reply-To: <20211213123040.184359-2-nsaenzju@redhat.com>
References: <20211213123040.184359-1-nsaenzju@redhat.com>
         <20211213123040.184359-2-nsaenzju@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-13 at 13:30 +0100, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-fixes-2021-12-13
> 
> for you to fetch changes up to 6a56599b5a6b19adb21f8f0d9f2d33511426fb20:
> 
>   ARM: dts: gpio-ranges property is now required (2021-12-13 13:06:25 +0100)
> 
> ----------------------------------------------------------------
> A series of devicetree fixes aimed at the Raspberry Pi family of boards:
> 
> - Phil Elwell adds gpio-ranges to RPi's main GPIO/PINCTRL driver
> - Phil Elwell and Stefan Wahren correct RPi400's GPIO expander's
>   labels
> - Stefan Wahren drops fallback compatible from RPi2's vchiq devicetree
>   node
> 
> ----------------------------------------------------------------
> Phil Elwell (2):
>       ARM: dts: bcm2711-rpi-400: Fix GPIO expander labels


Hi Florian,
I know you're in the loop, but just to be safe. Both patches below are no
longer needed: the gpio-ranges change was applied by linusw alongside its
pinctrl counterpart, vchiq's fallback will remain as is.

>       ARM: dts: gpio-ranges property is now required
>       ARM: dts: bcm283x: Drop fallback compatible for vchiq

If it makes your life simpler I can send a second 'dt-fixes' pull request.

Regards,
Nicolas
