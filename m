Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CACF55345E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351269AbiFUOTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351157AbiFUOTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:19:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF79140CD;
        Tue, 21 Jun 2022 07:19:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u12so27827569eja.8;
        Tue, 21 Jun 2022 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJcEJHgKYHK2ge32KOPbngb4fap2zLy6k+L71+xMqxs=;
        b=S3SY5NmCA/58ZV14ZhEQ/wsmZTHR1vM9olmXvgWLfT0N+hSpNza8wPf/Pc5y50FEF4
         EDXBGt66/jSQ/Uwq/Z5pcPpvA6N9YCO7mUJZs5aRd2SOPCGUWmV96e3FXXXVd5XuNXc+
         6N+TLGPYXdTL156LjoEgyN/q3914nRfv0Qa8wmc39U92r91M5UZjXm9JeWxhd7iOftB/
         yzxugvBNbgpL13YRFBYzDr501On8GR8THDL25DagnAx7VecOkKu2HV3EQljswXMzzlEU
         xjWkv+HQYIuf8KoiRGE3eLvmVSMoaee7kyt/b2FNunwoCTlmKKNMUgyxeMlJL7BW8rDe
         XnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJcEJHgKYHK2ge32KOPbngb4fap2zLy6k+L71+xMqxs=;
        b=CkVui3zD0L3/gMzAG9A2nPJvgbBbYJRaApyiqtTVCB7djnCdMXRSIKeB5kbQdno/bq
         wCjihgv3Is+7uMvl2rzzeWoKFGCh/jVdrLiao1YFKlpDCAkrQrK7gxGqJTbWPEEJXztv
         lXmcKZJxmb9Ojs54Sm7hu0jrwasbsLxwdheWxklqha1mnQrrBYwBIHejyiizA26vAako
         o5oqOB/eHOvMcTu3dt1MrzZn4xdA1r3e/KA61Yq3iuLndX5Igze3Y2EJCNq643M2P/wc
         slw36f7A2MK7AgPuHsl4q0HvDaHZ6SFbdxTr720mediYrRH64XO3YZ0NG0MrPrbWgQXb
         bW+g==
X-Gm-Message-State: AJIora992DIeGo3HQgpkHKBpVAHi5UUsSPCZi/Fr9203BLvdM14vJH6w
        KUZDHDPWlq+VFVrHRoc6k7f6QnxvkRK1QYCPhjo=
X-Google-Smtp-Source: AGRyM1s3MYxLF4VXs6SuFJ5MAGaGHHsLRrY1E8crXVHyz2Zq2/PF5L4GyO7D8f2YZyKvy5clBI40DZnclYMfnONR0pw=
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id
 dc1-20020a170906c7c100b00711d2e999d0mr26117746ejb.639.1655821180915; Tue, 21
 Jun 2022 07:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220621065502.28868-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220621065502.28868-1-jiangjian@cdjrlc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 16:19:04 +0200
Message-ID: <CAHp75VfKEu2T+DjCTEGnmME3OCX0Lezy4KxdXezALUH9+sg97g@mail.gmail.com>
Subject: Re: [PATCH] media: usb: gspca: aligned '*' each line
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Jun 21, 2022 at 9:01 AM Jiang Jian <jiangjian@cdjrlc.com> wrote:
>
> Consider "*" alignment in comments

In a similar way as I commented on your IIO contribution, do changes
for all similar patches.

-- 
With Best Regards,
Andy Shevchenko
