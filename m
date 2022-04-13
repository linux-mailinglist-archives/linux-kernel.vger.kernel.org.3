Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7E34FFF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbiDMToz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiDMTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:44:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C8179384
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:42:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bh17so6049526ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FKEsAEC31s5NjW6gR7R9XH+ZD7Bj81woAOOZnXXyKBw=;
        b=EFmIOK1fhCFyYhjY9XJTUgpu0JtHcZJ4NHOpwoDsZY0lezkatu17BwYQk/ih3GjWfB
         ca6FbNKgL6t+xDmphtWTjIpRv7S/ihMoTWe+REiRZQOsRDZdiV2sWmdu6NjTlrsVa440
         D0SHXFoWWC3+nqOcssyoQYZ/Ed0xE8aYwI5Bxh4F7At0Gb1eV10mTTzpblJzagQ3Bizv
         T4+v9hqYRHS0mv+5eyKtXGWrHmI52lUiNKBAAhXJiDGPWujoSJlpZd4eng+Nyc1el2ZM
         EepXPPrDH8CzHwgCOoVzGdG1IyMCd2L09m0kBFVXCHprNOplwt59O8byoa9JX4Qgx9Ql
         NpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FKEsAEC31s5NjW6gR7R9XH+ZD7Bj81woAOOZnXXyKBw=;
        b=7X7LayMAa80e4XJY4u+RdvizuGhttBBso0uoN0LiKALJb91gk8dMq9JZI/iRtJOU+d
         5u1z8dHOqD2Spc4zkdD3SQP5gPRBBcGV78PImwE0Dp0qagGOyi3oWw99H0hIswFBeUGM
         tZzoBbkeQjl1qL1DGDPmcEYnkFdd88olGInPrxMSKk+TOdGueeyS4I3Wn5KI+zGV99UY
         bhOMYJVdb+PDDyf6T7akMkpXFfGyfB3C4XXW3gOg5zpUjKWDy4G+SJXna3KCaut0W2xX
         i/uEcP+Ys3ReH2L4YvUQG5K/opDnYhlFB66dv5SdhsW/3hGwvpiyM9+dACG1CYivwMX7
         MXsg==
X-Gm-Message-State: AOAM53259jfyVTcsn6cbXbresxO8BsWbwpGDhseI6O2ZenVnKeLeuCjF
        LIlTDtBg84NeB6zzuKKU4Gw=
X-Google-Smtp-Source: ABdhPJxkiwD6sFd4SphGvl7PDG5NDTGzem9nThMR3YuT3EUoNHMSsHy+X5AI4kRFNFLHOcTRHd8FXQ==
X-Received: by 2002:a17:906:1e94:b0:6b9:6fcc:53fd with SMTP id e20-20020a1709061e9400b006b96fcc53fdmr40266567ejj.450.1649878949484;
        Wed, 13 Apr 2022 12:42:29 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id jr16-20020a170906a99000b006e4c05e8919sm283247ejb.35.2022.04.13.12.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 12:42:29 -0700 (PDT)
Message-ID: <86a66ea4-45e3-cfa2-9130-f698ae212bfd@gmail.com>
Date:   Wed, 13 Apr 2022 21:42:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: struct rt_firmware_header issues
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <94a72ecc-3acd-758b-15a4-a7d56bf03fbe@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <94a72ecc-3acd-758b-15a4-a7d56bf03fbe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 18:27, Michael Straube wrote:
> Hi all,
> 
> I think the rt_firmware_hdr structure in rtw_fw.c has some issues.
> 
> 
> struct rt_firmware_hdr {
>      /*  8-byte alinment required */
>      /*  LONG WORD 0 ---- */
>      __le16        Signature;    /* 92C0: test chip; 92C,
>                       * 88C0: test chip; 88C1: MP A-cut;
>                       * 92C1: MP A-cut */
>      u8        Category;    /*  AP/NIC and USB/PCI */
>      u8        Function;    /*  Reserved for different FW function
>                       *  indcation, for further use when
>                       *  driver needs to download different
>                       *  FW for different conditions */
>      __le16        Version;    /*  FW Version */
>      u8        Subversion;    /*  FW Subversion, default 0x00 */
>      u16        Rsvd1;
> 
>      /*  LONG WORD 1 ---- */
>      u8        Month;    /*  Release time Month field */
>      u8        Date;    /*  Release time Date field */
>      u8        Hour;    /*  Release time Hour field */
>      u8        Minute;    /*  Release time Minute field */
>      __le16        RamCodeSize;    /*  The size of RAM code */
>      u8        Foundry;
>      u8        Rsvd2;
> 
>      /*  LONG WORD 2 ---- */
>      __le32        SvnIdx;    /*  The SVN entry index */
>      u32        Rsvd3;
> 
>      /*  LONG WORD 3 ---- */
>      u32        Rsvd4;
>      u32        Rsvd5;
> };
> 
> 
> Then we have in rtl8188e_firmware_download():
> 
> 
>      fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
> 
>      <snip>
> 
>      if (IS_FW_HEADER_EXIST(fwhdr)) {
>          /*  Shift 32 bytes for FW header */
>          fw_data = fw_data + 32;
>          fw_size = fw_size - 32;
>      }
> 
> We add/sub 32 bytes but the size of struct rt_firmware_hdr is actually
> 33 bytes. I noticed this when I wanted to replace:
> 
>          fw_data = fw_data + 32;
>          fw_size = fw_size - 32;
> 
> with:
>          fw_data = fw_data + sizeof(struct rt_firmware_hdr);
>          fw_size = fw_size - sizeof(struct rt_firmware_hdr);;
> 
> To me it looks add/sub 32 is correct here but the struct is
> wrong. I don't know if the firmware for this driver is so much different
> from firmware for the drivers in drivers/net/wireless/realtek/rtlwifi.
> They use a struct of size 32.
> 
> Also, souldn't the u16 and u32 variables in the struct be __le16 and
> __le32 ?
> 
> I wonder if we can just use the rtlwifi_firmware_header structure from
> drivers/net/wireless/realtek/rtlwifi/wifi.h ?
> 
> Comments from people with better knowledge appreciated. :)
> 
> regards,
> Michael
> 
> 

Ok, I figured it out by looking at the hexdumps of firmware files. The
field Rsvd1 should be u8 instead of u16. I'll prepare a patch for this.

regards,
Michael
