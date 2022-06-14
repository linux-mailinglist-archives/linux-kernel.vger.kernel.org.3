Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3B654AC70
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355949AbiFNIuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241517AbiFNItq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:49:46 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2851170;
        Tue, 14 Jun 2022 01:49:45 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso5284129pjg.1;
        Tue, 14 Jun 2022 01:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2WMPTKYwy1gkVaJtAN7tuJhmsjYJoOG0Gap8PZZ0H6M=;
        b=jNBIVyp7QnC2U8iaVKn1OPEbtlW1q6ARIbd1W8M7pD8NQL4zW1XKF/oc7jObTs2Jj7
         3goM6UBKGMX04CK/Y57oyWb2d2XJtLANHXS5D/PTEpNnBCeLeJaoXDOmTgbfxHrdzhnI
         XpYLi6HxYKXxJcFawQWqI4TQSgqQ8ArkAt12SVZff6S6+TrIBpNjWGHb5p4FekduONXo
         GGf5Au+JR9pfoPkg2iJ+elw29Rr8I4CezT5XyMJjwCcLp1mBBQtsnVfq1+66ZX574Re6
         HIqy8hb31/HWnvDf6DgB0/jp3IkYtBG67mzc0fLUQV7a/k8ZN7xpQNzDdHazepUDDvSZ
         KWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2WMPTKYwy1gkVaJtAN7tuJhmsjYJoOG0Gap8PZZ0H6M=;
        b=6T+nLnobcp4x3h5d7Ztj6GlodJmLoZ/vbuMf2XiEbmunmITk6LKwOlVKd63jMf7ikM
         bV5xUY26TZF73YOnW+34BR3Qa13UKkomQu10z9EvU/xA1i9kQjnW9MXwZLKu8ywESxzl
         6NLC/lE4lKUH4+JFYTT/SnEUP/U1X107c5vimUQZA8DmrcBylkFjJFFvuxAGmSl0CBoB
         kQbshc5HQXpONNqWdxtPfWSh99kWFX1OjZE7nZW+MS2AY/g/lXl/c2Nb2w9uGT/8yIJQ
         K3obm71ySTdPzKEXgg36QpBKxmnq7JksWIwAzI/3+SLrD7Fx+DFBygcS6hq3+NhxOvJf
         NeNQ==
X-Gm-Message-State: AJIora/qYushzPeKd80M7yThznF4IL6BfRf34zyqqKCJJZDmF03NAq8q
        8Q37fXkZtIm/vCPehhrcfwjPSbRDNRI=
X-Google-Smtp-Source: AGRyM1vmZAyTzqJUMsOqo3vDve2ja6Tmv/2D3CgrXzX0v9g+vjYT5qvLppZAwUzBJzcz6xPInaeIYw==
X-Received: by 2002:a17:90b:60e:b0:1e8:9bd0:5417 with SMTP id gb14-20020a17090b060e00b001e89bd05417mr3416056pjb.208.1655196585146;
        Tue, 14 Jun 2022 01:49:45 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-37.three.co.id. [116.206.28.37])
        by smtp.gmail.com with ESMTPSA id d20-20020a170902e15400b00168c523032fsm6551870pla.269.2022.06.14.01.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 01:49:44 -0700 (PDT)
Message-ID: <22e6a8ff-ee1c-69c9-dbcf-2865142e05c1@gmail.com>
Date:   Tue, 14 Jun 2022 15:49:40 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Documentation: samsung-s3c24xx: Add blank line after SPDX
 directive
Content-Language: en-US
To:     linux-doc@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220614164506.6afd65a6@canb.auug.org.au>
 <20220614084658.509389-1-bagasdotme@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220614084658.509389-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 15:46, Bagas Sanjaya wrote:
> After merging spdx tree for linux-next testing, Stephen Rothwell reported
> htmldocs warning:
> 
> Documentation/arm/samsung-s3c24xx/cpufreq.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> 
> It is due to missing blank line separator between SPDX directive and
> page title.
> 
> Add the blank line to fix the warning.
> 
> Link: https://lore.kernel.org/linux-next/20220614164506.6afd65a6@canb.auug.org.au/
> Fixes: b7bc1c9e5b04da ("treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_147.RULE")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---

Oops, I forgot to mention that this patch is based on next-20220614.

-- 
An old man doll... just what I always wanted! - Clara
