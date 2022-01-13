Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6EE48DE8E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 21:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiAMUBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 15:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiAMUBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 15:01:48 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08CBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:01:47 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u21so27172824edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKKBvExIdXR4NmexUNKYFi4XGwRsnmajoIJ3WHiHemw=;
        b=P6MjH8VbEXKaa9Xe+OrKdRO/17t1xnavCQ1iFuARciPT4LOiqcts2TRquGSo5R4hUs
         1HKly7dXYmo1IcgU9eZ4RmPEjLSqFF5kdyQWJnjz5/QihSZl6AGE+jS9VQ77dkxe0Wlq
         0d5L0I0bVSUC+9dy1Z/pSnd9aqqpJeumK3DHxYZz4Bt7jIJWGJuAZdFZ01sJY8HxXVUo
         H6b/dbQhLkC+rjVhwONRlsm3b5c5Qqt0xdGix+lt5LFdDdhVyg85xvsD501bTueWz05l
         Lt99uTyImY/wlqSlKOJswzL3ZLzS0SJI7r6mjE5yB3GbQqi0HzmXON/MMPGHvLZ6JHTa
         WVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKKBvExIdXR4NmexUNKYFi4XGwRsnmajoIJ3WHiHemw=;
        b=jzY8jJwD5AomNVjLNzzbf7eWIyKHHS6YQJWxkGl48n/A5sgUfIvu9dgQD2bj/Z0qDM
         aBLLDnGNnOQ922T14z53+dnG6DSM+cNZBh2uOv4/fKL45ivmqJOMIHfvsmDF8G4aBlTU
         PMhHTlnosxE6DR7VWuPTfg3GaGLkAQ+eyFsO0uoVbavVK9CkSggnFQzGfkRuA8o8qYWm
         LNvPLjgE5OEFqha6pI4dHhJpcuy0h3hKNQ7RTZjKn6Tbxx/LWs60GIMxuMm2N3Ox7Zpc
         GMtl9A9HfSX97rr92Yo24K0XXCDCAy9ZkP1UDd41DuzA6Vo0KY4TjzuQdMJgYJVY31j6
         NMsw==
X-Gm-Message-State: AOAM530Yhp5zOh6/X96gwGBdF7Nj6VHVGAuld4ik6PwxCSIZ793aGa97
        biv6UhTyPWSrfnsVGVG2QIhmRVG9xkxVplQMgSA=
X-Google-Smtp-Source: ABdhPJwslh+6ha9GsyWg4OE9COVsBHcsGl2nt9B4vD1RxEyfjpYwfsR9lnhbTXuKZfXaIgsCtfoSmB0myB659ctydp4=
X-Received: by 2002:a05:6402:350f:: with SMTP id b15mr5636003edd.77.1642104106220;
 Thu, 13 Jan 2022 12:01:46 -0800 (PST)
MIME-Version: 1.0
References: <OS0PR01MB59221ED76B74231F5836D5FB86539@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59221ED76B74231F5836D5FB86539@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 13 Jan 2022 17:01:34 -0300
Message-ID: <CAOMZO5DJiCb5bJN5_nxnYa-FsK-u7QtFghWNzs_-udE42XPDeA@mail.gmail.com>
Subject: Re: dw_hdmi is showing wrong colour after commit 7cd70656d1285b79("drm/bridge:
 display-connector: implement bus fmts callbacks")
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On Thu, Jan 13, 2022 at 2:45 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi All,
>
> RZ/G2{H, M, N} SoC has dw_hdmi IP and it was working ok(colour) till the commit
> 7cd70656d1285b79("drm/bridge: display-connector: implement bus fmts callbacks").
>
> After this patch, the screen becomes greenish(may be it is setting it into YUV format??).
>
> By checking the code, previously it used to call get_input_fmt callback and set colour as RGB24.
>
> After this commit, it calls get_output_fmt_callbck and returns 3 outputformats(YUV16, YUV24 and RGB24)
> And get_input_fmt callback, I see the outputformat as YUV16 instead of RGB24.
>
> Not sure, I am the only one seeing this issue with dw_HDMI driver.

I have tested linux-next 20220112 on a imx6q-sabresd board, which shows:

dwhdmi-imx 120000.hdmi: Detected HDMI TX controller v1.30a with HDCP
(DWC HDMI 3D TX PHY)

The colors are shown correctly here.
