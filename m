Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF0546FE13
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbhLJJrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhLJJri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:47:38 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC56C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 01:44:03 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x15so28655554edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 01:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vS8MsusnmvnE6UdJ1SW2n4IaVQhdymK8JOAioenED48=;
        b=y3fW384PWYpdlMwnYZsVFQ9UcpHmuyRA1yNFjJ2htMuajQvvlqDmz2CKZSH3GkezmR
         ULEomoHfNhvfmEUjgBTGWpeCymyEx82IAt7a0rL6a0fa+k/CsI6BUwiUKC/BToq4Y8hf
         +uFzS5JjSShQeEVv1CaQ2VTaawguWUyMeWiI4zghU/z9ONFtDcTVlPYogrTkO0cOFkVz
         q27Rbki/JmzyCjRlMdUH1TcyOOAvTqadYoIXoBZNL5OyipNgUEsi2uJRXxSheemMQ7gH
         NhNnLbNt4sZkcoVTsuXmtX7UuarCMpUSqJt0FFmKQy0wqOtPp7/bAEl4Vyk6IifeZuBH
         Z6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vS8MsusnmvnE6UdJ1SW2n4IaVQhdymK8JOAioenED48=;
        b=XxdvRY+oe8P3VioCCS+0hXpl1TazmODpXx4uEGgJKBYnTl5Ukub0VQwCf6ss1GJVoE
         j932ywZMbwM+0W8YhTdF2lZfdVfBgCHJnM1CXl01rUy7ghwIc39WwQD9K9OpLeBTG+2e
         jOgyO5RoSzpRFcM5rpg3gxe7VdCHBw4JYwluzIrYRG0RD6jWDWLbiqjab/FxBPeOy/8k
         2eniAMAbFQJ/ITZuLbXjCpY3+MsXx61akTaZCHRLMRmxal1V/xvemAQU1sm+T9E7h2gE
         nBsxGcXYg8Aae5m7sjQDmriqcSjwmttJniMxqXX8DEDBd0sOUhwxAT0nfhkzUL+sei04
         NbqQ==
X-Gm-Message-State: AOAM531MtU9eNQzxmJB49BsJjiHzcRrl0+N7EqmV0Gsoqv+aCh32eRZw
        2UqV7X2GO8OraQ4u90BonQZXXpEFF5GXhF6XGmw4hA==
X-Google-Smtp-Source: ABdhPJzyjXAMJZccpErM1wLJ0h6+TH6ZJNR2MY2g0yNTUklDb5v4TuOzMVVFDmSPxEkCZ31hpQZx7G4Uuz4mcfVFlv8=
X-Received: by 2002:aa7:c415:: with SMTP id j21mr36434272edq.289.1639129441769;
 Fri, 10 Dec 2021 01:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
 <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org> <CAN5uoS9xv-kKpC4E6-muYdh59g8XPSDfbquk5=DbQ4GmiVk-PA@mail.gmail.com>
In-Reply-To: <CAN5uoS9xv-kKpC4E6-muYdh59g8XPSDfbquk5=DbQ4GmiVk-PA@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 10 Dec 2021 10:43:50 +0100
Message-ID: <CAN5uoS-Ho-YVY8N_3ouW2zaeVMvBTquLV12cgJbM4nTwtZTDfg@mail.gmail.com>
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
To:     Jerome Forissier <jerome@forissier.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        "Wang, Xiaolei" <xiaolei.wang@windriver.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixing typos :(


On Fri, 10 Dec 2021 at 10:38, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
> On Fri, 10 Dec 2021 at 09:10, Jerome Forissier <jerome@forissier.org> wrote:
> > +CC Jens, Etienne
> > On 12/10/21 06:00, Sumit Garg wrote:
> > > On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
> > >> From: Sumit Garg <sumit.garg@linaro.org>
> > >> Sent: Thursday, December 9, 2021 7:41 PM
> > > Yes. AFAICT, optee-os should allocate shared memory to communicate
> > > with tee-supplicant. So once the communication is done, the underlying
> > > shared memory should be freed. I can't think of any scenario where
> > > optee-os should keep hold-off shared memory indefinitely.
> >
> > I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
> > the config file [1] and the commit which introduced this config [2].
> >
> > [1] https://github.com/OP-TEE/optee_os/blob/3.15.0/mk/config.mk#L709
> > [2] https://github.com/OP-TEE/optee_os/commit/8887663248ad
>
> (snip)
>
> It's been a while since OP-TEE caches some shm buffers to prevent
> re-allocting them on and on.
> OP-TEE does so for 1 shm buffer per "tee threads" OP-TEE has provisioned.
> Each thread can cache a shm reference.
> Note that used RPCs from optee to linux/u-boot/ree do not require such
> message buffer (IMO).

I meant: "Note that **most of the** used RPCs from ..."

br,
etienne
