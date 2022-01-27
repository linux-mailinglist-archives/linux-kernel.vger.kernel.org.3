Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9872C49DEB0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbiA0KEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiA0KE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:04:27 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2DBC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:04:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e8so3839703wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9W+F2zcaPhBNE+IIc45ICVo3MhOH5IvZRsFjhKpBYTc=;
        b=jFp5VVPIoz9kUJd3L2nS0zBZcuLjy6Cj5UbWk5RoWl16fMllUpfLCYalqSfhU3+2S9
         z/ps5Xtow4NxwJnTZYpBy4C/7h6jVEDmdlKiNvMfPET67c5qQ1ycqgGPRQCvzlGcgADh
         /mpPtZyCQFdNY7r4JxZU708OreApI9fMWXBFPCOpk8VqntHf0t/Sc42C0smoS58RmQCJ
         z4svie/7ZiRVJIJa4uidvHLdMiQVjn0G391FbQf5QY17g1MHt0LX0nJpeC0J+ubvreQp
         dXhWxvS9NXcfULSjU0bTBOgmkR0dQsiDiy9fIBDTejJC0exT7mLWJv9PwQZnZH8IvV3c
         lv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9W+F2zcaPhBNE+IIc45ICVo3MhOH5IvZRsFjhKpBYTc=;
        b=1/kA1Yu4WI0hAij1Hf5bfytWYyWWzQjat6s7QyQdaai+HKUrJLzLNQ8s2Aad5ivkiW
         82V5sV0aZVeJ4LwZ4TB6o+CbOc/oB/rpwQWJ/tF6NFLpkNAdccJUuSSwyS31+W4z1PBg
         Sdubq2XLeto7TCRBSyU2suQQ67jM5xRxwpReHEAPV+k37VQ+XEeBAx4l9hf76mPaXYKx
         c81mykBnvzMYYU59qIJAn7rhsiFspMO4iyWSOM9vkrNl7TC5k3StZAWHbg/uVm8LKNNJ
         gv1LgnyNGQa68pB10t42E7NhELrukIM3th4/Ht4+HkHqWp4d430kMkpQNNDWT2pWGwlj
         7noQ==
X-Gm-Message-State: AOAM533tGAmzis0DHmiJHXvmuV0HPXbehuQrrf0slhA3hK8quKIGaElb
        84cByrbDazVz+FjvqicWnQt+E/O0eQBy0A==
X-Google-Smtp-Source: ABdhPJwBUl5JcpieHD99vmRmVaJlXo/1iHw1b90qGkQDfcWqJQrKooIEdtuRJnoiSYaNErPYlNIG5Q==
X-Received: by 2002:a5d:47a1:: with SMTP id 1mr1334128wrb.87.1643277865648;
        Thu, 27 Jan 2022 02:04:25 -0800 (PST)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id n13sm5616500wms.8.2022.01.27.02.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 02:04:25 -0800 (PST)
Date:   Thu, 27 Jan 2022 11:04:14 +0100
From:   Aleksa =?utf-8?B?VnXEjWtvdmnEhw==?= <aleksav013@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     salah.triki@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: dio: Fixed coding style issues
Message-ID: <20220127100414.o3hj63sirlavyb33@artix.localdomain>
References: <20220126195341.5154-1-aleksav013@gmail.com>
 <YfI7rZrYn4liKuPB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfI7rZrYn4liKuPB@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I made a really simple patch fixing coding style errors.
Could you please review it, and tell me how to prevent errors like this:

> - Your patch did many different things all at once, making it
> difficult to review.

from happening in the future.

Should i split changes into 2 patches? One for upper half and one for
lower half of the file I changed?

Many lines have multiple errors, so if I fix one error, I also need to
fix the other one. So I can not just have patch fixing one thing at the
time. Should I try to fix error in this manner:
[PATCH 1/3] fix lines that have ONLY spaces to tabs error
[PATCH 2/3] fix lines that have ONLY braces error
[PATCH 3/3] fix lines that have spaces to tabs error AND braces error
or should I have a different approach?


Sorry for bothering, this is my first time submitting patches.

Thanks in advance,

Aleksa
