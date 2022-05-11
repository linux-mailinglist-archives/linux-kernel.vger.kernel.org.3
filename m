Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B351E523F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiEKUy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbiEKUyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:54:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1CC1C12ED
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:54:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c11so2992933plg.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QOBEiygmzdOccRJ2xs/t/iC85JI6XVGlts/kvxY1hCw=;
        b=g7FCdtcxf55q/ZSL4+jYR8X7GelzKz9XVwAEJyuojZG7N7IJOlQf1EwPdzlyNNLOBR
         ytkV4tRtc2Vfdq+2up8FXugivmqJUkJ1NKbO+VIhJONrOIaIBOCtGutSjprYv8muoWM/
         xFpAg+nEc1XkGMAScGvgPkXkOKukcm1Nhy9P+wg0vv+d2iwwxhvkJhTlsCNFlRTPLHgg
         dG4yDir/XFNlNGLFtp0GAO2V+yxH+QS6zoYwCATlABLFCKae72ZFEItTpiTF4fCtRQIQ
         r0N8HwLBIinDuXVL44RtEa6CL1WHQkl67HbwxwdGdBmypEV8jVq/yh8yGtuj5NyJFdg+
         7qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QOBEiygmzdOccRJ2xs/t/iC85JI6XVGlts/kvxY1hCw=;
        b=FGYyhh8YLnTxpAn37bOGa/XKH9TcmaqzZu4hQ47lWBW7uHuephtioiPQUjqY07sLix
         61wD79xGneMtwj+dxE9Andbxz0fJn1phraIIEhQ3DjHYvfkPEa37ZpkYNZOfDCgXByrB
         +allYDC1f1Ul6IxRm7Sv+NPV1BMRbTrATRpQ3IvOPQ2B3pW2goekQ/LHHQtsiMkjQ/uu
         gsbnIr+d7vKAGAOVka+EMDBjYjwFHxhiz1n3vMMbddssDIFp+A1/puDprzFqq6MlY3v8
         V/KfZwDrBUqntRHUuetfJtA/wWmuteX/UVhY21JxZDA0/M+CdP0QaqODCn+GuTK63fCI
         aLOg==
X-Gm-Message-State: AOAM533S3r8zZRWqYlczjLJX5FtqmjqhllWPG+BIVW/Gg23CXVeOatrZ
        NWzGVjZ9rCOFWDRKCkHvEoo=
X-Google-Smtp-Source: ABdhPJwFu3ioJfSmYXGPxbC910Um6QR1JHzZzbjU+5wF3DCe4WFHNxpq4TDRRrij4g4Df0VGqvDlJQ==
X-Received: by 2002:a17:902:bd81:b0:15f:2f8f:ea99 with SMTP id q1-20020a170902bd8100b0015f2f8fea99mr6287215pls.7.1652302461242;
        Wed, 11 May 2022 13:54:21 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090a8b1700b001d954837197sm373921pjn.22.2022.05.11.13.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 13:54:20 -0700 (PDT)
Date:   Thu, 12 May 2022 05:54:18 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] openrisc: remove bogus nops and shutdowns
Message-ID: <YnwiepO0tBvt4hMe@antec>
References: <YnMKHdRy/GkAB+9e@zx2c4.com>
 <20220511133550.143236-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511133550.143236-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 03:35:50PM +0200, Jason A. Donenfeld wrote:
> Nop 42 is some leftover debugging thing by the looks of it. Nop 1 will
> shut down the simulator, which isn't what we want, since it makes it
> impossible to handle errors.
> 
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Thanks, this looks good now. I will queue it.
