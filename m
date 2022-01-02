Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE36482C90
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 19:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiABSlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 13:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiABSlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 13:41:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A1CC061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 10:41:16 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v6so4284397wra.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 10:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tShDbYknZRWS4YLp1TQWmgakh1Xx5r6yUGEJ8fPlufM=;
        b=KT1w8ru6khj009b2hhJSG+gmT9S2sh+TI+IC0XSmz5/a8YvlQD1is3MFEjGtPRbkzL
         qxo9N0eB9cd8U65sUkhbyD7CC5mLDQtbLM0+BTZ2NQvl9XXnUhmcRiMRTplU15reqs1A
         0vZ2oMuUhPHP541+0MiWGLXZqFoSrvb2j4mUa0td8puRYZtQMgn1CYZjSCPXidAJHcGh
         IABazWv+OY/w24UGF6j2pu1BYESyngrg19tEzG0p939EuMVtm2oebyHx4PtSyf+1O0PL
         b60Q+iMde0KCQ2gZNO2suYmqEcKwemJ49rr0OooZVZ2tWuU8111/coVS0YhF2C6hM9Kb
         y4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tShDbYknZRWS4YLp1TQWmgakh1Xx5r6yUGEJ8fPlufM=;
        b=tEQm7T9lzKJydq+721OW8jWFL6VT4bOM7+tLVxKwiEofU7FszZJMqW62i2hH2dMFSZ
         /tZIrw3J6oWRSF8QyMnGL3WbqUR9w9yV/GDiExVsOdgHwREd1ZPHxL56nwL0q0CwwT1C
         TO6oLx1znqBaB6GbcNy8YbePsHzi48cXvZVtfEDNlfgkKLeaS3zSHEgTFH2b9tT7J/7g
         zESQw83bAvwIuSXirI/TxxUik9yQIAlibMfxSIcqsY6w1n4iwhTgEx7hAfKWrWnmQMVr
         xaRRfyWkV9e9mRNOjpW5yxcPLYunglgK3UJLoaM6sCI9zNupsXYFqYhxKuiUszRcNnQD
         lH2A==
X-Gm-Message-State: AOAM533cFp219LJoI1C+zpecCkeUhJ2vYdjqlo0xOhtW61Z6rT3zzM+N
        qKiyR8j9ogIDSBdL1msUKmE=
X-Google-Smtp-Source: ABdhPJwGzVTO3MmfHrAdE+ZI+yg060sdsonun9deEPMt3V7tGLIQ2Xs2Ex44QO2xbPCkYcj5KPFwGg==
X-Received: by 2002:a5d:56c2:: with SMTP id m2mr36334359wrw.313.1641148874773;
        Sun, 02 Jan 2022 10:41:14 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7e8? ([2a02:8108:96c0:3b88::d7e8])
        by smtp.gmail.com with ESMTPSA id z11sm39696846wmf.9.2022.01.02.10.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jan 2022 10:41:14 -0800 (PST)
Message-ID: <1821100d-c647-5237-de4a-b96bde556c5e@gmail.com>
Date:   Sun, 2 Jan 2022 19:41:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 0/5] staging: r8188eu: some trivial cleanups
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220102175932.89127-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20220102175932.89127-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/22 18:59, Martin Kaiser wrote:
> Remove unused variables and defines in several places.
> 
> Martin Kaiser (5):
>    staging: r8188eu: remove unused power management defines
>    staging: r8188eu: internal autosuspend is always false
>    staging: r8188eu: fix_rate is set but not used.
>    staging: r8188eu: cmd_issued_cnt is set but not used
>    staging: r8188eu: turbo scan is always off for r8188eu
> 
>   drivers/staging/r8188eu/core/rtw_cmd.c        |  3 ---
>   drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  9 +-------
>   drivers/staging/r8188eu/hal/rtl8188e_dm.c     |  1 -
>   drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 21 +++++++------------
>   drivers/staging/r8188eu/include/drv_types.h   |  2 --
>   drivers/staging/r8188eu/include/rtw_cmd.h     |  1 -
>   drivers/staging/r8188eu/include/rtw_pwrctrl.h |  5 -----
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  6 ------
>   drivers/staging/r8188eu/os_dep/os_intfs.c     |  4 ----
>   drivers/staging/r8188eu/os_dep/usb_intf.c     |  3 +--
>   10 files changed, 9 insertions(+), 46 deletions(-)
> 

Looks good to me. For all patches:

Acked-by: Michael Straube <straube.linux@gmail.com>
