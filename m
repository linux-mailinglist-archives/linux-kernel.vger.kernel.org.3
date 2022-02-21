Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2154BE71E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379939AbiBUQLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:11:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379935AbiBUQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:11:46 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBC627160
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:11:23 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id d7so33150105qvk.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=d396PtROr+jPwEkDcy61jcpnkTVE5m6X1ZEPC1Mq6R0=;
        b=OgdF/dWy8xpsv8JpMGt0895ynwGPKpH7tPRnhw90xwJ+PbyrMIYqCdlAxmsXtL3xg6
         bAqxoRk1MPK/zriW/sWl6L+9DoanBM1jSKP7Bt0AayPKMx/IPiDbMhb6a9MyaFSs7+9c
         WJbtkoRLF1t5COPU8BMwUYriXe1ZOyH72oH4ThIFec1NiDYjuF1YGtKFSuMHRaIrUCTI
         fOrypVM6f1BW/lqQdZKmODdwuHyJPWN5kCGvQIDaEMQMjaiLVCj0FAWUckqEPhKHZolW
         dgmP9NLiWud3trBpU9rY1NgkhzqkmAR3NoiqxQtoEgGG8iW2hFUmXr8cZixw9/c3dw1J
         yTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=d396PtROr+jPwEkDcy61jcpnkTVE5m6X1ZEPC1Mq6R0=;
        b=XDG49lqaHfMHtYwlzdApLAMD535RvNnWnqp3Y1ov7qhO3Of5CbIpdHBW+s4gAHCc9J
         vbQk4aKdvRl4UkJ0ugqni/3x3BrBd8JO1HK/g/mePcDyJ3cmWK4hmAlDyw9LfAbfWJCQ
         A21qcBVI2xtnsqCBe41vC4ml6a4/QAvuVYg3SNeW45ygsDBVvRSi9qsAD3eOO5t4qDF7
         emStqp9BBFBxu52qbNj+jhxh25tNyelT7L0d6/P9E4T8qkNw4HlTKg3s8tOyORkH3flz
         PaV6WSvbqtzMz5Pzg3y6OD84w6OuzJMRQBCum7G8lCPdWDixaXS74FYdrL9TrM5ZYAy2
         vMMA==
X-Gm-Message-State: AOAM532LiKUytp7K0p6FXgyDbs+3M50lQ5mrGRaQMcNdEGn9k814ZkqS
        Se1Q6g4YkNKwFTMqG5cc9XVttjMTB+w=
X-Google-Smtp-Source: ABdhPJwW/9NjOXYdvMVZZVJ2vXSMs+hJXRrqlemsUNY6Kpl/tizcVjiwcIJwZqXYLaD9Ir5qk1JzKQ==
X-Received: by 2002:a05:622a:40e:b0:2dc:eb59:4855 with SMTP id n14-20020a05622a040e00b002dceb594855mr18786913qtx.526.1645459881699;
        Mon, 21 Feb 2022 08:11:21 -0800 (PST)
Received: from [120.7.1.38] (198-84-206-107.cpe.teksavvy.com. [198.84.206.107])
        by smtp.gmail.com with ESMTPSA id d23sm9295816qka.50.2022.02.21.08.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:11:21 -0800 (PST)
Subject: Re: Linux 5.17-rc5
To:     Robert Gadsdon <rhgadsdon@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgsMMuMP9_dWps7f25e6G628Hf7-B3hvSDvjhRXqVQvpg@mail.gmail.com>
 <2d30205a-fc22-02e1-5c4b-99b91493580c@gmail.com>
From:   Woody Suwalski <wsuwalski@gmail.com>
Message-ID: <013de68c-a30c-6c13-ee08-2af65d5cb849@gmail.com>
Date:   Mon, 21 Feb 2022 11:11:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101 Firefox/68.0
 SeaMonkey/2.53.10.2
MIME-Version: 1.0
In-Reply-To: <2d30205a-fc22-02e1-5c4b-99b91493580c@gmail.com>
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

Robert Gadsdon wrote:
> Compile fail.   Fedora 35, GCC 11.2.1, x86_64..
>
> ....................
>   AR      net/netfilter/built-in.a
>   LD [M]  net/netfilter/nf_conntrack.o
>   CC [M]  net/netfilter/xt_socket.o
> net/netfilter/xt_socket.c: In function ‘socket_mt_destroy’:
> net/netfilter/xt_socket.c:224:17: error: implicit declaration of 
> function ‘nf_defrag_ipv6_disable’; did you mean 
> ‘nf_defrag_ipv4_disable’? [-Werror=implicit-function-declaration]
>   224 |                 nf_defrag_ipv6_disable(par->net);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~
>       |                 nf_defrag_ipv4_disable
> cc1: some warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:288: net/netfilter/xt_socket.o] 
> Error 1
> make[1]: *** [scripts/Makefile.build:550: net/netfilter] Error 2
> make: *** [Makefile:1831: net] Error 2
>
>
> - already reported on Feb 11th, at:
> http://lkml.iu.edu/hypermail/linux/kernel/2202.1/05890.html
>
> Robert Gadsdon
> February 20th 2022.
>
Compile failed for me as well.

The workaround:

nf_defrag_ipv6.patch
--- a/net/netfilter/xt_socket.c    2022-02-21 07:29:21.938263397 -0500
+++ b/net/netfilter/xt_socket.c    2022-02-21 07:40:16.730022272 -0500
@@ -17,11 +17,11 @@
  #include <net/inet_sock.h>
  #include <net/netfilter/ipv4/nf_defrag_ipv4.h>

-#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+//#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
  #include <linux/netfilter_ipv6/ip6_tables.h>
  #include <net/inet6_hashtables.h>
  #include <net/netfilter/ipv6/nf_defrag_ipv6.h>
-#endif
+//#endif

  #include <net/netfilter/nf_socket.h>
  #include <linux/netfilter/xt_socket.h>



Or force use CONFIG_IP6_NF_IPTABLES

Thanks, Woody

