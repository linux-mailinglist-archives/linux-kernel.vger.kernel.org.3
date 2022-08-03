Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BDA588581
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiHCBtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiHCBtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:49:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DFB26108;
        Tue,  2 Aug 2022 18:49:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso527916pjo.1;
        Tue, 02 Aug 2022 18:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Eq2bNZKRTPBg/Erec8mPYF5Hp1Q9yAhnQPYCvx6UjBg=;
        b=Pv2AGY0MFO0cMVcGdczfMNk6TbrOlpkS1uYKIJ2y8ZnWn0Ob6HJB/hO5eWzNRK+AXN
         z/C/4WXNKKaBa9IyW2klipUwtwhfSAjcFHNRpkfOSCXrj4pOwUssCsyP+DFWm4VLz/Hm
         OB8eVPL9L3QgMKFECyg/xvjE14mMHTGaHUWxG4HDHuft8nKx23RX/EVO8WjKF3FanHdQ
         9eRkgFt+ZHART0w1blYCmvnvBAdKYyUZa0XzhYZB21Z6FaW2bbNAuF/m7FA4ggnPZP/t
         C2cNACV46E1K2lConbYYv6L0YFfA8j6L1WccLk+LCSmIDsBTk8c7vASuRc05x8LFIbqB
         rSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Eq2bNZKRTPBg/Erec8mPYF5Hp1Q9yAhnQPYCvx6UjBg=;
        b=3TcTYRNFpvKAJplYCEwqu4UUmVSMh78cMkFLUjh3H6TYTJuzxmYgXx2LqZOg6bZEZt
         lfgioNcknp6dpF6O2zqA/C6mTKJXczWr8J36iS8hemRGPsxb6iT5GHTKTFIpLgDy9RHM
         yqxhBY1JHovpZ3PmWteb4wUv79nHcVTSyJygsPYxmnl+aU0XdHkelcrWsZ7mA4/Z2QE+
         ZW4Uf6U0bZ68l/05gW83J4oQVrkzmqJp/Wcfd9yIqdgEtdXGMybUwTbMAlToDAwiBTiM
         Z9BU4fNw8+D03fpKRJjJBqEjWD82RctFSVMI3dsOWZ7kqTaEcujnWKYjgHK9Ul6P/FO3
         d3Lg==
X-Gm-Message-State: ACgBeo09/3qDPQiBWfWxWpcxoP8/zeeH/Svpi1M7b0G7SErETB6fduv+
        Tp7u2l+Sv84zgsn0KIMNvoOjlffCuyQ=
X-Google-Smtp-Source: AA6agR5FbzZ+4i+MqGhdOutVudI24WXHqMCbg0DGun8EDKBuEmxFJwTq964y86XOTzQLRT7IU91hRQ==
X-Received: by 2002:a17:90a:2b42:b0:1f4:fc9a:be32 with SMTP id y2-20020a17090a2b4200b001f4fc9abe32mr2329539pjc.221.1659491341961;
        Tue, 02 Aug 2022 18:49:01 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-86.three.co.id. [180.214.232.86])
        by smtp.gmail.com with ESMTPSA id g18-20020aa79dd2000000b0052d4ffac466sm4297165pfq.188.2022.08.02.18.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 18:49:01 -0700 (PDT)
Message-ID: <d1f90d44-a1e9-7490-f789-f928b85a1d26@gmail.com>
Date:   Wed, 3 Aug 2022 08:48:58 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-next: Tree for Aug 2
Content-Language: en-US
To:     broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220803010326.2814276-1-broonie@kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220803010326.2814276-1-broonie@kernel.org>
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

On 8/3/22 08:03, broonie@kernel.org wrote:
> Hi all,
> 
> Changes since 20220728:
> 
> The hid tree gained a build failure which I fixed up.
> 
> The thermal tree gained a build failure, I used the version from 20220728
> instead.
> 
> The net-next tree gained a conflict against the net tree.
> 
> The kvm tree gained a conflict with the kvms390-fixes tree.
> 
> The pinctrl tree gained a build failure for which I reverted a commit.
> 
> Non-merge commits (relative to Linus' tree): 12734
>  12594 files changed, 1319236 insertions(+), 278745 deletions(-)
> 
> ----------------------------------------------------------------------------
> 
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.
> 
> You can see which trees have been included by looking in the Next/Trees
> file in the source.  There are also quilt-import.log and merge.log
> files in the Next directory.  Between each merge, the tree was built
> with an arm64 defconfig, an allmodconfig build for x86_64, a
> multi_v7_defconfig for arm and a native (arm64) build of tools/perf.
> 

Hi broonie,

Thanks for keeping linux-next up while Stephen is on vacation.

What is missing here is powerpc build (ppc64_defconfig), since the
architecture is often used for cross-compile test.

And I think since we're at merge window for 6.0, we need to say
"Please do not add material for 6.1 until 6.0-rc1 have been
released".

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
