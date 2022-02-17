Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41094BA9BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245149AbiBQTZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:25:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbiBQTZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:25:46 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2150BF94D9;
        Thu, 17 Feb 2022 11:25:32 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id h9so10320877qvm.0;
        Thu, 17 Feb 2022 11:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=/WM3d+d6P+GlLRzeppghOHiUa2w7JBeq4LDjhr4En7U=;
        b=kjizsqFv/9oBwihdSQeFIAD+OJ9Kw3pJSSfkKDQWqKKLi9nG2I14YulYAN4O2VCtQj
         Chx8PsBd7EJiUKe0w7cGW1IVGYU9ldkPHukNdF+nRiB7Aur+rDZf8CSMZD6wzUl2B5/Y
         ok91XKSgaK6PuA2nh1CbRLLEB0TWzP6QZimMBsmel0uLzllYlWBiagYS2ixCALv2BfQu
         HwjQakopfMvn+gpa4m5hrN38U/DAUtU4FHfL3j+tvrm5KD7oUo5cY/FGzTeM3x4/HCVt
         rvJjMQ1vRJ8JWTCWuNzE86PPPGn+Tc7G5csHc5wyLbEv1ByoCCjzCMry7g0CAzuVnl+d
         pEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=/WM3d+d6P+GlLRzeppghOHiUa2w7JBeq4LDjhr4En7U=;
        b=L9bfFEJdcPK5L6VeJS9VWTVP8vA8T9ZPESKdSvFwgrCBt6rE7IWNsrTUKgZN+rvbOt
         +ScU897daRUuEgBnc18ej69IAB8uOrVEi2bbvJkg2981Q54MdpfLDpl3PSZLoxZZSfwi
         tf+ytiL/WlfL0fcvmXY91ANwR4tC3mlZCRjLNah6EPvCAb65gMUJKwHHroirDfAPc1DU
         v7y6+9no3DMv5UzVSb2qBzsaJxxFBvHyHeTX9MfI2kWaB3rYMzaYR6RDJ0UqMNUqWBmo
         ANn4BQtOhT21KA2u5ku95/p3+YZ5f9ywnrOspzYevknlsLyccroSL0o5WRBcTX9JEwLw
         D/Hw==
X-Gm-Message-State: AOAM532R89wQZa2nPByehwwVpQ6PNFrml1w3cJWpCqFCssI7zX+0mcJ0
        WhU1zT2dq98r0gn2N3eFN5U=
X-Google-Smtp-Source: ABdhPJww3RWBaldGY4hF3DwN5pm3E8izPdvrNGRQIk5/nvfAMVmR8XtzEBy2d0TygnEIyQ7rrm2olw==
X-Received: by 2002:ad4:58af:0:b0:42c:2c20:c717 with SMTP id ea15-20020ad458af000000b0042c2c20c717mr3393103qvb.31.1645125931270;
        Thu, 17 Feb 2022 11:25:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z17sm24079120qta.11.2022.02.17.11.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 11:25:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aa82f347-1b1a-8c40-b5cb-9efe292ae0ec@roeck-us.net>
Date:   Thu, 17 Feb 2022 11:25:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     sylv <sylv@sylv.io>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-doc@vger.kernel.org
References: <cover.1645108566.git.sylv@sylv.io>
 <6103836f1116a045a25919ae3e5c18dfdc485902.1645108566.git.sylv@sylv.io>
 <f1e13a4e-2e86-1d53-f34d-a04838e8e8f9@roeck-us.net>
 <246de83631dd5e165f95904d7f1628502f030e02.camel@sylv.io>
 <66d4ea0b-0377-c9ae-68eb-7303c32cf87e@roeck-us.net>
 <7a567823d62b6ed00cbdc2ce239dc4a69e48b411.camel@sylv.io>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/3] hwmon (xdpe12284): Add support for xdpe11280
In-Reply-To: <7a567823d62b6ed00cbdc2ce239dc4a69e48b411.camel@sylv.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 10:38, sylv wrote:
[ ... ]

>>
>> That makes me wonder if the chip needs to be added to this driver in
>> the first
>> place, or if it could be added to pmbus.c instead. Any idea ?
> 
> Oh, we did wrote a standalone driver too, and it works fine.
> Maybe it's better to upsteam it instead. :)

No, I meant if it would make sense to just add something like

	{"xdpe11280", (kernel_ulong_t)&pmbus_info_one },

to drivers/hwmon/pmbus/pmbus.c.

You only really need a standalone driver if it does something
special, such as a workaround for some register access (like
the xdpe12284 driver), or if support for manufacturer specific
registers is desired or needed. That would, for example, be useful
if the xdpe11280 supports per-phase sensors.

Thanks,
Guenter
