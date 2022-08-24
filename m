Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D70A5A025F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbiHXT4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiHXT4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:56:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD1279EDB;
        Wed, 24 Aug 2022 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661370984;
        bh=g0hUjN3cAbARSzcql+JH8MKMfgvdS0bGxKwU4LFSaFY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=g2Be9smpQen2fyJWj7264iksqJryLmLyJqgG7lW74Rs6xY21QcjcDTG+9shf88VTF
         8Sjb7ldgjjtDbE3i3Ku6Rtv6jWnZuQIxCM3SKigCv3i3WHs9mKrJlhtOP55EH81F8T
         bzIsImioBJmxTSXH51Y53EW2JPJnqJHlXX4cmGC0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.173.19]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQe5u-1olNYU1UWc-00NfEJ; Wed, 24
 Aug 2022 21:56:24 +0200
Message-ID: <b696b6cc-7cd4-4f62-6289-6f29c1e40214@gmx.de>
Date:   Wed, 24 Aug 2022 21:56:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] video: fbdev: omap: Remove unnecessary print function
 dev_err()
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220824114455.5167-1-jiapeng.chong@linux.alibaba.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220824114455.5167-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QE/g5FKVqH/BMcj4p2uGLEVLJe07d8CPvlc2J2oLPTXty9ncQ5H
 /ZPNU7F171RI5/CWxYTZX3phnBs7+zNnMbiiAxYBPbcyIa2iwOo+at/4Io1xPsnxSp+aYEN
 pIN3NHdVCS5xwnFu8pSYwpyoUqp7qSPzdcBVl/cMq5y7S7awpt1abiQLwhdmD8/RDB/b307
 /QOvs9ZKgKOiSfCRwU0rQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CqtS7ixjPPI=:3J3WaS2ZijgVbDNW2UfG+g
 HqkEp1Nces5eJrV+TMc4PW5I8M5KQ7kMRxfHY69PyYjVamiQsLZrNSWYN8GMKAofx7SZXcH3O
 hu2m0T9sgCmZKi+nOHJhnkvOWHvLq3z7jECYARDZ8OuGp82cDNp1TcyRZ0gL5dUxpeYvq1jws
 Jqajj9cgLk3jFv1DOZuxnJHjhntT8ltNxlOSs7cavSwRlU1PAcGqFLdn4ioC+dkTK+6MQeRmQ
 kKQsrnC8CE0llGDr2BBVTlaSB1fSohSiMi68/H6bUXTG7c+JfJAADMSTDyLkGsXc27r4xOr72
 Zda9wPDE5fKRX52AfSWMPG2twxvho4EKuwOBX5iSwtVog58lLTPa4Er2W1swyeZ7jDHqaCmSm
 9v9mKZGNFaW97uwTbCTvL885gtfMuDExceDoWMQcd8P+0GrgUqclY4GjYZP8PHA/duv4XnIFG
 icmIQ/Yg163jIGPDoYUKovh7uzVyKnGPsHC2NB00phlgfoM7/nzz8XVGrL1DEvJ0ZSZbnHOAy
 WCkxjX2Y15c84nb42x22q/E5MEfi0txfF7KkdsxQvx6s/y3hQTwrFnKzxsfYIly/2rAhB8yfJ
 Kg2aFXkWSi7/WmfLhgEx2hSU4d7yij11CdsgfyGKLTcgT06kTipkhDGCyMvgFOYq5MqVHDwNt
 OeNo8Fb9VS1lp3yBGYeK3yrof3iXHd8cgM+LNm91NXTTXrmTvoNUb8dSOk00KMFtbF0fNu3m2
 Cv0vSSRpfiXLTfXskaNdaLrD7FNqIlCE+PHXbJSWffP8LRRDdpx3/3x5KOrxlSgXJID4owTEe
 EWDzR6U/+Rb2g5lypBIkcjSjFGrbUByuPTk5bE5thHHZoji7w87Gmbq61MNPFugqtHc+MzAFu
 VKYZMlYm+1woPOfU6zKxmK10SyBakIewqoMElLorB7iUOvW03ujO+3UNh6alN49DaI8wfEiwa
 JVR9iUJ+HCmAB8sLhZrwaPrzfg1rc/S6AkrV5gPSQhW5lXz7EFLK3Yg/jgPn6TuhQkXEhuTpU
 QQNOk+ki+HPDnpW3wDc2pAiPzQGg73Ji+AgM8NO2ZIXlUcXNNt0bzvG0/bAOHLw53tPR45s+r
 vKz5erwtkfqzCJgw5G7+MLUG4tOl5OlqKAhPmVhPZPfjmHpNl57vIVX6g==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 13:44, Jiapeng Chong wrote:
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
>
> ./drivers/video/fbdev/omap/omapfb_main.c:1653:2-9: line 1653 is redundan=
t because platform_get_irq() already prints an error.
> ./drivers/video/fbdev/omap/omapfb_main.c:1646:2-9: line 1646 is redundan=
t because platform_get_irq() already prints an error.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D1957
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

applied.

Thanks!
Helge

> ---
>  drivers/video/fbdev/omap/omapfb_main.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbde=
v/omap/omapfb_main.c
> index fbb3af883d4d..17cda5765683 100644
> --- a/drivers/video/fbdev/omap/omapfb_main.c
> +++ b/drivers/video/fbdev/omap/omapfb_main.c
> @@ -1643,14 +1643,12 @@ static int omapfb_do_probe(struct platform_devic=
e *pdev,
>  	}
>  	fbdev->int_irq =3D platform_get_irq(pdev, 0);
>  	if (fbdev->int_irq < 0) {
> -		dev_err(&pdev->dev, "unable to get irq\n");
>  		r =3D ENXIO;
>  		goto cleanup;
>  	}
>
>  	fbdev->ext_irq =3D platform_get_irq(pdev, 1);
>  	if (fbdev->ext_irq < 0) {
> -		dev_err(&pdev->dev, "unable to get irq\n");
>  		r =3D ENXIO;
>  		goto cleanup;
>  	}

