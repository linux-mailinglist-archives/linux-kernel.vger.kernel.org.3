Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967F24617E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245298AbhK2OYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350503AbhK2OWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:22:33 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5E8C08EC93
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:01:12 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x15so71439320edv.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABZXvipJiG8DU0yscOKHfTw3HZvtKWkqQEDbi5xK6uo=;
        b=cEIsawItBaJxQ/QDzdwcTw67OoAqLCKjn1Ls301C7F31rlaDn+MvN5IoUI83fIdnvL
         LxBBN7XTi5gww/joPljDYwruMGFUzDaFi4SKwUP4dCIoIdNCUcHVamCLBC0SS9sKveKR
         ealzt1SoVSkphBci8irwlz6S9vcUfL0VsuF5BTv804W5EyO3F6S8UNNpXNVwE5Kaan2I
         cqhKlDp/bPBWln1/7XSoRZlV8hM8q2aHEybsGrubdYfTKxo+ZT9RX9/ukovO9ALfsTlX
         vIOFFtjJkiXHX7XxuCcN9jW94WgxDZQyv6CZeRDE3999Yb1/wOrSGUMXptvnVrtlKmcV
         JC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABZXvipJiG8DU0yscOKHfTw3HZvtKWkqQEDbi5xK6uo=;
        b=2m9RUcN4l1+i+t+lzzDJfX2Bvxs1MhKbs2vEFlA/bg318cvCt87lShayIeLMVfFmJI
         2TScZg0mzjnvxsdy3dQintstmTR3vDND3Y4tiKGqLc9o3G1ctY/O6kheo8Vn7t/vvdoF
         8V6qvE6YfxZ1EoAXo74b/ocWD8Reul3YR5YeOB7RfyCONlFG1YU/Xmmrq5Bu6DItMANS
         rSPtDbRMe99tKplu1Perry3U5rmSt36z+lF+FoJMulmEb2+C7x1B6D0uX0KllBrOECL4
         3mGl9UgnEp9SebYpxr29/4UKXW0l+vfRZpG8TWZyVI7WZUbGbbZJlG8gJv7l9lmmHhjx
         SA4g==
X-Gm-Message-State: AOAM531L645c5FgroYS6g0wEBIdk36jASDukn3xoM6zfQw1Tu42kopY/
        1H3v+t5iDnsBVxOVhY/oo44E20nmCfAgVuem8Azro76tyXs=
X-Google-Smtp-Source: ABdhPJwatCldH5/iun6LDNpdgUDPAUO3hI6pGmmGQ+/kKPvtL4/dDNgyAiHoY10wTUPlk+rrGJbowNFiDyuWVB6J2hY=
X-Received: by 2002:a50:950c:: with SMTP id u12mr33554755eda.361.1638190867012;
 Mon, 29 Nov 2021 05:01:07 -0800 (PST)
MIME-Version: 1.0
References: <202111271017.dLo8jJ8p-lkp@intel.com> <CAMo8BfL88Qc6o=WheT6+n4pOpXQbnw220UQa_GCQb98F=S9ffA@mail.gmail.com>
 <YaN+E5fuvU2VO+W5@kroah.com>
In-Reply-To: <YaN+E5fuvU2VO+W5@kroah.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 29 Nov 2021 05:00:55 -0800
Message-ID: <CAMo8BfKSaOUD5V5G+PBaLqcmcVnHw=JwrYP=hoLRoNj=oWDdLw@mail.gmail.com>
Subject: Re: [linux-stable-rc:linux-4.19.y 565/981] arch/xtensa/platforms/xtfpga/include/platform/hardware.h:50:33:
 error: initializer element is not constant
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun, Nov 28, 2021 at 5:03 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Nov 27, 2021 at 07:10:56AM -0800, Max Filippov wrote:
> > This happens because the backported change
> > 1c21a8df144f1edb3b6f5f24559825780c227a7d depends on the change
> > d67ed2510d28 ("xtensa: use CONFIG_USE_OF instead of CONFIG_OF")
> > which is not in that stable tree.
> >
> > Should I send the backported version of the d67ed2510d28 or should
> > the change 1c21a8df144f1edb3b6f5f24559825780c227a7d be reverted
> > from the stable? (IMO they are not the stable material).
>
> I have queued up d67ed2510d28 ("xtensa: use CONFIG_USE_OF instead of
> CONFIG_OF") to hopefully resolve this.

Thank you. However the change that you've queued is missing one
hunk of the original patch that makes the difference in this case.
I guess it's missing due to conflict introduced by the change
6591685d5004 ("xtensa: move XCHAL_KIO_* definitions to kmem_layout.h")

I've posted another backported version of this patch that includes
that missing part. Could you please apply it instead?

-- 
Thanks.
-- Max
