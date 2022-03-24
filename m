Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB4D4E61F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349593AbiCXKt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242718AbiCXKtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:49:25 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC40AA1476;
        Thu, 24 Mar 2022 03:47:53 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id g24so5566865lja.7;
        Thu, 24 Mar 2022 03:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0J0phj6AMm9UiRKwAINuoHI0saZ8K5+RIjVP4BiGyXI=;
        b=W00tgU32BzYT8QLgeVcXl8t4GzABMp804DZT8qVYJWfBc/h/MwqASWjK/H7E55dO9S
         vGbTCT41p6wwmNueLXPdk+fSUc8udFZn/GnSGl9K9eHZn1Ms4i+g6FKFk9++rUP+PPI1
         /yS65327j6U+Q91NDdtof6r4Af5w8VvN3uXkRl7payULhsm3xi/wLV6TD/z/J5hn+uPB
         wfuHz+C42EwmTphgB0DHXZGKdxYhj0i4M4JuAvLCaUZsPc4SpLNLekyrXVDJLlSQ30ln
         10SneDCDPmi8igzRWPJcI2H9lr/7RAHeziu6Lc+N1M2ol8Zv/FmvZok5DcfYIBMeuAUx
         dGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0J0phj6AMm9UiRKwAINuoHI0saZ8K5+RIjVP4BiGyXI=;
        b=1vN34ONauab3igrWeEDRVG2GpY1aPLu7CPIcKEWYKG6AF3yYYatxD+hlStUDdg4Yeg
         2DHyTFvfI9fA2IhfYWk+uMGGlSCXJmJNZkCniRdBigdmH0Chon7J2mwj7+W06rmcL1+V
         4erBgU0UNRr/ujyt6rYXDsMF9QRronYGsxRC5Vop2sxvqLkFaIt/ax7uSDdwGaKRbkg2
         ZaK00xeSE9d8sjqfRKKqPk4sMCCK6xoAkuHzOJsCa/OLH45KAvMopEuJX6stKz5EkUCw
         3InP6sU15XuMYw07EHxg/m45F/GNe4pU5olyUWm7thNfp4DWOzrwHyBIivJziNOn6+ZM
         glag==
X-Gm-Message-State: AOAM533iZ1RF/KrYaqzzfLnlcZthYiJ5WkYRNCH5MGUO4mtGr1sZE6PY
        7y+GQla39IHTTg711K9L4jmA279R4Lwj8FOB6JU=
X-Google-Smtp-Source: ABdhPJxvmZtFy+J+bFzyel0LLaX1+RiiFwWo/r3cr+oq0EQA4ui/aadInIzdparY+LLIAu38KrEIPRgcoBCKyW02w/0=
X-Received: by 2002:a05:651c:b1e:b0:249:95d3:7832 with SMTP id
 b30-20020a05651c0b1e00b0024995d37832mr3671439ljr.426.1648118872009; Thu, 24
 Mar 2022 03:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <1647235924-15572-1-git-send-email-vincent.sunplus@gmail.com> <Yjth1mAtn/hX2Xvx@robh.at.kernel.org>
In-Reply-To: <Yjth1mAtn/hX2Xvx@robh.at.kernel.org>
From:   =?UTF-8?B?5pa96YyV6bS7?= <vincent.sunplus@gmail.com>
Date:   Thu, 24 Mar 2022 18:48:41 +0800
Message-ID: <CAPvp3RjPW1x-k4oA7QHHXm+QCNySMJLiR5TcqtCK-0geRtrd8A@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add USB HOST OHCI driver for Sunplus SP7021 SoC
To:     Rob Herring <robh@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
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

Rob Herring <robh@kernel.org> =E6=96=BC 2022=E5=B9=B43=E6=9C=8824=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=882:07=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Mar 14, 2022 at 01:32:02PM +0800, Vincent Shih wrote:
> > This is a patch series for USB HOST OHCI driver for Sunplus SP7021 SoC.
> >
> > Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
> > many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
> > etc.) into a single chip. It is designed for industrial control.
>
> Looks to me like the generic-ohci binding and driver should work for
> this?
>
The generic-ohci binding and driver did work for Sunplus SP7021.
And do I need to submit the patch for the ohci driver and binding doc
for Sunplus
SP7021 SoC ?

> Rob
