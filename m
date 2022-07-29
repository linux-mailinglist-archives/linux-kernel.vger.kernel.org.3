Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71B5584DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiG2JLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiG2JLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:11:33 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFE77AC2E;
        Fri, 29 Jul 2022 02:11:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id o12so4111775pfp.5;
        Fri, 29 Jul 2022 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=tAfuCia8g3UGLQjPkQqMIogLpqoBvseGFs11sBYSBWc=;
        b=dAhK3qlNLVMH1/IkAssvtHxsuZv95YEeaKjQM1jt++T0Ec0Eod8tiJRf503fuujft2
         YbgEYlIVLWycgSn2QNcFdD8FuRKc5D+JNCPPP6SgsFSeJED9DOIREu8sRw8K/2MpGDMm
         b44mSDp/gVKW8cjNTeRGTxoN+g1C+2BqHV1cj4NkeL+bCPny3DvlhWSHMG4DZZr5XIps
         AUL9kMO/1SW1/r6SjXfI4+PZFR1fOId5BXJkQyfV3sa7ZFZymnhQdqobY+OebRvOIUea
         D/bEWMkt0Tg+fqgBdULHbampU4wto8pU9sR3DGoolJ89l7ITOmJUxEmk3hKF/ZQPQjjb
         NUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=tAfuCia8g3UGLQjPkQqMIogLpqoBvseGFs11sBYSBWc=;
        b=IZUt1jegFIiZewx+H/28DSLM9wTjMGbgkU8wIgMS5/iGgU7Vs6t5R5X4MpgirqLrDT
         MsbAVDEZ1Cpa9fzJvBSIJ+zg4LGX9+tAkpdIOS7z/aEYqYfJNC+Qx3o5Z2iwQCSIYTy4
         ZAIH1DS5OkfO56ZY/qjca5zgU3u0f9Eu4wo3UycopUqRyBlrJyFuvL/oHP+tzXltlezC
         Z0VMUJKI8dkAKRYTxmyHI6Rt6+7stCSSrbllez18HanyEvKTmvGUEiqbr6gzXx47bZnH
         WUGaL7tNszRnXfVAqUi1Oj9o5dbcmWxYbtlV2vT+Kp5p2D+uc/GJx3ye5J/eT0T2IK0z
         T2PQ==
X-Gm-Message-State: AJIora9kP/nWEJfu51LHah3XIjaGL6jwoxb2AthxlABUACHIqGKUaZyF
        h3Tnj8Dc06nADojNYRJaT2GMfvHmz0U=
X-Google-Smtp-Source: AGRyM1sJgAt2iYbjeBsSUgtZZUJ0GAhAPqJDcEvNmYz8HtpcmL7VRNHNnxngssbVKwn9518Dg6MoJw==
X-Received: by 2002:a63:b56:0:b0:41a:495a:2a26 with SMTP id a22-20020a630b56000000b0041a495a2a26mr2206570pgl.411.1659085892129;
        Fri, 29 Jul 2022 02:11:32 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-14.three.co.id. [116.206.28.14])
        by smtp.gmail.com with ESMTPSA id bt21-20020a17090af01500b001f1ea1152aasm69925pjb.57.2022.07.29.02.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 02:11:31 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A834E104A60; Fri, 29 Jul 2022 16:11:27 +0700 (WIB)
Date:   Fri, 29 Jul 2022 16:11:26 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 3/5] maintainer-pgp-guide: update ECC support
 information
Message-ID: <YuOkPtg+Wa7KldPm@debian.me>
References: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
 <20220727-docs-pgp-guide-v1-3-c48fb06cb9af@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220727-docs-pgp-guide-v1-3-c48fb06cb9af@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 04:57:06PM -0400, Konstantin Ryabitsev wrote:
>  
> -    If for some reason you prefer to stay with RSA subkeys, just replace
> -    "ed25519" with "rsa2048" in the above command. Additionally, if you
> -    plan to use a hardware device that does not support ED25519 ECC
> -    keys, like Nitrokey Pro or a Yubikey, then you should use
> -    "nistp256" instead or "ed25519."
> +    Note, that if you plan to use a hardware device that does not
> +    support ED25519 ECC keys, you should choose "nistp256" instead or
> +    "ed25519."
>  

nistp256 isn't just ECC key algo other than ed25519. In fact, it is a
part of NIST curve family (the others are nistp384 and nistp521).

Maybe we can just say "If unsure, or if your hardware device does not
support ED25519, use one of NIST curves (nistp256, nistp384, or nistp521)
instead".

-- 
An old man doll... just what I always wanted! - Clara
