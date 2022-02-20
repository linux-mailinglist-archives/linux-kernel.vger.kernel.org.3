Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B714BD2AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 00:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245285AbiBTXhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 18:37:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiBTXhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 18:37:47 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8C026D1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:37:25 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id ci24-20020a17090afc9800b001bc3071f921so1402978pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=PfnPViFi5jg7IRyMxQ3OaQXKIHWgtsoMjGOlXD3zJQM=;
        b=iRob2c+2Fra2zwal5sxhXh70bO5WigxgAUdN1dsAHPlzA+Chs964jL5I+Xa5jG+zpJ
         gMIRcE5UBh2Bs5k5+IbI8WsNKt5rf1RTuIJfgzCSRmX/3hO1uEBPnkJZOMdARpiynuIe
         sZ5vQqFMj7B1O4oIqmecMQrN3x95NLx61I4iThqIv2R6+HvhYyEKg7P688rptpQ6gjwE
         IyLWu45YshhfjR2YcNBtrMQM5tiPvB5usbh+m4nay4dKLFGiXtOv0Gqt57Qu6p5pymSP
         gamGFz6gguwmSVtvFCGP06emerWfp95vch1guKiSftIitgRnOyFzEVvcPZA6DScbH9sr
         h3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PfnPViFi5jg7IRyMxQ3OaQXKIHWgtsoMjGOlXD3zJQM=;
        b=MaI+YDHKwqRr+6bnD1MbKphA8hVy4muwVauGEMGjW4JcpuGDgw4F7DQub2KzBhZGeX
         7oeURXK0r7+1x3f9csoZNuAlpSWRUu3MI78tejCEhxrKRWBigX1Tws0HG4jaEj4KY1XV
         2axuIu20+rKrgU1VWNdlLJSkmdYhaxjNnGK4G4yyJ7K64PNGj25las7QQxIQL0SVgmdm
         A7Reda5bw4NvBmkIhTncbEZbMa6xJ1jCdmSYPJm9RcTFaRqaPA2Gm7szy6ii8N05tVDp
         4UXTIAQ6+ez11Lfnrqn5E2NCLN++2vvRfG3CUmGm+dX2LrgmwwJ8jORZ3ERtf/5OOCXR
         XVMg==
X-Gm-Message-State: AOAM530onbMJpjCKeiPt9/MT2fg59w6cJzz1Y0BDf/fOCxqXqjuAVKqk
        4ho6tFpHpOUfKkaWPo8x2QCqvzw6sM6N2Q==
X-Google-Smtp-Source: ABdhPJwJZcBh1EKHqiF2w9O4ZrJ1IYsxxMAFqgoYGFudkI4Sp3rvs4qiYXDdGu4DqAapa2ePGodlig==
X-Received: by 2002:a17:902:e889:b0:14f:c4bc:677b with SMTP id w9-20020a170902e88900b0014fc4bc677bmr965728plg.68.1645400244621;
        Sun, 20 Feb 2022 15:37:24 -0800 (PST)
Received: from [192.168.0.2] (c-73-158-10-71.hsd1.ca.comcast.net. [73.158.10.71])
        by smtp.googlemail.com with ESMTPSA id 13sm5560588pje.50.2022.02.20.15.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 15:37:24 -0800 (PST)
Message-ID: <2d30205a-fc22-02e1-5c4b-99b91493580c@gmail.com>
Date:   Sun, 20 Feb 2022 15:37:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Linux 5.17-rc5
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgsMMuMP9_dWps7f25e6G628Hf7-B3hvSDvjhRXqVQvpg@mail.gmail.com>
From:   Robert Gadsdon <rhgadsdon@gmail.com>
In-Reply-To: <CAHk-=wgsMMuMP9_dWps7f25e6G628Hf7-B3hvSDvjhRXqVQvpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile fail.   Fedora 35, GCC 11.2.1, x86_64..

....................
   AR      net/netfilter/built-in.a
   LD [M]  net/netfilter/nf_conntrack.o
   CC [M]  net/netfilter/xt_socket.o
net/netfilter/xt_socket.c: In function ‘socket_mt_destroy’:
net/netfilter/xt_socket.c:224:17: error: implicit declaration of 
function ‘nf_defrag_ipv6_disable’; did you mean 
‘nf_defrag_ipv4_disable’? [-Werror=implicit-function-declaration]
   224 |                 nf_defrag_ipv6_disable(par->net);
       |                 ^~~~~~~~~~~~~~~~~~~~~~
       |                 nf_defrag_ipv4_disable
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:288: net/netfilter/xt_socket.o] Error 1
make[1]: *** [scripts/Makefile.build:550: net/netfilter] Error 2
make: *** [Makefile:1831: net] Error 2


- already reported on Feb 11th, at:
http://lkml.iu.edu/hypermail/linux/kernel/2202.1/05890.html

Robert Gadsdon
February 20th 2022.

