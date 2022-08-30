Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB4E5A6336
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiH3MWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiH3MW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:22:28 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54793155D72
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:22:21 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id m5so8209420qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=q2zzBXTgvVkqSdVHqRnl/+harTyofTTL9LZ7avMR1gc=;
        b=P+XXprz2ZEpHw0qF1LgCYcFcAP4T4VtcX2mCeEYOzOzNObZiNzYjEzABD+98r8ehJQ
         FUV3tU79yML70pkA11zg7y5/kB0VE6n76WWatN2/RRGUcauKohZPhSOx5xDVYcaPS6tX
         VF43nNU8OQpSCL5vbfhTVuDkUKXYajsJEb/2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=q2zzBXTgvVkqSdVHqRnl/+harTyofTTL9LZ7avMR1gc=;
        b=qZkEOnCoZDhHKL65KA8STU3a+FTmEyKwcPyjnkRnMdYe6lpnT8hboWA4hgRT/QGmYI
         SW+7xb9gGCz6xuf47dsu+y2zU+W6DZ7+kzVzCRXfoCsy2Q4WWxL/WNE5KFwDMX1XJS6e
         bYV+FjgoxgXximmAU/8/4OX4ZGRyTI8rN5DiBxCI+gcJm+g+p20c1zJbzNmFff//7CAM
         gHmA9b6JfV5VPUeJfHpg9SSBdUZ5YY7W+oiTWJyOrA9UjRb/Hs8UkhkauaGFBDUbk4mZ
         yfNWjso8cTMNRPzPfrKgf+jMLGeTR3XSqGFjVDxxZUsLVYFi1v/6VDbawBIizxc7Vlhk
         k8Bw==
X-Gm-Message-State: ACgBeo1wsrx/Us9EYIccmpVqYeP8RVC3dpoXfkBHMiUlFZoa6wCto1HI
        ZQWIo70MBJqo323eUMQZHpI356rbLIW6vA==
X-Google-Smtp-Source: AA6agR6jhjRVWMNtgF5DAKzV46IXVybCSh3mzIbIANgWLCTXHHbusDFAOGcD7jq49vXYh9jjX3E8mg==
X-Received: by 2002:a05:620a:f15:b0:6b6:4a92:81fa with SMTP id v21-20020a05620a0f1500b006b64a9281famr11091039qkl.762.1661862140240;
        Tue, 30 Aug 2022 05:22:20 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id fd8-20020a05622a4d0800b00346414a0ca1sm798778qtb.1.2022.08.30.05.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 05:22:20 -0700 (PDT)
Date:   Tue, 30 Aug 2022 08:22:17 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/41] drm/tests: Order Kunit tests in Makefile
Message-ID: <20220830122217.h52zswusnlb3iggq@meerkat.local>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-1-459522d653a7@cerno.tech>
 <f6289e5d-98e3-1a0d-f514-136e2b7978c1@tronnes.org>
 <20220829190242.tk2hinttzzmzhnaj@meerkat.local>
 <20220830083027.4iyi2s5r5bto4h2e@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220830083027.4iyi2s5r5bto4h2e@houat>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Dropping most cc's, who probably don't care about this thread.)

On Tue, Aug 30, 2022 at 10:30:27AM +0200, Maxime Ripard wrote:
> > I noticed this, too, and I think the reason is because these patches were
> > generated with "b4 send -o", but actually sent using git-send-email. It's not
> > a use-case I've considered (or tested) and the breakage is because when b4
> > generates patches with "-o", they are written with CRLF line endings, which is
> > not something git-send-email expects.
> 
> You're right

OK, the latest master should allow you to do that without causing CRLF errors
like this series.

> For some reason, b4 send doesn't work for my setup and I haven't had the
> time to look into why and let you know.

Yeah, I see what the cause of it is:

> Connecting to /home/max/.local/bin/msmtpq:0
> Failed to configure the smtp connection:
> [Errno -2] Name or service not known

You have sendemail.smtpserver set to a path, which is supported by
git-sendemail, but not by b4 (yet). I'll see if I can put that in today.

Thank you for testing out b4 send!

-K
