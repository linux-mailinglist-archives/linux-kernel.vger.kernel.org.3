Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1391F4EB7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 03:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbiC3Bpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 21:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbiC3Bpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 21:45:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4096476;
        Tue, 29 Mar 2022 18:43:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y10so14138224pfa.7;
        Tue, 29 Mar 2022 18:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JqKr/dTx137KLola/7A49s2uL7z/Ma6HdQ5kniz2p5o=;
        b=mnv7549VlSPsTZw/dOJDZ+WAhRuKqUG1B4gyLxpABZoIGSwSG16xhrdjRf4Gu/CUy1
         S1N2rLPbhDAIjVThGQkRksw6burBh6rd8h6PIfUMTx7Rk6i547bqcgEW9AwGiPi5zxYs
         joeieRV6G+g9EJ842B9Xw4ST5fR4CSWjMVtBFACRFuqRstnFYNqCXUUgV+sk4n9B47Yn
         5uc2xoQwYT9SjJXgyfX22nDZ0GyGHyq7yRm5NR4gVG2O1VqyDJH9wm34mOkjs+gzrUxv
         2xGMMGS+5Dmuqdkn+R071AH4Yu3WElPxVMSj70gMLN2WmjD2+z68tr13LuAM0jazNilP
         dFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JqKr/dTx137KLola/7A49s2uL7z/Ma6HdQ5kniz2p5o=;
        b=YN0xP2B9mGovi6qMtGIfW72D7+iuYW06CB2y4MCxEy4pP0mEEEQm5FgtzHCkKiJunA
         jf8r2fOUcKHcZqT2oc5NKI9hAnFT1+B3LdJ3e4ZDnB+0g4p39dhoccfDv6mzFXJsXv2+
         Z+2Up5KymjWW5Q3nIVN8uP8XeBY+WoMrnN/tCWi8U+pC6Yx9IeNLWisyj4+S8Vui+h4W
         QFB2yfw8Po7atCkC6boWrTRkBau4MgYHauJgXM72qP/exMyK2NZW1CC7wlIuUVUSVk6z
         NWGV+aD/I5szOk6Szp1IxplpYYXwjvl05BWVEVGjtTKYwIzUu9zSkqp7qFtGQv4dJIAr
         7ouw==
X-Gm-Message-State: AOAM532N4ybi13RuUWBfT/bRAxw+Cac87AHapT4sgmastTfUM6xH0pCL
        0ZdC2JBQRBCVn2Imo/lWTAg=
X-Google-Smtp-Source: ABdhPJyhpoi2BBuNQZTHzfRUkXVsw90dHi5ViQxmTuNrtB3H3xqi9Ey0XLJQFn7NIrYSFeuVOUEqKA==
X-Received: by 2002:a63:c10e:0:b0:381:6a51:6231 with SMTP id w14-20020a63c10e000000b003816a516231mr4133872pgf.189.1648604637911;
        Tue, 29 Mar 2022 18:43:57 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id g3-20020a056a001a0300b004fa65cbbf4esm21542294pfv.63.2022.03.29.18.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 18:43:57 -0700 (PDT)
Message-ID: <a619a0da-bd86-e57d-789d-51ee85125be5@gmail.com>
Date:   Wed, 30 Mar 2022 10:43:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] docs: Add a document on how to fix a messy diffstat
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <87wngc6a7q.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87wngc6a7q.fsf@meer.lwn.net>
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

On Tue, 29 Mar 2022 09:37:45 -0600,
Jonathan Corbet wrote:
> A branch with merges in will sometimes create a diffstat containing a lot
> of unrelated work at "git request-pull" time.  Create a document based on
> Linus's advice (found in the links below) and add it to the maintainer
> manual in the hope of saving some wear on Linus's keyboard going forward.
> 
> Link: https://lore.kernel.org/lkml/CAHk-=wg3wXH2JNxkQi+eLZkpuxqV+wPiHhw_Jf7ViH33Sw7PHA@mail.gmail.com/
> Link: https://lore.kernel.org/lkml/CAHk-=wgXbSa8yq8Dht8at+gxb_idnJ7X5qWZQWRBN4_CUPr=eQ@mail.gmail.com/
> Acked-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
> v2: Various tweaks suggested by Borislav, Bagas, and Akira

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira
> 
>  Documentation/maintainer/index.rst          |  1 +
>  Documentation/maintainer/messy-diffstat.rst | 96 +++++++++++++++++++++
>  2 files changed, 97 insertions(+)
>  create mode 100644 Documentation/maintainer/messy-diffstat.rst
> 

[...]
