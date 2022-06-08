Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889A3542A06
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiFHIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiFHIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:54:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA797B9E8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:14:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so23147645pjo.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yAAfz6VFgK53WoizHA9gf9VGAh64Ih3KZqm+Dx/e2Qg=;
        b=lPrwhE0pZvKqOgczAZmdECVWnjVyC588bCu9pRlWDyVgLve1zH19r5Y7XKWRK9WBlW
         Wkt9aggzOdEDpoNnVtZkiZylDBNgo3mTlObBmwZWujAjOOWp/G4uzLAHbANB3EvROkrS
         Q2BLAEgUxsMU2IyfGNntcm/RfQFvO90Cvix8xlHXt8OBCjoHA3oclPx2IaofQHNSn+bg
         2wqelJP3r36xrTykp6Tfpbz3+aHTEal04wrlijz/Gy7fxpB/6ehpnGYreiGUGjxwj2Dn
         yXVBCCDKUXpZs7xQO6Qk0XTsWv8fzXP8/zDqXYa8wokyLywZ6yn/OyXG+fhZ+W02Qfnx
         Mb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yAAfz6VFgK53WoizHA9gf9VGAh64Ih3KZqm+Dx/e2Qg=;
        b=UZe5UCdjng4sERkn4me/zsbmzp22QtwtIUYl0GLgRwNOEinmrZih0vYc193Ha0Y7dz
         KLASlw6XnecoWOSCQ21t13DnRkUG3iWXN8tXT8/7rYa2c2twutbNAJLa0mIHMEZ55cFi
         zXF370GchGiNFegBYyItUBC+TWXb065qUve/SlZTn/mvM5yz/rWIkVuxkI0V8Uus9GTd
         W23r7+jC3eAFUOsZMa1wkRTjzFIBU3d2XLXMVkfRdtSi5R9pO5FRc+TfTlehc+oZUXjZ
         eyUr31SSwzEPNil0QUKtCDztBu59jnzgqe7s+7NPBSnxwo0kxz8PfZLT0/p8k3FMXVOA
         hwjA==
X-Gm-Message-State: AOAM530hwvXoNatNF64MY+8zgFe755bPuaJwTJQGGVAwdFc6EONitx4C
        XduoCWm2MvQj+e+tHnU8ZfY=
X-Google-Smtp-Source: ABdhPJx328Q9Z2sSpBcFDBHEYWZcUzwGmh4GhcEVgGagAHnHXSPnccfK7UkdQp+vFWNKXkMWKnRDlg==
X-Received: by 2002:a17:90a:b396:b0:1e4:d7de:ea3d with SMTP id e22-20020a17090ab39600b001e4d7deea3dmr37243736pjr.222.1654676080366;
        Wed, 08 Jun 2022 01:14:40 -0700 (PDT)
Received: from [192.168.0.24] ([88.126.57.132])
        by smtp.gmail.com with ESMTPSA id r9-20020aa79889000000b0051894243fc5sm9443444pfl.147.2022.06.08.01.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:14:39 -0700 (PDT)
Message-ID: <b56e81de-e972-9e3b-798d-53dd1d3a3707@gmail.com>
Date:   Wed, 8 Jun 2022 10:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/5] MAINTAINERS: add bcm63158 to bcmbca arch entry
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     joel.peshkin@broadcom.com, tomer.yacoby@broadcom.com,
        kursad.oney@broadcom.com, philippe.reynes@softathome.com,
        dan.beygelman@broadcom.com, samyon.furman@broadcom.com,
        anand.gore@broadcom.com, linux-kernel@vger.kernel.org
References: <20220601225654.18519-1-william.zhang@broadcom.com>
 <20220601225654.18519-5-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220601225654.18519-5-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/2022 12:56 AM, William Zhang wrote:
> Add bcm63158 related files to BCMBCA ARCH maintainer list entry
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Applied to 
https://github.com/Broadcom/stblinux/commits/maintainers-arm64/next, thanks!
-- 
Florian
