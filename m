Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0296650D8DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241286AbiDYFdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 01:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241293AbiDYFdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:33:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FDD6413
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:29:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p8so13802699pfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MStvkw3lE5OmicwykYX3b0gfRyKHWjoxMvSCjFua0k8=;
        b=D5ht9Jzb4ph+C/KWWoHMm+RLBkNhBp9fXFJZziktPQi1C+eGBHe5qttyGHY8jjswmE
         saMdrZ2Ns9j9+2Y2RzUy7UJjN1eRJjKOkWOxtDpUSyLJsq+bAhKMbenPuXMQt52IDAZF
         7BsXGf3S1+rFaUenYd90nmJ8gy5yz6ImScdPzwGQT7LetPM4mNkVCKEJyZc0qXbyQKYw
         HxWZHV3DO4JiJ2eqFKiruUpU+QPWF8PSnWmjCzmd3ypfQOKFlGaKRhq3yjtLVYGAJeed
         ZEiA3r1IF+NHydPxefjzFC2QyMkguhYHekEqpB2MzQxqi86U32DyVSlLb+PQJQPU7Iew
         WGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MStvkw3lE5OmicwykYX3b0gfRyKHWjoxMvSCjFua0k8=;
        b=1f95ed26dz1JymWKq5/9zCHh2CBZnYoYojNVVUaJLIYJ6aoucvjsBNYa8VzHqKKa/a
         uznZQFVTaDxYq3V8f2F2yOO8TF3oFLhQ2Ah0rHPlz49nKVckhD75a6e2fr9gojpsbN6C
         AZDRRtBmZKS5nw+oAEo66XPPm+rBZeQLQyx229BUVVlwbkfDhLj9/pMfxzdQJNOAttIq
         G9N819yPWGTtyRP11CJ8834bZSfeUIvy8XIzPKm80TW4bVpRCSh7iIlBk5la/wRL+FP8
         XUYgX92rxkyKTyhJmaR3+vuErncGzhLcsUpyaGviUnwm5tZxJUCyVORwI+oJcooVag3l
         3SWw==
X-Gm-Message-State: AOAM531Sm5j/SN5QMVAVLWCV1hzW6RdFOaJxpKHLJdAoNeZ5JHOkAvCD
        fraoeA6nn10WooKj7DUo/Hc=
X-Google-Smtp-Source: ABdhPJxSP92BxEQyCLVjf8jOxz7FwQkPDQ0oW3hV+wR6G+0mcIo9vPJLT+JwF6O6slzvOwpgY5/WtQ==
X-Received: by 2002:a63:2b8a:0:b0:3aa:f59e:a4a7 with SMTP id r132-20020a632b8a000000b003aaf59ea4a7mr8320955pgr.91.1650864595611;
        Sun, 24 Apr 2022 22:29:55 -0700 (PDT)
Received: from ArchDesktop ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id 5-20020a631045000000b0039d942d18f0sm8282718pgq.48.2022.04.24.22.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 22:29:55 -0700 (PDT)
Date:   Mon, 25 Apr 2022 13:29:52 +0800
From:   Solomon Tan <wjsota@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        straube.linux@gmail.com
Subject: Re: [PATCH v2] Revert "staging: r8188eu: use in-kernel ieee channel"
Message-ID: <YmYx0OrJGLR82211@ArchDesktop>
References: <20220425011612.113664-1-wjsota@gmail.com>
 <YmYnbKeqce5TZuM1@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmYnbKeqce5TZuM1@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 06:45:32AM +0200, Greg KH wrote:
> On Mon, Apr 25, 2022 at 09:16:13AM +0800, Solomon Tan wrote:
> > This reverts commit 0afaa121813ed602bd203759c339cb639493f8c2 as changing
> > rtw_ieee80211_channel to ieee80211_channel causes a memcpy bug as reported
> > in
> > https://lore.kernel.org/linux-staging/67e2d10b-7f0f-9c5a-ce31-376b83ffba9e@gmail.com/
> > due to their size differences.
> > 
> > Signed-off-by: Solomon Tan <wjsota@gmail.com>
> 
> No "Reported-by:" tag?
> 
My apologies. Included in v3
