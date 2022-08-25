Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61475A1149
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbiHYM7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiHYM7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:59:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8516780359;
        Thu, 25 Aug 2022 05:59:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pm13so11354177pjb.5;
        Thu, 25 Aug 2022 05:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=fuV1/GtLLcy/AQjBr18YmMzftopLTKIBrNKhv7I2M5c=;
        b=YAqmG4HvxJr7GnXVclo3JMlq5xBaR4Xm9rsuri+6mx80quxwBoID0NqYnUu7NEV14r
         83jeez4vRYhP4AcSHIFem2aBZgV/ISciwlvMiexXtM8i5kVeZZMFDAOyzYTYJJL+y6vS
         miDjo2yFLYFUFvb/6ayo+ps6+lTK+4iGQCb/eQadlMa9RMoJBPN/w217k/wQRoMTI7Yc
         /7HDazTbGJIb5E1+4ZamiQzxPU4QW3hd0YZzDUiofzGvbF/MTewOHBJWYOcPCTe2WAPy
         K3sHNRTLFEs6fKRSmOtuM9139+dMt0Ek5rtvulftUw96R8o96nm6oe2qNsXm/pI/Fy2c
         4bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=fuV1/GtLLcy/AQjBr18YmMzftopLTKIBrNKhv7I2M5c=;
        b=o8jmzqII70DeqTYKeY88Cl+Q7bAj58O1Zlwl61v5Qyiy+d5r3DdokDLBqc2YKTrPiK
         s/TdqlErZ3ZDULYkE02I/CWZ1ZKGgt6jD7GhTSuG6bTDEMCE19L8VBvUv/0pzmNKxK93
         fbpddtGgFHzNRnxk4ZbU9tAX5n4u8j7peSFPo+JOpMhIWuUQPR+uRf76wU/Dd4LRIAdJ
         wAt94mr7ETcffG37pQ183PI3Z9XMntTF0nJf4Ez/qkDiCtJvEjiL8V3o+qwhPBlICOzK
         O3o01MMuZFwMTPKb3vzTqp34O+iVxQIBfMlpWcI+HZk1xEQP0HqVoy/rUrR2axYtaLQW
         ekDQ==
X-Gm-Message-State: ACgBeo0g7I2mB27bEzrv0oEBZ/YB+4Sv4uBmGuQl3ydUdlSz1qjVORwg
        68l9mK+ulU2wnYixa6s008E=
X-Google-Smtp-Source: AA6agR4M87k7KNtoIVI/9CYTSX7xIP/qLSIYpclytwjiIfTBHZNKYBsoiNa/0l21SqiqYByzOkv14A==
X-Received: by 2002:a17:90b:4b47:b0:1f7:2e06:5752 with SMTP id mi7-20020a17090b4b4700b001f72e065752mr4614124pjb.187.1661432375792;
        Thu, 25 Aug 2022 05:59:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090322c100b0016dbb878f8asm14762140plg.82.2022.08.25.05.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 05:59:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 25 Aug 2022 05:59:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Duke Du <dukedu83@gmail.com>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        fran.hsu@quantatw.com, charles.hsu@quantatw.com,
        george.hung@quantatw.com, duke.du@quantatw.com
Subject: Re: [PATCH v3] hwmon: Add driver for the TEXAS TPS546D24 Buck
 Converter.
Message-ID: <20220825125932.GA598991@roeck-us.net>
References: <1660878283-9512-1-git-send-email-Duke.Du@quantatw.com>
 <20220819133458.GC3108215@roeck-us.net>
 <CAJqQiD39b=n-Lsza_YUPQR2jm49a3ZLxT-x7eYUv=yhD4fiDJQ@mail.gmail.com>
 <20220824105027.GA13261@roeck-us.net>
 <CAJqQiD2+6jo3h5Ymd2e7Th634gBZgijBxp5xRHB=h7-__8N0uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJqQiD2+6jo3h5Ymd2e7Th634gBZgijBxp5xRHB=h7-__8N0uQ@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 07:22:34PM +0800, Duke Du wrote:
> > >
> > > When the vout mode bit 7 is set, we update vout mode and clear bit 7
> > > in the driver probe function, this operation is the same as changing
> > > the reported value of PMBUS_VOUT_MODE ?
> >
> > Absolutely not. When changing the bit in the register, the chip operation
> > mode changes, and the associated values (VOUT*) change from relative
> > to absolute mode. When changing the value reported by the chip, nothing
> > changes from the chip side, it still operates in relative mode, and all
> > VOUT* registers are set to relative mode.
> >
> > Guenter
> >
> Got it, thanks for your reply !!
> 
> Another question, If we don't need to change the mode from relative to absolute
> mode, could we just change the PMBus core to determine vout mode with only
> bit 5 and 6 ?
> And clearing the bit 7 in the driver (tps546d24.c) probe function
> would not be needed, right ?
> 
Sorry, you lost me. The problem is that the chip supports relative mode,
and that the PMBus core doesn't. We can not just ignore bit 7 of vout mode;
that would result in bad data for all vout limit attributes since the PMBus
core (currently) only supports absolute mode. We could add support for
relative mode to the PMBus core, but that would be a major effort.
This is why I suggested to change the chip mode to absolute mode in the
tps546d24 driver. If you don't want to do that, you'll have to implement
relative mode support in the PMBus core. I'll be happy to review patches,
but you'll have to implement and test it since I have neither the time
nor the necessary hardware to do it myself.

Thanks,
Guenter
