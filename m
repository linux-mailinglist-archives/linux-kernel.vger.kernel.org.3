Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C599552074C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiEIWHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiEIWHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:07:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F9E2A83C7
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:03:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c9so14432439plh.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 15:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+mWa3oMEkh4XA9cDfwHg0VqdUr0bDZ32vKcsE3CO8fo=;
        b=nCgxGG18DIMgYys7H/4/hF/VD4t44Hf1UBIzqy1mxN+2wXrVcXuT0f6XzXP6eWYBun
         1w9kgnYwd8j9bmivGsEwxCwwiuC3qqMiR4JZmHnkPPKOj/Dne1kAG9oUGZgcndyt9noD
         72rf6Yd+6psUbZ5aVwLruReYY0jkeX2+XndzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+mWa3oMEkh4XA9cDfwHg0VqdUr0bDZ32vKcsE3CO8fo=;
        b=DiwCO0BYhT0bAZn6VFTmrOt/uYOo7hFtdR+hlTWQQY1q63RNvxRKeJFJv0yHhJmtcN
         cZY4OHyVMT0vMO804V4FNLIsB2jKE49jv/Y4cXk1Esb7AGWAkB2D1waMT/WqpnGsk5zD
         k3sKAEQde8wI9AZ8bqLeH42bUURF036TLjR3H/PLuM1peHjyrzN3c+1jdBiBndVR38cP
         KQXbDo1QmnOr8+DLO+7gx6FFEEspNfP9DEgQJgYXEbR59wkparUnd7+Ev8fz3grniv4p
         FwU+Ufwso5hpAc+4HDqZnUZC8YurUpvTsNfyoB3LG9wRBG0W/NvNqV78bemAsuoeD5eJ
         DAaA==
X-Gm-Message-State: AOAM531TxtQcQ1Jgd+2XIpKvD1K6WslZJWhIVCMF6R/veq8RVcznjgnw
        S7gMYgGRBoxuAVUnrilXvcKO4g==
X-Google-Smtp-Source: ABdhPJyQ8MrViyQYFV8VcRDY37VUC65pvcsBo5fZrywDTtgEvI94XKV7yWsFBEcxR6GfhWgAyidg3A==
X-Received: by 2002:a17:903:2344:b0:15e:bc62:bda7 with SMTP id c4-20020a170903234400b0015ebc62bda7mr18084266plh.120.1652133830033;
        Mon, 09 May 2022 15:03:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bx1-20020a17090af48100b001cd4989fec6sm204245pjb.18.2022.05.09.15.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 15:03:49 -0700 (PDT)
Date:   Mon, 9 May 2022 15:03:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     ira.weiny@intel.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 08/44] Documentation/pkeys: Add initial PKS
 documentation
Message-ID: <202205091501.132944B2C7@keescook>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
 <20220419170649.1022246-9-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419170649.1022246-9-ira.weiny@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:06:13AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Add initial overview and configuration information about PKS.
> 
> Cc: "Moger, Babu" <Babu.Moger@amd.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for V9
> 	Feedback from Dave Hansen
> 		Remove overview and move relevant text to the main pkey
> 		overview which covers both user ans kernel keys.
> 		Add an example of using Kconfig
> 		Move MSR details to later patches
> ---
>  Documentation/core-api/protection-keys.rst | 43 ++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
> index bf28ac0401f3..13eedb0119e1 100644
> --- a/Documentation/core-api/protection-keys.rst
> +++ b/Documentation/core-api/protection-keys.rst
> @@ -13,6 +13,11 @@ Pkeys Userspace (PKU) is a feature which can be found on:
>          * Intel client CPUs, Tiger Lake (11th Gen Core) and later
>          * Future AMD CPUs
>  
> +Protection Keys Supervisor (PKS) is a feature which can be found on:
> +        * Sapphire Rapids (and later) "Scalable Processor" Server CPUs
> +        * Future non-server Intel parts.
> +        * qemu: https://www.qemu.org/2021/04/30/qemu-6-0-0/

It looks like QEMU has pass-through support, but not emulation? It'd be
really nice to have this feature emulated so it would be possible to
test the code. (Or I need to find a machine that supports this...)

-- 
Kees Cook
