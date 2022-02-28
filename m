Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB80C4C7C11
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiB1Vcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiB1Vcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:32:33 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C5F12F43E;
        Mon, 28 Feb 2022 13:31:53 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v5-20020a17090ac90500b001bc40b548f9so362456pjt.0;
        Mon, 28 Feb 2022 13:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=k66+0NBdInfEOq9yxFpLr2boMVNjFk29RdvxyccfnqM=;
        b=cd+CwlxhWN0+XEO/CMr7/TW9Jrf93W7Bvb65TNuTnny0CQbIlQOmnIeofW3+8mRGDx
         mSD1Cc+ZMv/qFGUj27TnfFtW+ksRFBkY7Eactutxxnr+amWESbStFmKgC4DzKQzoyY0e
         /e6/7rCZpzrI0mdorKIACxrmhI4gzkuXkeAagzyMirxZATA0/Uuz7Kh04c4nKnjTXmYN
         EG9KZSj3w0lIqnWfjp+ZjgKxx/dn1tDyf/O5wqfGlwil3abwhzPIzkvSbXCQO8BbQg33
         8y8y8KgRP8OfvaNd1hXkYKleZpHmgmW33emZ4QZVVAvBEyUF2BrCsT1UyrugZNMGL2Rl
         A3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k66+0NBdInfEOq9yxFpLr2boMVNjFk29RdvxyccfnqM=;
        b=Z8BFzCn5zHzDda0aaQeqTMesZydXgTrhh/okcalg5ruER9+KGLm+avO0q7JMQ3x5H3
         gKlsbrudqai/cK6F0PxJ7c5l6A7XFGI4s8sRkrYWWH4MG2GIMmcBCQ963Gfu6SH0p2dD
         e+l/iL/JfiFAHmjLN4TbUO5U1PavUAbgVTHLlXFmO3dXTD7gWihvs44zO9y0u5GtXjb3
         FOIArI4NKUt8ormtQlU7FxT/soU3kcnfXqvk8FYGsx6M2h5hlhh1u0StFljjRHWhUD+g
         RHbVydn6ynJbxvpwsU3rM1wOpLTp2tJ6FjEAdf/xnT0WnCuQnkoA3Z2HULv4DwiVeeLy
         osgw==
X-Gm-Message-State: AOAM533LagkrRP0inRhCvvfDALubrKhypcpaCC9+lbYlDZXLFgIpLTZc
        EtfnbLXHT2B8WsvVY/jXJ2U=
X-Google-Smtp-Source: ABdhPJylCG8LedKReihawuPUm4WE5/20Ku9HoR+cBvnCqpjdo6asB1ev36fEl8Yj/GWGRfHHk/1u7g==
X-Received: by 2002:a17:903:24f:b0:14f:73fa:2b30 with SMTP id j15-20020a170903024f00b0014f73fa2b30mr22474458plh.174.1646083912552;
        Mon, 28 Feb 2022 13:31:52 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id l9-20020a655609000000b0037589f4337dsm11386450pgs.78.2022.02.28.13.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 13:31:51 -0800 (PST)
Message-ID: <bdb6a903-6efc-e7ff-3a88-70ad9fe3fc09@gmail.com>
Date:   Mon, 28 Feb 2022 13:31:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] arm64: dts: ns2: Fix spi-cpol and spi-cpha property
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220228110903.97478-1-singh.kuldeep87k@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220228110903.97478-1-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/2022 3:09 AM, Kuldeep Singh wrote:
> Broadcom ns2 platform has spi-cpol and spi-cpho properties set
> incorrectly. As per spi-slave-peripheral-prop.yaml, these properties are
> of flag or boolean type and not integer type. Fix the values.
> 
> CC: Ray Jui <rjui@broadcom.com>
> CC: Scott Branden <sbranden@broadcom.com>
> CC: Florian Fainelli <f.fainelli@gmail.com>
> Fixes: d69dbd9f41a7c (arm64: dts: Add ARM PL022 SPI DT nodes for NS2)
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
> Hi,
> 
> This patch is on top of git://github.com/broadcom/cygnus-linux.git,
> master branch which is not updated since 4.14 kernel.
> Hope the reference is correct. Thanks!

The reference is not correct, but it applied cleanly anyway. The correct 
reference would have been the github.com/Broadcom/stblinux 
refs/heads/devicetree-arm64/next

Applied, thanks!
-- 
Florian
