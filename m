Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E174BC9A0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 18:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242734AbiBSRyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 12:54:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiBSRys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 12:54:48 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB7865152;
        Sat, 19 Feb 2022 09:54:29 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u20so11193671lff.2;
        Sat, 19 Feb 2022 09:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aoZkz4UcqkbcbdkBIaYothPTAVInA8f47sKV7OByCA8=;
        b=V05F1qg9f4nbiwXkgAbj6ZupT1vhyiVl+oRG2Cb72we2lGfczwVY5Hrsq7P5izsqOX
         Jzh5Xj+Gwz6iNZ2fw601ehpiQ+HttwigtxD5rOh2KVkMMnaFIQ6eOQpVT3RBZe8nT+1S
         3RtcX5CTCmsgG88DqViob+rNiEN6HGEcaaRmNvUyhLGZiLwv7jcaRgIGQfCLvy/sKMPp
         Z4DtHnEzaP7/oGctss4mUdtZ7ucRZv2phgcJBBoqIgc68C6qig8bdTiPZJy5tLB5vJvb
         dPjcJPN9hXsMvugSHTwQgtFfAOJEdNIxR5fOtKAlEdPFAyXr2lAtUizSi/gfJMgcbg4s
         bLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aoZkz4UcqkbcbdkBIaYothPTAVInA8f47sKV7OByCA8=;
        b=6yqnKA1LDz52zli0i0vDrQL+no6db8rti09D+NHKsIPBNAt2QJ6XfbwCgz8PAZZoZB
         u6huig02U/ljVeoUl8msrj31xCVxTPsqCak1yBXKFCq/5d/khyA0ZH78GQvvAXBejpP5
         6OGOBGrG9ltOPMnMH+9cVA3xGip6gkNLmmzFtrrlDbt/uqtROlIYCfPWDlkHZaDekeIS
         e5/zx1IJ3RHQFwgReJtGJNDiO2XtAFCQJT2UcqZTLfkzUJubuFdm0AubL5krn3svNu/X
         5nm/qJZ0sOtF4GqWI6Ro5Dc6nbYDxBY6jC/cV8F/qQ7rIny/do0jTo+JClawZXSyfZRz
         +3ZQ==
X-Gm-Message-State: AOAM530e0fH5l+FLWayBQsiOznoW52a37wYma/eww5n1hELCtdZX9+kE
        9GXBMKHUDxz2k67V9M4nFBR7Qd3Y8yo=
X-Google-Smtp-Source: ABdhPJyZm5rpdUuzDAVCO59dU5XnbDOQjopGFqtKzdhrYSb/gAp9nQZmNiw36/eNkNYap3Bi46Jbbg==
X-Received: by 2002:a05:6512:220b:b0:42a:1481:a977 with SMTP id h11-20020a056512220b00b0042a1481a977mr8836563lfu.293.1645293267754;
        Sat, 19 Feb 2022 09:54:27 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id f19sm390690lfh.264.2022.02.19.09.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 09:54:27 -0800 (PST)
Message-ID: <1c97bbb5-ba0b-742c-2a21-8abf195b9e6d@gmail.com>
Date:   Sat, 19 Feb 2022 20:54:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/9] gpu: host1x: Add context bus
Content-Language: en-US
To:     Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org,
        robh+dt@kernel.org, robin.murphy@arm.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-3-mperttunen@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220218113952.3077606-3-mperttunen@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.02.2022 14:39, Mikko Perttunen пишет:
> +config TEGRA_HOST1X_CONTEXT_BUS
> +	bool
> +
>  config TEGRA_HOST1X
>  	tristate "NVIDIA Tegra host1x driver"
>  	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
>  	select DMA_SHARED_BUFFER
> +	select TEGRA_HOST1X_CONTEXT_BUS

What is the point of TEGRA_HOST1X_CONTEXT_BUS if it's selected
unconditionally?
