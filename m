Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E211570A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiGKTJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGKTJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:09:30 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA542A738
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:09:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u13so10269939lfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NNCQrtnWgXhweJyHBzmUMAvNZjug28FIArGHTvNylrU=;
        b=LytjKyLMp2QvtPgcfXhehbLH0cHqmVC7tGT5N0b9lPbyskD0GSK2so9hz7mo+MvsFP
         wkTXigM/IowhrRJf7f50XTXEUdLp6ySvTTCdzRnvuJuXfonICikuRbFCX1FPA2eI2pPZ
         9N2Eg0ZtNX3lY1bhP++ULq4ewWzt8Tz0XFq7R4CxIKPFbrq92mQKpgSKaUahI76/lePt
         9GT3RosG28W4H7Uuo8Ws4cdNm2fWkCIzqfihnaG27chA9tH4BiguWEf6u73qqS6lnu+8
         z25nBEiYU5nZr6oU82Tb2WzdM7suqOLwpWTTETig3PbHIXJVgtHkSopEERyjfFLGlgGU
         8FPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NNCQrtnWgXhweJyHBzmUMAvNZjug28FIArGHTvNylrU=;
        b=RVflLz/PTbh6JZmWxu4p+3iK4NB2PTozGcJWckffYQTAfFwOUnxBCoGJVGREZEKllt
         S9CqWS8mnBYb3dl1GNJqmmwseTRS39FC1X6PomMpYvVp87gXdvCuF+vrSo9BjlgEBCLD
         iONEGdnzV5w/Z5IDSVGWjj4gAnXL2jWPO1yqzUCT3t9hNjO28PQ9p+nStYLQAM7gnHNv
         i+MgOhvrAaHGcLQ8c2FjGbx8zm7O9hbKUripRhkT9nQ45KCkCPArFqED7nXrSdbW+xBH
         GzdqWt1QDpF8NvHnQ7UBJWekVO47/5Dg2TU+vBBsJvNzXrJIp+8UwfmENgWSJB/4ChxQ
         CWOA==
X-Gm-Message-State: AJIora+/zByEyIzY3NDMsugARfLSFnR30XPBJ2eUeOTqTkaNVOeBs8rK
        jhxw1KSo4TtlgPit1UUnKFw=
X-Google-Smtp-Source: AGRyM1vXa70epjhbuq8PxAzpww+wC+BQvclHtmuk7j1QBF+G+OQIMszM+RebFISkxQOoXfG9CGOQ6A==
X-Received: by 2002:a05:6512:3e08:b0:489:d3c3:e901 with SMTP id i8-20020a0565123e0800b00489d3c3e901mr6142805lfv.125.1657566567925;
        Mon, 11 Jul 2022 12:09:27 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id w6-20020a05651204c600b0047f9cfa914csm1706987lfq.18.2022.07.11.12.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 12:09:27 -0700 (PDT)
Date:   Mon, 11 Jul 2022 22:09:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v4 1/2] bus: bt1-apb: Don't print error on
 -EPROBE_DEFER
Message-ID: <20220711190925.pk4pt3kh5tgxd3mv@mobilestation>
References: <20220708194448.10700-1-Sergey.Semin@baikalelectronics.ru>
 <20220711155335.ltctlk66vylwcpcj@mobilestation>
 <CAK8P3a2H0+LDO18onn3F469t4ci=VbL+EZV83dct74Ce8tqfqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2H0+LDO18onn3F469t4ci=VbL+EZV83dct74Ce8tqfqg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 08:54:26PM +0200, Arnd Bergmann wrote:
> On Mon, Jul 11, 2022 at 5:53 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Hi Arnd, Philipp
> >
> > Since no comments have been posted for the patches lately and the @Philipp
> > notes have been fixed way on v2, could you please consider merge the
> > patchset in through any of your repos?
> 
> 

> Hi Sergey,
> 
> I already merged these into the arm/drivers tree on June 10,

Hi Arnd. Great! Thanks for accepting the patches.

> I suppose
> something went wrong with the notification email.

Alas I haven't got any notification. Spam folder has nothing too.

-Sergey

> 
>       Arnd
