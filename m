Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783D353D945
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 04:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243514AbiFEC3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 22:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243467AbiFEC3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 22:29:10 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485537672
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 19:29:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j6so10063056pfe.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 19:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zmwdrkPzXm2zLB3I7uZQ7LfidxYJeRv45MlnmEANwf0=;
        b=nM+7bl0MGWutSe4tVSUsRTw7YIUHpQZNgWaltNcBVYw3GgpwA5HJxrSpH3VliKHzxD
         rfdvNh5gWHqdZLrV+Vj+DAvq5/rDUk4050PDiy9JlaMbku9TWTZ6dQwiR0yiRSHjPytq
         GgZsDyEgsoLMFtsgUVVscWBv41frnttpPm6uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zmwdrkPzXm2zLB3I7uZQ7LfidxYJeRv45MlnmEANwf0=;
        b=zC/qDePLomfQmOsGURo1tiZb6nN4Z4NjK6nMwQPDpmHJ70EfLh8WY2bL8gwesiqzdx
         HbeYCsKN10T6JdTUTMoZF2jX0keEew2Nqc6TkJQcUvQHm38Djxb+h27FUFxg+QyDz0Nm
         te8RIkqx6gxO45tr6U/dzPMztMPIuS2HNTQka8RlE7BjZiKN9Z81geT6K7GQVxionO8K
         TavvVxPWXRiR+AsEESsRLjJeCPY3YOkjDavzx537ueJTc1S9KWkWFJepZF8jlugtzCsf
         hqfbAF16tQoR441vlQC7WCtrpvHJCFHl3DtuvEPu4UNZJLcQdI0R2pjHYCA9bHCDQVnv
         CXqQ==
X-Gm-Message-State: AOAM532ecD6rwNcHLP6xB28AfEIW95lCFAZz3gtddFLvHGGKmWvSguXe
        kD5vml/NFmjNuosDPDDrOp9JAw==
X-Google-Smtp-Source: ABdhPJzCabmTySI24zEKZU3PooLkghD1bASDtXXDSHebcJDIFw13F7zEojNDmMRpFd5hFwQTxLAdzQ==
X-Received: by 2002:a63:874a:0:b0:3fd:3e1e:ca7f with SMTP id i71-20020a63874a000000b003fd3e1eca7fmr6980470pge.229.1654396147648;
        Sat, 04 Jun 2022 19:29:07 -0700 (PDT)
Received: from 1144aa5e55ff (194-193-162-175.tpgi.com.au. [194.193.162.175])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090a178500b001e3937f21absm7566873pja.19.2022.06.04.19.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 19:29:06 -0700 (PDT)
Date:   Sun, 5 Jun 2022 02:28:59 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 00/67] 5.18.2-rc1 review
Message-ID: <20220605022859.GA7@1144aa5e55ff>
References: <20220603173820.731531504@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603173820.731531504@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 07:43:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.2 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Jun 2022 17:38:05 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.18.2-rc1 tested.

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
