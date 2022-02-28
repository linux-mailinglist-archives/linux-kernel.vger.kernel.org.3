Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3DF4C6E96
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiB1Nuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiB1Nus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:50:48 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4B45130C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:50:09 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r8so1110505ioj.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21fUVB6TefM/c8yrxJzAiD3KXehP2wSXZEAs7TxW/KY=;
        b=nSyYgrW7HeGcBTLlKTDK06+o3qEhHtwxUbd+v8vQI5ECADYYX+IZqiIawh7SP3IF/Z
         xActt/jSbw0m3wbOIFsNAnKFKqDMo0Z8pktmlCzw9tfFokzr66CHbcbj0bRHIZv1/f15
         zf1UyBut2iCjDc5cZKqW1Whkjb7BQ170/j54o1Ch8t/0r5GvfkC7bkAY1nGuL3a5Xqqx
         vAUcnwBGZb9GM88lsCxX2TJFAXQJm2m8EHITMD2+Te/ztnFBFYrNGNzDqPgehyupOPuS
         /4DsHREBuIo/Lq+zglhQ+5Nwj+UVn7Gwhec82EpZH4tVTiwhbY5rHjWt5MdCos6CPi1Q
         rESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21fUVB6TefM/c8yrxJzAiD3KXehP2wSXZEAs7TxW/KY=;
        b=xGKIROMZ0a9+liTenvrokGWYkujaLO0G+2Mw64PkEYDjJ8akxkdAvKkYM3xX5MnyUr
         E6d0QIEeIrviJJaS43M7ShYiem5wTW1MTaqnxMSo0v2nnlUD6sxoqNtpSHa/eZBnpLoU
         4egI8md/MCWr7ca8QNcDcZI7ykcSgpuNn6+94WnMn3UKjC06ZZ6DCs4Wck+s40aZE2iY
         T6vTbNRxrTEgrOuHmSvLDYqcBqLXD2MZ3Mug/Tich42hEDb1WedlMDfKftkSuSHfMXzH
         NTNpogs5f4L+iXyG0vEextUM8CcgHs6E4zdgo5eQj2K6AETtYP1hJsHi34Doo8KhWUTC
         e5lg==
X-Gm-Message-State: AOAM533uP513sWfpdu/Lm/UwDvqKWXXXrewlp9U/1KdscG/qrajaA2qZ
        eIEVq9QYSZhY5pNwbjhr38Kp3ljAGiFIHZTSZy44+3mIjdk=
X-Google-Smtp-Source: ABdhPJyLRAV+HX54WbTOI1iHvdGZyWmKDJa3Tou4qCEjmH/5eSQuxhAXhcTg/qLW06hIparb5Wf2Ew4MDJs9+7cOztY=
X-Received: by 2002:a05:6638:1117:b0:30d:1e9f:26ca with SMTP id
 n23-20020a056638111700b0030d1e9f26camr17376369jal.256.1646056208675; Mon, 28
 Feb 2022 05:50:08 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjtZG_0zjgVt0_0JDZgq=xO4LHYAbH764HTQJsjHTq-oQ@mail.gmail.com>
 <bd43bd47c8eaa4c22c1a1549cee66f7ef960b1fc.camel@med.uni-goettingen.de>
 <CAHk-=whFMxks63sfMQ-0_YO1GsTmoLfsO4ciMtoiCHNgaG_+GA@mail.gmail.com>
 <979af7ae9b7e8baf080ef6f8d42d48d7f5d2c5b4.camel@tugraz.at>
 <CANiq72k_PUBPVL1Fx4HLm_WO66RuSsi0oSsKRhssCYRNGbY84Q@mail.gmail.com> <dc52af7ebc044c94337e138f6e1ae807559b4825.camel@tugraz.at>
In-Reply-To: <dc52af7ebc044c94337e138f6e1ae807559b4825.camel@tugraz.at>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 28 Feb 2022 14:49:57 +0100
Message-ID: <CANiq72mcuXDRM-xMDPuL7uDLUfXDhARTBJJsVj4fnR15T1v=TA@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Martin Uecker <uecker@tugraz.at>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Feb 28, 2022 at 8:08 AM Martin Uecker <uecker@tugraz.at> wrote:
>
> Technically, this is true but not really in practice. If signed
> overflow would be defined to wrap, then code would start to
> rely on it and detecting it becomes useless because there are
> too many false positives.  In your own small controlled code
> base it could work though.

Either code is written with signed overflow in mind, or not. That is
what actually matters for detection, not whether it is UB in the
standard or not.

If a project starts relying on overflow wrapping, then they are taking
the same stance as projects that already rely on `-fwrapv`. That is
their choice, same as today.

But making it non-UB in the standard does not force a project to
consider it "not an error", which is what actually matters for being
able to use UBSan effectively or not.

In fact, if you are just concerned about detectability or `-fwrapv`
being the wrong default, there is still a way out without keeping it
UB: we could consider it an error (thus people is not encouraged to
rely on it), yet not UB. That is what Rust does, and why I suggested
the past exploring the move of some existing UB in C into an
"erroneous behavior, yet defined" area.

And, for the cherry on top, if users had a way to write exactly what
they mean (per operation or per type), then we can flag exactly the
cases that are not intentional, and users can still use unchecked
operations for performance sensitive code, etc.

Cheers,
Miguel
