Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C515ABAFE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 01:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiIBXEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 19:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIBXED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 19:04:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D60E8316;
        Fri,  2 Sep 2022 16:03:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bq23so5272168lfb.7;
        Fri, 02 Sep 2022 16:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JwcThZfvgGkXvH/oN7CgEbjQX6xMEv9IlnB4AnwDp1w=;
        b=XEhCtacuL7sz7x1zd9T562MxiUsvaaPJftDtplKq/7UYHrsmUE1ydgFEdQ2h/ClfW6
         6ccSu7C0ZTLcWvtQo/nBHx5c2YTxVdDWQOypehP/JKixamj5xUQl8ETbVLcSsg5Xa337
         aiW/EN4V5J8MBXoMbBG/MJDdWDOJT3Q/wimWcbt0LbUHL8FE+ubtkGUNust0RCPVRVup
         ZQoCRu+A3EzS/CdQdgTCwt7pJcSYUTAzzISsQUKCmiyPuDtf2fbTR9asU3kolCxp7yMi
         lCx2ZnBC71Vlyj25Q1NzMdznlfj4dR4C14lsY1Qt0kH471GIzTbhUUEYXaTjjjNBgfmQ
         lfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JwcThZfvgGkXvH/oN7CgEbjQX6xMEv9IlnB4AnwDp1w=;
        b=mtjzUjzUV+hZqCwx9n9v7hJtKs9NruSmezhg8fctErfS7wis6Vreg20VSI5xOheM1l
         0iY3dAeo5irdGgDjreKg5bQy/LglCeEijK04tZeGfHFv+MceJqpLePYX1m6wVCIwNnJ7
         Yrqq449lkRUCpu2xh95XSP0qx3Eyk4SYwcnZt6ZTVbzaA3bgyXGeRoVe0Wzw1eNZXzLE
         IXuMh8QWEv28QMZ6nKit2Z/lzVUlJLYKsT42pet9lQlfr4cChQvlLGphcp5e5pLNwE8V
         FTbHCL/FIEEjZvZVq425vQKMR5P9i/TYDh/Ava5RHTG1Xr/vUbA1cewQCVwz6uChNCb3
         r4dw==
X-Gm-Message-State: ACgBeo1fI5Os7BNyZbLJlWEzNeT6dVHT+lWja0Lem7LeGkdCm//9CL1N
        qj3AxJV91nZo1JYl8EzUHiY=
X-Google-Smtp-Source: AA6agR7Z2FehWmCHWUOj9dB/4A7HYfLxZaSgOsEhd90WFW8vXX1ICBOJkci0w7dn5wDyrL+c7mqpkA==
X-Received: by 2002:a05:6512:32a9:b0:494:a994:6fac with SMTP id q9-20020a05651232a900b00494a9946facmr1444344lfe.5.1662159837478;
        Fri, 02 Sep 2022 16:03:57 -0700 (PDT)
Received: from mobilestation ([83.220.236.124])
        by smtp.gmail.com with ESMTPSA id q22-20020a056512211600b004947303691dsm384418lfr.95.2022.09.02.16.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 16:03:56 -0700 (PDT)
Date:   Sat, 3 Sep 2022 02:03:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>
Subject: Re: [PATCH 00/11] Add support for enhanced SPI for Designware SPI
 controllers
Message-ID: <20220902230353.mscyeklhamzpg5s7@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220826180327.yazfoydjiyygd7qf@mobilestation>
 <CAHyZL-cmyRprNmr_DtUQaZFXJtcV-6r-UOksFJeMz=XgDhnMNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHyZL-cmyRprNmr_DtUQaZFXJtcV-6r-UOksFJeMz=XgDhnMNw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:48:35AM +0100, Sudip Mukherjee wrote:
> On Fri, Aug 26, 2022 at 7:03 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Hello Sudip
> >
> > On Tue, Aug 02, 2022 at 06:57:44PM +0100, Sudip Mukherjee wrote:
> > > Some Synopsys SSI controllers support enhanced SPI which includes
> > > Dual mode, Quad mode and Octal mode. DWC_ssi includes clock stretching
> > > feature in enhanced SPI modes which can be used to prevent FIFO underflow
> > > and overflow conditions while transmitting or receiving the data respectively.
> > > This is only tested on controller version 1.03a.
> >
> 
> <snip>
> 
> >
> > I've deliberately collected all the generic comments here so you'd be
> > aware of the required changes in total, because I very much doubt all
> > of them could be fixed at once via a single patchset iteration. But as
> > soon as all of them are fixed we'll get a very nice and neat solution
> > for the eSPI feature.
> >
> 

> Thanks a lot for the summary here Sergey. I am sure I will have a few
> questions for you after I start with the changes.

Ok. Don't hesitate to ask.

-Sergey

> 
> -- 
> Regards
> Sudip
