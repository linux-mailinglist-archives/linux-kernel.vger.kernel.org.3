Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E6447CFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbhLVKKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239930AbhLVKKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:10:30 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457BCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 02:10:29 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id d10so5155901ybe.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 02:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WD93X3OyN4cNksS3WzdLzMZDmKT4youItA9pASTKcKc=;
        b=m2r0ykFzvLQzs5312dlDRpjSOXo0+WWDfp9ivUWagPUizhOp2QrzVdbfRgcovvdxM8
         ZaZn8hkXZ6y5dH1iS0wpmEMAE40rswqjTuRiF+D5IBlL3lOG7v9QiyG2elSeGKIXT6+M
         y2dvASo+6pcyzYY/L94UIjeyso1zXQNkZAEUo4Sr5/eUGsGCoX34eZjkpQJ8flhw76ss
         wZbzLFDKHJUhYw/kSnnERn3cOxXikyV6xj9IIVpCplVdSMYrgyESLOcxYNpgycpVbUGr
         LkXvMQnFLM7dodTFchFn7Ldi0OrqgKjBvCLue27bxv0W+M6W16mtbr2EPWtuzkk/0LLC
         ivsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WD93X3OyN4cNksS3WzdLzMZDmKT4youItA9pASTKcKc=;
        b=5vrgLwXTiRaFp4Us3INlyoUd+VZrUPz4eIm7bFV6CwEDoH6kfP4A0WfJ+H2AI9JR5R
         zuq5+FJo/B3Lg29tpCHQfmXlHCZhw+hBUa+ULonfX0vQ0/gMiSuvdGuh1v/fUmq4Gxzs
         KPgM5SehS3vXtleq6mQxAR7L19rDa3NQBzfXquYdIwkCfs+eMaotxBpLrN42ZhsFZy+G
         4CeSMp98u7HbzSUCXetRWbOB0R4xxCSfmyI1vAsof/R6pHJP2DYfMeQkvbBghAdekHFF
         2o6r5dC2VBz9TTpPhxL81a5O9oCfkp5MShmAaR2zp1PfFWSWNpcx2HlvUSMr9lqK0MhY
         PXOw==
X-Gm-Message-State: AOAM531pkxt7bGdsvrQw7BuQ0wqMP9jVuX+sPnBvj6IJDi+gtSNqPlnQ
        +QHnzPlNqlHBSCE5bDvQLCBV91LFIim/OAJRrJE=
X-Google-Smtp-Source: ABdhPJzgoS9gFYIDd1l8xex1e/RnV0TW7nPju+EzGvlG7g2PdPAi/NYAxac/XCO9lYL+vMSFYsBOaIdRsNxrQZKj1Qo=
X-Received: by 2002:a25:dfd1:: with SMTP id w200mr3227618ybg.359.1640167828349;
 Wed, 22 Dec 2021 02:10:28 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMym0M1UNuNGUVpFr2yUwOwjkZ_sQpCD0jC8YB+hs=j-bA@mail.gmail.com>
 <YcL20/7ddWTsdIuQ@kroah.com>
In-Reply-To: <YcL20/7ddWTsdIuQ@kroah.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 22 Dec 2021 11:10:17 +0100
Message-ID: <CAKXUXMyAa0RExrEXO1RVV+Lh-60RdO+4+pgE1PmEik9PRzypPQ@mail.gmail.com>
Subject: Re: Addition of config USB_HSIC_USB3613 soon?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:58 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 22, 2021 at 10:54:41AM +0100, Lukas Bulwahn wrote:
> > Dear Vaibhav, dear Johan, dear Alex, dear Greg,
> >
> > I have seen that the greybus arche driver has been under heavy
> > development in 2016 and 2017 with some further clean-up in 2019.
> >
> > However, so far, the config GREYBUS_ARCHE for this driver still
> > depends on the out-of-tree config USB_HSIC_USB3613, with a proper
> > exception made for compile testing (with COMPILE_TEST).
> >
> > Will this USB_HSIC_USB3613 config and driver still be added in the
> > mainline kernel in the near future, so that the config dependencies
> > are consistent in mainline?
>
> Do you have this hardware?  If so, we can add the driver, but given that
> I did not think the chip ever actually shipped, it didn't make much
> sense.
>
> > Or, are the further out-of-tree additions still maintained for the
> > current kernel and will stay out of tree? Is this arche driver not
> > needed anymore and can be dropped?
>
> Do you want to drop it as it is causing problems for you?  It's a good
> example driver for those wanting to create a greybus host controller
> driver so it's nice to have in the tree, unless you have a different one
> that should be merged instead?
>

Greg, I just stumbled over this code due to some janitorial workwith
./scripts/checkkconfigsymbols.py in the kernel repository and wondered
if it is worth keeping this in the kernel tree. I do not have the
hardware, nor do I need it and the driver code to it.

Of course, the repository is full of other dead code*... so, if you
know the current state of this driver, it just remains in staging, and
is actually a good example for educational purposes, we are all fine
:)

*... This is not a complaint, but my task description for me as kernel
janitor to submit clean-up patches for the various places of the dead
code.

Thanks for your quick response,

Lukas
