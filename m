Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD55567A6B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiGEWyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGEWyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:54:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E1D10CF;
        Tue,  5 Jul 2022 15:53:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o4so19553638wrh.3;
        Tue, 05 Jul 2022 15:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EwGxnZ5x0SNmvQDKOSOQHy8UpQQQrz2+JP+pz6BLjY4=;
        b=Y0r0D7X+vZrlSeMjvw/Y/PVCtqlc7Tna0nbdIBO9b5puzrLR5WKxsUNwbZw5cWM0R3
         OLRjbHmGXOgLWjrtNyCp1iSrLdsyZnNYIGaup/6lWsajWehd+T1UJJJz4YtwsFXObUUE
         O8M/mj04qy90yX9CuQvc7RwVdu1zbSFURHMpOCoWVxLdjyglHCp6wvIezNofvgSGrjFa
         Wr3RYvWs4gr7xpZRsIHWP9VuxuhVYhqU/SHTJK3mucfCCqYTPdK3xPPPztQn8N7LqFSR
         /rXPjXyDHtGRspTtb360BzrATyvqAPdL9GlxhAZT2zNLHd9AVZU+BzRbhNbeZKepEW/I
         tdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=EwGxnZ5x0SNmvQDKOSOQHy8UpQQQrz2+JP+pz6BLjY4=;
        b=2VzuImtIlJQD8C8QBRwge8kL4v1Bf9CiLjvdGyxXZhHluTXDmG9rlUa006itqBnpJW
         J4Yk/YgaxRtY76Y1Kf228XbzBWJ3BPh1T5fmH+EclaDlaqn/KtJ19HDKy0gunXBH/4m3
         uwCFYFvLdoz6FDSu4UZWKYbFbwrx32Emcv8Oid2RM4eqpjuBCV5uWT005OXkqpkt7nH/
         m7c5cQCr/u543Oo8mtMgyvttiBdbDMdbdjq8Iq6EvX702WQUfkJsVvieAog/0O22PKWf
         PRA0FP47PCh9uD5AyEijUvvqIzv5AhEsXlgiojNIO5SAmUwFNM+mrJfM2KwoUnBm9hfw
         yPCA==
X-Gm-Message-State: AJIora9YlGnHiZRZsh1nN4eiqXMurLFv2oXa9oFpRLdGa549zptqoI3q
        trOfmQpEkZEEs9vq1W5Kn9o=
X-Google-Smtp-Source: AGRyM1t47k9N/xwwklARYa34Oe5nJGwwJWn05QvjO4BYjAXyz00xC+I04pPTG1/SuTSP732BPAs5hw==
X-Received: by 2002:a05:6000:118e:b0:21d:701e:7cc5 with SMTP id g14-20020a056000118e00b0021d701e7cc5mr7176589wrx.376.1657061637182;
        Tue, 05 Jul 2022 15:53:57 -0700 (PDT)
Received: from [192.168.90.207] (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d5146000000b0020fcc655e4asm34675746wrt.5.2022.07.05.15.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 15:53:56 -0700 (PDT)
Message-ID: <84fc71cbcae80a7b021a88da55fd0aa8452bbcbb.camel@gmail.com>
Subject: Re: [PATCH v2 2/5] iio: pressure: Kconfig: Add references to BMP380
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Jul 2022 00:53:55 +0200
In-Reply-To: <YsMUj+kzVtn0HPZ0@smile.fi.intel.com>
References: <20220704002747.207401-1-ang.iglesiasg@gmail.com>
         <YsMUj+kzVtn0HPZ0@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-04 at 19:25 +0300, Andy Shevchenko wrote:
> On Mon, Jul 04, 2022 at 02:27:45AM +0200, Angel Iglesias wrote:
> > Adds reference to BMP380 in bmp280 driver descriptions and symbols
> 
> ...
> 
> > -         Say yes here to build support for Bosch Sensortec BMP180 and
> > BMP280
> > +         Say yes here to build support for Bosch Sensortec BMP1/2/380
> 
> Please do not shorten them like this, list all in full:
> BMP180, BMP280 and BMP380
> 
Ok, thank you for your time!
