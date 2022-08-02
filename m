Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC723587D4F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiHBNno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiHBNnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:43:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D23820BC7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 06:43:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w3so2005722edc.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxMBbuBDdwyOFmQW1I8hAnSHIEKIwpcYs30ZPSwwd5M=;
        b=FR5S3Cs0uToyFO8i8vZuZOYUJGqblJtUSCRmW2IF5+PQF2X0HKWATMMVySOTAJQ78Q
         5rUvmOd/CV2RmEIc88WV06bRDN+yWhrZHegSl5abWyG5GLZkCdAbr+U0tVq8MkGlvReX
         Sv2D0g0MI2LPEC7lDTYfdPGgtZS8Ulq4JtfFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxMBbuBDdwyOFmQW1I8hAnSHIEKIwpcYs30ZPSwwd5M=;
        b=ga2cvZ1S58Lpf9myzgF7PNPXHcTACDi1HO+yjvBfi1KXNxiMR/xy0WFLNWDTBpbNG7
         ttjFAVyGTr/40vU4GrGbRmbR6QEc78L30GyVU/LXNKswn1B0eM2dx7wvv71xt1D17gsc
         LDUbmu7zPPBkn2xBuo9RgRyNrzGPa13INQETJqnSd3aMKFryNj1XE31bDVWCfxhb49un
         ooPPhdllTH8UJnOt+GGiZx/3n4n2RxBa97ec9pJBwFdqRKdS3bTxv+WAusR0yNUgA8wu
         OFo4GeNNcWAJnN7kkDmWGG4XRIYdPuedD/YR88Rm9xb7p8eNt2JV7NGwNNPJZwTdBfTC
         IYCg==
X-Gm-Message-State: AJIora8hGhsDvkbWzN01fRzRo6c80wjCLpRlqqb4cZuGWJ8IV45lztsF
        rbl8+kyBko6OQgSW3nzMc7clBi6g7555OcojtWM5A+FlgV1pMw==
X-Google-Smtp-Source: AGRyM1tQcDM51UiQAKhZ3CCyYSZbkAlD+nb38S6lVfegL5x/v4zGD6nILExtE7KhfeHHXzFc6jNpTW+kzQ3J5XC8aKc=
X-Received: by 2002:a05:6402:187:b0:43c:b095:4ab3 with SMTP id
 r7-20020a056402018700b0043cb0954ab3mr20719367edv.5.1659447819700; Tue, 02 Aug
 2022 06:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220729015726.3076091-1-williamsukatube@163.com>
In-Reply-To: <20220729015726.3076091-1-williamsukatube@163.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 2 Aug 2022 15:43:28 +0200
Message-ID: <CAJfpeguwkYgxX5u5Ww8rAKRYLfHPDgKs9rmGu+UJU=LtaaKweA@mail.gmail.com>
Subject: Re: [PATCH -next] ovl: Fix spelling mistakes and cleanup code
To:     williamsukatube@163.com
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Dean <williamsukatube@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2022 at 03:58, <williamsukatube@163.com> wrote:
>
> From: William Dean <williamsukatube@gmail.com>
>
> fix follow spelling misktakes:
>         decendant  ==> descendant
>         indentify  ==> identify
>         underlaying ==> underlying
>
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: William Dean <williamsukatube@gmail.com>

Applied, thanks.

Miklos
