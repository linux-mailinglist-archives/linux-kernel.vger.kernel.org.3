Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7A4FF1F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiDMIdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiDMIdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:33:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356AD457A2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:31:28 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q12so1130784pgj.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=chGjcfefBnQ4BeBZDhW3oPLmrJW6azxv+NwFPPJzzAM=;
        b=DbI02QRbLh3TKahtEbJlM9IUfwo5nw9k7L49CekyKhC0YG1zNGhFunA9774GbfI818
         koamUo/NSFcZy4EUKnJRFP4oECkt3BzDtdmP6CFHrobN1j0F+qaAgfcj+Nc3sORKcTB5
         KHX1NejylgST4ZRTWpwL1eGElWNpGd+RrWvK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=chGjcfefBnQ4BeBZDhW3oPLmrJW6azxv+NwFPPJzzAM=;
        b=Jj2Klqu1yloeNxGDf/CgIvnY35WQRIR2pwR8b/5htaQhmMUsCXGtLUzTY61yniOKlt
         OOjQXwNauXh4bWXp3eGIuNf7sOZNHjHA717+AvILq69/hKV6d/HT4sAKxR8I0ua7mGZy
         U8yNnH9zRUVmRcOhyBZkENZlqP1SB6hySevmjhj412+HJ9xkgeT8x0cusvIqNhuE/jw2
         tgjX3avx4fa7SYdFV9HIkCeoPVHCTTWY35cZArITGNGQN/pPnp1xkhyu4QCOjxZlMGL8
         zN0MeouePUFlZsfuqcAnhT3R7PLsMYPFQSxBPK0zMFnxt11R7MqD/vEFnzZxs+TfI7g/
         WgFQ==
X-Gm-Message-State: AOAM5311mF5lszu9V7P/4+7m36u2tceCZ5vhJfI+/10XcA9uRk0TpgFI
        ClHVfljd8XvEhsLYMvLPJ+qLeQ==
X-Google-Smtp-Source: ABdhPJyUUR9gRYGMz39Fk8QlFmSeUjwOj6rgzZcR7HNHJMlUG6EXy1jLvDcbuzH2icNVHEZK0g1nkA==
X-Received: by 2002:a63:5525:0:b0:39d:40ed:5e3c with SMTP id j37-20020a635525000000b0039d40ed5e3cmr13651541pgb.20.1649838687567;
        Wed, 13 Apr 2022 01:31:27 -0700 (PDT)
Received: from 7b8f14d3d472 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id w123-20020a623081000000b005056a4d71e3sm20939203pfw.77.2022.04.13.01.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 01:31:26 -0700 (PDT)
Date:   Wed, 13 Apr 2022 08:31:17 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.17 000/343] 5.17.3-rc1 review
Message-ID: <20220413083117.GA7@7b8f14d3d472>
References: <20220412062951.095765152@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412062951.095765152@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 08:26:58AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.3 release.
> There are 343 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Apr 2022 06:28:59 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.17.3-rc1 tested.

Run tested on:
- Allwinner H6 (Tanix TX6)
- Intel Tiger Lake x86_64 (nuc11 i7-1165G7)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
