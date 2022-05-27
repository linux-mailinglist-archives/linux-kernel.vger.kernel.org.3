Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C6153640D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 16:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353234AbiE0O2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 10:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346211AbiE0O2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 10:28:10 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76504123887
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 07:28:09 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id q3so2956003ilt.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KMv5tCcCWrPkpO9Ttncp3VA2pFtqMuTyATs8kAW8Ii8=;
        b=bKV2zNu/ZX20GZe89JDMdKLB3pkqN717hLJrcdbuoTpxNtRnIso4IFoE8AQJz6c3dC
         gCBOv19GPggLPnQJviLIU5jzB5LJK3MfQtoRyOnsUA2TmVF4r5gjgJn9rLP1v9jZh/k/
         TowS6l95bTtU8HqW9QEfJ43g2rfSueGD3U+jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KMv5tCcCWrPkpO9Ttncp3VA2pFtqMuTyATs8kAW8Ii8=;
        b=xGGUSe7ADenDDc/IV8MBDdMekhmaMafVfQdzCmUKU3Q+iaNdV2soB18O6mye0C4qWO
         w2dNwhWe2NjS9zFt1guIRpRcJADrRjZNux+5U+2hmUteyIwnG6R2ASleDkadDYquDKNF
         JZ9/bpbyVIXblXmcf563V0NL2iA9U8DSfdLipJ2X1pw/eASTAKvj5/K21fk33W3V9pMc
         clBPobdfMm9+xuCHKt2lNTyk0VyZk686gjwWuqTxnUBPel7M7e95Zxm0cLyaf82b3h+s
         gA8M8SFJ1fLmEDyMJ22E0VX4nMTTlCD+5zXZ/5QMkD8F8Cew7/OgX0hc95SGpje0Zuho
         bI7g==
X-Gm-Message-State: AOAM531FoNpSw/AlCL1BJa3MwKtW6Qmv0punigZFwNasNHzpjaOB7koU
        YFpTe+U+0XKGXWiU1cTbf7NtsA==
X-Google-Smtp-Source: ABdhPJyOOICm2jtrQXxIQy6Ma/v9ki/PwgnLWf/Rhv03iWeZJeDSCkgeDTRuNgQ6YZqALspHh35HQg==
X-Received: by 2002:a05:6e02:12cf:b0:2cf:4afa:2957 with SMTP id i15-20020a056e0212cf00b002cf4afa2957mr22444289ilm.26.1653661688869;
        Fri, 27 May 2022 07:28:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d136-20020a02628e000000b0032b3a781755sm597031jac.25.2022.05.27.07.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 07:28:08 -0700 (PDT)
Subject: Re: linux-next: manual merge of the kselftest-fixes tree with Linus'
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <shuah@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220527093354.27316445@canb.auug.org.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <abcacac6-0a9a-976f-dd48-a8282075247c@linuxfoundation.org>
Date:   Fri, 27 May 2022 08:28:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220527093354.27316445@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 5:33 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kselftest-fixes tree got a conflict in:
> 
>    tools/testing/selftests/vm/run_vmtests.sh
> 
> between commits:
> 
>    b67bd551201a ("selftests: vm: refactor run_vmtests.sh to reduce boilerplate")
>    33776141b812 ("selftests: vm: add process_mrelease tests")
> 
> from Linus' tree and commit:
> 
>    e8f0c8965932 ("selftest/vm: add skip support to mremap_test")
> 
> from the kselftest-fixes tree.
> 
> I fixed it up (I used the former version of this file which seems to have
> included the latter) and can carry the fix as necessary. This is now fixed
> as far as linux-next is concerned, but any non trivial conflicts should
> be mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.
> 

Stephen,

This is just a bit outdated kselftest-fixes tree problem. I didn't update
it after Andrew sent the fixes in.

I don't have plans to send any pull requests from this kselftest-fixes brach.

We are good. Thank you for keeping the fix-up in next. It will be cleared
up in a week or so.

thanks,
-- Shuah
