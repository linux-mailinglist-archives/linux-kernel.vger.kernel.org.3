Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80FD4B4BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbiBNKEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:04:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343946AbiBNJ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:59:23 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF584BE0;
        Mon, 14 Feb 2022 01:46:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u6so29409972lfc.3;
        Mon, 14 Feb 2022 01:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JX7AEWXC7VEIWY52t5bRvWiW+LKItzN9Fx20I+DVf7Q=;
        b=YsRhlT93NM4dfLaeDzZGwO6e3gwuFU7eMUUlBmryc8SBCwRenDL7W7byp1JbzHcitS
         o2k41NNVTSpvEnFlHj9WtfPIQYYzxrRh3ueitTIMJ1u0SOK8qBCVjHIG/3D4S6PnptmI
         GT8TSd0KTiqSumJRryLTqSp0yKtbN0M5N/y8TfHGqD7LZ3bXsvkdOQEZ5d9WDz2fxJYq
         X2jlfLaQJcP7aEKAh1WNmJF5lfJr36BNn81O0vh5Cxtl14jrL1xl9bwDiq51kqcSAM0Q
         BEShCQiU7QTjmJ2tB7TLqGPxbXzgT0vdi1d9K3CEwK7BPZpZLFKVov9K7MJ0j9q48zbf
         iiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JX7AEWXC7VEIWY52t5bRvWiW+LKItzN9Fx20I+DVf7Q=;
        b=jTvOUcIj5NT4FsI/iQ/Uz59IPJ6KDQjwN8l99Uoc8lT9g8jwYWkaME4iKlU4ryj3sy
         McUogGOEqiEO/mG3w70y12e4P6fh9ColC+/YhZ56TrMcFtZbyUpVAQrAdz4EbqTi+Ptz
         H7ruIZEm4E+wmN3gEOSrqD3fXcQ7cMPCbrh3CpQPIARftQCkVkb/GC7eigza0LiGnwkE
         bEPeV1InqrfdMkgu5GmVzfsz1Rgb4hjubgoVEze9W0cG92c4vDWH0e4bi88ukTnXh/hs
         qLx1eNl4veFadPxlWhjbUiLUpZWJEscgpL9vxWQ+ybIIXAR1A7QWvBE+3CNGSBJ2v6As
         5yRA==
X-Gm-Message-State: AOAM530Xp4D5rOx0FwhwrYkhgjn4I74yKQOMF+cv0GHdgp49R8/B8pbQ
        Q1S7OHsSkEHGsePVVCcsG6HdwvhgWjPyVJisqGc=
X-Google-Smtp-Source: ABdhPJwB0ChPiWBxcQQTBEF/ccpfXCeN7CcbUvlTAUZiXeIJ2StOJ+hk1DsIM7X47AewXPzXDEWa/IldeHH3bjzC4e8=
X-Received: by 2002:a05:6512:130f:: with SMTP id x15mr5145474lfu.651.1644832001032;
 Mon, 14 Feb 2022 01:46:41 -0800 (PST)
MIME-Version: 1.0
References: <1644827562-17244-1-git-send-email-vincent.sunplus@gmail.com>
 <1644827562-17244-2-git-send-email-vincent.sunplus@gmail.com>
 <YgoVBv/z1uCsR1Y0@kroah.com> <CAPvp3Rhtb-g1A5FG6_1irzX2fG-VACU3T4tST1Xo99cnnL==MQ@mail.gmail.com>
 <Ygodd+TFQGnhki6A@kroah.com>
In-Reply-To: <Ygodd+TFQGnhki6A@kroah.com>
From:   =?UTF-8?B?5pa96YyV6bS7?= <vincent.sunplus@gmail.com>
Date:   Mon, 14 Feb 2022 17:48:20 +0800
Message-ID: <CAPvp3RiPVkonTtAdTcLqQuPggg6zw8yNEPf-mR0+1bbtSsdtEg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] usb: host: ehci-sunplus: Add driver for ehci in
 Sunplus SP7021
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2022=E5=B9=B42=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Feb 14, 2022 at 05:03:00PM +0800, =E6=96=BD=E9=8C=95=E9=B4=BB wro=
te:
> > Hi, Greg
> >     About this issue, my colleague Hammer Hsieh has explained it to
> > you recently in the mail of "[PATCH v7 2/2] serial: sunplus-uart: Add
> > Sunplus
> > SoC UART Driver". The ehci driver and uart one are in the same Sunplus =
Soc.
>
> I do not know what you are referring to, sorry.  Remember we get
> thousands of emails a week.
>
> Please be explicit and make the code work properly for each patch you
> submit.
>
> thanks,
>
> greg k-h

Hi, Greg
    About data incoherence issue between memory bus and peripheral bus.
In case of AXI bus, use non-posted write can avoid data incoherence issue.
    What if in case of post write:
Send a specific command after last write command. SDCTRL identify specific
command, means previous write command done. Then send the interrupt
signal to interrupt controller. And then interrupt controller sends done si=
gnal
to Master. Master receives done signal, means write command done. Then
issue a interrupt or proceed next write command.
    Thanks for your review.
