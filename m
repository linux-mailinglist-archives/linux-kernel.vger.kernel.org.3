Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24114FB510
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245541AbiDKHjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245524AbiDKHjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:39:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DD83DA58
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:37:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q20so9322301wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+xQY2SpAJG2FH0txc34PYfRaRk4uWtpVwc78xUBOWSU=;
        b=TS/IxOnvcH6ZPV1/3rEi3H3oQt9or3TRdg5EVUzLyPTjuly+DjvvsaK9DyiWWOYF6E
         V3jWXpD9hkg3SlZz3m8JADhNws0wD+RW0PrWA/y74T5744uSQcfZE1quEVbWHoR7Swg5
         Kwn8aZWuW55Rttcz2Nb0hm/VT2kil5/NL6OiTNv+MA9uwh3UjJrcKJxR74tLqQj+6rQI
         OSx2faf1xSTTLwqzhUqc/2hniLWXqMWZ9k7B86D+bOeTYF9nMvRhc9MCidIai9pOYzxp
         Q9PkgwNPGF77XlZg1bbTaeagNLSFQOhzRUPEoUwMlEGWLgHVKWZUeNBrNLtzQG0KUpVy
         NUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+xQY2SpAJG2FH0txc34PYfRaRk4uWtpVwc78xUBOWSU=;
        b=Li+WGprfQgRs/Dy+mmsuY2cj6zhEzPduKaeiID6Cbd5Wk/YPh05Lv8ZbLWcaXn+e1z
         zRCWegWrKbGLqT9zhPrBXuPUq6RGJdcVe3HLDuW3ZiACzezCmEPYhqHYXQ7QHFebjjvG
         K2qxhQJ9jhgAi4fywp31Ht9/RwvH+4yvcwYzZYbzpX6OXuwxBpxO2pkpB2YFOnWhEMOR
         HOLFSiB4qa8zmb4JmY120s6i8cgtMNyReDI+LMdypYtdPM9dKpRdNS+g8khAxoYYDr6H
         OiglLMfuYSbbOabtoDbkfuJ/XUkAi1rAQD9JEJNbpcn66rhpEiWM6CBOuQJaSb81m5mi
         T1+w==
X-Gm-Message-State: AOAM530TAj+4UZ2rGTziBNBO6YvIhyHdB7Vy/euL0qN8eRLPnQWD6l4j
        L9D9sqpT4DApOzgLDjcknjIdtg==
X-Google-Smtp-Source: ABdhPJw6YDsVxhm8ahPT5MtcNsZmYpcdioU9tctYlMVQ0DSOz1HcAz/qdpUjYszLpoIjX1Pcu6pNMQ==
X-Received: by 2002:a05:600c:3c8c:b0:38e:4c59:6852 with SMTP id bg12-20020a05600c3c8c00b0038e4c596852mr27607010wmb.194.1649662644891;
        Mon, 11 Apr 2022 00:37:24 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id k6-20020a05600c1c8600b0038e7e07f476sm21404842wms.35.2022.04.11.00.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 00:37:24 -0700 (PDT)
Date:   Mon, 11 Apr 2022 09:37:22 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     jernej.skrabec@gmail.com, samuel@sholland.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 00/19] crypto: allwinner: lots of fixes
Message-ID: <YlPasmjElADX+7u5@Red>
References: <20220317205605.3924836-1-clabbe@baylibre.com>
 <Yk/xNIjjINj9Hvki@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yk/xNIjjINj9Hvki@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Apr 08, 2022 at 04:24:20PM +0800, Herbert Xu a écrit :
> Corentin Labbe <clabbe@baylibre.com> wrote:
> > Hello
> > 
> > This series is all fixes which I found on allwinner crypto drivers.
> 
> This doesn't compile cleanly with sparse.  Please fix and resubmit.
> 
> Thanks,

Hello

Coul you give me more details ?
I do not have any sparse error.

Regards
