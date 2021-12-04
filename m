Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08284686DF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 19:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385341AbhLDSHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 13:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345275AbhLDSHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 13:07:21 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0E6C061354
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 10:03:55 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id f9so19102048ybq.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 10:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rLzAPQRH2eocZ5yarciM+SfnfNNbvB1ODjCX9P75N9Y=;
        b=Kt6hkUqTxt23xqHH9bnTRwcCOrC+SDGPI/6GzzWOeRiF3k/Q+6XZApEYhSd3n8WG0N
         XVvSHLfY4Xocq76jzrxsZ9HZMSJo6NczgxLPc6OtrOAdAZs7P2GNzdtttSxq27ReIiI0
         4AhAhdNOqvONqIIcS6reHtmUU+Vc/+2RMi1o88KFYoh5wejN+FI1yXy9Qq36sgXk99ag
         wIq90UKkUzCTil4chwSLbM6mig7nN0EI6O5UXXE8+C+kADZF/I+s81tSJ5yQr/JfBDZB
         jJ1Xvzr/KjVUQ05gmfdw9zwWN8izf7XhpnNAAytqUQN53Rfh/1s4dB2Ou7E0nEAip0uP
         1Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rLzAPQRH2eocZ5yarciM+SfnfNNbvB1ODjCX9P75N9Y=;
        b=zPmZ2YntmQBJV00l2ImTT9V26Enyr9XfT1trpISLYDqRMS3DG6gTkm4Uwle9GwMsZl
         90FF3jwQqqRt0qJGjqC+7gaO2/IziG/pV7sIj906EecreE+ZXebLDPTo+ksAcHgWbmG9
         3ayZjmH216nhjca8t/gGPF7+C7BwFTk7ByWt6UM0aXN1MWmppxDq33KRSO/JObKlYiH3
         maFQGHsRU9M8Y72uqPCxI4VNDfqW2u3q2CiC3k18lm9u4hlqMOYAcWFQxZETWU414FCQ
         8cLEC9qmZiSMrabY7B9Cl8gJVTg2RpnVCX0Vq6UrcgDwwc/1DOBXX0SKH2Do/NUXI2yN
         DJDw==
X-Gm-Message-State: AOAM5324Sgx+kdmruS0gt6uC/rkzDSkfnIgQXbMaT75T29uRxcXXkVoe
        XNXNpbTKciFSJgCbkwxpxCWKVjJLJ9xf5qMfhPfd4Q==
X-Google-Smtp-Source: ABdhPJzcdxMJ8it5euAFf+JTsiFWuncVVlYniOa4dNyprZwr+7Q1vupJyr8MUC+M9izx3+ugyiCh6ocbFCO/aWseaV0=
X-Received: by 2002:a25:d04d:: with SMTP id h74mr31641623ybg.266.1638641034305;
 Sat, 04 Dec 2021 10:03:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0d:c906:0:0:0:0:0 with HTTP; Sat, 4 Dec 2021 10:03:53 -0800 (PST)
In-Reply-To: <YaujvjBFsb3ricUx@kroah.com>
References: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
 <20211203192148.585399-6-martin.fernandez@eclypsium.com> <YaslQCg2G1pWUPVV@kroah.com>
 <CAKgze5Yw6=PjY9+cn=FKX5UsiSon5rVOK_Gc-3Hs8dQspSFaYA@mail.gmail.com> <YaujvjBFsb3ricUx@kroah.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Sat, 4 Dec 2021 15:03:53 -0300
Message-ID: <CAKgze5bJ5WOG+_ZXQpVKq=tF4yunsTmCtKOHLVR19aNWkL1U0Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] drivers/node: Show in sysfs node's crypto capabilities
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        rafael@kernel.org, rppt@kernel.org, akpm@linux-foundation.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/21, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sat, Dec 04, 2021 at 01:35:15PM -0300, Martin Fernandez wrote:
>> +Date:		October 2021
>
> October is long gone :(
>

:(

>> +Contact:	Martin Fernandez <martin.fernandez@eclypsium.com>
>> +Users:		fwupd
>
> Maybe a link to what 'fwupd' is?
>

Will add.

Thanks.
