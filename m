Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CDD57318A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiGMIt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiGMItK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:49:10 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB25713DC5;
        Wed, 13 Jul 2022 01:48:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so2556374pjm.2;
        Wed, 13 Jul 2022 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UIoh9NHxanWIu9MKPpKAF1viSnOBb2X/cB+otoNiyAI=;
        b=NwmwNoJ9ooQtARwNewttG01efjd4nOv9Hb1L1CSb9sSNyZWvRSf6Zp4oJKQKjUqyM7
         LFzUFM/ed7cWTlGy1uGAgMCkBXQDnoFPD6ITBZlVqt6fs+c8veLMo6uNJEpXMZJhZp6P
         5okNGO1RH+78g7xsUAfpy5/a7lh5aIqqIUZEL/igyRgJr+aTsD5ZisbqMJNF7nBtj6vD
         lHWxJHI9C16S9HqropbcoY0A02w6laCL0GYzrlYDXk8lJGaiSg7c+/sxruYd3yRW1JUe
         2ZD/F9brWyW8AAM8IV51byRUkGdTQ7bGxj4Wn21JXmODEKjA3OdoHvnANpKNJPo+Dp1V
         2RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UIoh9NHxanWIu9MKPpKAF1viSnOBb2X/cB+otoNiyAI=;
        b=j1cipUR6h9MYnzoxQmF5lxeMCSTXkSLMArLP+maEXvF2kzvw557Uaid1BMYJ9/uYLV
         o2globJ38WjQCNZ4megfr3nQ+OD3v5cGRxgFxwplChHmvadbbIWl+jpH7ydgkg26TrXo
         mIj+k3F65R0D5ceDHIy048YPl6BvcqYkp8CI1svbAROhWZvsa9TwJH+e1h4rqgq4IRGx
         u2sPLorBvOs1BsR53JAxcFdA+jvHZGeokafN83ozjz9EpcDChLfC5BfXlssgZsqvPZhD
         oXpP5iiq526oXPcrR9xA/ZnwuUuUzooItZD1/cvZ1w80bl0YSQkHxzKeX+TDOpha/QgF
         XbZw==
X-Gm-Message-State: AJIora/yQXNOmmpXKZ2/qIoyqULwczbSbAqireC81gV06MlDz6gv7CfT
        9Gd0/qn/FmxAW5zWmxT2iSuMmNotl00=
X-Google-Smtp-Source: AGRyM1vdMa5JxdLDERhFxTImec2iKAG9Oo0H3NUBuB7MwfIOjRQpopjkN+4Af7TawxI31k0hvRhrug==
X-Received: by 2002:a17:902:f391:b0:16b:f995:43ac with SMTP id f17-20020a170902f39100b0016bf99543acmr2405768ple.32.1657702130130;
        Wed, 13 Jul 2022 01:48:50 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id i6-20020a056a00004600b00528bbf8245dsm8323921pfk.79.2022.07.13.01.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:48:49 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6FA5F1038C5; Wed, 13 Jul 2022 15:48:46 +0700 (WIB)
Date:   Wed, 13 Jul 2022 15:48:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-next@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/2] Documentation: qat: documentation fixes
Message-ID: <Ys6G7pERa+fUoKwl@debian.me>
References: <20220713030332.158525-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220713030332.158525-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 10:03:31AM +0700, Bagas Sanjaya wrote:
> Here are documentation fixes for qat driver, as recently reported in
> linux-next.
> 
> Changes since v1 [1]:
>   - based on next-20220712
>   - Drop kvms390 (already applied by respective maintainer)
>   - Focused on qat driver
>   - Drop "initialize" from [2/2]
>   - Collect Acked-by from Giovanni Cabiddu
> 
> [1]: https://lore.kernel.org/linux-doc/20220712092954.142027-1-bagasdotme@gmail.com/
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> 

Oops, missing v2 subject prefix. Will resend.

-- 
An old man doll... just what I always wanted! - Clara
