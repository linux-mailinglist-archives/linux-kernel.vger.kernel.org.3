Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010F54E1FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 06:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244464AbiCUFGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 01:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiCUFFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 01:05:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5055C1152;
        Sun, 20 Mar 2022 22:04:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so6010014pjf.1;
        Sun, 20 Mar 2022 22:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rWn5lOEVKhm+FQ6md1T7NJaCwXARs2ppaRXQ0ISSujo=;
        b=Z6CZCluY+X4TE/5PAqyM+8g2WPrypjmBsL4y9z7MyQq3tnZf1i78nZxX+Ig3SqfwVs
         d3CkCW/Qzu2bBiDBkxAAE8BGkeTniraV8l7JRVXOYpd2umcmF8xuq3lyIr9zHM5pnmmA
         ezJbzllMjrutcx6j0MQ+FFw6Ge/1ee7xP7BAkBI0fb1WvpjtQOpyvWPprZl2sdi2799w
         sFHZRZbTeNZDsaFdReL81SbPcdaJuGm/MBF6sswlFx3SJ+//oI/mrFbA75jOxReJxtiU
         9hDsg0vzu271i2j++j68tVZe3DHzbVM4LGX2AmeMNgTkLrUKfVdD3jJ2gJFTrCcMvSGH
         V1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rWn5lOEVKhm+FQ6md1T7NJaCwXARs2ppaRXQ0ISSujo=;
        b=sa25JSriYchqBkaPBhiqHAdQkhokpRB0dYEmVFrKBmL3rWGXuzkInbAXftdZBjXibM
         K1eoSR2emadQb92zCcR4JS7V/uPysWztaU30tAK3BiAIoCHzDsdBAKCbUn728X5Tt/0g
         ZSZOjmCxh4i1Q+b5EEkknWdWjF11ve44jRD4iyiBk6PBxPGIMvB/XME2Tn2hNg8lLCfI
         YLy+xyeBNng7Fo7uVbpEnHkbsSFYX1bcrxB9tQ+qHvGvP3EaA8WfiY6cgl6ODOq6eLx3
         dpQJYHKo1Q/S3xDR8Q5O9raY2rSAtowY7exL/fxnL1sboJMzYJdwnbXRGK6qxlFTR+xv
         T22w==
X-Gm-Message-State: AOAM533Aqs1arqRM0rZHqHE/gyOP+R8ivX/OpinKR27BiuvSOS3Ru+Bc
        vT8+Xulozdm0I5phOI9EhuI=
X-Google-Smtp-Source: ABdhPJw3GsuYmAvFujOtsMEZmTIiI8Ukt+Rrq0Zw7bPrTEkxB9B36nuwkv85fIHGkT5k+pTveYeOEQ==
X-Received: by 2002:a17:90b:4f92:b0:1bf:25e2:f6af with SMTP id qe18-20020a17090b4f9200b001bf25e2f6afmr24103584pjb.98.1647839068735;
        Sun, 20 Mar 2022 22:04:28 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:31f6:c8f1:6f10:b2ec])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090acd0500b001b9c05b075dsm18659405pju.44.2022.03.20.22.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 22:04:28 -0700 (PDT)
Date:   Sun, 20 Mar 2022 22:04:25 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] Input: adi: remove redundant variable z
Message-ID: <YjgHWeTiAWRty3rK@google.com>
References: <20220318002318.80519-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318002318.80519-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 12:23:18AM +0000, Colin Ian King wrote:
> Variable z is being assigned a value that is never read, the
> variable is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/input/joystick/adi.c:139:6: warning: Although the
> value stored to 'z' is used in the enclosing expression,
> the value is never actually read from 'z' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thank you.

-- 
Dmitry
