Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EF857F2B5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 04:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiGXCtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 22:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGXCtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 22:49:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB7139B;
        Sat, 23 Jul 2022 19:49:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y9so7534768pff.12;
        Sat, 23 Jul 2022 19:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gSZBqo+GJpbLxWO7KUPdX/NIEOZXi3uHA6I5/h9Ae88=;
        b=JpptwV03fN+pOYghJzEYoh4JLL/XC8Ly3sK+VAc2fYzO9PLQ5aWJUp31mjVV9FqupM
         33uZjBtqtSBi/98glrdRi2L3R1j+cI5YqMUMWUo0K6Zm01IgQPbn5UL8fIMgRhLpqZLk
         d76O9uR8bDjfrNgvSoKaxk+QLT1TD0LUFxzq9DHurAq5zVQavTyqSgrW1VMpXDQ6i3Gr
         NoEPi0xun6zF+LZCDSVyNHwiuYIMQ38ot0X959afjv88i4mByuNumOfJbieL0MDHQ2dx
         LN0kphXd2WxeAvmYyIMyPFuSf8KbdqdWj+6Irtm0BPlJcSrxw+oYLGUtT+Dn0ur6psSU
         dDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gSZBqo+GJpbLxWO7KUPdX/NIEOZXi3uHA6I5/h9Ae88=;
        b=KF5ykfctosdrnLdPTUEG+R0xomxdK1a/+ahtBkuc0l2ctwxurXPtnPSIuq3lGxHEEQ
         mk9NHq/kU+Vft/6R9AX2kp8t//ckQo8yUcfpQfT94RqHDTUQcRxRUTYzzbPg2D6gZ6R4
         0xcsgQwO6TYoWS2HzO9ut/iXaVfFhgaT23FYGBv6wusIYD6ymAqoDw/c+MDfGMRotv39
         4Zo2D26pxs42ZT0ij7X/31udvpOfiaoEGjApgvfmR+DPmyRKO27c0QTaALeQ9SiPWBRP
         fquABb1+nM7jDK4gendiikEZ8dHYBe9qNiW/WfwNhWTtAcHYDWXnlq8uBeyyX1EvjcZB
         9D3w==
X-Gm-Message-State: AJIora9VIAmnAQYnubOFfGIM9WSdBH4yn27UQsOzpUl65hA6IsORDqbv
        yE6LnaSuC+R+63TWAIbhtew=
X-Google-Smtp-Source: AGRyM1soUkXAdCXAvC/wf3HF5Sb42PzXzKJdqZxcowDy2J3LxksJuS4HfcKY1yxdZlNZoo/Ul4XJGw==
X-Received: by 2002:a63:4b62:0:b0:41a:e5be:fe23 with SMTP id k34-20020a634b62000000b0041ae5befe23mr1290555pgl.140.1658630978263;
        Sat, 23 Jul 2022 19:49:38 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-16.three.co.id. [180.214.233.16])
        by smtp.gmail.com with ESMTPSA id o42-20020a17090a0a2d00b001f21f0f6d7csm7819116pjo.25.2022.07.23.19.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 19:49:37 -0700 (PDT)
Message-ID: <5e13ade3-10a5-4eaf-2d9c-aa03fc23a374@gmail.com>
Date:   Sun, 24 Jul 2022 09:49:33 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] docs: fixed table margin in
 configfs-usb-gadget-mass-storage
Content-Language: en-US
To:     Maxim Devaev <mdevaev@gmail.com>, linux-doc@vger.kernel.org
Cc:     linux-next@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, sfr@canb.auug.org.au
References: <20220723101432.72178-1-mdevaev@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220723101432.72178-1-mdevaev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/22 17:14, Maxim Devaev wrote:
> After merging forced_eject patch, there was a broken margin
> in the configfs parameters table in the ABI documentation.
> This patch fixes it.
> 

Hi Maxim,

I think the patch message can be improved, like:

"Commit 421c8d9a20da ("usb: gadget: f_mass_storage: forced_eject attribute")
 adds force_eject entry to config-usb-gadget-mass-storage table.
 However, the table border for attribute name is short by one `=`,
 which triggers Sphinx warning.

 Extend the border to cover the now-longest entry."

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
