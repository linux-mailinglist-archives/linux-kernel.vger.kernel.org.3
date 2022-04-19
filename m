Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0E506558
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349031AbiDSHLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiDSHLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:11:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6510264F9;
        Tue, 19 Apr 2022 00:08:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q3so14408437plg.3;
        Tue, 19 Apr 2022 00:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MWbi3vUZgXTvK2pooF+cjTO/k3F4lPsZ5PdazRMo9ck=;
        b=HWHJtmaXSJlLSrZBv72QeA31ihOlVrQewyaZ8/n4q2di2eEnCWAbkM+RBStfyAyMnS
         +LdnwNA2lseBYI563Kg+J4ACvvBNedOdkVAgV0+MAt7wpKUAZtyVUqEpAergG+Ai1yfb
         qrNkprK3+8RbalL0b1xirl5Q8xp0k234CEwEwVDhiwn0rAOZWpamDMftCTIA+BgUwEw8
         33n0TMnXhrlwQQGRA+9us29k2Qv3yFpJ/ri+oOtI4QDsBn6JsKj7HXdOmfwlAz7GOF0U
         nYxWPhGw20+d7a2V30MjgT1FrfaFr9F3D5wGpo4/2YOR/G3dMyL+8fvmL5M0LSgN5grT
         qySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MWbi3vUZgXTvK2pooF+cjTO/k3F4lPsZ5PdazRMo9ck=;
        b=d84BWAxVi/uRRTVOY8ZThxBoquNTevzL7Tuv0Hs8Ogz8kj1kKhL4zWVDGsUWjpaoEg
         pR4XxGiw7+FG8DIDZIczNbaZ7KUs9cFpk4qOO9AYvMxw5NlfqNmHDdGq+A89ZcTD3RFW
         T6fTQcjOKNQhjqy0SeHcqbp7Z97yi3L3IXeR2eGya8rZ1zVWn7AfdF/I7AGSRlt+9BsH
         EoyTJ5AIiHsOoEDJP9/BP3CWyXDaCOkrm2v+xv+HRIUdOAC6x1UZBbuno+6jPsEPv8Vp
         3k3O6Yb1tyAnelThRuRo97SIqSC8KwRpdkC+tDWFbTjGDE5zyg9YX6EdHmDtaWvC5Mid
         EN4Q==
X-Gm-Message-State: AOAM533iOtFbWCcruGOOw+HuyRNcfe5RjgRotNez5hDgNutwaiV4Gnk9
        vNj4K3lYsfsihgM6uCEp8gQ=
X-Google-Smtp-Source: ABdhPJwUt0RWFVjhL9w12YonxxPsHt2k1Zq3rZEbxbKoUImJh8Whh7SYSw449vrOlAzoIDOfkdktJw==
X-Received: by 2002:a17:903:2c1:b0:158:f9d0:839c with SMTP id s1-20020a17090302c100b00158f9d0839cmr8734012plk.118.1650352131805;
        Tue, 19 Apr 2022 00:08:51 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-69.three.co.id. [180.214.233.69])
        by smtp.gmail.com with ESMTPSA id md4-20020a17090b23c400b001cb66e3e1f8sm15123600pjb.0.2022.04.19.00.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 00:08:51 -0700 (PDT)
Message-ID: <371488b0-1baf-8cea-628f-83c9b0383c88@gmail.com>
Date:   Tue, 19 Apr 2022 14:08:48 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH rcu 0/2] Documentation updates for v5.19
Content-Language: en-US
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
References: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 05:50, Paul E. McKenney wrote:
> Hello!
> 
> This series contains a couple of documentation updates:
> 
> 1.	Add documentation for rude and trace RCU flavors.
> 
> 2.	Update RCU cross-references as suggested in doc-guide, courtesy
> 	of Akira Yokosawa.
> 

Bulding htmldocs with this series, no new warnings found.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
