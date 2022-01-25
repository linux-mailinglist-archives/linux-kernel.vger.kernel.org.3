Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E8049B451
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378304AbiAYMvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457057AbiAYMsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:48:36 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9607C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:48:35 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id q127so1801429ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZAMOdaZV3kaz6DNePCCcseQo6HQuQu7Jogq542aV50U=;
        b=kZymcFPiqTrN6lay77u5I0pKKqy2ePROp3bdw2vGb8US+M0sWOhNhaqYtxFsK6XlWR
         dIQRE4DeBE7TxBj+NGMkPXgtz76s9jy0dTstR5MrSue8bnRaJabAw6uhlwpqeLFFFAOR
         ZSJGt/PXAZVjf93sLfwIsbvGJij0XBJn1vZ5CvU81dBY3+B/ucKnTRHhZmPKQWk7PBJL
         hSussOi/wXrQjzlqTJNsw9XWl6lJGHw7zpQukUEqWFlCCXNoDRgV9Igurb14+aQgCA/S
         G1k+kySrajDS+Mua7l6UXeEFUGgGUuKSpMtI5uH4iyI7on+g/9Of5mmWaf2TEhQfDQei
         lIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZAMOdaZV3kaz6DNePCCcseQo6HQuQu7Jogq542aV50U=;
        b=QCRAtz56GyhKRKHCuBQ6NrEwZwM1NCCryyzaukRQU+HSrSY+WRAD8fzz/wkXnOFkB+
         WV2oO0dNk4WJkHKULFjx8qZup2Pm/YnlzcKkv6erGQ025vfLcjhSnGNpQsAdCODBIPuF
         lrwxlEjTyTI0tVJbmp83YaRPsVATdvQztsI17pIb1ZG0Dlfe94fX4Ctz62yqs1kcI8oM
         Ts+MJCN0BcVOCurgWtmjS9L+QBN8lfrNNrphdD9L+Ndsr09fj0AuGJg1i2UYTRccHHDW
         2NgpUYKLw2B4jrr6fagTcKnvApsRKyp1gbfdH+1Gb061UKMVIoCnF3b6H3/pyqJnDdOw
         GCwQ==
X-Gm-Message-State: AOAM532EEiV1KZJIF/AWD1ODZ3ScKsNRl44A1bScCD3DIjYBw4VaJXwF
        p2mNvuUqPxyfILo8YfBQ52k=
X-Google-Smtp-Source: ABdhPJzD0Dpm374X8XGe9j8y27j8+MrVZsA3uxyWNkyDoKVx4BpSAuxrJHa9ZGTTJW3EUDmd8kf0yQ==
X-Received: by 2002:a2e:22c6:: with SMTP id i189mr760695lji.496.1643114914006;
        Tue, 25 Jan 2022 04:48:34 -0800 (PST)
Received: from [192.168.1.11] ([94.103.227.208])
        by smtp.gmail.com with ESMTPSA id j23sm781579lfh.35.2022.01.25.04.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 04:48:33 -0800 (PST)
Message-ID: <67ddc4d7-e19f-7c9d-a4b7-4eb555830ea1@gmail.com>
Date:   Tue, 25 Jan 2022 15:48:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 05/10] staging: r8188eu: remove smaller sets of DBG_88E
 calls from os_dep dir
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-6-phil@philpotter.co.uk>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220124224415.831-6-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

On 1/25/22 01:44, Phillip Potter wrote:
> Remove all DBG_88E calls from the os_dep directory, other than those in
> os_dep/ioctl_linux.c, as this contains almost 200 on its own so will be
> done in a separate patch for ease of review. These calls do not conform
> to kernel coding standards and are superfluous. Also restructure where
> appropriate to remove no longer needed code left behind by removal of
> these calls. This will allow the eventual removal of the DBG_88E macro
> itself.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---

[code snip]

>   
> -	/* 2012-07-11 Move here to prevent the 8723AS-VAU BT auto
> -	 * suspend influence */
> -	if (usb_autopm_get_interface(pusb_intf) < 0)
> -			DBG_88E("can't get autopm:\n");
> -

Didn't you make a function change here? I didn't test and also didn't 
find any mentions of tests in cover letter.

I am asking just to be sure you done it not by accident :)





With regards,
Pavel Skripkin
