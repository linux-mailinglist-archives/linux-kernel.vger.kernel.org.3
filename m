Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BFE55A5C0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 03:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiFYBPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 21:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFYBPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 21:15:49 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FB03ED2C;
        Fri, 24 Jun 2022 18:15:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id t21so3966927pfq.1;
        Fri, 24 Jun 2022 18:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mddgUzjjMvwn6t+jkp7452qXuMD9uxs9pKqRGpWnzls=;
        b=MFL75ZqSwniQVJ/Tg712PAfFoFZvNdUvvD/hHpnQShNFY/kvSnWnwMdGXuyFf6363F
         InG8hiCJoMElYT0AYLFk9kwgttuBvSDgybhQeiOQSCJKXX7iV9NMaIVeA5V9HKkFeyQi
         D0pv5Lh1cd1gjsl3hfadEOgKyegWuS6L4pjyOtchRD5G9RUb13fE+AayBbCz7dHeQ5ij
         uDeIqmpxmzTFTUuU+wOTF4t+Z39oVUZh8SbygfhA9E5qr/MauwsO8C2xNOkzSUls3mnD
         vdAhHP+ZGW5AWfuw6h3b3c4IyhkmWRsf0OR7t7/VRE3UVfFSEnuj/z6yN4gDae0XzvgM
         KMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mddgUzjjMvwn6t+jkp7452qXuMD9uxs9pKqRGpWnzls=;
        b=Xx1C5wc9CAHLyRPp3h/8HT0uq1n4DXhx3fAg049UgsHbL6q1ie41LV0VVYE+6CFhqx
         ZXvHz+1RiPu8+vBYrCgWGvuYYNvzJRc4qmO1N2ODyXJKiMBCAPe7Q1V1qBQRxnZNGSzt
         m03wLfbSaMd2Pv3vA98/HAnQGaiHFhaClP2fkovRX2bPVvJgR28ez/MIl6IAtPY1HUK+
         jxx2mo4+OOH+zcUJBCKLqEMr9bU54stup6zaGfGO+sgFPb694I5wL2HXWqpqCLhhE0QL
         8wpjmCsCOUZPYu4IUGEjW9Sz/0ER/xvO/TPBt0GYkd+vYC6qKsdOZdBiEZ9ju4kdDumj
         BTNQ==
X-Gm-Message-State: AJIora/KfeoevwP8tngjw4Qqq8rd2tQKtMZIhjtd825kBGPKOfm44o4J
        yUlU+vUqg87Bb5QDwMYd0eQ=
X-Google-Smtp-Source: AGRyM1tyD3JHAlSkBQre22ZgvMm1Os5Ag+84SUDLVbeBfB3j6RW5jvPKEfdDHIPvu+CHWDALZaL72A==
X-Received: by 2002:a63:6b08:0:b0:3fd:1b8e:3932 with SMTP id g8-20020a636b08000000b003fd1b8e3932mr1481851pgc.552.1656119747744;
        Fri, 24 Jun 2022 18:15:47 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-71.three.co.id. [223.255.225.71])
        by smtp.gmail.com with ESMTPSA id d76-20020a621d4f000000b005255151e248sm2433430pfd.174.2022.06.24.18.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 18:15:47 -0700 (PDT)
Message-ID: <241393bf-1fd3-ab25-867b-7132d7590aa8@gmail.com>
Date:   Sat, 25 Jun 2022 08:15:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] media: docs: Modify the section of User xattr
Content-Language: en-US
To:     Deming Wang <wangdeming@inspur.com>, miklos@szeredi.hu,
        corbet@lwn.net
Cc:     linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220624014605.2007-1-wangdeming@inspur.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220624014605.2007-1-wangdeming@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/22 08:46, Deming Wang wrote:
> Delete duplicate words of "the".
> 

I think "Modify something" isn't clear subject, because reviewers
don't know at glance the logical change this patch is doing other
than actually reading the diff below.

For the patch message, what about "Remove duplicate the"?

In this case of trivial patch, it's OK to have the patch message
same as the subject, if the message can't be described more
concise but clearer.

> @@ -607,7 +607,7 @@ can be removed.
>  User xattr
>  ----------
>  
> -The the "-o userxattr" mount option forces overlayfs to use the
> +The "-o userxattr" mount option forces overlayfs to use the
>  "user.overlay." xattr namespace instead of "trusted.overlay.".  This is
>  useful for unprivileged mounting of overlayfs.
>  

The diff looks OK.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
