Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B11A55749A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiFWH4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiFWH4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:56:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1BE47062
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:56:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so1793912pjj.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=52DOKUmijPrR1llFW9K3DBIew/ljlnTH6iwCtWc1Dcw=;
        b=exQnH0NQbD26Rfz+zMOaKrsn9PANlcA9Lv4uS4pbvNApPEF7QMuYvgKaP8SoEPjHPN
         CeIOcPQy5Bgl6x3/PUA9e+SwYRvohXoQpAEvSVgcCBGVZqNoUVJM5P7NYald6MKEyOkO
         4DzyCvykmIZtkgBnANfHPcsfKorJF4SjFwTJZ7+Lsn1O3dyWwH/HL3G2b02X1tbnFSG1
         xY5mAccjq6mocIz68F1WL5WT4ChDt1eWSfBDVVouNF8q/ACxNV+rhrcQT5CPpJ5CIyW6
         9ri04H8gIFDXjuwcK5OLNNCM4Js6DdbLExipOFQNwxVZW71UsXXPR22s9f5EmyrDBLpq
         G4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=52DOKUmijPrR1llFW9K3DBIew/ljlnTH6iwCtWc1Dcw=;
        b=T/RfcV1CmzhK2SwI7t2EHmUIRwfe5xpmftSX+ECxjHa/uWILQaPog/Esq5qMRJpVYt
         ORkdZQO7gtmszvLgUl5TPI75z7U33LqU7t5OqaYrMIindagmaL9VPLbamsFp+Z7Ux1L5
         TUa8dl/PSXxw3QBQjl1TqyktrqTc4AQhjjSQ6mSytZJ2KVGJnT3Ob1aAtf5sm23GFAPC
         xrY1L92QX1dTmEzk6j+C2KmH0IJaLidKb8TezLpilf3mt5AcOJ0BF6zGXh7h00rZUoJH
         TCgCfnotG77i0Q/hST3c1JgMo6MRrP7pUyKwCml2sM9BcNmDrr2Vux065usOA0D7n6jk
         QIoQ==
X-Gm-Message-State: AJIora8qKjLT3R+APiQ20lCbTnRcIXCGo9n7ZV13SwH2pM3gEOAuZqG1
        2GElWWx/9Hkq/M7jNRorV+8=
X-Google-Smtp-Source: AGRyM1udj65Ge4ca9XFsOJwZwt9pFP2X01j5Lj0HcNbhtI8hHeiq88W2Din8RIUWd62QMSAqgA6W/g==
X-Received: by 2002:a17:902:9a97:b0:168:a97e:2457 with SMTP id w23-20020a1709029a9700b00168a97e2457mr38139523plp.33.1655970994002;
        Thu, 23 Jun 2022 00:56:34 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-43.three.co.id. [116.206.12.43])
        by smtp.gmail.com with ESMTPSA id v1-20020a62c301000000b0052090076426sm15492531pfg.19.2022.06.23.00.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 00:56:33 -0700 (PDT)
Message-ID: <89bc29c5-ad82-4f20-2855-44e57b043c49@gmail.com>
Date:   Thu, 23 Jun 2022 14:56:28 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ARC:mm:Fix syntax errors in comments
Content-Language: en-US
To:     Vineet Gupta <vgupta@kernel.org>, Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     Julia.Lawall@inria.fr, rdunlap@infradead.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220622080423.41570-1-yuanjilin@cdjrlc.com>
 <YrLTCXLrr3HB39lv@debian.me>
 <d104124c-5196-bc80-b3e3-0ab55f0cc35e@kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <d104124c-5196-bc80-b3e3-0ab55f0cc35e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/22 09:50, Vineet Gupta wrote:
>> The patch is OK, but its subject is wrong.
> 
> Right.
> 
>> The patch above isn't fixing any syntax errors, but rather minor cleanup.
>> The subject should have been "Remove duplicate 'to' in the
>> flush_dcache_page() comment".
> 
> I'd just say "ARC: mm: fix typos"
> 

OK.

> In an ideal world yes. But sometimes maintainer complain to break whitespacxe fixes and such into independent fix. Also as someone said later in the thread, for somebody just getting into kernel and figuring out patch submission etc this could be a perfect dry run and helps improve the code anyways.
> 

Seems like you missed the point that it's OK to have typofixes while
doing other real changes (like refactoring) in the same patch.

Quoting from [1]:

> My opinion is that trivial patches like this are fine as a starting
> point for new contributors, which is why I acked the previous patch from
> you guys. However, if we start getting two of these every week it just
> adds more maintenance burden than it's worth.

I tend to agree with the last sentence of above quote. Let's pretend that
I'm the tree maintainer. Besides reviewing real change patches, I get
flooded by these similar minor cleanup patches that I need to review.
Some (but not all) these patches have issues (say subject or description
error) that are repeated. Lazily speaking, I'd like to privately notice the
submitter about the situation, and I withhold these for now.

Thanks.

[1]: https://lore.kernel.org/lkml/0308c92a-0e10-35a4-928b-8f715a7bae44@linbit.com/

-- 
An old man doll... just what I always wanted! - Clara
