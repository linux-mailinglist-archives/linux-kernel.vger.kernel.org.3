Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDF847A37C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 03:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbhLTCHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 21:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbhLTCHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 21:07:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103CCC061574;
        Sun, 19 Dec 2021 18:07:06 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso11408623pji.0;
        Sun, 19 Dec 2021 18:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=44frKLBjDoKoXxQ8vCCuFrEW3887v3fISzPaK57VSks=;
        b=FqSqP03FGGeduGfunQo2NNYyvLpJGhBnhUgZoy99T0F80I6aSZxy8biV9H1L/uKQXb
         Zhukoz2Wd4f6Kb9FIrsvGfxwZw79tThdOJulHdM3+q6fBofjzvbbVo+4C0QCu33PFvu/
         6gqUwtvf8g3WVt+XqtG1Nh4h7XueE+DtGYXYiZyUIVw2a5yzRVeILaqUZ/7Ti3o1hGfA
         H7X/lA6u2LAUszzIzLpcbX76F3At6IVsjrVRv2YqrnbqCbSHKlNFkrP8vcGzwoZiy5Rj
         sgkUNrsXZkPKra3B1kMxnQVpIF3I3gYi0NSOX6J2u/0agviuxr6rhjxx7HzCalfoXGky
         RY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=44frKLBjDoKoXxQ8vCCuFrEW3887v3fISzPaK57VSks=;
        b=pzNaKelgV+nJQEyCjJm1IZeWYwK2yR0W+AEyQ3ils/B68voihzxWNp5VosocOL4acI
         /kdA7iFUWP9CDtBSTKzwUvf48t0ca0JQQYwGfvJjCR/gLYidk5pS4OcZ2XdWU9bmJxbF
         riVg8UC6zY+aTScisQWrGtK03UKTHyRe8Bcib9VR3KAmt4624Jzm5C/FH/s1PBWPvyFk
         8jnXYzfkbNCpvDA7p9rqf/0+dO8PZhSnKmuMdS9qQQsDTYmROyx39Q8Ti2YHtBmnfzQU
         iJ0L20yP69g2bj1hZY2Ifoi/FLhFa4L03O4Ic4Ilvy8j2QXM+Qb6DNPxAuKItgri3zmC
         fR+g==
X-Gm-Message-State: AOAM532tAod4AdHveRT2spXHwWQ/PxqpFdvGPK/vzZdJExiZWi5qHwqJ
        bxz1uGt92lvlpSRJAsL0eMRrh8h7Ji0=
X-Google-Smtp-Source: ABdhPJyvjwA2D67Iw4qitWQoguW24AqqOkqX1oH+5BaXzVO5p0vFM1e+/mgg4oC3lIbo8N5g7jnMgQ==
X-Received: by 2002:a17:90b:33c8:: with SMTP id lk8mr25293962pjb.191.1639966025517;
        Sun, 19 Dec 2021 18:07:05 -0800 (PST)
Received: from google.com ([2620:15c:202:201:3e2e:1228:8845:1f8d])
        by smtp.gmail.com with ESMTPSA id 13sm16002162pfp.216.2021.12.19.18.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 18:07:04 -0800 (PST)
Date:   Sun, 19 Dec 2021 18:07:01 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: byd - fix typo in a comment
Message-ID: <Yb/lRVC4B7S0kANf@google.com>
References: <20211216082735.11948-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216082735.11948-1-wangxiang@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 04:27:35PM +0800, Xiang wangx wrote:
> The double `the' in a comment is repeated, thus it should be removed.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Applied, thank you.

-- 
Dmitry
