Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D10526EF5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiENFvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 01:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiENFvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 01:51:15 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A175A2EA2A;
        Fri, 13 May 2022 22:51:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g184so9352258pgc.1;
        Fri, 13 May 2022 22:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=KjQi2jPRlQmZyatFX7tW7uernsm0nsmL3abzBg+Is6Q=;
        b=jUBlBiVWSkYHj0Rv2cONri0U3zoJzOhOXbecxVI68rxhE8XEHLnOwy+dsWjZF62gkh
         i1/2CM8nWtMj8tcrDV3HJMZ12kso8oRb8oYF2HB+eBVcxDi0zsu7T0Sk4uf5Jzu3mwrU
         4wW6dwUW+PC5aOrjuZnzopm5mdEWOBJqRHT00WAZi9YUglQTkJuE93DKwngagboaR3me
         kR1ZaspukYVdGtq3dZjYKAYLfGbA3hijYX+dLaszYvnPauZ/7VBH1hxB7hSogNfhNLJS
         UfnaGahAExLq3O1WuFeC7TrWvwO6HowTTK7GOw3bQHVPBzFE41DryiqTgHT0IcgQeGRs
         HGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=KjQi2jPRlQmZyatFX7tW7uernsm0nsmL3abzBg+Is6Q=;
        b=p/BXm3eJSTe1kUdSNRYSeDSI+lYjJkdEy7szLvrQQdOZYZel0UAV5+pk6IyT+UwdwA
         sr+SNt0bi6MoqNCAnPySkaVam3fqcdaSkXpAjtS9YG8LM9MRiSYI4wMwkQr6+YH2xHCn
         zEzkhvmEt+rCXANV5amv7GAxyF4YQp8E5aJvfXSXjfRiglabH3ogCv81DPyyAV6AnfvH
         YZ6eO1T1/xNHTssOpIaCHekCu2wDS4itrEpa4VsRkwEUfjSQv50BLTFZzAc2Tl9MftdS
         mRbiqFYPzyZqvDuBpumeANKCd3gcgmQAARgHYxu4WWS3nDYmaDw2NzSkzEHAmnRO42GC
         5B6w==
X-Gm-Message-State: AOAM533GjEgIo+Fxw2ZQye2fXBjZ1dk2UBJeKtlU6ITMWSZMgCfvGzAg
        8+AEYCLowwHwC9jZ0EXlV7s=
X-Google-Smtp-Source: ABdhPJwF1sdiqLInjvFG+rlCMnVGcwsWXvVEIupHykoPRze8RWLN6eSgICUuQ3BJPIk8fMsCEdsK+g==
X-Received: by 2002:a65:428c:0:b0:3db:822e:2163 with SMTP id j12-20020a65428c000000b003db822e2163mr6607568pgp.466.1652507473055;
        Fri, 13 May 2022 22:51:13 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-36.three.co.id. [116.206.28.36])
        by smtp.gmail.com with ESMTPSA id n16-20020a170902e55000b0015ee985999dsm2912404plf.97.2022.05.13.22.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 22:51:12 -0700 (PDT)
Message-ID: <c6f4a479-6689-1ce6-60fb-c24f2635ad28@gmail.com>
Date:   Sat, 14 May 2022 12:51:08 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] Documentation: Wire Oxford Semiconductor PCIe
 (Tornado) 950
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
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
 <02a1d5a9-4a95-ce58-d401-962d8ea5a0a2@gmail.com>
In-Reply-To: <02a1d5a9-4a95-ce58-d401-962d8ea5a0a2@gmail.com>
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

On 5/14/22 12:50, Bagas Sanjaya wrote:
> 
> Shouldn't this patch be squashed into [1/2]?
> 

Oops, I mean patch [1/3].

-- 
An old man doll... just what I always wanted! - Clara
