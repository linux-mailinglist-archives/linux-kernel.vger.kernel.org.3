Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EEC556EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377229AbiFVXWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346517AbiFVXWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:22:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D84641F87;
        Wed, 22 Jun 2022 16:22:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p14so11753104pfh.6;
        Wed, 22 Jun 2022 16:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RhdPk8LTYym77hcacrBh62mFWOXLPvdMJrHyB1VYTWE=;
        b=Kkg1xVTJn3A6ODjjhox0jw96wt8Nir+xL4V8oyctP37fCoFIMXqaoLanauvFgXdQi/
         a2H33sB5auls4+vL9CBLgx8CcgGxIb/AeZoI0ub13hBEZwXviINlDDKguBrVW8KgQI68
         MWWYh4z2c8akTmBPUNw/W5OOnW2lp8ESCeT6QhZTGIRBV+cISe01altAyf5KNUnGjQvY
         +IwKGFeSwNd3eeaYYxIOnJks8cNnAD0FEuOMqpE0i8LWwqm8HI/1nXhfBzg8WoeDbjRB
         9mPZGtILDbmSWOW3dodZTq3lY0o2AQjgn1w8KRpuYpiP2E8rK5wD/cNCeKm9ms7ufLSZ
         5xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RhdPk8LTYym77hcacrBh62mFWOXLPvdMJrHyB1VYTWE=;
        b=FkY9/BCR6OrRQ0n4UH5vzF3WNm5boFgF2l5v8UDWrpz7rJhXt5u93E5rZUPksfaU2s
         d8k02lb6tKDG/iKsG+racfD1XV8WJsrEaba4wy+x9rRO9b22Q3VxBwZhbtSzR4vNsLkL
         A54p8c/uZ/Boa16IHlhUifUy5+zZgkKhIoPUsBlW08lWfx52U+7bolJw5Tz4YTIYXXeY
         TqT2FQA86Ev4zv4H1sCp7txow74x2n5Op2Wp5ItN6N5QQoEiigI+MsTkZ2aiMqy0+jCK
         SP7VvLwWXI2RTdXkYyMgge36Xg8QKSyTR5td13PbZPWFSLwCbMhPHgyU0hKcBtB5ppHi
         1kmg==
X-Gm-Message-State: AJIora9vksSUz1QTwlRWSCDnePatgwrsWvLOxNApLxYVh688qcDySn88
        xAt3pl42REgmPrHtQ1LraKo=
X-Google-Smtp-Source: AGRyM1tPlK75Uip0r4AyWz6QcOUYzT6R0eKUYdL1vKkpDutT1V+u7HwzHD1iH/RGbvASNX+A36yauw==
X-Received: by 2002:a05:6a00:198e:b0:51c:3511:4aff with SMTP id d14-20020a056a00198e00b0051c35114affmr37628508pfl.20.1655940131463;
        Wed, 22 Jun 2022 16:22:11 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:fe7d:3981:3b3c:19b5])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902d14c00b0016a4f3ca2b5sm1567482plt.277.2022.06.22.16.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 16:22:10 -0700 (PDT)
Date:   Wed, 22 Jun 2022 16:22:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: usbtouchscreen - suppress empty array warnings
Message-ID: <YrOkIMJK3G3VkhLk@google.com>
References: <20220620084628.20894-1-johan@kernel.org>
 <20220620084628.20894-2-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620084628.20894-2-johan@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On Mon, Jun 20, 2022 at 10:46:27AM +0200, Johan Hovold wrote:
> When compile-testing the USB touchscreen driver without enabling any of
> the device type options the usbtouch_dev_info array ends up being empty,
> something which triggers compiler warning with -Warray-bounds
> (gcc-11.3.0).
> 
> drivers/input/touchscreen/usbtouchscreen.c: In function 'usbtouch_probe':
> drivers/input/touchscreen/usbtouchscreen.c:1668:16:warning: array subscript <unknown> is outside array bounds of 'struct usbtouch_device_info[0]' [-Warray-bounds]
>  1668 |         type = &usbtouch_dev_info[id->driver_info];
> 
> Suppress the warnings by making sure that the array is always non-empty.

Does it still warn if you add a check for type, something like

	if (type >= ARRAY_SIZE(usbtouch_device_info))
		return -ENODEV;

?

Thanks.

-- 
Dmitry
