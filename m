Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311DB508202
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359789AbiDTH0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbiDTH0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:26:30 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5533B544;
        Wed, 20 Apr 2022 00:22:20 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id b128so731863vsc.13;
        Wed, 20 Apr 2022 00:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=an8Y6T4fVZE54BITp3FmoMlxViK/7pDo+RKZKhqsE+Y=;
        b=OkCMl/iijHw/NECX67njrTVj1iP1oKTqTBm7dAdANNVJjHD1uj6kF9+Oifdxx8raTI
         22oj0Oxz/qdELe5FwfUF8qrTTwtrE2CI0sEbIhz66sjvNtuYnAp/FTbsgaEvpF2tGh34
         7m90kgS3wPIHaLicCi79lVCmC7r0jDXpF/UgGoWTchTro+GcXeW31pjtvA0Btcw7whIZ
         GD8Vp4inyFdmwjZk3Yth16sj34vD+Mv8PovgyxcERHE3GZHAqsy2mUojz9kxy6cBtYXB
         QNEyh6KupbOi3wTf6A8mf3WeLXo4Q1q1Up5MT26hQoVc1L2nhsd2j9DCsfgYB+YVXKYY
         Up4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=an8Y6T4fVZE54BITp3FmoMlxViK/7pDo+RKZKhqsE+Y=;
        b=aAlZztRlXuSGr/T6ZBMyU+k2sOhENSg0I3GCNLBrQbCMWL15ABVI8fwgnxSO6oT531
         GorX6afi+LDp5FcQ64H4dtt7G5iACnK4bHMsfRH9njAHR0k/x9D2nnSNOwN6zu82WjUF
         9mCB8lRlNT3K/5oKSOVCdjGzuudQUxh93M8QcXRMdQ0E52/gJQuES/w1JMrSvpeLO5C0
         6Qou3aQW5/vCN06db/b20kBuQOw4VqD1r+HrB/PRxtsl4p1dVaOeFbEIPCD/yC6jeypc
         LicEtYI55RDpVEYpuIekWHmJK1vYpQ4IY04pb3xUDaOsVMhz05JrvEXp48MZohiKCFhV
         8c1w==
X-Gm-Message-State: AOAM531ljLxXjbT3nSfyVIet5jOU/a2NqonQrZB/S1o+Ty9YEj8gxHdl
        S6LUmrme5D+Nnb4tcZdYxWDY24cVYNzTSleYyXA=
X-Google-Smtp-Source: ABdhPJxdyv8gWP16mCgcl0q+o4/I/z8NVR+Nl82FcpaIpoaMjrk3l90ZPZrN5oo4rLffj8g/nQZhHacUxjBg71rI3k4=
X-Received: by 2002:a67:fd65:0:b0:32a:27e9:7c09 with SMTP id
 h5-20020a67fd65000000b0032a27e97c09mr5760412vsa.55.1650439338801; Wed, 20 Apr
 2022 00:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220415130005.85879-1-andrea.merello@gmail.com>
 <20220415130005.85879-13-andrea.merello@gmail.com> <20220415174808.3b81baa4@jic23-huawei>
In-Reply-To: <20220415174808.3b81baa4@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Wed, 20 Apr 2022 09:22:07 +0200
Message-ID: <CAN8YU5Pfc6t=3_Yj7v5PF36Ut=1_Vr86Li60z=+SENKRyn+iTw@mail.gmail.com>
Subject: Re: [v4 12/14] iio: imu: add BNO055 serdev driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno ven 15 apr 2022 alle ore 18:40 Jonathan Cameron
<jic23@kernel.org> ha scritto:
>
> On Fri, 15 Apr 2022 15:00:03 +0200
> Andrea Merello <andrea.merello@gmail.com> wrote:
>
> > From: Andrea Merello <andrea.merello@iit.it>
> >
> > This path adds a serdev driver for communicating to a BNO055 IMU via
> > serial bus, and it enables the BNO055 core driver to work in this
> > scenario.
> >
> > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> Hi Andrea
>
> A few really trivial things in here from me.

Few inline comments below; OK for all indeed.

> > +struct bno055_ser_priv {
> > +     struct serdev_device *serdev;
> > +     struct completion cmd_complete;
> > +     enum {
> > +             CMD_NONE,
> > +             CMD_READ,
> > +             CMD_WRITE,
> > +     } expect_response;
> > +     int expected_data_len;
> > +     u8 *response_buf;
> > +
> > +     /**
> > +      * enum cmd_status - represent the status of a command sent to the HW.
> > +      * @STATUS_CRIT: The command failed: the serial communication failed.
> > +      * @STATUS_OK:   The command executed successfully.
> > +      * @STATUS_FAIL: The command failed: HW responded with an error.
> > +      */
> > +     enum {
> > +             STATUS_CRIT = -1,
> > +             STATUS_OK = 0,
> > +             STATUS_FAIL = 1,
> > +     } cmd_status;
>
> Locks need documentation to say what scope they cover. In this case
> I think it is most but not quite all of this structure.

I admit my comments here are awkward: I've put a couple of comment
that indicate what doesn't need the lock.. I'll change to do the
reverse (comment on what need the lock)

> See comment on completion below.
>
> > +     struct mutex lock;
> > +
> > +     /* Only accessed in RX callback context. No lock needed. */
> > +     struct {
> > +             enum {
> > +                     RX_IDLE,
> > +                     RX_START,
> > +                     RX_DATA,
> > +             } state;
> > +             int databuf_count;
> > +             int expected_len;
> > +             int type;
> > +     } rx;
> > +
> > +     /* Never accessed in behalf of RX callback context. No lock needed */
> > +     bool cmd_stale;
> > +};
>
[...]

> > +             }
> > +             break;
> > +
> > +     case CMD_WRITE:
> > +             priv->cmd_status = status;
> > +             break;
> > +     }
> > +
> > +     priv->expect_response = CMD_NONE;
> > +     complete(&priv->cmd_complete);
>
> I argued with myself a bit on whether the complete() should be inside the lock
> or not - but then concluded it doesn't really matter and moving it out is
> probably premature optimisation... Maybe it's worth moving it out simply
> so that it's clear the lock isn't needed to protect it, or am I missing something?

It should make no real difference to move the complete() out of the lock.

I think I put it inside the lock because of the (paranoid, and
hopefully not really required - would mean we have been too strict
with completion timeout) reinit_completion(). On serdev rx handler
side (i.e. bno055_ser_handle_rx()) we clear expect_response and
complete(), on the other side (bno055_ser_send_cmd()) we set
expect_response and clear spurious completed state, before issuing the
command and waiting for outcome. This looks symmetric, but those two
shouldn't really race in practice.


> > +     mutex_unlock(&priv->lock);
> > +}
> > +
> > +/*
