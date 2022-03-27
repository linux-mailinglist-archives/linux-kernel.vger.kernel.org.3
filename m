Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1BE4E85EE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 07:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiC0F3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 01:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiC0F3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 01:29:05 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63201EACC;
        Sat, 26 Mar 2022 22:27:26 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id z128so9746810pgz.2;
        Sat, 26 Mar 2022 22:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E8NTt7ig1pU1hSZ1U5qlamHZutvLAHUXQA1+pTFB7LQ=;
        b=DBzTXJyy/uzYtS/GWMtT4TwhEt19ty3BMTfcsETZ0mJ33m4jWoq/+aw16lttOSVRB+
         vcxYWGRspvX74scpSZAF5bBCmmFRZGgg4jLEo8ZfwnKEpcs5nA5tgiLCsLWRfNIlq9dC
         02HLn29GDI/JgALE9F2rZyqDHFoAg31RPwbNDatVwBQt0LKDsTb6mYvmEWXH0R8da5al
         MvjsXYtzBMJZoNbvIUpDMLZABqnbObaXkyAjlRiIcKm5/sSU6cOIthQ39lUH+strxAbx
         jhF1HSkdV8d0jW1c6ROXNpfEMkbP3uZh6LwIg0nr+a58fpxg2djYvLS++dHj0WGA9DLN
         vA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E8NTt7ig1pU1hSZ1U5qlamHZutvLAHUXQA1+pTFB7LQ=;
        b=1F3TdSE95avh1U2sANQtX999B158q+ALsy5IcScLt38xOJzL/RiAdgE0xejykeDCBq
         ReSHyqe+Pc89ddtOqhXKK0woCJ/qDIw4gMosk7H9zAS8vpYA80ZLdLB6oiJa/LvAjEgb
         67QoUUj2UKK5EzPeJgxuo/G4V1JdKBrnH5HM4IWjV8k3MjEnrpife+zLyyJBiZ/4Gv5L
         bg6PlslD1ACLV+YvUadyK+UzJxQ6P5YPib60oLBmq45f+6a24hhZqwfn4yPurcPPV5Yh
         Ln0NJgMlBG2XjRxUAL7g4UJfG5R7+mln+GqCN9da4OiJ2ptPSegH6XVwDPDneouiEz/K
         7/Zw==
X-Gm-Message-State: AOAM532wcOAvPT+/8qAwTiG0fa5wnQ3N0V1RBb/NH0DXsakSDXLKxBs/
        YtyTg4dDYucLkGABxiy/Ff0=
X-Google-Smtp-Source: ABdhPJzbD5EsXIw7aOaiiFtQxTNjlryX9D5y4t13BB7E98bVXDll3Mnci1izQFCEiLImPlb1UzxgXA==
X-Received: by 2002:a05:6a00:2186:b0:4f7:5544:1cc9 with SMTP id h6-20020a056a00218600b004f755441cc9mr17621539pfi.62.1648358846240;
        Sat, 26 Mar 2022 22:27:26 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-21.three.co.id. [180.214.233.21])
        by smtp.gmail.com with ESMTPSA id t18-20020a17090ad51200b001c71bec7b22sm10051853pju.23.2022.03.26.22.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 22:27:25 -0700 (PDT)
Message-ID: <49829de5-efe5-9065-d87a-2494d16b9465@gmail.com>
Date:   Sun, 27 Mar 2022 12:27:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] Documentation: kernel-doc: Promote "Writing
 kernel-doc comments" to page title
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
References: <20220326123337.642536-1-bagasdotme@gmail.com>
 <20220326123337.642536-2-bagasdotme@gmail.com>
 <20220326145332.0698a849@coco.lan>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220326145332.0698a849@coco.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/22 20.56, Mauro Carvalho Chehab wrote:
> Hmm... I can't really see any differences... What this patch seems to be
> doing is to just change the markups for each level.
> 
> See, on Sphinx, the first markup (whatever it is) is level 1, level 2
> the second different markup and so on.
> 
> So, before this patch, kernel-doc.rst had:
> 
> 	level 1: Writing kernel-doc comments
> 	=====================================
> 
> 	level 2: How to format kernel-doc comments
> 	------------------------------------------
> 
> 	level 3: Function parameters
> 	~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> And after it, it will have:
> 
> 	====================================
> 	level 1: Writing kernel-doc comments
> 	====================================
> 
> 	level 2: How to format kernel-doc comments
> 	==========================================
> 
> 	level 3: Function parameters
> 	----------------------------
> 
> No semantic changes at all.
> 
> The only (eventual) value of a change like that would be to make the
> levels more uniform, but IMO, it is not worth to apply a change like
> that, as:
> 
> 	1. There are a lot other documents that don't use the more commonly
> 	   used level standard;
> 
> 	2. Making all .rst files to use the same definitions is hard;
> 
> 	3. Even if we place everything using identical markups for every
> 	   level, as new stuff gets added, different (still valid)
> 	   markups could be used on newer documents.
> 
> Regards,
> Mauro
> 

Indeed, fixing heading levels when adding title heading is required because
without it, Sphinx will complain "indentation inconsistency" error.

Maybe better splitting indentation level changes into its own patch, right?

-- 
An old man doll... just what I always wanted! - Clara
