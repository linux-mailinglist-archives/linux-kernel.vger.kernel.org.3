Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D82049F83D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiA1LYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiA1LYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:24:40 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6719C061747
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:24:40 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z14-20020a17090ab10e00b001b6175d4040so4945485pjq.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MuWXa/dKeqGYD0Uv835NnGzX3ZFfUYNI8MH1vd0SUz0=;
        b=EJpUCkcd+r5r2AiIM2NRsEH+zuMJdDorQZuoPjgBDWTHW+XGXvJZMzc5c236FdkISz
         8FzYgvJTwBNOzbhdM0BUdIA2+CHiybdOYb5+u3g+9/kbf+S8j4EXLgg2T6N/02vVEnkA
         vBgXQVLIGTGm/g7tRFDYxyssWdda+DP/I15PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MuWXa/dKeqGYD0Uv835NnGzX3ZFfUYNI8MH1vd0SUz0=;
        b=GtgdALQ7P8YSdv+ug5cSYbHCm/NuR6UrohmjT//4irZRA97uLmyy4ZYvBkGf8Ty/dU
         5TfOIB9cfnE7Nhn68Lmx79MklLYntYVPOn+6QrRGzzRkGmYDa54ng44EFtqgBBhcrqRb
         ZwMGdgEDBvi10sJ0oIyhHtbiwaxVSmLjazt/QcSVyF9z8BbmkEwqduQV40KmmLvIVbPY
         C3VE7Z0d+2Yj873hp1WLFAvKH5uz8Pp2ilIp8yZGZb0PAkt44pzQiyyKwPSFOyR790IN
         aBbEQgx/Uo7kAyh8QTVkwiUtYGlhDYKjzWiEct5+qNLf1Gg9VidGhlWbC9AK1RKFVuII
         eOtg==
X-Gm-Message-State: AOAM532jXUj2QQ8dG4FW+oxgD9OzyHIZdXmEhI0zdSfS2fcZeb5cXz9X
        GBxiuFNmYhIkxu8RXgx/VyWy+g==
X-Google-Smtp-Source: ABdhPJz9vaeT420x071ltTwUhJu7VUM9ha6We1vBjrZ11JSKseHhyHknNxQDrjtEVpPRo5iBau+kTQ==
X-Received: by 2002:a17:90b:4f49:: with SMTP id pj9mr19168988pjb.211.1643369080062;
        Fri, 28 Jan 2022 03:24:40 -0800 (PST)
Received: from adf6a34bf206 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id k12sm9394044pfc.107.2022.01.28.03.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:24:39 -0800 (PST)
Date:   Fri, 28 Jan 2022 11:24:32 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Vyacheslav Bocharov <adeep@lexina.in>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/2] Bluetooth: hci_h5: btrtl: Add support for
 RTL8822CS hci_ver 0x08
Message-ID: <20220128112432.GA28@adf6a34bf206>
References: <20220126073905.3637841-1-adeep@lexina.in>
 <9CE136E5-3BEC-42CB-8A19-644E2B4D0D10@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9CE136E5-3BEC-42CB-8A19-644E2B4D0D10@holtmann.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 02:40:38PM +0100, Marcel Holtmann wrote:
> Hi Vyacheslav,
> 
> > Add a variation of RTL8822CS with hci_ver = 0x08. This is fully similar
> > to RTL8822CS with hci_ver = 0x0a observed on the Tanix TX6 Android set-top
> > box and JetHome JetHub H1.
> > 
> > While testing the RTL8822CS SDIO WiFi/BT adapter, I found that in some
> > cases the kernel could not initialize it. However, manually resetting the
> > adapter via gpio allows it to start correctly.
> > Apparently at system start the adapter is in an undefined state (including
> > the unknown state of gpio after starting uboot). A forced reset helps to
> > initialize the adapter in most cases. Experimentally it was found that
> > 100ms is enough to reset.
> > So, add power reset via enable-gpios in h5_btrtl_open function.
> > 
> > Changes from v6..v4:
> > - fix patch description
> > Changes from v3:
> > - add has_msft_ext option
> > Changes from v2:
> > - align the patches for bluetooth-next
> > Changes from v1:
> > - remove Signed-off-by chbgdn <chbgdn@gmail.com> as not reachable
> > 
> > Vyacheslav Bocharov (2):
> >  Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
> >  Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open
> > 
> > drivers/bluetooth/btrtl.c  | 8 ++++++++
> > drivers/bluetooth/hci_h5.c | 5 +++++
> > 2 files changed, 13 insertions(+)
> 
> both patches have been applied to bluetooth-next tree.

Thanks Marcel and Vyacheslav

> Regards
> 
> Marcel
> 
