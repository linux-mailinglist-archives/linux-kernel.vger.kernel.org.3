Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A290359AE67
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 15:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346807AbiHTNGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 09:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348420AbiHTNF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 09:05:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F56FD06;
        Sat, 20 Aug 2022 06:05:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g18so6984629pju.0;
        Sat, 20 Aug 2022 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=2zOBbjpazl8s57/XiU2lbdevcEWjRoAb9VSfq8YjUQg=;
        b=ND4Av5P0qlLxEj7+crbFAgOALB0pd7miYDDOPKNvz3UzUj68fzMefaoMY1I9gHac40
         dL74FQ9r4eOggMyubGiK176A+MoJbmX0RXYQ+poPLUvy3Exdi8DyFDRgK2drv65nb1Cz
         LDhWpgdDXg+4I22AlbF7mrHVKP5Ji32WE2ITbEP7EBQ43s+uz7kDREKwFlpdNhZBmjYJ
         j9harzTZrUZp87cCJFrXJRcQvIJCJ5R+7u2rabfhwYLZP/bv3mooj3d5qSWWNlSSVtm1
         Z84TpdQQlt8KrsR1gS0kZJV0QGKcf4dNh0mFl1hjvyMeLu8K23LzwKfk/Jvt4QKmhObx
         +aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2zOBbjpazl8s57/XiU2lbdevcEWjRoAb9VSfq8YjUQg=;
        b=7v40BkBvn6lswQ5P3stx1CDnjQTcNcMC/cQn8qUafaU0ssyp99Y5IJZT0p+HG4NRuc
         IKsItEojzkt+S809Zz76WvFz9OigyHtUYgXzB2gWfuhyHonog+7zDAM5rRIHAhqU89Ea
         FlVRJa4/2kkKndaURoj0l3mg3ENKUqv2gojPmxbQyYVJ7V1IEhUEZs60TzZMP3wHcso+
         O1ftKS6tzW+kts/JkGIPEEjAEeL1LUL5PVj+J1/mtjiTPNnl0MRn9kW1aXohSs/KaN+I
         RborkyS60oNyL37RX43mySF9F3FDlvov8+WnsfYDWipRFtGSqKGqMcN0BZFEW9jnIJR9
         AAnQ==
X-Gm-Message-State: ACgBeo3MCCb9km+vAjCw8zpBfxyEIMpp3fdnEeueor4YlKDS1Ht8Gb3B
        p6AHg5Lq5d/FD+IkpGJdVPPNDgsUEsI=
X-Google-Smtp-Source: AA6agR7jWkYSTki/k2c0Y6EKP69+uqDweVtoCPWQRCpoopmtfW/s6ufzx7Ae7nwF+QPWN3LqtBjKnw==
X-Received: by 2002:a17:90b:1d89:b0:1f5:a59:46b1 with SMTP id pf9-20020a17090b1d8900b001f50a5946b1mr13392684pjb.173.1661000757722;
        Sat, 20 Aug 2022 06:05:57 -0700 (PDT)
Received: from [192.168.43.80] (subs10b-223-255-225-239.three.co.id. [223.255.225.239])
        by smtp.gmail.com with ESMTPSA id r1-20020a170902e3c100b001618b70dcc9sm4865960ple.101.2022.08.20.06.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 06:05:57 -0700 (PDT)
Message-ID: <d63cc303-0b73-4100-829d-01c6e3bb3548@gmail.com>
Date:   Sat, 20 Aug 2022 20:05:47 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] doc/rcu: Update LWN articles at the beginning
Content-Language: en-US
To:     Shao-Tse Hung <ccs100203@gmail.com>, corbet@lwn.net,
        paulmck@kernel.org
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220820083244.28338-1-ccs100203@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220820083244.28338-1-ccs100203@gmail.com>
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

On 8/20/22 15:32, Shao-Tse Hung wrote:
> This patch adds LWN articles about RCU APIs which were released in 2019.
> Also, HTTP URLs are replaced by HTTPS.
> 

Please write patch description in imperative mood (say "Add 2019 edition
of RCU API documentation and use HTTPS links." instead).

> -| 1.	What is RCU, Fundamentally?  http://lwn.net/Articles/262464/
> -| 2.	What is RCU? Part 2: Usage   http://lwn.net/Articles/263130/
> -| 3.	RCU part 3: the RCU API      http://lwn.net/Articles/264090/
> -| 4.	The RCU API, 2010 Edition    http://lwn.net/Articles/418853/
> -| 	2010 Big API Table           http://lwn.net/Articles/419086/
> -| 5.	The RCU API, 2014 Edition    http://lwn.net/Articles/609904/
> -|	2014 Big API Table           http://lwn.net/Articles/609973/
> +| 1.	What is RCU, Fundamentally?  https://lwn.net/Articles/262464/
> +| 2.	What is RCU? Part 2: Usage   https://lwn.net/Articles/263130/
> +| 3.	RCU part 3: the RCU API      https://lwn.net/Articles/264090/
> +| 4.	The RCU API, 2010 Edition    https://lwn.net/Articles/418853/
> +| 	2010 Big API Table           https://lwn.net/Articles/419086/
> +| 5.	The RCU API, 2014 Edition    https://lwn.net/Articles/609904/
> +|	2014 Big API Table           https://lwn.net/Articles/609973/
> +| 6.	The RCU API, 2019 Edition    https://lwn.net/Articles/777036/
> +|	2019 Big API Table           https://lwn.net/Articles/777165/
>  

I don't think line blocks are necessary for lists. Instead, use nested
list. Why? Big API entry should be as sublist.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
