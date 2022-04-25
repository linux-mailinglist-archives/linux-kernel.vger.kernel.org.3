Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDCB50DD32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiDYJy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbiDYJyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:54:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAEF3FDA7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:51:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u3so20017342wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JVRowZf7Y6lrQhVcOg9o/xME5QnsN42CZSfKjMBpsVY=;
        b=AWblNvq5Vx8bJ2t3TobVYKoX3WPueHB8vpiAy+dfkpcOkIQTNoUMsRUaV3dE+EzTyp
         1iUFBD5joI4TL1RPx1QYh0IaM+lWrrBAcM7glXzAdYGZ9LYm3eL4/ECGObXO4fiLYCUu
         VkiNOmsHAAtqx+4hS+4DU6/4mk5y5VU04mVtfybkGAasaSSiP2SgrMXgNnUo8k++4cj7
         S8SQJ1goIJTzkjpWexFH4JeyZFz8JX5zMcWdx22m9s+6gL8wE4FLjAMQXdbYSRZhueEr
         SDrRHp1j5XfaeT6nbX1v/L47wWP/Uxip6iM+SBQ8EZMZEDJ/vsTMccNu/xQTRzbX6di4
         SMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JVRowZf7Y6lrQhVcOg9o/xME5QnsN42CZSfKjMBpsVY=;
        b=mnREsw2HmlyppCTVoidRoc4/e+xIUBryZTuNkpsirdRHMTQ6J9ZGbnpV562/+32JtN
         OPl7sHItRooeYCERfZVOQsUXyM390WwVjg8dwUdZoSmuW/PHD8CSMhKc+oIA1J8tWot0
         4EAiGw6Nupo6q1Fofam0SX1GXATYu7p/KtoJ88X/c/R2rrFb4tYZ14Qa6xnR+RxvtUkl
         govE+27+ZZhITnQqbPdBAmPeGAQa1oL0FbL1b10S4STn4iih40CGp6p2ogI83meadqq7
         +2xf4shvwNcwmnqKJ5NmcR+E6MvGOJhupTgj7UeLyvN9BolRjV+4EgFiHNUEp3plP2Uj
         BjEQ==
X-Gm-Message-State: AOAM532k7J8KcBmJPLR+DDl4zcElLINYwtdDJqP8ILh+9MMCwNt0S75v
        jKPVatLcWqXMCL30hRamFYA=
X-Google-Smtp-Source: ABdhPJxmm/Mx+A7bBbPnwj5NepOH7XAXLalTSTTHWEpgUPro0+lSCgHw5J65b7YjaQSme3tO+vXj/Q==
X-Received: by 2002:adf:d0d2:0:b0:20a:d81e:cb23 with SMTP id z18-20020adfd0d2000000b0020ad81ecb23mr5531373wrh.656.1650880260196;
        Mon, 25 Apr 2022 02:51:00 -0700 (PDT)
Received: from debian (host-78-145-97-89.as13285.net. [78.145.97.89])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b00393eaf94077sm3394482wmq.8.2022.04.25.02.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 02:50:59 -0700 (PDT)
Date:   Mon, 25 Apr 2022 10:50:57 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: Linux 5.18-rc4
Message-ID: <YmZvAUakbWnyQEqa@debian>
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, Apr 24, 2022 at 03:22:59PM -0700, Linus Torvalds wrote:
> Fairly slow and calm week - which makes me just suspect that the other
> shoe will drop at some point.
> 
> But maybe things are just going really well this release. It's bound
> to happen _occasionally_, after all.

My last night's mainline build failed for arm.
Build was with af2d861d4cd2 ("Linux 5.18-rc4").

imxrt_defconfig -> failed
lpc18xx_defconfig -> failed
mps2_defconfig -> failed
stm32_defconfig -> failed
vf610m4_defconfig -> failed

arm-linux-gnueabi-ld: mm/page_alloc.o: in function `alloc_large_system_hash':
page_alloc.c:(.init.text+0xe7c): undefined reference to `vmalloc_huge'


--
Regards
Sudip
