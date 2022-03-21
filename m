Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B954D4E26DC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347562AbiCUMtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbiCUMs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:48:57 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969599D4FC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:47:32 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id x9so10252792ilc.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bf6DH+83XG8UE1e9L+UJGLGGrgMRp+G3nSV6FxSx3p0=;
        b=2+nnDfCOIo+wapK4Fsw1/CMxpQHiYfchtA3lKnkkLW2n0e/mFe3/MnlTXlC/4/QBpl
         CizrzlKJaalZuGx+OynSaQbhjyaIuK/5DQbHzX86KCyI/zZ2cHnyEhQ31e2LDfvBskIY
         Z87nONGY6nFDgh0ubTjSnlTyd6X7tccWuzTGo+1HuZvdE099FCAo9IYRIQutdhdMFlgV
         0QaPjftSSRgPyHklRoXrPU2/+UPiv1yr8pKQt6/yGu4GLUUR7HSG5nWNPfjQP55/pPsW
         DT7Ml6mwARyrYwaI+uB5jIGZtN01eVD9G0QoV3fq4vunk5/o3XDhLMcof6Dxl0COVG9L
         Am5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bf6DH+83XG8UE1e9L+UJGLGGrgMRp+G3nSV6FxSx3p0=;
        b=7y8pVe9E+wU+V+5gWOj1yejSFaYUW+xv2EPV4MS4HXgvY40rPz9of6b75C9eoeI/a/
         HY6CE//56taGefjL8KLDSauoXqGSvpGN/t5OarM2an2uVfI7w1+xwxaYKqHXD5COdG3p
         H1lzZlcihD4SQ6X2oqCaUkV7D5uz2bYHU0G4JwKPmAHOIkOjiZGRY25JRtL+167bK1TP
         Tz4Zd51HoBsjnC1l+LJsQSGUIrzHxfWHtb+8VFPyKlBZVFhoIakXIx1yMFY1v2Xvx+o+
         09J4+HIg745D3K0S/ZRMzjLgF2SvOdUII6e9gmuSsQmrTGoAB4Inh61qdPQKL9UL2Wpf
         Q/FA==
X-Gm-Message-State: AOAM530ddT40TOy/PzjZYfLHR1jhus7VrCNb+nHlIcug2CM6s6nAMDcy
        c6IUx/jHmB1NOoh0yHbDYLtcwTtBVuKRQxiTUQeGTw==
X-Google-Smtp-Source: ABdhPJw4UQDKLYFVVqjgpcun+5W07OdW05mbWbRHUidXIal0bk0/wI/AZ1HJJmi4rMd46egCWYTbbm13zieLMkY31bg=
X-Received: by 2002:a05:6e02:20c5:b0:2c6:14c9:35dd with SMTP id
 5-20020a056e0220c500b002c614c935ddmr9894325ilq.129.1647866851755; Mon, 21 Mar
 2022 05:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220321121728.414839-1-robert.marko@sartura.hr> <Yjhyg5cNe5KZ6SOp@lunn.ch>
In-Reply-To: <Yjhyg5cNe5KZ6SOp@lunn.ch>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Mon, 21 Mar 2022 13:47:21 +0100
Message-ID: <CA+HBbNHw5v+R5WHPTvNj7oVtz0szsCm=JCXPFRtUf2GW7Qz35Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: uDPU: update partition table
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 1:41 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Mar 21, 2022 at 01:17:27PM +0100, Robert Marko wrote:
> > Partition currently called "uboot" does not only contain U-boot, but
> > rather it contains TF-A, U-boot and U-boot environment.
> >
> > So, to avoid accidentally deleting the U-boot environment which is
> > located at 0x180000 split the partition.
> >
> > "uboot" is not the correct name as you can't boot these boards with U-boot
> > only, TF-A must be present as well, so rename the "uboot" partition to
> > "firmware".
>
> Are there any ABI issues here? If these names are being used
> somewhere, you are potentially breaking the boot. At minimum, i would
> like to see something in the commit message which indicates you have
> considered this and why you don't expect it to be a problem.

Hi Andrew, this won't break booting as BootROM does not care about
partitions nor naming, it will just go to 0x0 of the NOR and boot it.

The same renaming had already been done:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/marvell?h=v5.17&id=a9d9bfcadfb43b856dbcf9419de75f7420d5a225

I can update the commit message if required.
Regards,
Robert

>
>            Andrew



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
