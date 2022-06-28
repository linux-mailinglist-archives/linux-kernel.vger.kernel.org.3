Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5583355DDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbiF1BVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiF1BVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:21:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809BB1CFE0;
        Mon, 27 Jun 2022 18:21:04 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x20so4097661plx.6;
        Mon, 27 Jun 2022 18:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/OM7p2xmgcLKvrCC4aR5bM7KnQIk44Oxh3ZTj61eUw0=;
        b=hb270D/YuXBN9rdMINPybXWvsxPWW54PdpujAxfPoZTib4Dc4NiJwZAEKXtbSkyNcq
         uEK5RgTrKHhASICLGIuE2Nxs+PFwlcKOKe2YJWfwoIQhAaUfmU2NLaTVnSvKYg3ESioo
         mO0Ri4+NYsV6jDkgsUNJa36AdmUVvHZxzaaPuJFL/yMeCW8n1DrC+iR/l1/atePvzqJM
         Ct/xfrNfbOL3ZWiLnXAtfj4iIvTukb9WsZWC86NAEFnnIr/JtmZDaWzhs54f6eLCXsZf
         3J9dWwYwxvocO6cN3BOgFuVzR4LSn0S2bhWSV25QUaWRrEtbotWgwObsrbejhQdhjTY1
         DmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/OM7p2xmgcLKvrCC4aR5bM7KnQIk44Oxh3ZTj61eUw0=;
        b=fP8Qm3wSyJNX14KdmMCGgrDuJaTi3kt9OXQ+w4XQFLXoOVAVW1hbIlPfCRXKzfc9Y+
         6np1iQUzoRl5kRuR5h5/H5VKNsYCFdyJNkDwvXGuq/AqIErboUERMykri2+qLYbnGPJ1
         9Sw+xZmWcVCyAxjwt7eY3Ja/8Jyfxp8jSiGTk5SLeuSxQCmkttjEB5Kklm8DiVDOEy4K
         g9hojLKiALDO8nxd+Q4tTwQvliZGFSbMBzrmxbY/k7ZXkG7g7aeY5opKMC25FXEAonbm
         TTyULqyJNZBa1EMWrtF6zVJ/8vy21QtRrVqYcS0tk0sMxPbdsvBk/V5z6LH9X3oFihyR
         CorQ==
X-Gm-Message-State: AJIora9JHGXJ8CDb61xBXPmeicFW7Cm4wvTxYZxbhqbpvtEyGfG7ocfy
        syGkd5yN+M3kd5zkKLuBEepO5ZJjrro=
X-Google-Smtp-Source: AGRyM1vtFKI769HEoE3iMPmPbjYiqTEoKyKL1RWA//bv2hGcT8xrkpnuRlfL7sT7pu6CN8L7XwHjJQ==
X-Received: by 2002:a17:90b:4b0e:b0:1ec:dd93:5113 with SMTP id lx14-20020a17090b4b0e00b001ecdd935113mr23734613pjb.12.1656379263107;
        Mon, 27 Jun 2022 18:21:03 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-39.three.co.id. [116.206.12.39])
        by smtp.gmail.com with ESMTPSA id 21-20020aa79115000000b0050dc7628171sm7884690pfh.75.2022.06.27.18.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 18:21:02 -0700 (PDT)
Message-ID: <bd2957f4-3793-d876-8b1f-1dbb9cf160d1@gmail.com>
Date:   Tue, 28 Jun 2022 08:20:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 06/11] docs: process: remove outdated
 submitting-drivers.rst
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
 <20220627151819.22694-7-lukas.bulwahn@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220627151819.22694-7-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 6/27/22 22:18, Lukas Bulwahn wrote:
>  There are numerous sources of information on Linux kernel development and
>  related topics.  First among those will always be the Documentation
> -directory found in the kernel source distribution.  The top-level :ref:`process/howto.rst <process_howto>`
> -file is an important starting point; :ref:`process/submitting-patches.rst <submittingpatches>`
> -and :ref:`process/submitting-drivers.rst  <submittingdrivers>`
> -are also something which all kernel developers should
> -read.  Many internal kernel APIs are documented using the kerneldoc
> -mechanism; "make htmldocs" or "make pdfdocs" can be used to generate those
> -documents in HTML or PDF format (though the version of TeX shipped by some
> -distributions runs into internal limits and fails to process the documents
> -properly).
> +directory found in the kernel source distribution.  Start with the
> +top-level :ref:`process/howto.rst <process_howto>`; also read
> +:ref:`process/submitting-patches.rst <submittingpatches>`. Many internal
> +kernel APIs are documented using the kerneldoc mechanism; "make htmldocs"
> +or "make pdfdocs" can be used to generate those documents in HTML or PDF
> +format (though the version of TeX shipped by some distributions runs into
> +internal limits and fails to process the documents properly).
>

Did you mean "beware that TeX distribution version as shipped by distributions
may fail to properly generate the documents"? I have never tried pdfdocs,
since the dependency requirement can be huge (hundreds of MB needed to
download packages), so I can't tell whether the phrase is relevant.
 
> -  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>` and :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
> -    These files describe in explicit detail how to successfully create
> +  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
> +    This file describes in explicit detail how to successfully create
>      and send a patch, including (but not limited to):
>  

Maybe "This document" instead of file?

> @@ -12,9 +12,8 @@ This document contains a large number of suggestions in a relatively terse
>  format.  For detailed information on how the kernel development process
>  works, see Documentation/process/development-process.rst. Also, read
>  Documentation/process/submit-checklist.rst
> -for a list of items to check before submitting code.  If you are submitting
> -a driver, also read Documentation/process/submitting-drivers.rst; for device
> -tree binding patches, read
> +for a list of items to check before submitting code.
> +For device tree binding patches, read
>  Documentation/devicetree/bindings/submitting-patches.rst.

The hunk above is OK.

-- 
An old man doll... just what I always wanted! - Clara
