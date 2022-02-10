Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F934B0243
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiBJB3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:29:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiBJB3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:29:40 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10424BEB;
        Wed,  9 Feb 2022 17:29:42 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id a19so3508565qvm.4;
        Wed, 09 Feb 2022 17:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ToNCyCER18er4bQVMsXGiDd9JZ4VHfKIQFWhjnXru2Q=;
        b=diG+Q6iHPMCG+8DyBzxqb1NI8p1ZMfHMEgR0kYUzkbIZvu/QajXhbxzbjjIoc3Yuw+
         Wi8RTzuCI84MntfVrwONo3Xs60JrBQXCVw90eT95lBtt52mSS6Y200opNL9SLD/zsEYN
         BRrPMtoL3MRYpgGrc4aN+evta/FxtPYcVj5Sf9BQWnzqRJw0fP5UxPJUe9YKMnknoJ9M
         S1ZWuoc7/5MlCWbCGUqUl+DSFK51VMz93J//1nipAT2XB6Z9xTlnaTAD50NTmzxOdECS
         1N+JTkJD7u9sUupKl9xNxkSVu75BymPj1VW1hXbxHMNv7dvYzvdDQQbcTeWMkuyatxxI
         Z3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ToNCyCER18er4bQVMsXGiDd9JZ4VHfKIQFWhjnXru2Q=;
        b=hmI8lzu7koNrXrpAba4yBgRzYGKzzcCSS//g6raOEseF/8Rs1Z8+YgQJriesZtl0Cc
         LdqbnEi3WqpcfbyA9qoG6z60td0H9PBNHx703RmSqx4cUKsFxRyOw8E6/6WBq4IG1KZU
         gLChIS8Oywlwqq26FyXlYaYOO3GO7+HCmLoccRjNAycimhIlibyn/3clCl0eZx0XfrYJ
         jOAfN7JVhaRzRq8ih7wzsJMrvJrq/Nj+brp7xWESN2qbQYT3gzlEvXaWDBjnSWYqPHzF
         wHwYQJtGhh16GEQ/au+OcCWYweo3lBSHAB+4T7014uXK2mCKlBRt6zzLFkSyyAylTsDU
         4EHQ==
X-Gm-Message-State: AOAM533OSAcz0k5aj0jDPIMtCjVKCCP20hD2j2aXi5efE0DDMwF386Md
        qWeQf/ZQieXYMpdnKrOc/WomcwJ4cCg=
X-Google-Smtp-Source: ABdhPJxe4K+f1x2wrGyCqcfa4iOdbXjp5YK45cjtlWUvZxJHCnm+FBTprVk8D3JJFXiAaBvBwv7MLw==
X-Received: by 2002:a17:902:aa85:: with SMTP id d5mr4974794plr.150.1644455008697;
        Wed, 09 Feb 2022 17:03:28 -0800 (PST)
Received: from google.com ([2620:15c:202:201:2a5:6459:fd91:33b])
        by smtp.gmail.com with ESMTPSA id z13sm20883691pfe.20.2022.02.09.17.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 17:03:27 -0800 (PST)
Date:   Wed, 9 Feb 2022 17:03:24 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yunus Bas <y.bas@phytec.de>
Cc:     yuehaibing@huawei.com, linux-input@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Input: tsc200x-core - Add axis inversion and
 swapping support
Message-ID: <YgRkXLZpPBpHF2QY@google.com>
References: <20220209223933.1672782-1-y.bas@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209223933.1672782-1-y.bas@phytec.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 11:39:33PM +0100, Yunus Bas wrote:
> Since Commit ed7c9870c9bc ("Input: of_touchscreen - add support for
> inverted / swapped axes"), the of_touchscreen interface supports axis
> inverting and swapping through Devicetree properties. Make use of this
> feature.
> 
> Signed-off-by: Yunus Bas <y.bas@phytec.de>

Applied, thank you, however I believe we also need to adjust
Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yamli to
allow these properties.

Thanks.

-- 
Dmitry
