Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B0B5AA941
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiIBH6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiIBH5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:57:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338C6175AE;
        Fri,  2 Sep 2022 00:57:47 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y141so1143650pfb.7;
        Fri, 02 Sep 2022 00:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=o9Ihr0WtD+g6gkqQl1OECUuvwlWOgpDnJ823HpLeTaM=;
        b=PuXr+dUf7lm9gSvzez8jxvllrGgsmilhjAFiiYYddWly9aOSEoF7To42LiY0mZknmy
         oY745/ey9gqtoOhzz3enEUXPn0z2wSvjFnK3/kGcg9EJaM9B2gJaDujXzNYAUrZ6llrt
         4lj+PAfaDDnX2yZ2eixbG9DwSs1CEN+8n+umkwGJY1CmkQ37HEc5kfWl1GP+VnjZ5yJ4
         dA9yI2PeIBphMfUlcIlXp3IP8ktEdC1SUJ1vN3xWKrdwO35jB+XnXxkAtc3doGzYQJ7h
         0KkIku96NyGiTcbnimX/In9kI0xcqKRR97COShiSuTx0Oe0fO43AG9rZD9xTWfhakSvt
         pSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=o9Ihr0WtD+g6gkqQl1OECUuvwlWOgpDnJ823HpLeTaM=;
        b=pdKgS1FUhbJTNPPQerrept1yZFyoupDmX7pusf2MyM8ltNl5jIk3K8nRKEJ3E6lHIz
         JY9FPdUe5w+7dcwn7U0GHZvR1AC751HgMpt1wHioqR7l3LNDr4tvlZdQxYrPVqcyDXIx
         7OJLVdD8qKACV1udwow5f68d3BpC1TjOBOhIWhPpsjyHq92YF1aDFvVULdy3omT1I7hl
         3biUO3EG0YgA9UfSRhfa+69lqkUVFX+ASjaVXyRMmh+ZGVkPQax2yurJTLvUYt2JQMp8
         wAfupFD6lVH++xjDxZH9qinFda25zZ56vN3IYu7AzRp7l83xfKCi96p1fgByEWZkBPJi
         xPDA==
X-Gm-Message-State: ACgBeo3UvFwXCSIj4FeAX8jPwDnhlVTKpjIvCT++VsYf8gRZfVv9+/Va
        xTGiPzzXl5POx2FuAPSzDwA=
X-Google-Smtp-Source: AA6agR4COWy6jqKbhr5qZ5ezNJDdoOC2dH4cm6bWTuM3WHKZSGKqvLnwxGGpgGl1JTC6/8kD/PPG2A==
X-Received: by 2002:a05:6a00:3306:b0:538:444d:87d3 with SMTP id cq6-20020a056a00330600b00538444d87d3mr22916975pfb.38.1662105466782;
        Fri, 02 Sep 2022 00:57:46 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id u13-20020a170903124d00b0016bb24f5d19sm921318plh.209.2022.09.02.00.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 00:57:46 -0700 (PDT)
Message-ID: <110faf8f-2578-67f3-741c-02182b485769@gmail.com>
Date:   Fri, 2 Sep 2022 14:57:41 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] docs: update mediator information in CoC docs
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, gregkh@linuxfoundation.org,
        corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        joanna.lee@gesmer.com
References: <20220901212319.56644-1-skhan@linuxfoundation.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220901212319.56644-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
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

On 9/2/22 04:23, Shuah Khan wrote:
> @@ -51,7 +51,7 @@ the Technical Advisory Board (TAB) or other maintainers if you're
>  uncertain how to handle situations that come up.  It will not be
>  considered a violation report unless you want it to be.  If you are
>  uncertain about approaching the TAB or any other maintainers, please
> -reach out to our conflict mediator, Mishi Choudhary <mishi@linux.com>.
> +reach out to our conflict mediator, Joanna Lee <joanna.lee@gesmer.com>.
>  

Why had Mishi be replaced with Joanna?

-- 
An old man doll... just what I always wanted! - Clara
