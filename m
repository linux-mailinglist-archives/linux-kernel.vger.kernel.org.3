Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71334EA194
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344689AbiC1UgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346503AbiC1UfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:35:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B701530F6C;
        Mon, 28 Mar 2022 13:33:22 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r13so31066767ejd.5;
        Mon, 28 Mar 2022 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=99of423IY7CVPR8iPnU+TMAUNxIGG8oT/8tTMtEORJo=;
        b=G5DBj1J4jLpDgQj7PFiqg755gBkN6ZebE1uZCqAfXyefK1DTfuLKXUbpVv8eChBm/6
         j+9ZOtiTtsRKec9UTyuPH78a1LDBDHVlI5Ri9ulgfW79sWSTowUIBbsR7m+YxeS/qAZc
         EZoCnTMA1kTWwkrSCR0wbrdM4YuF8YtBvkCrNlEe5ZRu6DA79QoHwWu9JNHl5uoG7kYD
         yH64hFSIyfYEsjTixT3DTerwLTh+A2iKo2Z9YwWibTVtOS6SIx0JN0L7q7gwXVr5V0sB
         4WpFTx9p3YRgp7BxWgSTUjdPLkv2bkRyCuiltwEKDdk1S8kGyfaxGQTvRq5GRp/5SCtA
         78qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99of423IY7CVPR8iPnU+TMAUNxIGG8oT/8tTMtEORJo=;
        b=mFbN1mxA00vR4Czgk3myFKPdkEiwch69MwpSN/2ow2TJr1plvrTn51PmrAv3dxiQF8
         AKv66No+szw4N986PKx3w/Z6qiESW7eOwto2X972TB4vm3p3Ck555EdLeNcpuRnzdhiQ
         qFg9tfhkojFgt6pPI2TbKKLf+itOoBYYRC3UP7GyWF4H28ofq8zmydEW5X8pndYL3mv+
         FBiOehogQuf+bD8LRjuTrWhWqXVd5IhKua1BiZ77aWzvT4Rkh3yOmnIprC9kgZYZR+Db
         +eDvF47ZPjOAuc9IYB0pBJK9Zb1KN19rW6PGbM2cE9QOm7dQ88mfChr2xis2c38wNQIR
         yazQ==
X-Gm-Message-State: AOAM5325w91H3oYz5pMH2uirncvXlhDh7qvpe1Z7HMFTw2cJoJXr+1bo
        FbGIbTDkQxi76ScBS5uk/mypaqZdUP1GscZsBYA=
X-Google-Smtp-Source: ABdhPJzCRrL+Gc1pbqF+lApMPgSvyVYO246Ig45MwOtUmzuhGX2T1TmaYbvQh8EJzEZ6yHHl8+D9+W35G0lcF5JQgc0=
X-Received: by 2002:a17:907:e8d:b0:6e0:19e7:9549 with SMTP id
 ho13-20020a1709070e8d00b006e019e79549mr30071158ejc.44.1648499601151; Mon, 28
 Mar 2022 13:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <YkHOpCT2Gad1YaxN@hp-amd-paul>
In-Reply-To: <YkHOpCT2Gad1YaxN@hp-amd-paul>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Mar 2022 23:32:44 +0300
Message-ID: <CAHp75Vf7R2=m7apZfXkY9-nETNiG7n6oXpivBg-56Wguzx2+8A@mail.gmail.com>
Subject: Re: [PATCH] IIO: accel: fixed coding style issues
To:     Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Mar 28, 2022 at 7:45 PM Paul Lemmermann
<thepaulodoom@thepaulodoom.com> wrote:
>
> Fixed case statement issues and spacing issues.

...

>                         switch (val[j]) {
> -                       case -1: str = "-1"; break;
> -                       case 0:  str = "0";  break;
> -                       case 1:  str = "1";  break;
> -                       default: goto unknown_format;
> +                       case -1:
> +                               str = "-1";
> +                               break;
> +                       case 0:
> +                               str = "0";
> +                               break;
> +                       case 1:
> +                               str = "1";
> +                               break;
> +                       default:
> +                               goto unknown_format;
>                         }

What you cited from documentation mostly affects the new code, but
this code is already in the kernel and modifying it, esp. taking into
account 3x LOCs count, looks like an unneeded churn, even if
documentation thinks otherwise.

What I could acknowledge from your proposal is the default case.
Otherwise just leave it to the point if we touch this code for
something else in the future.

...

>  static const struct of_device_id kxsd9_of_match[] = {
> -        { .compatible = "kionix,kxsd9" },
> -        { },
> +       { .compatible = "kionix,kxsd9" },

> +       { },

I dunno why you touched this line (likely TABs vs. spaces), but please
remove the comma as well here.

>  };

-- 
With Best Regards,
Andy Shevchenko
