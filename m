Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B78587689
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 07:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiHBFFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 01:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiHBFFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 01:05:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E8E65BF;
        Mon,  1 Aug 2022 22:04:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s11so4762950edd.13;
        Mon, 01 Aug 2022 22:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y82hfpg6T6DnHBl0eGr+nPNpL/5TjcB5vAqOZt23ee4=;
        b=cTCUmjrx0Eu58mdFSzfFDVH3IjrBV1VlqQcaOIquZeMs82x+1IxhEVa9V7ehFhIz8K
         4SfimlfHVSG9PSrEzbXp2v4BiOF+cCXAVHkfj5K3W0EG2J4DC3zT5Qqr+4P4v5Y6r0OI
         38cZdyfQDb3n7xT1pFMJnO22whKoVGwsjoWV+8JcRFtB4QK67aRL86yH5CYwxIDI2+eT
         uTRPKQ0+VziAdhYpFB85+zfi5SwZxYYcMqjq/R/miMD0L1PyZFFKyC7nTdqWEAQ78TY0
         DUb2875Yyi50e3l/RSt5mFhz9ch3dMLV/8rUdkP6DkSMHAvU37tbZ0qUiugqmb+74+nt
         M3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y82hfpg6T6DnHBl0eGr+nPNpL/5TjcB5vAqOZt23ee4=;
        b=Kl5zkxso/hBv4YvJhAXJ3lwUpg1G4t2mHbW/vjWtNrwl0ZLFYeYjfMqoE8GKihKu7F
         pwlW/CsqsS/bFKYBrdID27BQPLSlJfBZqpUizWiO2QgJcu9igOCa6DU78/aEmromQvxv
         lNOs6aNt4IwL8v0RdfSMS3E6pp8TLcDze+TAu3Lk8p0BE4XwIxgA54lWmdt5Z3IZDEy8
         qlSnSJe0W3bZE+BOaHLfubalv9Ckyle08im2p5aJMmJl9uA+Lq40b3wNdyVZsOs+puhC
         xoXLRL5ydokWcQlfvsT/LJHdh1DyS/SaBGOzh7v38q8HK0xF98CPQFx4JGKCoJH5+u2I
         N+8A==
X-Gm-Message-State: AJIora9KOPI5Or4D0tCzWc+guCUqKxKXK6/ohwZRIK93rLk22TrTLZ9v
        ZWJwHQdAKiJTqueb4rK7+6gRt8HHUDCe/dUhcqg=
X-Google-Smtp-Source: AGRyM1vEdWhU3Y1tZm3JHUujUTcNSEx040urz+bsEtVG7v5vNfBj3rpIAAS6UDPDvetxnRNI6x/Lc0NgdGcsFuBtBsM=
X-Received: by 2002:a05:6402:4024:b0:43d:2067:f068 with SMTP id
 d36-20020a056402402400b0043d2067f068mr18000013eda.258.1659416698232; Mon, 01
 Aug 2022 22:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <CANX2M5ZSuHONz-TPVdGcW3q_n6Z2DKLM6M8RfG+mORA9CCQRsQ@mail.gmail.com>
 <CAKXUXMxVCCRB2uaAN68LZv6Fwe7zAkUmwCmsqB6pE=z_=cztMg@mail.gmail.com>
 <CANX2M5b9PBp9i5v_akXshQqBFRT4dTHg+PR2pWpHPa5RBOEUTg@mail.gmail.com> <20220731095307.GA12211@1wt.eu>
In-Reply-To: <20220731095307.GA12211@1wt.eu>
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Mon, 1 Aug 2022 22:04:46 -0700
Message-ID: <CANX2M5YxE31gSU804jm6U4T6uTeCTjgk1gfHM+ockpjHnXfDrw@mail.gmail.com>
Subject: Re: INFO: task hung in __floppy_read_block_0
To:     Willy Tarreau <w@1wt.eu>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        fleischermarius@googlemail.com, its.priyanka.bose@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 2:53 AM Willy Tarreau <w@1wt.eu> wrote:
>
> Thus I'm a bit confused about what to look for. It's very likely that
> there are still bugs left in this driver, but trying to identify them
> and to validate a fix will be difficult if they cannot be reproduced.
> Maybe they only happen under emulation due to timing issues.
>
> As such, any hint about the exact setup and how long to wait to get
> the error would be much appreciated.

We can confirm that we were able to trigger the issue on the latest
5.19 (commit: 3d7cb6b04c3f3115719235cc6866b10326de34cd) with the
C-repro within a VM. We use this:
https://syzkaller.appspot.com/text?tag=KernelConfig&x=cd73026ceaed1402
 config to build the kernel. The issue triggers after around 143
seconds. For all the five times we tried, we were able to reproduce
the issue deterministically every time. Please let us know if you need
any other information.

-- 
Thanks and Regards,

Dipanjan
