Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773DE5740C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiGNBIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGNBIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:08:22 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233491EACB;
        Wed, 13 Jul 2022 18:08:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso5128349pjz.0;
        Wed, 13 Jul 2022 18:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wFMM2g6zoRAZ3mH05I5PE3+zRmeZ3zKwjwqMIFOKIKw=;
        b=MqoZYrlgMmINeVkW6ZwlR7ISJW2YJH5qxwYi6wjdpU0FoCLbkHmRgNyA39JP4tvz66
         w2pOjBIoId1/LIYGsK1TT+7rEidVZTmvJEwsOjSbq4YGGSs4KFgRl12rM2xMMnxlUILi
         N118tCscHaoHpfXbSoSCGjleb3vWaqvYQiSGRvB1iOAYJ3Xdq+tD5xZU/MS6bMRTr0YQ
         fx4IqtjJ+M6Xl9LCUTm0WiMolc5hqgcEN3Kk3aMlgvn7Pv72uV5tRa/Rv5Hn/K/VosOn
         TJiNnwuq1uavOIQrRzmzTN/hKeC6iNjMjTmKA/m7koYlXjJZmOVKHCaN+N7nZfI6flK6
         RBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wFMM2g6zoRAZ3mH05I5PE3+zRmeZ3zKwjwqMIFOKIKw=;
        b=J30cSqdeqEOe45KtlogunEXwhVBYU2QawMcBFmhAs2H8icqL12bLVh8hdRA/bPytUG
         d4RlHstfIZc+IqvnZWyf2HuXw7A+gP/kp3zzOCSVBGB/fppqonFneVP8W7s9S9h0YeOY
         rOgo5ZQbO43yIQePKZuaay8+kO0gyxvGQ8l2Iw5mmP9K+BWJt9TWiOyvM0yKuBQvEuv9
         lEFfVpBvqJaU8Wk7836UM6B6iV3Sz6Ml9qGb3neW0ORJL24+D6zL91cBN4FEeYLE9GFy
         IhLA3zeuFr39/xYXvLPXogWliGDKzqD3CxKFfGUWmZ5+QIMaBKlwmdKursgIYykZd/Hb
         coQg==
X-Gm-Message-State: AJIora+ANoGQhgUj2wyHypsYuoPSWgeuh8fpxNFRG+5Nh4GpRUkukWam
        KH8GEyho3NeJ/GvEyfCB4vQX3edrW+Q=
X-Google-Smtp-Source: AGRyM1vrWC3thvZtjWLaL7UyUsAy5ay9G+wz6yRm9EE9+pHD+hB4TCAow0tvxxxzuPJAaGHWDduwuQ==
X-Received: by 2002:a17:903:41c7:b0:16c:4e4c:7440 with SMTP id u7-20020a17090341c700b0016c4e4c7440mr6034564ple.169.1657760901562;
        Wed, 13 Jul 2022 18:08:21 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-3.three.co.id. [180.214.232.3])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090322cb00b0016c33dc879esm57986plg.113.2022.07.13.18.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 18:08:20 -0700 (PDT)
Message-ID: <f943bce5-32c7-9339-14ce-876036db7c46@gmail.com>
Date:   Thu, 14 Jul 2022 08:08:16 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Documentation: process: Update email client instructions
 for Thunderbird
Content-Language: en-US
To:     sndanailov@gmail.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220713225037.1201-1-sndanailov@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220713225037.1201-1-sndanailov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 05:50, sndanailov@gmail.com wrote:
> @@ -280,10 +280,10 @@ to coerce it into behaving.
>  - Allow use of an external editor:
>    The easiest thing to do with Thunderbird and patches is to use an
>    "external editor" extension and then just use your favorite ``$EDITOR``
> -  for reading/merging patches into the body text.  To do this, download
> -  and install the extension, then add a button for it using
> -  :menuselection:`View-->Toolbars-->Customize...` and finally just click on it
> -  when in the :menuselection:`Compose` dialog.
> +  for reading/merging patches into the body text. To do this, download
> +  and install the extension, then open :menuselection:`Write` and add a button
> +  for it using :menuselection:`View-->Toolbars-->Customize...` and finally
> +  just click on the new button when you wish to use the external editor.
>  

There's a remastered version (uses MailExtensions interfaces) of extension
at [1], suitable for current Thunderbird version:

[1]: https://addons.thunderbird.net/en-US/thunderbird/addon/external-editor-revived/

-- 
An old man doll... just what I always wanted! - Clara
