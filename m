Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E7B4933A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351314AbiASDg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344436AbiASDgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:36:55 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC144C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 19:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=9QB3AWI6LgBI2A3hgjObs46olZfV7DK06QXjlVEbSfc=; b=a1HDE+aHSnEgQvsRz7gECfDBb8
        MZ/NOJi22ulpZxzsBLIGAxjDC5J8BtzxsTlgZNgRc1pqvaff/0Dv95M0bNvWKfX1cKeE/jnbBtxdV
        BBguP2QlICoeYEbPu9G1vP8g8Y/5GrkEZ683TX8nJ8bf5K6TuMuuBKPftR0L41TA1gNFKLD/iLQWO
        stDuGTMoF3+c08RZpJ4WeNUeN0UHQI28afw/s/sHcxSe4amlEcVAH///rqtS8ziwlA/s17gIzNumY
        m7pbUzbQNczICmB6FVw2MWoEkfdSTTr/qrSfTFCU0IWCSl97qrMPqUEzdngIWUN83SV8LAR/EqEax
        76y1Jwxg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nA1mB-001xp9-8d; Wed, 19 Jan 2022 03:36:47 +0000
Message-ID: <a54dcf61-9dd6-7848-f683-651d737b1533@infradead.org>
Date:   Tue, 18 Jan 2022 19:36:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: What replaces the 4.19.y scripts/mkknlimg in 5.16-rc6-rt12?
Content-Language: en-US
To:     gene heskett <gheskett@shentel.net>, linux-kernel@vger.kernel.org
References: <3003419.O0OFyGy2SB@coyote>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <3003419.O0OFyGy2SB@coyote>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gene,

On 1/16/22 18:56, gene heskett wrote:
> Greetings all;
> 
> That script/mkknlimg is missing in v5.16-rc6-rt2. What replaces it?
> 
> Or, can this script be copied to a v5.16-rc6-rt12 build and used?
> 
> Thanks a bunch, I'm trying to build a v5.16-rc6-rt12 on a rpi4 for the 
> rpi4. The build itself was flawless.
> 
> Cheers, Gene Heskett.

Mainline 4.19.* does not have a file called scripts/mkknlimg.
Since I am not familiar with that script, I used some internet search
engine and found several sites that might help you.  Good luck.  :)

https://autostatic.com/tag/mkknlimg/
https://github.com/raspberrypi/linux/issues/3249

Bottom line is that it is no longer needed. The second URL above says:

It's not at all clear what would be going wrong in your case. Our standard kernel build instructions (https://www.raspberrypi.org/documentation/linux/kernel/building.md) just copy the zImage:

sudo cp arch/arm/boot/zImage /boot/$KERNEL.img

and

sudo cp arch/arm/boot/zImage mnt/fat32/$KERNEL.img


cheers.
-- 
~Randy
