Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF97A468376
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384403AbhLDJNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384408AbhLDJNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:13:11 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BDAC061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 01:09:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z5so21691816edd.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 01:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=piWjoUd6FQrfDeKgRE9IYypzptj8wVsWHJQeGXe8XeU=;
        b=I91Ap0U+7TYHdAtefQ/emo7CYRpiakiJUfcBKICXVgI6ODhqCFYrhWFWFQibicUxys
         ByohGScAGeHZeXtGRO9YEJdu4KfOBMtrCD3AkhFw858nddHD1Vm3433jvFo1HXuUczQS
         jLFC2mf+h73XmijFtL9z27vGw63nB6jCR2CnQ92U/mSz3iDJzsUjPpIWmk0mT6INfzhE
         /3PeZJeRMC930K2TC2IvVhgv7IWxZpw2qdujbQh+lR0qET1riEXkhB/Sa+px96RIJVCC
         pvaI9FXPapjvSvmCMh6i2T9oxBO92DtLzBFjhx7XUbp1TufgBhROgTfkvyDB5waZzljM
         T0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=piWjoUd6FQrfDeKgRE9IYypzptj8wVsWHJQeGXe8XeU=;
        b=hLgfbGTB3InPTcLUVdrUFSnify5bX0Off5xXEX3hXA4fY1S/v25LWOeCpQAQ9mlWfN
         YLA2uGmJD3nSTSOcb+RgVvFJjFbBNQFYDw9P5iS+AX5K0vXpqE48fUVi+jyYuN9/0qst
         AaFZ8OmiQxJEra37/Sov3Mfm4Osrqn7FWRRJHavzzucZvQY+awRvkxrob6/ulhyZBzL2
         7YJVkSTjMdo8PaQs281NCjxsArCYab1OD+wy+FaXiaLdy98F+MdTrtgR8RWVkLk1Eg9/
         Q0C/QmLXf3gQ4tSuMHcbujXM5fQETsSs+hsoa9wjKnBJhin12owGqVCLl7RFwLqcCl+m
         0skg==
X-Gm-Message-State: AOAM530qsyPY8Gn11UG174HwKBbce+vpQpZDPz10f5XSPLltbVCjjOXP
        lrHuvhTG8o5tnaM0M9fUIl8OqNHheMY=
X-Google-Smtp-Source: ABdhPJxhRlai+oq1hnO8N30Wk/09aFIOvvrgqIvDeWLwq6bboeYyDdwJU/n91v61lQr9XliCForpzg==
X-Received: by 2002:a05:6402:190d:: with SMTP id e13mr34522176edz.282.1638608984255;
        Sat, 04 Dec 2021 01:09:44 -0800 (PST)
Received: from bulldog (host-79-17-112-183.retail.telecomitalia.it. [79.17.112.183])
        by smtp.gmail.com with ESMTPSA id l26sm3417925eda.20.2021.12.04.01.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 01:09:43 -0800 (PST)
Date:   Sat, 4 Dec 2021 10:09:41 +0100
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: refactor byMinChannel to min_channel
Message-ID: <20211204090941.GA3805206@bulldog>
References: <20211204004041.3825744-1-alb3rt0.m3rciai@gmail.com>
 <e0fea904-1861-0003-1b04-6d2e966657da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0fea904-1861-0003-1b04-6d2e966657da@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 11:27:43AM +0300, Pavel Skripkin wrote:
> Looks like this variable is set, but never used. Shouldn't it be just
> removed?
> 
> Same for max_channel (or byMaxChannel).

To be honest, I would prefer leave them where they are. I'm only
refactoring the code considering less the logic aspect.

I don't know if these variables will become usefull in a second
moment.

Anyway, If you consider that this could be a good moment to remove
them we can proceed.

What do you think about that?

Thanks,
Alberto



