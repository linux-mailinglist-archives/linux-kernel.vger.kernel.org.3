Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1750D57597A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 04:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbiGOCI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 22:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiGOCI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 22:08:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87CDE3;
        Thu, 14 Jul 2022 19:08:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cp18-20020a17090afb9200b001ef79e8484aso7150331pjb.1;
        Thu, 14 Jul 2022 19:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nN7oo55DHJds30bnSnWbgGgtg4JUOplmegF0qIGzI2Q=;
        b=fs9T5k8jP1VnFiV5TDNnPanhg5Qbj+hahpJWt9NonEUGzqVMd/7SMidWWcoyqgzMv3
         Nsf01j/iDpRyyCJxnFXUYjxnK/e0JifeEMVWFu8n5jrVB4ZtVY+V5pwU6ehavFfBfrHZ
         lxjHkA11K/6DIGzcQaVhPKkiLcLSQSoYOOSh+Dh0cKCdZ0RKYYw1h0WemBkqQ5qGHiP3
         Tsem7U1rChrHfneiwOFNjpqJPyWdGiRBll6l/+sdLVBvZnCLg2vTQNa/nTTOCGRAZw6J
         5iVfph63tCtuQ2apK8Gs5mIkIxqNrWEQ3zqNeZO3hLW8IH7bTqUN6Ay38U8PTl3VueQk
         rZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nN7oo55DHJds30bnSnWbgGgtg4JUOplmegF0qIGzI2Q=;
        b=QCx9j0RixA3hHUW3i6l2Z1rfi0FPqKLP0akCkyA2KqGYIMHPieieKLFpexTzVD9rPy
         vy/N9PazIkma/s1DlGHmZjq5+m/sgPSCk5bOoJ7LEESuuABB5x1pEp7CqRe6WruYshqG
         /FOLn6+cZllmp/q5BwVu7KGAr7xtEhjUA7fczf6TrGUFIPJE4QzeIxz89SXsgLMKGkkF
         ApMV5EicZaJMwrEx5fEwvF5eIPu/RZYRzCt/Fk6rn54FCJ1pjwx2WA4bgEFcSoKDy5FQ
         BLHUTsd013omwb+MpFjnsLp5ub+5AccEnPnbp9VnlODPGsjC6dYCS44K0LS1p6huep1s
         Xf0Q==
X-Gm-Message-State: AJIora98g5dBAZeQECQ4VZyTSSmPzR43xqw1gR+Dniq9n2DDQ9ezWPwI
        5xFHwQVohDFIi+ZH7NhIDuyjPjqLGlY=
X-Google-Smtp-Source: AGRyM1tluY4rWW4erradeeSknq2HDrY5E/UdncFgzvxdWm7Nit3fCU5px+LsiiGJ/7twoikJsL7xIg==
X-Received: by 2002:a17:90b:33c9:b0:1f0:35be:3038 with SMTP id lk9-20020a17090b33c900b001f035be3038mr18798278pjb.61.1657850936212;
        Thu, 14 Jul 2022 19:08:56 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id k10-20020a17090a39ca00b001ef8ac4c681sm4442992pjf.0.2022.07.14.19.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 19:08:55 -0700 (PDT)
Date:   Fri, 15 Jul 2022 10:08:51 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: [PATCH 0/6] gpiolib: cdev: code cleanup following hte integration
Message-ID: <20220715020851.GA10242@sol>
References: <20220713013721.68879-1-warthog618@gmail.com>
 <7277ef56-f425-493a-f148-8e4aaac37614@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7277ef56-f425-493a-f148-8e4aaac37614@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 07:06:18PM -0700, Dipen Patel wrote:
> On 7/12/22 6:37 PM, Kent Gibson wrote:
> >
> > I've based this series on gpio/for-current, as it requires the fix
> > patch -
> > commit c8e27a4a5136 ("gpiolib: cdev: fix null pointer dereference in linereq_free()")
> > Happy to rebase if that doesn't suit.
> >
> > Dipen, I don't have any HTE compatible hardware to test with, so
> > could you check that this still works for you?
> Sure, will do it by Tuesday next week.

Ideally with v2 of the series.

Thanks!

Kent.

