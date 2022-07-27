Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464065820EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiG0HSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiG0HSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:18:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A1ACE31
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:18:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l23so29983445ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mSx3wHVt7xAJmmMmIb8aW81Pol+b+vBcAqVHpxDw1YE=;
        b=vPPLAZkTvD5XkCEzh4ztZJr02ihnqDWfDjpcz48VEmrwOWsLCg3FbCUYkjTXGdxVSp
         0cJtZzJeEHur6jCRjr7TEOfindV2xd1V35jiE9fns0aon/JS2EtxRxTzbYQv7hS7/DXs
         qm/LSQVdfa4nztx6M0i7j62iyrdw8j1Fv/a2KSPxyoeLAThVj6I6+RAqwxdL/cLDCVvr
         mEh6xLr7a089GE97jcX7ScTz/xpCKQy8M8ozOXxqGOL4ho81ggdYr2L7C1XkEFib9c6D
         Dx+v5rVAfO1J4jZBZyskFmzd8i90dC6ua2ft2udBjL0n7l5W3RagPeK7UNX3fMV1S0e7
         b13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSx3wHVt7xAJmmMmIb8aW81Pol+b+vBcAqVHpxDw1YE=;
        b=R+SJp9IkazrEQkBd0Anu1RsfNKdfrWT5vSx9WGidEchuUxO16MYl5KWnuV8uQwythR
         FVABAMZ7HRC/Rd9avan7M31ZaA8H5IXjhe2QCWgVRTGyWoJQAcTvjwZIF7SA92LAkrxj
         fuIPpJkJjpln/cCQdB+Kr7sD0q3/tAoWt5yQAxtccmemZkwH35pV7m+to1hiO/YruztO
         J9cNVjtKEC31asu+GC8CCRpMkq0m5HgO302Ju1IQ2pbJfj0oCQS5YjjrMf635Dl3J/Ck
         Ca6CKOek5i/olaqdg4HmEsigsYmuHULDtXCbJNePS/ED+M2QnS4OQc/zgOe4txWJI37M
         y8vw==
X-Gm-Message-State: AJIora9ZsZxvSFSBcvoLlY7ouU7IdeSfOU0NrQ4LZMVfmyhQ2yC5JvrC
        9O36SaW38t46f6al1IotTwiX2SnKfOIsYQW4178STw==
X-Google-Smtp-Source: AGRyM1uOWuMb7hdqzBwxTZzJsWfLCr5rBYpu5OaNGOvW35Amyw+j4mlWvcvZj18uXu+oCVQcqT4sPb/HyrW/OICyuuE=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr17036681ejs.190.1658906324665; Wed, 27
 Jul 2022 00:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220721062345.46842-1-slark_xiao@163.com>
In-Reply-To: <20220721062345.46842-1-slark_xiao@163.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Jul 2022 09:18:33 +0200
Message-ID: <CACRpkdbM+RHcOrdzdfVE3qMb9-YJGqL8b1i0bqyMnFXEsSJQrA@mail.gmail.com>
Subject: Re: [PATCH] drm: Fix typo 'the the' in comment
To:     Slark Xiao <slark_xiao@163.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com,
        sam@ravnborg.org, imre.deak@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 8:24 AM Slark Xiao <slark_xiao@163.com> wrote:

> Replace 'the the' with 'the' in the comment.
>
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Patch applied!

Yours,
Linus Walleij
