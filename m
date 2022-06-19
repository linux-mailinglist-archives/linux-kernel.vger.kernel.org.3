Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282C4550823
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 05:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiFSDn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 23:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiFSDny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:43:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF5F5BF;
        Sat, 18 Jun 2022 20:43:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so7351904pjg.5;
        Sat, 18 Jun 2022 20:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EnzDhDeyfSBziXuZGA6YINXRpGRxK7wpOOa1cbvAH2c=;
        b=Ezj2jnSQqBIyAHTHnC6jPbT+kcQq3l+4wXvHGO4MbgCLezTx/CNXg4jyfBBsKEygvx
         jEo38lj8MRMvDSkcoZj8CiVn+GFxVPrDriM+nmFjA+imecRIcDB2n/sSWk2QQe8IV0WM
         eDFnlS2YvNLhDzKITKpVgHCJqmhgieqLhXe04CWrHb0NpdZGbznttV4rHcGkwwbtde93
         G++yfXVNQYobbGcQEVTFqbH3o4W1A6euFg2eMwGtPkR46ege2jbzHLLouZtpIM2DpqW/
         frIKO6xA9cS1mI/SQpB3a79L5Xcuhhrslqp73wAb37Xsj5X6WZ/wVcEcoGGmmrBebhnM
         FORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EnzDhDeyfSBziXuZGA6YINXRpGRxK7wpOOa1cbvAH2c=;
        b=LA96bSZxyk3qmlkzhKeO+937baQAdbHB0BHSWUfhlWCFNsAh73vnytuUej4C9eL9vO
         X1xpZDS6oGH89jILSU6iivyLJP77cszZaXMEnJUtISL8IS6Nor3wsiF/nD+6hrsKVfSH
         1JJNdIX88H55+MDDoCNFHitNP1q5bUG0kWXLpg3PWz+7Mveip/e6lB4v7Dte/sC+C2Za
         3yq+PO2ylcAywaTBovPDMoOCwpIl5QkHJUkgVR027u5ytyzz/MY6Jfe0dxeffzMDBdIi
         U9nkBk7eDLTg2hJhgjEtpFlW2iR794dGK9F/hfSCe+5sWBuzy5TezLo48LpuzjesK0F3
         /I2Q==
X-Gm-Message-State: AJIora8gJur/ZlEpGrt481+Aqc1jlDIp/qERbpISx5aEGsXOeFFeUSAW
        h8B+/qsHnxJrbkjQSc35qw5cydNw6YQ=
X-Google-Smtp-Source: AGRyM1s9BIefYI6iaMJKxjr9C1O1VsBkBYBGzz/+lRuNDelfYkgHC3gF4Y7iXEnv6cYNOOnQjdhiNQ==
X-Received: by 2002:a17:90b:4c48:b0:1e6:9145:513 with SMTP id np8-20020a17090b4c4800b001e691450513mr19431226pjb.227.1655610231381;
        Sat, 18 Jun 2022 20:43:51 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-30.three.co.id. [180.214.233.30])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79251000000b0051b6091c452sm6276015pfp.70.2022.06.18.20.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 20:43:50 -0700 (PDT)
Message-ID: <10467596-9276-096f-c7c6-e0cd349eaa49@gmail.com>
Date:   Sun, 19 Jun 2022 10:43:47 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] Documentation: Add a blurb about using
 scripts/git-send-email.sh
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20220617183215.25917-1-mario.limonciello@amd.com>
 <20220617183215.25917-2-mario.limonciello@amd.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220617183215.25917-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/22 01:32, Mario Limonciello wrote:
>  You should always copy the appropriate subsystem maintainer(s) on any patch
> -to code that they maintain; look through the MAINTAINERS file and the
> +to code that they maintain. A helper script is available in
> +./scripts/git-send-email.sh that can be used with git-send-email to automatically
> +findd the appropriate recipients for a patch.
> +Alternatively you may look through the MAINTAINERS file manually and the
>  source code revision history to see who those maintainers are.  The
>  script scripts/get_maintainer.pl can be very useful at this step (pass paths to
>  your patches as arguments to scripts/get_maintainer.pl).  If you cannot find a

s/findd/find/

Otherwise looks OK.

-- 
An old man doll... just what I always wanted! - Clara
