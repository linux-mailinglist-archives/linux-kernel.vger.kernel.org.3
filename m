Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA9C4CA535
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbiCBMuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241911AbiCBMuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:50:23 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C938E1A8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:49:39 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id u3so3128989ybh.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 04:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqR/m2IRMn5UYB2RI1OMZnWVlTPtF6bj7abYYxxYHtY=;
        b=td802ryprgjijWWVqctxqDgc7SbI4acmvjjmoxVek7PiNvmLMKjKuYu5CEgY2HVEZz
         +S7e7kai/YRh7lHPUPGXCWOyW9OGIa+VQyBmThE3mU2C6YQfS4+j49TeAm3zMn11dN88
         RzkdHlkD06yLpBXCw4Hef4nqcYwW+6i9uXvZ3tBlTkmWy6kwwFaF/z2nyPBd7ji55dEM
         rDF3BQsKKJk42FBPRCTmrM/27LCvZ8WG8H7eguocUUh2LjAikYTxfwLnBM64NTs4NsBU
         9LwAOyFpF9XKqDnHRBj628nkT5H74KvY7eH5CG71LSRCx0tHwY5irJYAExWBgxUT5H4L
         bmlg==
X-Gm-Message-State: AOAM531po1hWNu1kKV9fztlg5T4463qAN5D2b43NA5XKaW1VC6RunzH6
        3MA6BxaokAhp0fjSyhbaxFFcR51JZhx0jdi1yiE=
X-Google-Smtp-Source: ABdhPJwpgevi6vZ3WMCafC8Aa6KByLY3tXUOt1pWqB2ufMZMfKC35KBwZ/6ju3Q+4dPmU8/lsigQJD7XXXDEhtXr0/k=
X-Received: by 2002:a25:abb4:0:b0:625:5f2:5492 with SMTP id
 v49-20020a25abb4000000b0062505f25492mr29211292ybi.142.1646225378745; Wed, 02
 Mar 2022 04:49:38 -0800 (PST)
MIME-Version: 1.0
References: <202203021333.mMJpWPzx-lkp@intel.com> <5f13b914-e309-49ee-4f98-c81780c478b9@intel.com>
 <20220302103219.kvpfhc6qz42t3pvv@pengutronix.de>
In-Reply-To: <20220302103219.kvpfhc6qz42t3pvv@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 2 Mar 2022 21:49:27 +0900
Message-ID: <CAMZ6Rq+HR=j2mD97etTgSapOix96P=pK70bTr9HeJu2Mjkn3+g@mail.gmail.com>
Subject: Re: drivers/net/can/usb/etas_es58x/es58x_fd.c:174:8: warning:
 Uninitialized variable: rx_event_msg [uninitvar]
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kernel test robot <yujie.liu@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arunachalam Santhanam <Arunachalam.Santhanam@in.bosch.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 2 Mar 2022 at 19:32, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 02.03.2022 17:47:08, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   575115360652e9920cc56a028a286ebe9bf82694
> > commit: c664e2137a27680922d8aeb64fb10313416b254f can: etas_es58x: add support for the ETAS ES58X_FD CAN USB interfaces
> > date:   11 months ago
> > compiler: powerpc64-linux-gcc (GCC) 11.2.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <yujie.liu@intel.com>

Do we still need the tag for false positives (c.f. below)?
I am fine to add it, but maybe this will mess with your statistics?

> >
> > cppcheck possible warnings: (new ones prefixed by >>, may not be real problems)

Indeed, not a real problem. My wild guess is that cppcheck does
not recognize __stringify() as a pre-procesor macro. That would
not be the first time a static analyzer would fail on
it. checkpatch had the same issue which I fixed in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b844345fc2a9c46f8bb8cdb7408c766dfcdd83d

Or maybe cppcheck does not try to expand the macro and directly
yield a warning?

Overall, I think that GCC/Clang already does a good job at
finding usage of uninitialized variable. If cppcheck is less
mature in this aspect, I suggest to deactivate this particular
cppcheck rule and leave this job to GCC/Clang's -Wuninitialized.

> >    In file included from drivers/net/can/usb/etas_es58x/es58x_fd.c:
> > >> drivers/net/can/usb/etas_es58x/es58x_fd.c:174:8: warning: Uninitialized variable: rx_event_msg [uninitvar]
> >     ret = es58x_check_msg_len(es58x_dev->dev, *rx_event_msg, msg_len);
> >           ^
> >
> > vim +174 drivers/net/can/usb/etas_es58x/es58x_fd.c
> >
> > c664e2137a2768 Vincent Mailhol 2021-04-10  165
> > c664e2137a2768 Vincent Mailhol 2021-04-10  166  static int es58x_fd_rx_event_msg(struct net_device *netdev,
> > c664e2137a2768 Vincent Mailhol 2021-04-10  167                                 const struct es58x_fd_urb_cmd *es58x_fd_urb_cmd)
> > c664e2137a2768 Vincent Mailhol 2021-04-10  168  {
> > c664e2137a2768 Vincent Mailhol 2021-04-10  169        struct es58x_device *es58x_dev = es58x_priv(netdev)->es58x_dev;
> > c664e2137a2768 Vincent Mailhol 2021-04-10  170        u16 msg_len = get_unaligned_le16(&es58x_fd_urb_cmd->msg_len);
> > c664e2137a2768 Vincent Mailhol 2021-04-10 @171        const struct es58x_fd_rx_event_msg *rx_event_msg;
> > c664e2137a2768 Vincent Mailhol 2021-04-10  172        int ret;
> > c664e2137a2768 Vincent Mailhol 2021-04-10  173
> > c664e2137a2768 Vincent Mailhol 2021-04-10 @174        ret = es58x_check_msg_len(es58x_dev->dev, *rx_event_msg, msg_len);
> > c664e2137a2768 Vincent Mailhol 2021-04-10  175        if (ret)
> > c664e2137a2768 Vincent Mailhol 2021-04-10  176                return ret;
> > c664e2137a2768 Vincent Mailhol 2021-04-10  177
> > c664e2137a2768 Vincent Mailhol 2021-04-10  178        rx_event_msg = &es58x_fd_urb_cmd->rx_event_msg;
> > c664e2137a2768 Vincent Mailhol 2021-04-10  179
> > c664e2137a2768 Vincent Mailhol 2021-04-10  180        return es58x_rx_err_msg(netdev, rx_event_msg->error_code,
> > c664e2137a2768 Vincent Mailhol 2021-04-10  181                                rx_event_msg->event_code,
> > c664e2137a2768 Vincent Mailhol 2021-04-10  182                                get_unaligned_le64(&rx_event_msg->timestamp));
> > c664e2137a2768 Vincent Mailhol 2021-04-10  183  }
> > c664e2137a2768 Vincent Mailhol 2021-04-10  184
>
> Thanks for the report.
>
> This looks like a false positive to me, as es58x_check_msg_len() is not
> a function, but a macro:
>
> | #define es58x_check_msg_len(dev, msg, actual_len)                     \
> |       __es58x_check_msg_len(dev, __stringify(msg),                    \
> |                             actual_len, sizeof(msg))
>
> __es58x_check_msg_len() don't use "rx_event_msg" directly, but only a
> string representation of it and a "sizeof()".

Ack.

> I think it's possible to assign rx_event_msg before the
> es58x_check_msg_len().

Yes, I will do so. Even if this is a false positive, this pattern
can be misleading. e.g. during a code review, this does indeed
look incorrect at first glance.

Also, doing such change would be consistent with was is done in
other functions:
https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/etas_es58x/es58x_fd.c#L210

This not being a bug fix, is it fine to send it to net-next?
Or do you see a need to backport this?

> I think (hope?) the compiler will not optimize
> anything away. :)

With a function call and a return statement, the compiler would
need to be severely defective to try to optimize this away :)


> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
