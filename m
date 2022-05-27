Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BE1536701
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354263AbiE0Smy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244925AbiE0Smv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:42:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A052101E7
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:42:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k5so638665wrd.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/FfqEuqYsoYBH9BqWPgEI0X7vtMAlkOKI53z/x9ljKA=;
        b=a2c6NEIN3y/nYEhLsYo11LjIlTVy2FQXsq3C4LB3KwUdq0ld2EjY1vtjMquttnxNPd
         iewaBFDgbPbLmpffB7oZCVE7kTAnWZSfg8iUSkSXEtPrRUWX5o3wstSCurJ5xjKhgtyw
         7FlPNtKgQPSWj1gPOSKfUOi+/y3arR5umOBZg1fE2QuvsENlkFn712csg9+Y5Gz7Hbo0
         U5uJ29L/ZDgFN0TDAhs+2RNFVfpnMLSsgZfqE7uERxQMjJwMqDJKsw2q+R5sVm2cxHox
         1QSlcrfuvo2Mt+GrFyhsIf8wbrdbCaOK4f1tWekfn5TCW1d25tbMUbCtYwn5she9fghW
         UmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/FfqEuqYsoYBH9BqWPgEI0X7vtMAlkOKI53z/x9ljKA=;
        b=oNAlSR0+K1nutZF5OmrUzwT/+Dh1dWF8G7GyZxrp9vdtMSaQPeFrp7zQXEWRYDoxlC
         B2PSZLrbJQ7sNq8mOFuy3tBlpufj2n1R0n2P1IQRFvndzzBD1wCdTZx6OKvRrTXeyJjD
         UKaihASyxzVUaMCaEtHbICXs38CQvoQ2dFyPZ6vlis0Uy42f1cC66pVmKf+aku220xej
         aIm7JAdgqayU9eKVDJQUHve4/A39CMT4sjyghnL/w1Aj0DOLSE1Z+nxsA8ufVm5xjtQY
         9mtIwnZ7VmS8OLrarOxOMK4EOL3lbH3wd2YtH4M7+69vFk7X4qSVhjDW3cOJn0SV8MFM
         6l9g==
X-Gm-Message-State: AOAM532mxqIX32U7VPB6PriGv23FfAV8stk0lpCtT+1J6Dli9PYMl8xe
        F4kvPVFN7OAc0x+pnejNtBw=
X-Google-Smtp-Source: ABdhPJyU7aV3eXuKoLVF22q8YpyzjY/eyXUYrukOmK/dDtaDK5orO9Scgfdf/5bxWSM/kh24UIuTgg==
X-Received: by 2002:a5d:5955:0:b0:20d:4b4:9879 with SMTP id e21-20020a5d5955000000b0020d04b49879mr35386889wri.550.1653676967872;
        Fri, 27 May 2022 11:42:47 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id l6-20020adff486000000b0020c5253d907sm2354149wro.83.2022.05.27.11.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 11:42:47 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Update Xen maintainership
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        jgross@suse.com, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
References: <1653674225-10447-1-git-send-email-boris.ostrovsky@oracle.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <69716937-59d0-b316-2a42-94194c79320c@gmail.com>
Date:   Fri, 27 May 2022 21:42:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1653674225-10447-1-git-send-email-boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27.05.22 20:57, Boris Ostrovsky wrote:

Hello Boris

> Due to time constraints I am stepping down as maintainter. I will stay
> as reviewer for x86 code (for which create a separate category).
>
> Stefano is now maintainer for Xen hypervisor interface and Oleksandr has
> graciously agreed to become a reviewer.
>
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Acked-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>


> ---
>   MAINTAINERS | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6d879cb0afd..b879c4e6750e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21549,23 +21549,29 @@ F:	arch/arm64/include/asm/xen/
>   F:	arch/arm64/xen/
>   
>   XEN HYPERVISOR INTERFACE
> -M:	Boris Ostrovsky <boris.ostrovsky@oracle.com>
>   M:	Juergen Gross <jgross@suse.com>
> -R:	Stefano Stabellini <sstabellini@kernel.org>
> +M:	Stefano Stabellini <sstabellini@kernel.org>
> +R:	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>   L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
>   S:	Supported
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
>   F:	Documentation/ABI/stable/sysfs-hypervisor-xen
>   F:	Documentation/ABI/testing/sysfs-hypervisor-xen
> -F:	arch/x86/include/asm/pvclock-abi.h
> -F:	arch/x86/include/asm/xen/
> -F:	arch/x86/platform/pvh/
> -F:	arch/x86/xen/
>   F:	drivers/*/xen-*front.c
>   F:	drivers/xen/
>   F:	include/uapi/xen/
>   F:	include/xen/
>   
> +XEN HYPERVISOR X86
> +M:	Juergen Gross <jgross@suse.com>
> +R:	Boris Ostrovsky <boris.ostrovsky@oracle.com>
> +L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
> +S:	Supported
> +F:	arch/x86/include/asm/pvclock-abi.h
> +F:	arch/x86/include/asm/xen/
> +F:	arch/x86/platform/pvh/
> +F:	arch/x86/xen/
> +
>   XEN NETWORK BACKEND DRIVER
>   M:	Wei Liu <wei.liu@kernel.org>
>   M:	Paul Durrant <paul@xen.org>

-- 
Regards,

Oleksandr Tyshchenko

