Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99706527637
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 09:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbiEOHQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 03:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiEOHQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 03:16:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED7112D04;
        Sun, 15 May 2022 00:16:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i19so23214131eja.11;
        Sun, 15 May 2022 00:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XfV9hrJZXlb0h+0qnGHB9w3BsPoOeIKqTaIxDjQSgbE=;
        b=gIFRsC4Tael4SGkZtVqX6zuqUcpti8xiGrVjLWIznSYt8Ak7eytyqkUKv2hL12kfIg
         7tlNHSU/rDAHzZZ76v38+cjJggiO1UGrSpBkL6CdzXkA8tLXL/fPC5JFky3xWDi2S/Hp
         VJ7ZE2sZjo+hpFeAEldCXlQc8QMRnS1YikLS2qaOsguLrRIOrHchganJYgXFC65pp0To
         mBYvKgkBlDLV8xNTr/YA7Uw43PEsQQi/Ef6wZZwECT7abKoejCLFz/Ip1kYgP+YPTrlC
         5EyfKbS7tdehm635HPbgmi+Pzwn5KuFatTnY6ePj0yZxVPkIVUIzvIKBjgvIrPUVh8Cv
         JRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XfV9hrJZXlb0h+0qnGHB9w3BsPoOeIKqTaIxDjQSgbE=;
        b=WeF34qcVF8Vtx8kyQO7r30G0iGW0OYTKcftv2AQuQzLPK0fECeMtGseTNf72RvGFyC
         lD2+WGjYa1+cCij2mDeuT11xOoImORJjZ6fFVwKFO0qyWmMy8JZRsxHxa7gPqPOA0oH2
         h1CIFFjP431TI2JYzIFbw/wPRD1ZZ+H5GfrdRKJ+8MvlpsfVzFd7GoHsUFUMYJ6py1Js
         1uLlka5E4BFEN+ImjM+/wmTN+1/iyuuAJipOi4KD9lYYrqfOFI/9BhLpev348A2LPMoM
         9uuwpHW5M8C1sjdBaQs6+W2x5jtpNLaQnwYST5TjEFOLICk1HC31ya+nbJ6jypE/YDro
         ALcA==
X-Gm-Message-State: AOAM532cNyLgWFk3/1Hl5eJunIXHnJtETKbwI42312iDPKGcEep5EP9V
        1pqr9G4pHjngssy9sYZA1+8=
X-Google-Smtp-Source: ABdhPJyc0kfzDV3ltM6wM589GNkdV9+2UEw0opuQiGZBX/6yRcao9M3vPpR3xUZVEcJ5+IadJEhD0w==
X-Received: by 2002:a17:907:3d91:b0:6f5:2b6a:ef55 with SMTP id he17-20020a1709073d9100b006f52b6aef55mr10966011ejc.352.1652598986830;
        Sun, 15 May 2022 00:16:26 -0700 (PDT)
Received: from eldamar (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id qr48-20020a1709068cb000b006f3ef214e5csm2374912ejc.194.2022.05.15.00.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 00:16:25 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sun, 15 May 2022 09:16:25 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Adam Langley <agl@google.com>,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 1/1] sign-file: Do not attempt to use the ENGINE_* API
 if it's not available
Message-ID: <YoCoySEUSzu9zthg@eldamar.lan>
References: <20211005161833.1522737-1-lee.jones@linaro.org>
 <Yicwb+Ceiu8JjVIS@google.com>
 <202203100851.C00D9AB73@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203100851.C00D9AB73@keescook>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 10, 2022 at 08:51:56AM -0800, Kees Cook wrote:
> On Tue, Mar 08, 2022 at 10:31:11AM +0000, Lee Jones wrote:
> > OpenSSL's ENGINE API is deprecated in OpenSSL v3.0.
> >
> > Use OPENSSL_NO_ENGINE to ensure the ENGINE API is only used if it is
> > present.  This will safeguard against compile errors when using SSL
> > implementations which lack support for this deprecated API.
> 
> On Fedora rawhide, I'm still seeing a bunch of warnings:
> 
> scripts/sign-file.c: In function 'display_openssl_errors':
> scripts/sign-file.c:89:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecat
> ed-declarations]
>    89 |         while ((e = ERR_get_error_line(&file, &line))) {
>       |         ^~~~~
> In file included from scripts/sign-file.c:29:
> /usr/include/openssl/err.h:411:15: note: declared here
>   411 | unsigned long ERR_get_error_line(const char **file, int *line);
>       |               ^~~~~~~~~~~~~~~~~~
> scripts/sign-file.c: In function 'drain_openssl_errors':
> scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdepreca
> ted-declarations]
>   102 |         while (ERR_get_error_line(&file, &line)) {}
>       |         ^~~~~
> /usr/include/openssl/err.h:411:15: note: declared here
>   411 | unsigned long ERR_get_error_line(const char **file, int *line);
>       |               ^~~~~~~~~~~~~~~~~~

FWIW, we are seeing the same now on Debian as Debian unstable is
moving to OpenSSL 3.0.

https://lists.debian.org/debian-release/2022/05/msg00070.html

Regards,
Salvatore
