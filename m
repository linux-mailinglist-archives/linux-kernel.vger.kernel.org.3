Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1949589ABD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbiHDLEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiHDLEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:04:52 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDF4220E4;
        Thu,  4 Aug 2022 04:04:51 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g5so8129050ybg.11;
        Thu, 04 Aug 2022 04:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gysVTSxQqMdkwoifqxUC3E1zXkQL4nIgjNjawW+8ZSQ=;
        b=LP+DYq6Kb8krzFXzvrmob5KAAW1sAgpXSHYvHzraItsSVyURm+FPTJWQnpuMuRiVav
         t4YrCxSvFs/BAC3JRrymqOzVAK3Ug1q8IC37mZfPycJh0PVMXmBDB4T32iumirikoZfB
         TEVIO4GxUso9IGxEVpsUne3WA+4enS1R/RrsKkT4raVXZxbiPWe/xQkBC24SzKZiME6S
         9y6oJ1RLXnkWN3qjKuf8jHWZi3eSeVAht45XpCGJDD4cOJRWT3VsPExCdXJqCUJm41Ds
         mkRXYcqhBqo06pxt2/YohPJo8xb7l35hjAsueegZ6gKrI24NhM61PrthBHSDK75mNvpL
         cGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gysVTSxQqMdkwoifqxUC3E1zXkQL4nIgjNjawW+8ZSQ=;
        b=DeRy8OH4mptYXu0ruynT74C6PBlC5zQpiTGXYpw3nbHq5kFqicjtL9ibVvlB5T4s9X
         YiRoNkO8lV5TrwDuGESPNC2MAocjVhirLFX640JdC8t04qRt20MpGef6DbENpALMduoD
         KwSdAa39AneI327RN6XmoqbtUDo9gzto4b/xsuzxOPZ+S78EovQqmzHxMlikFtDzc6kQ
         9JaRfxPfIPPGTny/4cucg2NZdG71xtlKMnwSD+FCQUvSMxtRMJfUp3OP9clCz5Yi3ooF
         DEopbec5st6w6W56C7CoRjRNWirFoMs4bS2xGbBGjGW2DwbUP7bNGDIVQeDOCK2hCdai
         nEyA==
X-Gm-Message-State: ACgBeo3YznIUVH5mPP3thkO7+yqKEhPnhbHqf8Rn0ILpAtXCygfNdj1r
        U1mc1p//olMyrS1egQZRdr+ZRmMtHyaSFhsrzAezoCTR
X-Google-Smtp-Source: AA6agR6qbd/l6X7jvynx2FtDmilcCBTJ2yQU5CKBw4tJTANfglDZqUp0W8rQHK2q6kF5nfGmrz5kkj+5WRnMkoubPtI=
X-Received: by 2002:a05:6902:701:b0:678:9bcc:e8c6 with SMTP id
 k1-20020a056902070100b006789bcce8c6mr993922ybt.120.1659611090080; Thu, 04 Aug
 2022 04:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220803090218.1313187-1-kkamagui@gmail.com> <CAGRyCJHX1X238TkiTaML3WJ+rdc1-m82_d3Ut4jCVDmuQ=cMOQ@mail.gmail.com>
 <CAHjaAcT2fzpfJ563Jx5n3eYyrZD0vHNLr713qTZ=trrDjPaU=A@mail.gmail.com> <CAGRyCJGTXWNPmF6ZgTJuxzy++rbpS_irJAhv7Jrhg0BMqqwA3w@mail.gmail.com>
In-Reply-To: <CAGRyCJGTXWNPmF6ZgTJuxzy++rbpS_irJAhv7Jrhg0BMqqwA3w@mail.gmail.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Thu, 4 Aug 2022 20:04:39 +0900
Message-ID: <CAHjaAcQXfNOdK7b=bx1qLwgqm5jg5N+PRbrn4OJjEYJSqwrvNw@mail.gmail.com>
Subject: Re: [PATCH] net: usb: cdc_mbim: adding Microsoft mobile broadband modem
To:     Daniele Palmas <dnlplm@gmail.com>
Cc:     Oliver Neukum <oliver@neukum.org>,
        David Miller <davem@davemloft.net>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniele,

On Thu, Aug 4, 2022 at 4:07 PM Daniele Palmas <dnlplm@gmail.com> wrote:
>
> Unfortunately I'm not aware of any specific place for that: I wrongly
> thought that you were involved in the development of the modem and you
> knew the chipset.

Thank you for thinking like that. However, I'm just a Linux lover and
a Microsoft Surface user.

> However, sometimes the name of the chipset is left in the firmware
> revision: you can try looking if there's any hint in the output of the
> device caps request. If it's a Qualcomm modem it should probably also
> support QMI-over-MBIM service, so maybe you can also try a few DMS
> requests (--dms-get-software-version, --dms-get-revision...).
>
> Sometimes also the USB descriptors can be useful.

According to your guides, I did get some useful information from my
Surface Go 3 modem. Finally, it was based on a Qualcomm chip, and
other Microsoft mobile broadband modems should be based on the
Qualcomm chip. The test results on my Surface Go 3 are below.

==== Start of test results ====
 $> lsusb
Bus 002 Device 004: ID 045e:09a5 Microsoft Corp. Surface

$> lsbusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/6p, 5000M
    |__ Port 1: Dev 5, If 0, Class=Hub, Driver=hub/4p, 5000M
        |__ Port 4: Dev 6, If 0, Class=Vendor Specific Class,
Driver=r8152, 5000M
    |__ Port 3: Dev 4, If 0, Class=Communications, Driver=cdc_mbim, 5000M
    |__ Port 3: Dev 4, If 1, Class=CDC Data, Driver=cdc_mbim, 5000M
    |__ Port 3: Dev 4, If 2, Class=Vendor Specific Class, Driver=, 5000M

$> qmicli --device=/dev/cdc-wdm3 --dms-get-manufacturer
[/dev/cdc-wdm3] Device manufacturer retrieved:
Manufacturer: 'QUALCOMM INCORPORATED'

$> qmicli --device=/dev/cdc-wdm3 --dms-get-revision
[/dev/cdc-wdm3] Device revision retrieved:
Revision: '2140-e88e4b-c8-00004.36  1  [May 17 2021 01:00:00]'

$> qmicli --device=/dev/cdc-wdm3 --dms-get-software-version
[/dev/cdc-wdm3] Software version: 655_GEN_PACK-1.362573.1.400078.2

$> qmicli --device=/dev/cdc-wdm3 --dms-get-band-capabilities
[/dev/cdc-wdm3] Device band capabilities retrieved:
Bands: 'wcdma-2100, wcdma-pcs-1900, wcdma-850-us, wcdma-800, wcdma-900'
LTE bands: '1, 2, 3, 4, 5, 7, 8, 12, 13, 14, 19, 20, 25, 26, 28, 29,
30, 38, 39, 40, 41'
LTE bands (extended): '1, 2, 3, 4, 5, 7, 8, 12, 13, 14, 19, 20, 25,
26, 28, 29, 30, 38, 39, 40, 41, 66'

$> qmicli --device=/dev/cdc-wdm3 --dms-get-capabilities
[/dev/cdc-wdm3] Device capabilities retrieved:
Max TX channel rate: '50000000'
Max RX channel rate: '100000000'
       Data Service: 'non-simultaneous-cs-ps'
                SIM: 'supported'
           Networks: 'umts, lte'
==== End of test results ====

Thank you for your help.

Best regards,
Seunghun

> Regards,
> Daniele
>
