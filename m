Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537594DC089
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiCQH6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiCQH6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:58:19 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683C0DFD4C;
        Thu, 17 Mar 2022 00:57:01 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id x9so3198167ilc.3;
        Thu, 17 Mar 2022 00:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXyJmHq7iLaeDtjBuE2bMSQckYyVUnvPP7QsddlU6cw=;
        b=I7qeSxBnNiQedHtWDJMPUSwnkCzO9FhEoPVqgDOOUsBXXTJ8srnOVzRoHazIk/Y/mn
         2R1rTH8MNIA8qM/SGOOOHom4mrdzIdm/0/u/oYxBAmz7Sr9FGDXTifsv7IrBUgN0n1Yv
         UU7iguhQf7y2rgcblQEoVugZk4SsysoSliiDOnhdOGynNdg8vGSmwKPLD6z+HkjLOPvf
         EXvtY4zDP0SG48FCBkGdgMn1IbkcO4gUDWJEYQ8kSG3EiQhcXOWJ43T/8uGiNmQvxDJx
         oznX2d55V10ilIzjW6Z7CsV/ywCBGXhz4uxzbIznGBlepRJ4L8ySiCIZKIZkBHHBxIrn
         kBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXyJmHq7iLaeDtjBuE2bMSQckYyVUnvPP7QsddlU6cw=;
        b=IVMFDLzaG384aN+JbT6xuWH1nsqFq6n3MA5lNDl1TuHWh00Cxx30rNaf3MpDTitMAW
         VnhIAyTn/wpB3+fXcumMjM0VKEl3Iq9tAgRxjbV4elhMLFOCpZes+Tq8MzA9sGc/SGQ3
         00A4Ux+Zi7Bzu/aXsZR3YcUkChAPztjfc2MC7/UwdB21nzDZOx3jwi6f+5BjsptFxDsd
         kxlWm/oRcKAsq/KrXqXrUi5O7LfmPCXzAJ7K7ca5+tg9DrC6jY5KSuXtVW+NEFZbWfe9
         9HMtrwy19TDaAZebpBUK+V3/6NqJBi4Z14B1Ok7Rj+2sXS3nQvglVPoGzitiFifM/5BF
         kQRA==
X-Gm-Message-State: AOAM530mTSLQ0f791KT54dZ27sMFZaOqiuODk+Q5d7Oht6sDb0dir37c
        qEO/gxDxJCP5cV5nJT+Ryeb2E3rjb8UMyQ7V/es=
X-Google-Smtp-Source: ABdhPJyvlvEOLrYs1lDOa4PWJkYjXIN3UZltguxmxdZuZ/asrjDuef1XlW0OGDd8Sb7NNWUrz5s7O0/o8wl8SWe+MXE=
X-Received: by 2002:a05:6e02:b24:b0:2be:88f8:c4ed with SMTP id
 e4-20020a056e020b2400b002be88f8c4edmr1496965ilu.72.1647503820803; Thu, 17 Mar
 2022 00:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220207014418.GA28724@kernel.org>
In-Reply-To: <20220207014418.GA28724@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 17 Mar 2022 08:56:49 +0100
Message-ID: <CANiq72k6upeMaQz0JJHSR8qFLWWnw97qt2t+7S3qq-N9T8GSag@mail.gmail.com>
Subject: Re: [PATCH] docs: add SVG version of Linux logo
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Garrett LeSage <garrett@lesage.us>,
        IFo Hancroft <contact@ifohancroft.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Jonathan, linux-doc,

On Wed, Feb 9, 2022 at 6:32 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> This is a vector re-illustration by Garrett LeSage of the original
> logo by Larry Ewing (plus cleanups by IFo Hancroft). Garrett gave
> me (privately) his permission to use it for this purpose. The
> acknowledgement requirement has been made mandatory here to match
> the wording of the existing one.

Pinging about this one. By the way, now that Garrett and IFo both gave
their permission to use the same license as in the kernel tree, we may
want to remove the `cc:license` fields inside the file to avoid
confusion.

Cheers,
Miguel
