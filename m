Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957C558AE4F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbiHEQn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiHEQny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:43:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995BA1581C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:43:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w3so4102848edc.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=RjlAE1bDXXp4HDJF+2mcQXBU2IPR7RnkcGIixgvhqQE=;
        b=QdolgzFU7nxQe/dQ2LOhT1Yg7cAzE0MdA+20Mp50S1fk7aPCiJmmBAhP/XQxOtOBeQ
         mHU2vDwtZpUQbV+dp9lteDW9Xvygr7yEtzaeyd3XvYOpwwAwO7XmPz+g/oDXp++26btk
         BWXVv2w49lrw+/VkrszLSDCEQ+JWE6sJtp7N2CnQ5ODOd7uOCoByulXzr36RdoJNxV5S
         UcsFwJTjiqDBakf58sxyf/gOB7GJBPZExk8lE6YYUXiM6QAgqUa/K9eo8YzcnlpMUWsA
         Ykoq95p92BquHw2Dk3IUa+alHPfimQt+NEGPoCgUE9XroSqY8ajpVKbylNbdWgFCcWCk
         OVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=RjlAE1bDXXp4HDJF+2mcQXBU2IPR7RnkcGIixgvhqQE=;
        b=R4m7mrCs/1ohC3QREYx6a2hDzhFGaG2WqZbGsOpTT/qeHktBXFoG0BUPmstq+LeXYv
         Id1WKV+0hh73JxuMqzJhYCzbg33LbHSH/4vxr/OUvpZb48fGEgImI2HsAgq8JIE7CMX3
         DDk0l0j16vnhqhe+pz91e4OLHOdW3i/NP4PRTPZIAOVIGmWqKBn6iIJalJKZHZCydfbj
         L4dWpjFrUVcylFoxVjbT42CU520aYaucHQ9203aXfwf7ylAyCh7MMFN4+ngqLJfB/TfL
         CaB4v+FZC03oJ1a39robXjA3ObRlo5I9+X0SG/sN5g563AkrYiVMpY9qmzFGxe+e3pkk
         o9qQ==
X-Gm-Message-State: ACgBeo0vIoaf7FKe851Zg7o7DGRqzS2WxWXxdiJOr9Lyti3FPvadZ5pt
        NlJdA3Kq5QkuiXQISymKW4OGPGwCusc=
X-Google-Smtp-Source: AA6agR69m7IIA5pQgvBv/jXnWdN7mZ7yFkL9gscYsV7z9vVAK2xMr1Hdzt0ovu0Yh9b/gEFUgvnB1A==
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id fj8-20020a0564022b8800b0043a6c586c64mr7516817edb.348.1659717832106;
        Fri, 05 Aug 2022 09:43:52 -0700 (PDT)
Received: from [192.168.1.103] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id a15-20020a056402168f00b0043aba618bf6sm118775edv.80.2022.08.05.09.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 09:43:51 -0700 (PDT)
Message-ID: <8b0a61dc-1d30-2731-4497-a69fff57cd2b@gmail.com>
Date:   Fri, 5 Aug 2022 18:43:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/4] staging: r8188eu: cleanup some metadata issues
Content-Language: en-US
To:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <cover.1659715931.git.gszymaszek@short.pl>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1659715931.git.gszymaszek@short.pl>
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

On 8/5/22 18:27, Grzegorz Szymaszek wrote:
> This patchset tries to improve the r8188eu driver metadata. Some
> hardcoded values are replaced with proper macros, some unnecessary
> macros are removed.
> 
> Changes for v2:
> - added a cover letter and a base tree reference;
> - added Philipp Hortmann's Tested-by;
> - replaced the second and the third patch with different ones, per Greg
>    Kroah-Hartman's suggestions to make better use of existing kernel
>    macros and remove unnecessary ones.
> 
> Grzegorz Szymaszek (4):
>    staging: r8188eu: set firmware path in a macro
>    staging: r8188eu: use KBUILD_MODNAME instead of a string constant
>    staging: r8188eu: drop the DRV_NAME macro
>    staging: r8188eu: drop the DRIVERVERSION macro
> 
>   drivers/staging/r8188eu/core/rtw_fw.c       | 2 +-
>   drivers/staging/r8188eu/include/drv_types.h | 4 +---
>   drivers/staging/r8188eu/os_dep/os_intfs.c   | 3 +--
>   drivers/staging/r8188eu/os_dep/usb_intf.c   | 2 +-
>   4 files changed, 4 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 9de1f9c8ca5100a02a2e271bdbde36202e251b4b
> prerequisite-patch-id: 79964bd0bcd260f1df53830a81e009c34993ee6f


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
