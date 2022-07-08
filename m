Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D402F56C1C8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbiGHUUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238985AbiGHUUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:20:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D174532EFC;
        Fri,  8 Jul 2022 13:20:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 5so11335592plk.9;
        Fri, 08 Jul 2022 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JvRn3rvWlHDJiinkiBH01X8XyzaKuHuzaOkEP2fwSA8=;
        b=kKA7BwxpfIG4pb5JlkTE6MKy6Lb/AitSKmI06IVbVNU4o7A/1mTGBvKExNlN65TJkk
         ytRsHli+y+5vcKB6OkYPJ6/gFi5Z/MhyO9sgQdgnbZVFlRsVuV//be/rjGvN1aQuIBHk
         DtyktgiWc6cl8V8Dh43ciM3AkA2sQfBhAhAsdi++mu0FyyZ4iiPVubMNK0e4dgvgZ91J
         0xpT9Ju6K+V16DhbrhCQ5RjSXLZKmkpYXjGaMmJB2qgyOXOpUQQ4aMcW8jxeHE8gX8+U
         dLeFQeuoC+BHcXXja0J51Nr1a9ZbzxUS8kp0uIw7KsRbRBsPF9IvGME1H1XEawnuDVL2
         AuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JvRn3rvWlHDJiinkiBH01X8XyzaKuHuzaOkEP2fwSA8=;
        b=ETBV0XzyQOy8hIX3Ax0fRSCxhC5mCEaBT7H6wdBw2x526EMCYxO+9+Y+/HfvoQl2E0
         cpgmnmhJXIJeP63OyttC0Dvr5z8d8xApc/csdr3NsjvkCs2csNsI6rKo0Cem4N4XtkRr
         0RhvD0ISq+vETkPCZy7MdcZndWuk3nz1kz+9H8ENA73ZMyACYHB948cU1IojRGMSSWIu
         2My4G4j9H7gMha8fUe6JhlMmJC2A/ZlGTIPhc8At2vRraOdK0MIvOHMpS8pcQ+8zGDZo
         LE3STqzuEEvQ2RFWbnvg9m+kpFCEiK1yHA/5a/t889AbZaNaNGf0v9izy760fWWmAco7
         8ydQ==
X-Gm-Message-State: AJIora8YXn1pH+OCG++WNTpKHoCYQDWXD13O1O29WRl7uAggPaC13KUM
        CT3pM6rUqe1oHlLMUmlfGQjxaYtFQW0=
X-Google-Smtp-Source: AGRyM1sXKUNwupr3TzhCK8jnGYVpWCoU3pQQfdjQoWGD5OM4hFn5P3QtgbfXc2NJB446UrqAzT0NJw==
X-Received: by 2002:a17:90b:1644:b0:1ef:88c6:6e39 with SMTP id il4-20020a17090b164400b001ef88c66e39mr1762717pjb.122.1657311630316;
        Fri, 08 Jul 2022 13:20:30 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:9707:b37:49b0:77c2])
        by smtp.gmail.com with ESMTPSA id z15-20020a6553cf000000b003fadd680908sm28184890pgr.83.2022.07.08.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:20:29 -0700 (PDT)
Date:   Fri, 8 Jul 2022 13:20:27 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     hdegoede@redhat.com, tiwai@suse.de, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: i8042 - add additional TUXEDO devices to
 i8042 quirk tables
Message-ID: <YsiRixoaiyydp9j1@google.com>
References: <20220708161005.1251929-1-wse@tuxedocomputers.com>
 <20220708161005.1251929-2-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708161005.1251929-2-wse@tuxedocomputers.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 06:10:04PM +0200, Werner Sembach wrote:
> A lot of modern Clevo barebones have touchpad and/or keyboard issues after
> suspend fixable with nomux + reset + noloop + nopnp. Luckily, none of them
> have an external PS/2 port so this can safely be set for all of them.
> 
> I'm not entirely sure if every device listed really needs all four quirks,
> but after testing and production use. No negative effects could be
> observed when setting all four.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Applied, thank you.

-- 
Dmitry
