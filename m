Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8679052BE18
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbiEROZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbiEROZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:25:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC29217D3AE;
        Wed, 18 May 2022 07:25:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j28so3201931eda.13;
        Wed, 18 May 2022 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stnxt/OKHtoX8kg/zkH5s6FWJGjmv3qLkoVDNDYez8s=;
        b=brki9cE8DnBCjFO8MmzqU5YEpQn9nkcdZ/0AwxoJ7dEX8xPBOgn8qTrH1hWb61SPNv
         /oxPigsFSARndEpKecwGIOuCjS4xb0qRXClQWMR0fPscEaFRXAap95j91u6/EgJsoHsH
         mWUZxdIuNF/yt02ZedrdPclyji8RxELs7OC+MfreC7JsKmHp15NpBhdMSeugc/f7qVMj
         xt45Uty/mjnw0exm5bMTHRMKY/qNA4MLS6Vxeen7hWkr+Ym7tqyEA645nQ9wn1AIENOd
         IpOEswFVe5cfz3cxUE8Wtw48BhsTIbrCC+z82Viu73IGk9ssgFudesJIE2Wigb0/haGJ
         4Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stnxt/OKHtoX8kg/zkH5s6FWJGjmv3qLkoVDNDYez8s=;
        b=AGK+ENn76XCfc9CFnFxp7BayojgIOxR/LHhY0Ou93SjCspwu2O24f4JjwyiE8pVCzG
         PO3PzxeaSy6TBZiwIz+HoXBd19A06OLhpKJTxo1ZY1qpU7vcZGlEEaYlBgiJgM1ehu7E
         p2XVyUrCyWDMdmDQH2QlKQOq0t2QcmKcPISgxQ2iF8HZj/whBfkIwQkKIpUu5RKTd1hy
         VY7jxiUtJwp6/+c07dDTzLMo+C8vZgMHTWOO/s/d0XO8AVGMjGxrmI4jvX/RGthModBB
         vEvdpceN5aG5pvYtm0L38hDfhR8sZ2ShpxCGQZayr7G+HXPxgClgkCrCXEfqCsPseOHx
         S9CA==
X-Gm-Message-State: AOAM530tR4gtSItoF3g+NnYiDq7aWrY4Az310yWvTCGbdW/dg9UyG6o8
        wUNAA7kSRe086GKvItSo5onpTi3LKSqJYUoUtRg=
X-Google-Smtp-Source: ABdhPJwH6lPMMsalu565/GTZAbgAdLomEaQg43Xm5pxBzuLuWLmOos5vvCCQHl3CECFtWMDT2PuB9gKSZhr6go14a2A=
X-Received: by 2002:a05:6402:3585:b0:427:ccd4:bec3 with SMTP id
 y5-20020a056402358500b00427ccd4bec3mr4590edc.2.1652883909505; Wed, 18 May
 2022 07:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220516115846.58328-1-max.oss.09@gmail.com> <20220516115846.58328-12-max.oss.09@gmail.com>
 <CAOMZO5DhTNDHLt_VZoWqD5dMBHq3rvJ+0j8-4xHHThyqheqcgQ@mail.gmail.com> <CAEHkU3Xtm9gk6xXr586M3pm4tPpFA-fGn+QyKXfF+Cqqa8VK8g@mail.gmail.com>
In-Reply-To: <CAEHkU3Xtm9gk6xXr586M3pm4tPpFA-fGn+QyKXfF+Cqqa8VK8g@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 May 2022 11:25:00 -0300
Message-ID: <CAOMZO5C+6Hoh8Sq4eZp+pp-0ktroz9MJw2-cD5eZEhBZGx+Wfw@mail.gmail.com>
Subject: Re: [PATCH v1 11/17] ARM: dts: imx6q-apalis: Add ov5640 mipi csi camera
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Max,

On Wed, May 18, 2022 at 11:21 AM Max Krummenacher <max.oss.09@gmail.com> wrote:

> In my (limited) testing I saw no issues that the camera would not come up.
> It takes 2 to 3 seconds until the pipeline is running but I noted no hickups.
> I did this with setting the resolution to 640x480 and 1920x1080 which
> probably would not relate to the LP-11 issue you mention.
>
> I.e. I set up the v4l2 pipeline and start capture to the screen as follows:

Just curious: which baseboard did you use to test the ov5640 camera?

Most likely there was an issue with the customer's baseboard that
prevented the camera capture to start.

Thanks
