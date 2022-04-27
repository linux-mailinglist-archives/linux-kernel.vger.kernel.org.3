Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50D2511AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiD0Nj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbiD0NjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:39:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB0A4B1D8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:35:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p6so1553221plf.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fevsh/rbhcrhbIfP+Wn54QROEdpICy0URFQLH/DB8j4=;
        b=mMsAae1YBt+0tG01LiX3Ugj6TWIm+3o9pXGpxewc+8RJ0Ju3Acfo77c+tVGAqt1xrb
         QRbH5mDCmedkuaMIJ7j4O/ZhCHHtLD4k8TsENcT/Ia2aKCiqJxc49MC5JAxe6XNx2xxX
         keXvJokiLRmolr+lzWOgisfhU/CyvzfguQ/e82YjsAL8kliEd61XCYJ+wVILtBEGp8AL
         qMhFeo0FPQ02WqTrXRryKRJ5sZwADG6rwFwy12OmUsHiP/sgrANj3P40wBR3+WU0NXmS
         VK/RUju2sc6dD7BNvrNj9tCCSRJe6GOHE+ND4aLXZWQ2cfvMz7sLuCltEYBR9URWhDSC
         arfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fevsh/rbhcrhbIfP+Wn54QROEdpICy0URFQLH/DB8j4=;
        b=YggRp1ivbUXBrMeIhzRuoREZGorTD2sfRKE10v7Jb5ymBgHOCyNqEHS+dqO1wqA0sE
         MOHdsNpeRg4eFq1vR3ISv3zI+QP/HtS8f2cKdc19KfIuWulTEcbp34O15CVlUdp3+lcK
         pfSsUp8b7esMr7u8Ims1yfV6iDzwBh6h3G7CAxeXKXVS6iCfVgfE+PU+Xbv+l9IMQdN0
         k1AUi6G1PsupYt5yLIsuMBwWbAiin+Q2fQWCnrDDDGQMKJ1+v+6PtCboRIhtCmP6qTUT
         wqsTtMGMZ1cTWjurJSU9vx6ZKUJhJcnDFmG7IEHObhKbxKEsY+cVgENkq+5GpZgR+z4j
         FThw==
X-Gm-Message-State: AOAM531HQXOhxdayW55hBRM+IEIIYlGrmFoLQpL7Jp4lxY18NrmkXDcC
        5JRqv9384oWy0rzIVYBhzxwDvVzeb+TO/A0VPsQwQA==
X-Google-Smtp-Source: ABdhPJzAUAhRdF8NeipUDVixjh55zQ2zwqQbhWs7tKcIIcGjNttOwv1qVwl6XYaD60KKN31mA4lVManPplIdiXyqnms=
X-Received: by 2002:a17:90b:1c10:b0:1d2:a7c4:3cf with SMTP id
 oc16-20020a17090b1c1000b001d2a7c403cfmr33259489pjb.100.1651066552080; Wed, 27
 Apr 2022 06:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220408134144.1532704-1-sudeep.holla@arm.com>
 <CAFA6WYNbwqNqK89ZCWWpAT5HCR59A+J873_5Odyjyb9qu00nsg@mail.gmail.com> <20220426144545.6qkn6iwayuwpvi7g@bogus>
In-Reply-To: <20220426144545.6qkn6iwayuwpvi7g@bogus>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 27 Apr 2022 19:05:38 +0530
Message-ID: <CAFA6WYMCTn-YQrA-GixYu6OG8Qr_xsZ7xuk4LfFA-1PHgus3RQ@mail.gmail.com>
Subject: Re: [PATCH] tee: Add Arm FF-A TEE driver
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Balint Dobszay <balint.dobszay@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 at 20:15, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Apr 22, 2022 at 12:29:26PM +0530, Sumit Garg wrote:
> > Hi Sudeep,
> >
> > On Fri, 8 Apr 2022 at 19:11, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > The Arm FF-A provides mechanism for Linux kernel and modules to
> > > communicate with the secure partitions. This is useful for some
> > > Trusted-OS driver that are kernel resident or modules.
> > >
> > > We would also like to avoid adding kernel drivers to communicate with
> > > each and every service provided by these secure partitions. In order to
> > > achieve the same with FF-A, it would be better to provide user-space
> > > interface to access the FF-A functionalities. TEE subsystem seems to be
> > > the best suited to meet those requirements without having to create a
> > > new solution custom to FF-A alone.
> >
> > Yeah, this interface sounds interesting.
> >
>
> Good to hear that.
>
> > >
> > > All FF-A partitions that user-space access can be associated with this
> > > new FF-A TEE driver and represented by a single TEE device. Though the
> > > various secure services are generally distributed across multiple secure
> > > partitions, all of these can be made accessible through this single FF-A
> > > TEE device.
> > >
> > > The minimal functionality needed by the user space application is
> > > implemented, namely:
> > >  - Query all partition IDs for a specific FF-A UUID
> > >  - Sending synchronous message to a partition
> > >  - Share/unshare buffer with the partition
> > >
> >
> > Are there any corresponding user-space applications/libraries
> > available to get hands-on with this interface?
> >
>
> Not sure if the changes to make use of this new interface is publicly
> available yet as these APIs are subject to change. I will see if something
> can be shared, but this is the project[2] I am using to test with relevant
> changes to use these TEE APIs.
>

AFAIR, there is a concept of trusted services being launched by OP-TEE
as well [1]. Is it the environment you are testing this interface
with?

[1] https://developer.trustedfirmware.org/w/trusted-services/op-tee-spmc/

> > > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > > Cc: Sumit Garg <sumit.garg@linaro.org>
> > > Co-developed-by: Balint Dobszay <balint.dobszay@arm.com>
> > > Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/tee/Kconfig                       |   1 +
> > >  drivers/tee/Makefile                      |   1 +
> > >  drivers/tee/arm_ffa_tee/Kconfig           |  15 +
> > >  drivers/tee/arm_ffa_tee/Makefile          |   6 +
> > >  drivers/tee/arm_ffa_tee/core.c            | 460 ++++++++++++++++++++++
> > >  drivers/tee/arm_ffa_tee/ffa_tee_private.h |  39 ++
> > >  drivers/tee/arm_ffa_tee/shm_pool.c        |  94 +++++
> > >  drivers/tee/arm_ffa_tee/ts_msg.c          | 133 +++++++
> > >  drivers/tee/arm_ffa_tee/ts_msg.h          |  75 ++++
> > >  include/uapi/linux/arm_ffa_tee.h          | 116 ++++++
> > >  include/uapi/linux/tee.h                  |   1 +
> > >  11 files changed, 941 insertions(+)
> > >  create mode 100644 drivers/tee/arm_ffa_tee/Kconfig
> > >  create mode 100644 drivers/tee/arm_ffa_tee/Makefile
> > >  create mode 100644 drivers/tee/arm_ffa_tee/core.c
> > >  create mode 100644 drivers/tee/arm_ffa_tee/ffa_tee_private.h
> > >  create mode 100644 drivers/tee/arm_ffa_tee/shm_pool.c
> > >  create mode 100644 drivers/tee/arm_ffa_tee/ts_msg.c
> > >  create mode 100644 drivers/tee/arm_ffa_tee/ts_msg.h
> > >  create mode 100644 include/uapi/linux/arm_ffa_tee.h
> > >
> > > Hi All,
> > >
> > > This is the initial version of FF-A TEE driver to get the feedback on the
> > > overall design/approach.
> > >
> > > Few TODOs I plan to do before we finalise:
> > > 1. Need to decouple the driver from few Trusted Service protocols currently
> > >    implemented. I have WIP, but couldn't get all the tests working(yet to
> > >    figure out whether the issue is in driver or tests themselves). Just
> > >    posting it as is to get initial feedback on other areas.
> >
> > Yes I would be in favor of this.
> >
>
> I am too, but Balint had some concerns which I need to discuss with him yet.
>
> > >
> > > 2. Based on the way FF-A spec changes/discussions, does it make sense to
> > >    make search based on UUID + partitionID instead of just partitionID or
> > >    leave that for userspace.
> >
> > IIUC, the UUID is the one identifying the trusted service. So what
> > purpose does partionID solves for user-space program?
> >
>
> Sorry for not giving complete picture here. In the context of FF-A and secure
> partitions, there were discussions to allow single partition implementing
> multiple services/protocols(each associated with UUID) and on a system with
> multiple SPs, 2 different SPs can be implementing same protocol/service.
> Sorry if I am missing something here or if that is impossible, this is just
> my understanding and hence I was check if UUID + something(vm_id as per FF-A
> spec) need to be used to identify which partition and service we would want to
> talk to.
>

Okay, I see this explanation coming from FF-A spec but currently FF-A
bus in the kernel only enumerates secure partitions via UUIDs only. I
guess that needs to change first.

-Sumit

> > >
> > > 3. While I definitely want to move the protocol specifics from the driver
> > >    (as mentioned in (1)), do we even try to remove adding UUID of each service
> > >    we would like to use this driver.
> >
> > Yes, we shouldn't hardcode any UUIDs for trusted services within the
> > driver (it isn't scalable) but rather during open sessions we should
> > search if a particular UUID is available on FF-A bus to communicate
> > with?
> >
>
> Yes it is not scalable and I am aware of that. I haven't explored the
> options to get rid of them yet. Thanks for the suggestion.
>
> > >    I haven't thought through that yet,
> > >    but the idea I have is to just have a blocked UUID list which can
> > >    contain UUID for OPTEE and other in-kernel users.
> > >    That may need changes in FF-A bus match but something to consider ?
> > >
> >
> > Currently in the case of OP-TEE we depend on an open session login
> > method where the particular trusted application decides whether a
> > particular login method is allowed or not, refer here [1] for more
> > details. I guess similar access control checks can be implemented by a
> > particular trusted service during an open session. This will allow us
> > to not maintain any allowed or blocked list.
> >
>
> Thanks for the details, I will explore and see how we can use something
> similar. I will ping you if I get stuck or need more info or need more
> discussion on that.
>
> --
> Regards,
> Sudeep
>
> [2] https://git.trustedfirmware.org/TS/trusted-services.git
>
