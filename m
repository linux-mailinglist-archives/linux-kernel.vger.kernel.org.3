Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472B952EB6B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348893AbiETMCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348941AbiETMB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:01:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EEF56202;
        Fri, 20 May 2022 05:01:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w17-20020a17090a529100b001db302efed6so7712981pjh.4;
        Fri, 20 May 2022 05:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HUR71Busz7rHoO3kdum5ovbPXwWOHM0ZF312TuUbImQ=;
        b=gVyVvvBuan5PEI1TjD1XRfgPqU/5F2N75ycvOiIj4TNN2P7evdLgDgd96wcdLzT9fX
         LJuUMz6Bvm8PceIlm/FVNC1aLDL0bci/4S+m4OcxNw4+6wn4m9c9CJjQiinKJym8PRBh
         5vwZAWWM6qbw56jceZQd+woeD5T6sCXDfij2M6YU9iHvL0VmWZUR87hNh4Z8xB5/yvLT
         V0t0Y4lWwXnGnPr65L2KGpXyd5w3qLYLiIgVFLmwePpYteO1nxJ8Y5xjaUooQkzxPQjm
         3d4oYoBGixGVTnTABorwFFx8OneqiLrgw+9o24ckScevIJiolzTxCMBt5tzD8wvWWlpV
         Vaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HUR71Busz7rHoO3kdum5ovbPXwWOHM0ZF312TuUbImQ=;
        b=jz0J7Z0JJF8Lx6GU18V5jYHrT6vLhTbGZtbJKUhITsR0b1LDmNFfSwijUoLrEZa6R3
         tuTDyyAe4g80RzfwMGdrIjCaFgcjbviXKmzBGBG/ya+Z5UUNrersfpIMpY6y0Ro0DytI
         4Nt0TEx26k7AJIXQtg48Zbob9RCWZeyBRq7rwciBQAYwr8IOlgtyH/CVavuBqO7LuR7e
         MfBR9bfxfJQgHjfov872S9bpiey66DIWO1UyTH+oLbWUBmglqziTFZXh27tny6pBgZZ/
         /USYH8kbENdBnDGlM45+9wS+dJye124T41uQzFba4xafHaTQ0izAfcgfrI9liOLtv4yZ
         0t7g==
X-Gm-Message-State: AOAM5307tjYPy/sYbMTfpoYNIuFkVFE7zLGhPQE+DekEnAvDTBs/aa6w
        SP5mh1UrymZzbdZP2eb90uQ=
X-Google-Smtp-Source: ABdhPJxjrwzxzkeGGI2NEtVC0Txs8wwcKKyycde8qmg0K4hIXxUZGT1Zm0b/5rqdiT03fBEazffe5Q==
X-Received: by 2002:a17:90a:930b:b0:1bf:ac1f:6585 with SMTP id p11-20020a17090a930b00b001bfac1f6585mr10500025pjo.88.1653048115442;
        Fri, 20 May 2022 05:01:55 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-24.three.co.id. [180.214.232.24])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902768a00b0015e8d4eb1d8sm5486794pll.34.2022.05.20.05.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 05:01:54 -0700 (PDT)
Message-ID: <4752814a-091c-9dd5-762c-6fd1a476c4bb@gmail.com>
Date:   Fri, 20 May 2022 19:01:50 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] arm64: Unify vertical spacing in HWCAPS
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net
References: <b95b3128-f010-dcba-1f6a-1a85dd2d20a5@suse.cz>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <b95b3128-f010-dcba-1f6a-1a85dd2d20a5@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 13:55, Martin Liška wrote:
> Unify vertical spacing so that same font weight
> is used by Sphinx.
> 
> Signed-off-by: Martin Liska <mliska@suse.cz>
> ---
>  Documentation/arm64/elf_hwcaps.rst | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
> index a8f30963e550..1e79044f51a2 100644
> --- a/Documentation/arm64/elf_hwcaps.rst
> +++ b/Documentation/arm64/elf_hwcaps.rst
> @@ -171,96 +171,73 @@ HWCAP_PACG
>      Documentation/arm64/pointer-authentication.rst.
>  
>  HWCAP2_DCPODP
> -
>      Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0010.
>  
>  HWCAP2_SVE2
> -
>      Functionality implied by ID_AA64ZFR0_EL1.SVEVer == 0b0001.
>  
>  HWCAP2_SVEAES
> -
>      Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0001.
>  
>  HWCAP2_SVEPMULL
> -
>      Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0010.
>  
>  HWCAP2_SVEBITPERM
> -
>      Functionality implied by ID_AA64ZFR0_EL1.BitPerm == 0b0001.
>  
>  HWCAP2_SVESHA3
> -
>      Functionality implied by ID_AA64ZFR0_EL1.SHA3 == 0b0001.
>  
>  HWCAP2_SVESM4
> -
>      Functionality implied by ID_AA64ZFR0_EL1.SM4 == 0b0001.
>  
>  HWCAP2_FLAGM2
> -
>      Functionality implied by ID_AA64ISAR0_EL1.TS == 0b0010.
>  
>  HWCAP2_FRINT
> -
>      Functionality implied by ID_AA64ISAR1_EL1.FRINTTS == 0b0001.
>  
>  HWCAP2_SVEI8MM
> -
>      Functionality implied by ID_AA64ZFR0_EL1.I8MM == 0b0001.
>  
>  HWCAP2_SVEF32MM
> -
>      Functionality implied by ID_AA64ZFR0_EL1.F32MM == 0b0001.
>  
>  HWCAP2_SVEF64MM
> -
>      Functionality implied by ID_AA64ZFR0_EL1.F64MM == 0b0001.
>  
>  HWCAP2_SVEBF16
> -
>      Functionality implied by ID_AA64ZFR0_EL1.BF16 == 0b0001.
>  
>  HWCAP2_I8MM
> -
>      Functionality implied by ID_AA64ISAR1_EL1.I8MM == 0b0001.
>  
>  HWCAP2_BF16
> -
>      Functionality implied by ID_AA64ISAR1_EL1.BF16 == 0b0001.
>  
>  HWCAP2_DGH
> -
>      Functionality implied by ID_AA64ISAR1_EL1.DGH == 0b0001.
>  
>  HWCAP2_RNG
> -
>      Functionality implied by ID_AA64ISAR0_EL1.RNDR == 0b0001.
>  
>  HWCAP2_BTI
> -
>      Functionality implied by ID_AA64PFR0_EL1.BT == 0b0001.
>  
>  HWCAP2_MTE
> -
>      Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0010, as described
>      by Documentation/arm64/memory-tagging-extension.rst.
>  
>  HWCAP2_ECV
> -
>      Functionality implied by ID_AA64MMFR0_EL1.ECV == 0b0001.
>  
>  HWCAP2_AFP
> -
>      Functionality implied by ID_AA64MFR1_EL1.AFP == 0b0001.
>  
>  HWCAP2_RPRES
> -
>      Functionality implied by ID_AA64ISAR2_EL1.RPRES == 0b0001.
>  
>  HWCAP2_MTE3
> -
>      Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0011, as described
>      by Documentation/arm64/memory-tagging-extension.rst.
>  

Did you mean the font weight is heading? Something like promoting headings
by removing intermediate blank lines?

-- 
An old man doll... just what I always wanted! - Clara
