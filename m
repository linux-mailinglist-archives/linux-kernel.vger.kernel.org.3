Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF8E504A37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 02:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiDRAxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 20:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbiDRAxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 20:53:17 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFB613EB4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 17:50:40 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l9-20020a056830268900b006054381dd35so2760675otu.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 17:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rbBsewLQ28VXBD2dckSK5/fcybm99fyel6P5elhP/LM=;
        b=cTjE64825xtXj3L0x+9E2BwW3a6Ki9Ik09giBL8q9qFRPl8gVayqHwdxROR5jc+PP3
         ZNUumDHiMFN4XJtNsuD2FpPzratE4o67M4tB9ZUPDNu4EQXyboAXIF+9bjHpvlRqrcjd
         ARN6FVfkkKPdaRAYxmYNd65JEk0A+Zc2kNSagsRN84QJ2+r315rSrVjpcUZgmIzhh9uT
         u2Bya1mRfRIpxCUsONAXS4zSFcWEfIeaHFlScdldYoqsPfl6OXfrKyePPLaswi/dOcZL
         4b4puryY50j0ANudn2jbquBuZST52PxEWXvife+HwRqEyAdoKSzvDJ1cgYKU47rsZLuT
         rp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rbBsewLQ28VXBD2dckSK5/fcybm99fyel6P5elhP/LM=;
        b=KGEmefwldeyCXTVOYRwic6Uyws/2jfd/QcgCJlTBrJ65i1/IQda0tOMHmRrtJMBCqK
         m/mY9NboCzGlwcLOJjIoa/hD3bIBgYVGA6whjKZ/7f4kb5+YgNeGOwwYiKEzqcZmeTLx
         Pd151LZPBVbL6/3pxd9aelelQqrbZwNtCGghGZNShdFnBTKu/hA/VBbNIR0Q0lQVSdW8
         VHrWeTeXfgjGpmKPBc/ENg/ZOU0y+BdhPzBRCb+biLLcDEF6GDkVk4wXH4NmlVJO04Pj
         256uZMMOBAC+q471dwdB6t3r+HchLkLbDfUNAytrUXkBvDwyxpTEH2/Pb+x0RPxPteL6
         a1IQ==
X-Gm-Message-State: AOAM533dYbR2YV9DbWW6dhx/YJdCG59Eij99SmiGHsQmoZmkRdmuvKA1
        UxAhKCVDTygpqan6K4LtHzKgKOPgQ74=
X-Google-Smtp-Source: ABdhPJxOPZBc53jD1LNhllw3e8fw+cGAHjoIYDvs0Nty84nLBvaI7U69yeGhcsXQy9zDqJEatNQn7Q==
X-Received: by 2002:a9d:644b:0:b0:5cd:a627:c439 with SMTP id m11-20020a9d644b000000b005cda627c439mr3164477otl.112.1650243039825;
        Sun, 17 Apr 2022 17:50:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o133-20020acaf08b000000b002ef7562e07csm3484242oih.41.2022.04.17.17.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 17:50:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 17 Apr 2022 17:50:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.18-rc3
Message-ID: <20220418005037.GA1094849@roeck-us.net>
References: <CAHk-=wgBR6P8EseYMjfMjxQ_oTpoQmL0qvKpAw04kP-HBgSGFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgBR6P8EseYMjfMjxQ_oTpoQmL0qvKpAw04kP-HBgSGFg@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 02:19:01PM -0700, Linus Torvalds wrote:
> It's Sunday afternoon, and you all know what that means. It's time for
> another release candidate.
> 
> (Yes, yes, it's also Easter Sunday, but priorities, people!)
> 
> Things continue to look quite regular, although the diffstat may look
> a bit odd due to some email  updates that ended up causing a lot of
> spread-out one-liner updates in the devicetree files.
> 
> There's also a series to sound card probing error handling fixes ("Fix
> the missing snd_card_free() call at probe error") which ends up
> showing as a lot of few-lines across a number of sound drivers.
> 
> But it all looks pretty small and fairly simple. Famous last words.
> 
> Please do test,

Build results:
	total: 151 pass: 150 fail: 1
Failed builds:
	m68k:allmodconfig
Qemu test results:
	total: 489 pass: 489 fail: 0

Building m68k:allmodconfig ... failed
--------------
Error log:
sound/oss/dmasound/dmasound_core.c:1431:12: error:
	'dmasound_setup' defined but not used
 
Caused by commit 9dd7c46346ca ("sound/oss/dmasound: fix build when drivers
are mixed =y/=m"). Fixed with
https://vanko.io/project/alsa-devel/patch/20220414091940.2216-1-miles.chen@mediatek.com/

Guenter
