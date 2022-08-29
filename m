Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254015A446B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiH2IBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiH2IBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:01:37 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4DE50072
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:01:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bh13so7014472pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NadoXRR6ilfmCAucbvVV5J8mAN2n+t5qu+Hu/Yb8UBI=;
        b=Cjdl8Kr6t5W8LrCiuLr0MIOboPp+gr01hpyfJrAoi/JjKq8dZ70oKsElPHfJhdN1l/
         etbDYaAgT1DzIhJdDEHE7lY2xFRN0I/wgrQJtUR6ODGVE9nhp9uZaGaap5abArnOwhni
         WFGZtXPLuljnRQ9AofZgDze84UvqeBRpJl7wNF6NOT4lCdplMTbzwkDGiG6UyWidkcY8
         i60TIBBv8RMi9tTBa/qVFicaNSiGrJp31Pehld8oIfTx1BycMNcxmBH+q0kolpdbVULj
         cltMW+sPFb1EMGqyuuHI6hAnulG9lr71oD0IHLCndp0VcNDwecuam+68Lx/n2y/n5vWT
         zEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NadoXRR6ilfmCAucbvVV5J8mAN2n+t5qu+Hu/Yb8UBI=;
        b=B6MrD4RmjNLckhjddRgTs5Jn5syLGdg+MCgVtIUuLUeg3nO9a/24HJq2nLgv/ouVsI
         G7XB4eQK0exTn2M9aK2USoTbmvHWaLx5UZ+vE4mignzcf0NZqqrfbEAIWL/QOJi2P3rT
         iR6nLY3L1NZ/Pwx3qnzYP+f9zWi1GIm1PNns2O5JRGJMLfU9uceyEfK33Rqi7ij+Ph4K
         HvDl3384cpu4H7s1AM/9eiPxJ0B5bSNRvBsypccXSDhsECbxcjtwv7weW3j8Yvp8i7bD
         Nf/YORnwCPJp2Vc/RV10qszBx3w/cUmhqhMp6SMBJ1j1XYBfCdclEsPyqpt2jcOVhD4h
         yq/g==
X-Gm-Message-State: ACgBeo06c4FWXNac3LB4V/jTUp/d05Iv0upTrDFzGtAIpXZaD75o+SRp
        5IoPAFC0S0ti6xB41SY17RN55WRmMGx0fmFV+u3GbLZc
X-Google-Smtp-Source: AA6agR6Brb1AxOxSWY8d2PTMAnSSpK3AeXfazmkWERkRjX85mgdIOK8WkqraX/iHpGP4xOjUI31tQxyYHvrmVJ52a6o=
X-Received: by 2002:a63:2c8b:0:b0:41c:5f9e:a1d6 with SMTP id
 s133-20020a632c8b000000b0041c5f9ea1d6mr12660935pgs.601.1661760095667; Mon, 29
 Aug 2022 01:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220804114751.46714-1-wangborong@cdjrlc.com>
In-Reply-To: <20220804114751.46714-1-wangborong@cdjrlc.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Mon, 29 Aug 2022 10:01:24 +0200
Message-ID: <CAMeQTsZidqROwpsPzLVz0y-Zj0nFRvX81+vr2zO9VRv74gDjoA@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: Fix comment typo
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Thu, Aug 4, 2022 at 1:48 PM Jason Wang <wangborong@cdjrlc.com> wrote:
>
> The double `the' is duplicated in the comment, remove one.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Pushed to drm-misc-next

Thanks
Patrik

> ---
>  drivers/gpu/drm/gma500/cdv_intel_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> index bb2e9d64018a..53b967282d6a 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -115,7 +115,7 @@ i2c_algo_dp_aux_stop(struct i2c_adapter *adapter, bool reading)
>
>  /*
>   * Write a single byte to the current I2C address, the
> - * the I2C link must be running or this returns -EIO
> + * I2C link must be running or this returns -EIO
>   */
>  static int
>  i2c_algo_dp_aux_put_byte(struct i2c_adapter *adapter, u8 byte)
> --
> 2.35.1
>
