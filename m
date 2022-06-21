Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0492F55321D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350420AbiFUMfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350445AbiFUMfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:35:14 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D59828999
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:33:36 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s185so7256087pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nnytQ1/ffqTsaS1FtzsCOYrd2Ew04ibpssFxI3aXf+o=;
        b=S7i9eupIHzFHB5KN8Z3gSiF3ofQv0ujfsgVNY9U5wLCD662ABpSnLw2ittUAnPf8Cf
         4o+W/mhi7nfTsdN1pARWMedKzARy/KFcPOBFL2io7bEq9FqqolcYGV+XHeQmdDLUYxo+
         Ad8OaKogjXrB9SQCLmQgepv4rOMBXciWFES7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nnytQ1/ffqTsaS1FtzsCOYrd2Ew04ibpssFxI3aXf+o=;
        b=70V0iHfI8byqTUbrUvtHmSd+bhlRJnbsWHwMWv9sKAC3g2CJo9Tn69vkVoaIsOilPm
         jNvxrQ7T6gY810MF4no7RFiGmC1j5hpRqVYAgiweAme9lt5XYA0k9EcGvr1F+ZvAQZWy
         Z6iECFP/fqELXNi3rZb5c6rVJ9Yp5ieb57PQULStFN8WETfL5yUSpsArhDEG4CACk4tp
         6Fh70f2w14CaYiZTR8QQgh4WfnlA8YUei1A3G2PJuqAxnpsLlElcsVrPa7xk1wteW5Bb
         IBjNm111kB4ZuJnh+ba11eh+Losji6+WwXwV6oOmmJ6Yhqr2yf16dbMuEiAB+LpY6fh+
         SpNA==
X-Gm-Message-State: AJIora/Fx4TNxIkqgCIxNOEG5gajPhAcIUNhcb8s7mRKTs+G3jg9UAO7
        F0Q8/JpuPxwnVa5qek0hSwcWxQ==
X-Google-Smtp-Source: AGRyM1s5Hq05EtE0xvSbYDisIVMCshaUq1aFG2xwRyYLnsWFK1yNfOYvPbWsL2i+HzYZvWUk1SUzHw==
X-Received: by 2002:a63:bf43:0:b0:40c:dc14:ed26 with SMTP id i3-20020a63bf43000000b0040cdc14ed26mr5716464pgo.51.1655814815963;
        Tue, 21 Jun 2022 05:33:35 -0700 (PDT)
Received: from 54bcea96c890 ([203.220.223.63])
        by smtp.gmail.com with ESMTPSA id ik15-20020a170902ab0f00b0015e8d4eb2d8sm10508035plb.290.2022.06.21.05.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:33:35 -0700 (PDT)
Date:   Tue, 21 Jun 2022 12:33:27 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 000/141] 5.18.6-rc1 review
Message-ID: <20220621123327.GA12@54bcea96c890>
References: <20220620124729.509745706@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620124729.509745706@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 02:48:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.6 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Jun 2022 12:47:02 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.18.6-rc1 tested.

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
