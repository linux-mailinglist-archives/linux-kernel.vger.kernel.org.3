Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CD64EFBEF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351838AbiDAVBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiDAVBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:01:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72C91AF7E8;
        Fri,  1 Apr 2022 13:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648846749;
        bh=+4FDH3jDm0x78qOeY61M+kge294s3SFknVU6afK69MA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Hd1lpUGjZ7jwljEUow9h4SKDoFSzJ1wtPiCgWL5tz5hQWwtaVnfzuY+j0Z4r5nNzo
         Z1khj26DjD/VXJPijRwZR6gYo/MdysbboSc9+wWW9TVdPV2xCWNLWfisBEkfVjo5fq
         u545cDAzT8ApW+EwbiCclaykkTJR8J6KAPIpHYdE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.191.12]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1nf5Ji0OVz-008ZHA; Fri, 01
 Apr 2022 22:59:09 +0200
Message-ID: <b096c0a8-105b-c3aa-06b2-27477d0a1458@gmx.de>
Date:   Fri, 1 Apr 2022 22:59:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Hvideo: fbdev: pm2fb: Fix a kernel-doc formatting issue
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1648802518-10571-1-git-send-email-baihaowen@meizu.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <1648802518-10571-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZUvw/bJxDfNzp9Y3FnAT5dYJs7GUQLcRezhs42lpAjGg2wID1BS
 vObkwaY4YmrNR65HiWhdhtaJ42eja8x2fP1jez9kGtFeTPeL/EAoxJAR0gHyTzk5RQaBn1o
 YYb+t0KrQ13q/m4JBZsekxNIoS3ggvojVzfbrE7hGw8PqurMOvDlpR+YwDKqXEKIF77GOlD
 6iFD5oAYt3P5D+dT5cCBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5JrymS3SQE4=:BVZVFCP71JAeQywdKgqRVL
 AN7YOK63YP0viu9ltl6NESjTxjUmEFeo9XtZBsXK5+JPQ/2vrVJLNf9tXR6NBWmNQMRoRjG1D
 z8DdMYWD2TH+1tY1Zvsz2dgKASNMK/onS1WFkKSfOSlbgS9ItVmt9JAr8pj2vIcIrd5q5tI1I
 koZNk5oVpT7AybZvcLobIvpZrNil0pUMnwM7BLyKTQ1LMYIKmJXekKkLeZUcOk+D/KKyvtdFa
 0cxi9KTAGayn3thPUatLsk4P+5jUpg+iXcwqNU8dQUYAyRR8b0VhhCqS3NWjuotZvcyFmpP7O
 mj3kwaPhE8z6sLbbvlSPCSH368EbXJRkVWljsBXte93n2WGbE/K5k02KdNZP6FAziW0HHY/L+
 UkZCykNU4ZBDrcVvY6t6Nfj7SZAlze0wTfvxYcgTH0TdyRnyub6q+WsU16+CrJ/tX7r6lfbLB
 KKdKdhHIzKr+fhDwSjQS0Y9xMQyG35xFln3oSEnZSu04vpZq1Cp58PtSG8IdeZFHmiqvKgOhj
 /lh4Yc/Z5J4OsquOYIYSiUv5iY55Zbiw/nviYDXT49vych49linKKQLaKm2s82sCLXYune1Pv
 txim+Q8ay0gFPIdy0qDTn59Yiz31eDzt/2nN5+E3A07iTQzLKHq4vM+a7F7E+xnsF6IaN1CGX
 lOpBxMPEvhR404wJBB3MuXC2xkmtTdBp3SuQwhW6kGsP5smBa2GJLWOnIdjoWah2JMIcmQ/R7
 pHhIqt2R+2zX/kjeHn0J1rFJxBAIhfepJC4BWj82Xjm7gfnvytIrjH9DAXXpc9JFM+z/R4qz6
 0xFCHdcluodz92W7WeZ7XA0xcUg92elXw0Y3kGHBVfbFfJwu7thw1fDL2NBoDu4mNaUOPixQ3
 RMBVUnH7fVipGplBoUIIiHrL275AzhEDswfKSYR5DVLqlmgi3LdcTUMIBuVaU9wYn73S/kdf2
 ohR/e7E7/S+NnMm5uzCi4xX7k7Sb+/wBBL4qbFEiHYKxy/UtvXDSnbGCnggZKpI2Hq4L6w0+r
 F1GHlPZC3H0fBtffAXL3lZ2lzSj2k42e1OHfL2lBFh1ZGAmxEx3hkToWS3smxgPVaN1VfFISF
 WxiRZ6ZGGNym1M=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 10:41, Haowen Bai wrote:
> This function had kernel-doc that not used a hash to separate
> the function name from the one line description.
>
> The warning was found by running scripts/kernel-doc, which is
> caused by using 'make W=3D1'.
>
> drivers/video/fbdev/pm2fb.c:1507: warning: This comment starts with '/**=
',
> but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc=
.rst
>  * Device initialisation
> drivers/video/fbdev/pm2fb.c:1714: warning: This comment starts with '/**=
',
> but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc=
.rst
>  * Device removal.
>
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

applied.
Thanks!

Helge


> ---
>  drivers/video/fbdev/pm2fb.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
> index c68725eebee3..d3be2c64f1c0 100644
> --- a/drivers/video/fbdev/pm2fb.c
> +++ b/drivers/video/fbdev/pm2fb.c
> @@ -1504,9 +1504,7 @@ static const struct fb_ops pm2fb_ops =3D {
>
>
>  /**
> - * Device initialisation
> - *
> - * Initialise and allocate resource for PCI device.
> + * pm2fb_probe - Initialise and allocate resource for PCI device.
>   *
>   * @pdev:	PCI device.
>   * @id:		PCI device ID.
> @@ -1711,9 +1709,7 @@ static int pm2fb_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>  }
>
>  /**
> - * Device removal.
> - *
> - * Release all device resources.
> + * pm2fb_remove - Release all device resources.
>   *
>   * @pdev:	PCI device to clean up.
>   */

