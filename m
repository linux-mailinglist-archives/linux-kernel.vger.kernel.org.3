Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A9D50FFEB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351389AbiDZOF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbiDZOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:05:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247F519689D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:02:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k2so5191299wrd.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q2GTfUc7VLX7J3kb7UZo3L6hgl7G3SCi+Soy09ZT8/Q=;
        b=V16PSVQfUB/Or3B+sTPWN0OESvTLnOXJvVItFoiiWr+i+XWczhhBYVqK0CQKrBFUPV
         2nQrPeuHneJbpozsMrqjc0knwusbWrNPFgRqv28DbmGNIILbFLlzBHm98vIKW6Pp1XT1
         S//6Kt+IKv+px8Q76JYBkx1Hxff3JHR3cKMP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2GTfUc7VLX7J3kb7UZo3L6hgl7G3SCi+Soy09ZT8/Q=;
        b=ryWOh4UDkxCWdBgf5HG3ftfqgYTsJyW3yE3fgF2q7mC0Dh38sNkmXIVLTedhllcWz6
         J06mXdy2bgDbQtZLJu022ufFp1tkfThsur0nL+5xrYKa940TubWacyBPo5FGYhAm0jd+
         L8Z2kBmGyUWQBMhQx7DwOKzz3xN8EkmGWE54WwAtoF2IW0p1b6JxKg3xDAUrB0v6JxwY
         EA8b0qd5ipK+JtLmqHgLYu9enm8FHggzNNGsTqHmUiwif7+yp2XFwOxpHypvVeH4aFve
         lE9APDUNo3qeN0RMlZqjDH3pFQOLbEyZCQpb38IFYDnJmqAT6bjmLoX6YSe/cO1ejliO
         64Hw==
X-Gm-Message-State: AOAM531pldsLVW5tOyudlYcyFWVl9RHHHskm+yNC4tQW/DEH7hYIWzbT
        qfOk2+reQsfkQgXxPpRI1btz/Q==
X-Google-Smtp-Source: ABdhPJxic/QZR2BhX6akoIU8RQ/B3yNQzrr038cwGWxQtu13ObaIie5wUl501AIceUw/M1p5EPN2Vg==
X-Received: by 2002:adf:e346:0:b0:205:97d0:50db with SMTP id n6-20020adfe346000000b0020597d050dbmr18586212wrj.257.1650981737632;
        Tue, 26 Apr 2022 07:02:17 -0700 (PDT)
Received: from google.com ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c190d00b00393ee555683sm5414256wmq.27.2022.04.26.07.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:02:17 -0700 (PDT)
Date:   Tue, 26 Apr 2022 14:02:15 +0000
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] dt-bindings: update google,cros-ec-pwm
 documentation
Message-ID: <Ymf7Z/BJQSWO6pjE@google.com>
References: <20220420141556.681212-1-fabiobaltieri@chromium.org>
 <20220420141556.681212-4-fabiobaltieri@chromium.org>
 <YmcZn8mWQveT5HzT@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmcZn8mWQveT5HzT@robh.at.kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 04:58:55PM -0500, Rob Herring wrote:
> On Wed, Apr 20, 2022 at 02:15:55PM +0000, Fabio Baltieri wrote:
> > Update google,cros-ec-pwm node documentation to mention the
> > google,cros-ec-pwm-type compatible.
> 
> It would be good if the subject provided some clue what the update is. 
> Every change is an update. And all bindings are 'documentation' so 
> that can be dropped.

Fair enough, I'll reword the subject and send a v6.

> 
> > 
> > Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> > ---
> >  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml      | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> In any case,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thanks!

-- 
Fabio Baltieri
