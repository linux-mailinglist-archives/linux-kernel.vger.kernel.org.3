Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C35582796
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiG0NYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiG0NYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:24:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ECA2D1FB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:24:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bp15so31479035ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHMkpB5t7hmbPWWLKlbDM5K2ZorzaQLbHtU4+jaalmQ=;
        b=oddts4B12U+6PCzk4eaFHpzKf0/AWjqXcJsh2FsYPvng1kZorzMkNff/nvoIyfbZMH
         oKMKGa9FPYuHC6KVm4My/G0pVyfXO17wO2s1Etx2EMTXxL3/TGQdmuYb59Z/pXnrU9xO
         YBw1URWs1cQ8zFuef52zRvSdb8Bvr26tmTZ3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHMkpB5t7hmbPWWLKlbDM5K2ZorzaQLbHtU4+jaalmQ=;
        b=hDRz76UGK74+6nE7uEpfjdPSwwYFr8m9XbWpZjn9OlAqVLbZ7MYyuAx6bGoh2vV2vv
         vlcG5LLDBXnv9XuR2G9L9kAP3EZku38Iu0sSJHiR7eroLWNSve5u9ZrS/uG9/pH0pkjU
         siBEw+4Z0RhkX+jHZ8+bIu+KlEp4YpR+L/vB/R2YxDAdEAhlwEHLyTRgx0SN0PNkJlmr
         r+Ba14x2g2PYN9HdaxildwjXbrkmmri5cAZNZtYeI3AK8lOeFKY8Dx/Qr6Jo9+CKWRNS
         ar6e39P9M9fdYZqtCu8osgc78Nh3sodZUZ+xlWi48+1dPn6zdcEyDFPIcOAMHQ69SJKJ
         7IfA==
X-Gm-Message-State: AJIora8VViruofA4yy5yd8ukjgKhoBk6jFsuLrPL1tQy7qPtUhQ4GYGW
        1FBVnR7dJZM0e3gEnEjibO1KS52rCtfcmIxNv/8+Lw==
X-Google-Smtp-Source: AGRyM1uJuZCTUizUZkLY1fl9uNE3WAVaWRFsoUax4sRn1yFc1O3sJwP8uWV2lS+qNxCZkgECeYMKGj9UHQ+DlXPTFy8=
X-Received: by 2002:a17:907:2854:b0:72b:7daf:cc0d with SMTP id
 el20-20020a170907285400b0072b7dafcc0dmr17709950ejc.524.1658928245376; Wed, 27
 Jul 2022 06:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220712110933.2646293-1-williamsukatube@163.com>
In-Reply-To: <20220712110933.2646293-1-williamsukatube@163.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 27 Jul 2022 15:23:54 +0200
Message-ID: <CAJfpegsBbRaqG3UeVhiXhPsFX-6kZf+OGT9Rxu93vSfoepgbfw@mail.gmail.com>
Subject: Re: [PATCH -next] ovl: Fix spelling mistakes and cleanup code
To:     williamsukatube@163.com
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 at 13:10, <williamsukatube@163.com> wrote:
>
> From: William Dean <williamsukatube@gmail.com>
>
> First, fix follow spelling misktakes:
>         decendant  ==> descendant
>         indentify  ==> identify

I will accept a patch fixing typos, but...

> Second, delete extra blank line and add blank line where
> appropriate to make code format more standardized.

...not this.

Thanks,
Miklos
