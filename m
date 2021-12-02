Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D10E466133
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356748AbhLBKMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356758AbhLBKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:12:22 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109FEC061756
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 02:09:00 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id 84so18048827vkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 02:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KxuN9XUUMW8gZ9VWagInIzYpVNdqq81IIENwDXx0fOY=;
        b=sP1fiPXTUMJoNGskvKjjtSoGqquXQU21deizBbg70ItZf0gfJkisFdQOVvZ/ys7r4Q
         SHHCCKR9T78NVKyuPYXBWEguESlSjfflJRWrKiIqfssQQFz7WdfyzP1jBZKgJ6DzfOch
         NbaV8467W/9J4QvAsTBzPKCiQB4NxWBiSgJm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KxuN9XUUMW8gZ9VWagInIzYpVNdqq81IIENwDXx0fOY=;
        b=iwslW0wUACL6wLuomzXZTLDHBl1vRCzRafo7Mqp5NESlKe/qKCYUI5cRL+4bFeARuh
         qZ6+2T6OaDz+dezAZoJVmZM5SA8TnTFRm5o1nkb4bMv4mvegMC8Oum/iBXmay+I7axZU
         LHeCKlTgu82Gft4sqClMZYgbMSjbkfwgWH8TEqX80fBhOq5Hp/RzCa9a6g+Q5d7c0mem
         +MaAZ8MujeF00cM7JwNpu9ktfJi3LDtHUBNEi7R+JgvlITx58Kxq4+Ac6gfgwUMvFHZM
         2vbgD+Ax1jysoKmevQlXKEyLUGkSdK3/2+v22LA65fLylOHZ+ysrD6bSKNCpKOs6Ugsw
         H2RQ==
X-Gm-Message-State: AOAM530KAKm5gYyy38k9yThadqztCeW6ywWxBRJO59nMcCoPn6tLrqH9
        K95h+W9eZQOAfaiMSSIcbvuTZXq+jCovhTd+eMCFSQ==
X-Google-Smtp-Source: ABdhPJy0QfEolltcqqlYNbGRBgDMA/8lo3xhFobs++B2pW2+9lgHiRtlqmqQTR+L7HkU8xSlfezN+dEBQzfYY32Jfsk=
X-Received: by 2002:ac5:cdad:: with SMTP id l13mr14112277vka.39.1638439739151;
 Thu, 02 Dec 2021 02:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20211201175613.13710-1-dafna.hirschfeld@collabora.com>
In-Reply-To: <20211201175613.13710-1-dafna.hirschfeld@collabora.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 2 Dec 2021 19:11:51 +0900
Message-ID: <CAFr9PXnvbqtx-SpxjyO2uvoBR3ueNBD9vSFnbqjbAHz_7Lh8VA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] staging: media: wave5: add wave5 codec driver
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        Robert Beckett <bob.beckett@collabora.com>,
        kiril.bicevski@collabora.com,
        Nas Chung <nas.chung@chipsnmedia.com>,
        lafley.kim@chipsnmedia.com, scott.woo@chipsnmedia.com,
        olivier.crete@collabora.com, dan.carpenter@oracle.com,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

On Thu, 2 Dec 2021 at 02:56, Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
> Testing on BeagleV shows buffer corruption that is currently attributed to a
> known silicon issue in the SoC that makes the cache coherent interconnect not
> so coherent.

Maybe it's mentioned somewhere else and I missed it but would it be
possible to tell me which version of the IP is in the BeagleV chip?
The reason I ask is I'm trying to get this going on the SigmaStar
SSD202D which seems to have the "Wave 511".
I can see the firmware binary get uploaded and it seems to do
something as the register that exposes the vcpu program counter is
doing something (and the addresses look the same as the addresses seem
when the working vendor kernel + binary .ko are running so I think
it's not just running garbage).

I'm wondering if the BeagleV is a different version and the driver
just won't work as is on mine or maybe the firmware I have has hacks
for the vendors version of the driver which I don't have source for.

Thanks,

Daniel
