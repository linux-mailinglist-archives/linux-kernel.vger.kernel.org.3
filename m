Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DEF5257FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 00:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359289AbiELWsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 18:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355938AbiELWsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 18:48:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C52E216076;
        Thu, 12 May 2022 15:48:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a5so5346909wrp.7;
        Thu, 12 May 2022 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LenX5q8clYj/Ritl2+sXqopbOv/wuxh9dSWVaj6WujY=;
        b=K2axMNOwMpgK//LGT46npsuQhEEFQdyVpmgp0EPnc+YVChAmxoWbCCFtJTpiRf1Des
         ggQ6No7G71U25KfTlioMqTT53c+ru78fkEba7Xaf/jHn8jiT5iZ0RrNcCQ3NNOa2AT87
         wJne6mV/vUoDDUEcxuR42s2N+aJ0p37Z5UvHOZ2JwlI6YYNG2xY4ahMUo8KCVMe1BZaM
         2jqciX1w8jscLaGEHkyGpIF4P6Bjk6dkOLXTv55VTnxKecEkq5FEoVfhYFAhWeFDhLi4
         waUknWOYMRNukEF+XH6dEvkLtUSjbwUJNZTJf1c25UcncA5hgcmgqz2x3aVkc+2/y5O/
         4qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LenX5q8clYj/Ritl2+sXqopbOv/wuxh9dSWVaj6WujY=;
        b=P6DYMOyTBeLPV3ZKgpXw0tGZQTExGkgsQUpM3PHzn5GaPZJ3YcvVQZ2e4zW3FiPp5v
         oCApMmOAz0AMtABNXVofU39M6j2sE76WS8glJ66U9ba6QSx5i1hRMn0S3WSVk3Uj8P84
         y2ZqjDZzTSAVRZWFYWawfMvQRw/jZow0npnS6C7f/Bp8v3cFJtukmre97xmrwWm5eNuW
         z4wBtIlrUWHuaaSbi8vwN0mGkN5ElEllLl48zTsLEnxpUts9Gd5Q+CBCUdlSyxC1h34f
         f0tRXwf/iN02DicrBW5ZKtOZE4sb8BEQ80XM1BjCrar89gRuw+y+cbpLBOqQqkMqYQdd
         2s3g==
X-Gm-Message-State: AOAM530bquvjMgxxeAZfQAPIJofkE8I3diihpjbMuxMtm1d6JtqGOjSN
        GNfUGLDzCkeJJwfq4tqVK+Y=
X-Google-Smtp-Source: ABdhPJzVNDAOBS5AnObtbFQKaZ69q0gtsrK2qu6wMJyizLQbQOH9HFyFUfCD4w99AzyH5dGDXIKTuw==
X-Received: by 2002:a5d:648b:0:b0:20c:5aec:1c06 with SMTP id o11-20020a5d648b000000b0020c5aec1c06mr1428353wri.525.1652395689697;
        Thu, 12 May 2022 15:48:09 -0700 (PDT)
Received: from penguin ([80.149.170.9])
        by smtp.gmail.com with ESMTPSA id q4-20020adf9dc4000000b0020c6b78eb5asm602278wre.68.2022.05.12.15.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 15:48:08 -0700 (PDT)
Date:   Fri, 13 May 2022 00:47:49 +0200
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Pablo Ceballos <pceballos@google.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH] HID: Driver for Google Hangouts Meet Speakermic
Message-ID: <Yn2OlQAa9I++N80B@penguin>
References: <20220405183953.2094007-1-pceballos@google.com>
 <nycvar.YFH.7.76.2204210947590.30217@cbobk.fhfr.pm>
 <CAKdAkRQ7yxFFGJg41UxptxapKiP4bmHsfw7dRNE+LPzs1PRk=A@mail.gmail.com>
 <nycvar.YFH.7.76.2205121252090.28985@cbobk.fhfr.pm>
 <CAO9JgFwA5ZhwOOY0cU3HpMOV69CTumQ50zEgU6SPNAF0zDbCGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9JgFwA5ZhwOOY0cU3HpMOV69CTumQ50zEgU6SPNAF0zDbCGg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 03:35:00PM -0700, Pablo Ceballos wrote:
> On Thu, May 12, 2022 at 3:53 AM Jiri Kosina <jikos@kernel.org> wrote:
> > On Thu, 12 May 2022, Dmitry Torokhov wrote:
> > > I am curious, could not this be achieved without a kernel driver by
> > > simply using udev to map this usage code to KEY_RESERVED?
> >
> > Hmm, good point, using KEY_RESERVED mapping to achieve the key being
> > actually ignored didn't immediately occur to me.
> >
> > Pablo, could you please verify that it behaves in the expected way, and
> > confirm that we could drop the 'driver' in favor of udev rule?
> 
> I think I've achieved the same result by adding the following to udev
> hwdb. Dmitry, is this what you had in mind, or is there a better way
> of doing this?
> 
> evdev:input:b0003v18D1p8001*
>  KEYBOARD_KEY_b002f=reserved

No, that is exactly what I had in mind, thank you. Please submit this
entry to upstream systemd/udev project (and we can cherry-pick it into
our udev as well).

In general I think we should try to avoid trivial "fixup" HID drivers if
it is possible. I also wondered if we could be supplying fixed-up HID
descriptors via request_firmware() for HID devices.

Thanks.

-- 
Dmitry
