Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3B95753F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbiGNRY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGNRY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:24:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9823599C5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:24:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so9281786pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=Gbjcd2IgrO6L9fc9+WkTPZv76RZzps8wedDsg5wGKeY=;
        b=CCb+r6CxQcpbkaIIPO2+OFKrJm34bemuloqAiWccmWzW0dxE0dhcDaVN86XyANf2cf
         kv8i80/zkbjcsK8DcFaJO8ls4IkCCHuyokBkwaZWpQ53mnTleKA3g+pH05/wxT182Hdf
         ec0rhNnhkAEJa9wgmReQTy2uZknsTV3T16Wje1MtaxZ6TjIzeLIcKBVA4Q2ULKAlgO/S
         4MVc4nKI1aMgWpQrzmygW997CXLU2ouWUG4R41wrQS4oZUlf51zyRL+Z1U1nLE2tJN9c
         ycjfL/lSIvmuKM3wP+FzpuT5bA6CfjfykUgHHvASyTFEkMSZQvp9PLTL+FR5DXg6tlpO
         qBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=Gbjcd2IgrO6L9fc9+WkTPZv76RZzps8wedDsg5wGKeY=;
        b=pBmMjc9Y+Q90ytpjvm1Xp4ojarYU4aMiJpCCi030ppi3gk/MsrkBivNabmtqsrguo9
         wwYwgw4bBy3j6yuqcCALbeFTgS37MGUdI3BCyyiKjrxLG3qo4/iLTXUVhHOsnzCYBUgl
         HAaJpnflnvq6wKObRoBG+FVK777a1um8wehq4LKNehe+2z79qzrGhIeVyzC0FnSoYEqM
         ZdrASGU2fcG92nv7LwWjOAwkFZSw3JAO7hV6GcyhFQlqJay1DeoVAMavtCSP44ujzJgS
         hRy1JA3fuFg+m+ZtR9/zSKSDKGA41xEesrj7tdCG07NZ+MmO+H0+CULXGyTEVvnazFwk
         3WtA==
X-Gm-Message-State: AJIora+fU0acZAnwsN/xum5NWDzUzPWk5fX3fluVlgLs7jdlXKiUhES+
        Pnc5GwK35bQEtJGRo4Wsras=
X-Google-Smtp-Source: AGRyM1tMVmyK0B4PbANNEWw/DijnhfMre9NNZlC+bo9z31UxrNhAtoLWLzQrgiPEMW7DwZqkyO6HDg==
X-Received: by 2002:a17:902:7209:b0:16b:fa09:5d6 with SMTP id ba9-20020a170902720900b0016bfa0905d6mr9325521plb.120.1657819465381;
        Thu, 14 Jul 2022 10:24:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n8-20020a17090a160800b001ef869aa755sm3909452pja.15.2022.07.14.10.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 10:24:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6d5ac61b-b490-4f9d-6521-a4b7477d6fd2@roeck-us.net>
Date:   Thu, 14 Jul 2022 10:24:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
 <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
 <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
 <CAHk-=wgnmaTVigBc02tjqgcZaNJiYz8Xw77P+ERAXhcYjkwd=Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.19-rc6
In-Reply-To: <CAHk-=wgnmaTVigBc02tjqgcZaNJiYz8Xw77P+ERAXhcYjkwd=Q@mail.gmail.com>
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

On 7/14/22 09:48, Linus Torvalds wrote:
> On Thu, Jul 14, 2022 at 12:23 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>>
>> Oh, it's not just this one. The lists of build regressions between v5.18
>> and v5.19-rc1 [1] resp. v5.19-rc6 [2] look surprisingly similar :-(
>>
>> [1] https://lore.kernel.org/all/20220606082201.2792145-1-geert@linux-m68k.org
>> [2] https://lore.kernel.org/all/20220711064425.3084093-1-geert@linux-m68k.org
> 
> Hmm.
> 
> Some of them are because UM ends up defining and exposing helper
> functions like "to_phys()", which it just shouldn't do. Very generic
> name - so when some driver ends up using the same name, you get those
> errors.

We can't use virt_to_phys() and phys_to_virt() because they are defined for
the underlying architecture. Would uml_to_phys() and uml_to_virt() be
acceptable ? If so, I'll submit a patch.

> 
> And some look positively strange. Like that
> 
>    drivers/mfd/asic3.c: error: unused variable 'asic'
> [-Werror=unused-variable]:  => 941:23
> 
> which is clearly used three lines later by
> 
>          iounmap(asic->tmio_cnf);
> 
> and I can't find any case of 'iounmap()' having been defined to an
> empty macro or anything like that to explain it. The error in
> drivers/tty/serial/sh-sci.c looks to be exactly the same issue, just
> with ioremap() instead of iounmap().
> 
> It would be good to have some way to find which build/architecture it
> is, because right now it just looks bogus.
> 
> Do you perhaps use some broken compiler that complains when the empty
> inline functions don't use their arguments? Because that's what those
> ioremap/iounmap() ones look like to me, but there might be some
> magical architecture / config that has issues that aren't obvious.
> 
> IOW, I'd love to get those fixed, but I would also want a little bit more info.
> 
Geert gave the necessary hint - it looks like sh-nommu used defines
for iomap() and iounmap(), which made the variable unused. According
to Geert that was fixed a couple of days ago.

Guenter
