Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DAA526F6A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiENFuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 01:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiENFud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 01:50:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E60339;
        Fri, 13 May 2022 22:50:30 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so9424203pjb.0;
        Fri, 13 May 2022 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y+7/3F4K7tO9yPS1FoG+R06LhSxowngPNVcml3EJRXI=;
        b=Jq+CUR5rZrzmCrD/LVeMvxq+Xb/zak1b+scGfBXtHB2BtZDPcTmAsIj0eEldiX/hxr
         V/ZNKCZmCnwGjWBrQ/N5kebr6r2Rar2d1AZBLUYgfAmYmnejW13/wG6EiulfG9KLSN94
         64MGYxOHQrAJJ0VK7xPhvHevvKAhSebmducEdqqeMgyeNsOwP74MEmchgQA+vgTpRYQx
         Q5aaBJ882rp2u94Bysst1yaf1SxrObIB+PcbgiXMvfYRVPFqV5hxHR694izuvfQCReBJ
         ETjTbJ/lRJBHIp53DH8K5WNJYqyKGYcnTfNlqCTVeG1EbJT9N62xCReU9dfvuoWCgNa3
         +0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y+7/3F4K7tO9yPS1FoG+R06LhSxowngPNVcml3EJRXI=;
        b=OSh0XkJuG4uFsi5SztHb2mZnea9wpTCINynADk4rkhFWm+bA4M4nlENoini4GWYk1e
         6pnTc3ThkWDZ66lFgHoSekxOk4mF0vm6YZG6ShL31CgEkaXrXT+cBUQoHKykGXE1PItW
         K7gNGHOVYJrIDYe+eAXDhuAlcBf08br/mW3UTt04NAB7if4kZzRqFcp9fNxZQSO4rJM2
         8JYbtE2PBZGQcn675E7A5s10pPMSJCDuK3iCIfQT1+NKNmwyxg22esIffooZnXTLE0fq
         vkbWG/3l3dvrfezMGVLbQ/IfOVdpoH8WvfUBnvCpctkLg7KJyBa+JDw8w1ZvyeZDpfXQ
         mDZg==
X-Gm-Message-State: AOAM531G8axXigS50K7c5CrPV6hMwkJ08WInLMt8LfxjS48l7wd/wsYc
        I7p/3cVOFaYZvQq+TAXpzbQ=
X-Google-Smtp-Source: ABdhPJzZs8nO8pY3xEjkvf9SZbC4iLxTAZKozzoiIBqeTKah3zBlj3A8GW24T0kdEF8AOd5grcPNfg==
X-Received: by 2002:a17:903:124a:b0:154:c7a4:9374 with SMTP id u10-20020a170903124a00b00154c7a49374mr7870605plh.68.1652507429919;
        Fri, 13 May 2022 22:50:29 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-36.three.co.id. [116.206.28.36])
        by smtp.gmail.com with ESMTPSA id n16-20020a6563d0000000b003c14af50607sm2553652pgv.31.2022.05.13.22.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 22:50:29 -0700 (PDT)
Message-ID: <02a1d5a9-4a95-ce58-d401-962d8ea5a0a2@gmail.com>
Date:   Sat, 14 May 2022 12:50:24 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] Documentation: Wire Oxford Semiconductor PCIe
 (Tornado) 950
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
References: <alpine.DEB.2.21.2205131712410.10656@angie.orcam.me.uk>
 <alpine.DEB.2.21.2205131727070.10656@angie.orcam.me.uk>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <alpine.DEB.2.21.2205131727070.10656@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/22 05:42, Maciej W. Rozycki wrote:
> Wire Oxford Semiconductor PCIe (Tornado) 950 description as a chapter 
> into the misc-devices document.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
>  Documentation/misc-devices/index.rst |    1 +
>  1 file changed, 1 insertion(+)
> 
> linux-doc-oxsemi-tornado-wire.diff
> Index: linux-macro/Documentation/misc-devices/index.rst
> ===================================================================
> --- linux-macro.orig/Documentation/misc-devices/index.rst
> +++ linux-macro/Documentation/misc-devices/index.rst
> @@ -25,6 +25,7 @@ fit into other categories.
>     isl29003
>     lis3lv02d
>     max6875
> +   oxsemi-tornado
>     pci-endpoint-test
>     spear-pcie-gadget
>     uacce

Shouldn't this patch be squashed into [1/2]?

-- 
An old man doll... just what I always wanted! - Clara
