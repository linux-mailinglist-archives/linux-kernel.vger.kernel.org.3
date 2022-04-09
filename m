Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E694FA6E7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 12:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbiDILAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiDILAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:00:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD41A5;
        Sat,  9 Apr 2022 03:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649501859;
        bh=UYBoSSsDtH5IH0r6e5nJyRD+MdMFVssXpzqnN/u3PiE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OdydCR0hC1oHEZygmfIQLLh+qLGViNdPHjMfowG070VE8bZkQ8VInYVrhfiUZNV7N
         tqI6g+a/KdyIBsOSnq89uzj4Idn1jusTWbs/2JD2ixznzPa3Fm3YzZZb+yQitCigIy
         3R1smifLAnp+zq85tZEj3ANzNSgcf0i8vnLAOgcQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.154.105] ([217.61.154.105]) by web-mail.gmx.net
 (3c-app-gmx-bap35.server.lan [172.19.172.105]) (via HTTP); Sat, 9 Apr 2022
 12:57:39 +0200
MIME-Version: 1.0
Message-ID: <trinity-b6d141b2-264a-4a57-9707-6a38a80cea16-1649501859874@3c-app-gmx-bap35>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Dan Johansen <strit@manjaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Aw: Re:  Re: [PATCH] arm64: dts: rockchip: Fix clocks for rk356x
 usb
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 9 Apr 2022 12:57:39 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <ba60121a-a120-b717-6a2f-7883685d17e6@manjaro.org>
References: <20220409075147.136187-1-linux@fw-web.de>
 <trinity-71c38625-1a00-47d7-8e23-4f33f25a997a-1649499268581@3c-app-gmx-bap35>
 <9183927.T7Z3S40VBb@phil>
 <trinity-8384790e-d2aa-4041-b4e9-aba1130d8577-1649500371045@3c-app-gmx-bap35>
 <ba60121a-a120-b717-6a2f-7883685d17e6@manjaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:dvLdFGxPf9CViU988yGoUmzNpwK2DRKqyr8wB+jCf000bTk3a7kd5Vtof3H1y2wyZx/a0
 HTfoVedNWQiVBEkXcKnHY15A6TlCD3t2It+hSjMF8IMFmNJEzscg/Kr0qgEfWQK/aPJxMRR4nrGu
 C0i319SYNcoXEm0AdDcrZRgZlAGVNQdOwmkW9var8G7BGWM9+2eUiS4+ykORQfBl/j51FButhmE9
 Bql4CGXB8vyfV5u1FN+jzI0MFmxObXIWYoUnwuyNNN4Xe6aSKVBN+9N/+4SDEeiyBHx+vGxi9bLB
 XE=
X-UI-Out-Filterresults: notjunk:1;V03:K0:qgBG/cmMMYM=:zUd6e7MLnWhr7kMouv+61f
 KJp9FN/REP5io8BVUPy8qAtAQW8MTumlJ/LxWMldbnoKp0xcd1Bt9K0FZ9hxgt3qdVA9WAiLC
 NDTtE5ikSIiOBpc/VPpFnZuAX467ZLFaFm2sqS/waTFfKjKQaWaQ6Tw/kbDYLufO3c1ET3cT4
 LgIdYeEAki0xpJp8OH4UDfAkGQZtjU8FUwX+xnjYmRsqC2xSfj5flYwCpOutHbXrYEOB9D4Mt
 hXYuDM2iIO1FWaAUBhv0gseKfru1Jwgkkzm3cOTqLgG3jD5zX3RZTj7S3ooMzQPSCUDBWWIIZ
 IDlMVJAXwbRyJd68pc/Rx/4sUM1X1gTEtq/B6Lakd/j70nvpoYf9UMur5PM03d9lOvJE05ReF
 a0exbZTaFXxYtgKSZSJLi8Ifa+s2tmV1KMe/iprSdmqJNlJJpsYgX0H3QOYGKXQ1km2QLie8X
 brBb80JiVBmHCk2j8hP4H85ndjiD4iUR2ImNLkq3BgAaMsoKsPotX26ukjI4qAhTleK4ziZEc
 VX21HC11EQjqclteuOx2/hdtfk5mDRqsAWqDitPI22RqCCaE+jnps8amypHABMhtUfTW7diCk
 APE3cDEC/TmMXKkScpTBweMMmzYTFWTW/5iJPuKThSxBAejyZHBhl5RlbxtmTxRQW/EzKTHt4
 pOt+IcvsS76V+nMX8O9vIDChUbmjiqshSsSUSsV4xbjNIGcVBVJqNcRGidH7BJJNl07WcOrCH
 aUF3gVFQjn0gcNSN7Xb0Bfdbr/4/Zr0Pd9NFqJblh+lpEPSHMM/CjWkUhjGt8gxl/PwI+tvKU
 SWuFxvD
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
> Gesendet: Samstag, 09. April 2022 um 12:40 Uhr
> Von: "Dan Johansen" <strit@manjaro.org>

> So the issue is only with usb 3 ports, not usb 2 ports?

my board has no standalone usb2-ports. usb2 is integrated into the usb3 ports (dual phy). here both were not working.

afaik rk3566 has standalone usb2 ports that may not be broken, but i have no such board for testing.

regards Frank
