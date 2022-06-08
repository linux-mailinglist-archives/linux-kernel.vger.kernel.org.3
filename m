Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA8A5432C6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbiFHOkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241587AbiFHOkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:40:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7682FFED
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:40:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so11213104wmz.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9EhidKpUM6if67sguCO5Og92a54Vj8KeIpSWVWhTgdQ=;
        b=SK47hwDm6FJP9FIEMaK3YXzJI6JodkcDhToAkvbJwJmqM5pD/7GP5YZrsdT68gYGis
         VdYLDTWh8NCL0udFANKYNpxzJD84W5sQo+ORJNNcRySyXgCcfcUYscuN6+uCpMbwYbJJ
         B8gbMjnXNgRbs6FWZikwqLhGasX7LLk1juNoDTKGD0xnKH0ima61XC3rMkoesOAwsCjS
         xqT0y6C/04VTou0Mxyv3PEEvvWDvUinef7zEQv+K/OVZHLyRMM18Q2ivUrsl7hjB1zc3
         YYUx0wkhazy+r6XfkyGyMJOZKXaHaIEqZvbrYLovgrO7EySIb/E4LGUm5gqmib35e1nE
         Ig8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9EhidKpUM6if67sguCO5Og92a54Vj8KeIpSWVWhTgdQ=;
        b=YlTw3UZ3HY7opOgpCXj38J8fov3W46stLJ+R4Nag0pWl2ftFw48ew0lFym7xHqRXuU
         dSB4xGRZbWuGtSadj07PSsKLirn6Br4oJ36b5pTo4y58pBIjllkmJCObe7vArmwY8aU1
         gMmIXjDnDUReTfBY7+x3A7CMipk01/HXiuBu0IKOOcKiZXtVZK8qwv9GDXEzR5ISDdb2
         T2QVsEf7lr4nFRNYTLka+a3ROEyHNUpHko+gyUwzmR8vAeu72HjFUqsG7N/lFSJLtJnR
         s2rJvn4Akm8fO+ymz5CwQy3YwQIjFJUoB5hRP6vWbJwQVxrEfcemxAF5mtQF8yCU3242
         07IA==
X-Gm-Message-State: AOAM533ap+vAsrpipV/zzbqaQsP+0EViR26hz4JwCAZ63Nr7IjMFVg0Q
        biHS8iVEFfuSI21WFfUcc2NEgfHEpnUVfhJ5
X-Google-Smtp-Source: ABdhPJwOho3vz1015JaPZPGvivUvkPzuD09czLzgw8tNib5JsVZWBogUj940HIu9+Qtyn0NNFZ80Bg==
X-Received: by 2002:a05:600c:154d:b0:394:880f:ae3a with SMTP id f13-20020a05600c154d00b00394880fae3amr63424097wmg.13.1654699203653;
        Wed, 08 Jun 2022 07:40:03 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c154600b0039c5ab7167dsm5802344wmg.48.2022.06.08.07.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:40:02 -0700 (PDT)
Date:   Wed, 8 Jun 2022 15:40:01 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Helge Deller <deller@gmx.de>,
        Paul Mackerras <paulus@samba.org>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] fbdev: Use backlight helpers
Message-ID: <20220608144001.2gf6iaj3kvagowiw@maple.lan>
References: <20220607192335.1137249-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607192335.1137249-1-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:23:28PM +0200, Stephen Kitt wrote:
> backlight_properties.fb_blank is deprecated. The states it represents
> are handled by other properties; but instead of accessing those
> properties directly, drivers should use the helpers provided by
> backlight.h, even in cases where fb_blank isn't involved.
> 
> This will ultimately allow fb_blank to be removed.
> 
> Stephen Kitt (7):
>   fbdev: aty128fb: Use backlight helper
>   fbdev: atyfb: Use backlight helper
>   fbdev: radeon: Use backlight helper
>   fbdev: mx3fb: Use backlight helper
>   fbdev: nvidia: Use backlight helper
>   fbdev: omapfb: panel-dsi-cm: Use backlight helper
>   fbdev: riva: Use backlight helper
> 
>  drivers/video/fbdev/aty/aty128fb.c                       | 6 ++----
>  drivers/video/fbdev/aty/atyfb_base.c                     | 8 +-------
>  drivers/video/fbdev/aty/radeon_backlight.c               | 6 +-----
>  drivers/video/fbdev/mx3fb.c                              | 7 +------
>  drivers/video/fbdev/nvidia/nv_backlight.c                | 8 +-------
>  drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c | 8 +-------
>  drivers/video/fbdev/riva/fbdev.c                         | 8 +-------
>  7 files changed, 8 insertions(+), 43 deletions(-)

FWIW, from a backlight point-of-view, whole series is
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
