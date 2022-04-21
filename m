Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2B15099B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiDUHxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386290AbiDUHxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:53:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38614E0AE;
        Thu, 21 Apr 2022 00:50:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id md4so4219362pjb.4;
        Thu, 21 Apr 2022 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oicvIY0y5wccZhVe6ivP5Xo5+MG/BvSEb+nQiz7dyjQ=;
        b=V1Xglz2oLjrxpQkc5GBIiz3GzvJqg4IKyNDPTkuaNdo4ZTsHidcRaaXp8v6ztS2vFU
         dSwb+J/F2qw0xowspA0tDT3ckvYlt7X3LUJLAygGypOAgcHsClWlcELVg35ampaeDLe7
         QBmXh0Mg72WN948teJpSUp8xRL2vLrujoQcXPIjSMVx7iFmgJuss3pL3Szc6klaE6C1N
         uxvshLcSU78Lhtd9JFOt9D19h9mn0HS3AyPat1jTPOIy3EVf1gpE0O9jmeHj8BpGXwKr
         HrqOV42rLg7Zd0a05S2/z1ztPvnuIoNx0OFT8sud0d2vLiCN1rZS5skYqa/RhlJRqatY
         aOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oicvIY0y5wccZhVe6ivP5Xo5+MG/BvSEb+nQiz7dyjQ=;
        b=QSMc/3qOuwgQqzcOtUHgZu1x2xd5WH93oxsho2YnXWzJUFvkqMps/9LuEQjlAHt6Nu
         rCMdRTdn2UekfJa8zF1IGW3cH+pw02gzwLk0O77LQwROQeDcc2+khf4C0iJl1t9oCbAB
         RreL4/Hwbhv9GRTe4mMmy4H4bHYHAPakDte92rb/0JU1C2onw+2X+qtWFShrJVt1TbT2
         lvwm6GLkLu83Av1FA/6MVeW6IBvw9H4trowVvNLvHlNBoZKBtjd7JCuEoBjAIYrW31hT
         NxdBHoMwEHIT6TQDCVPP6PXalqBk3Hjw5vV5rON5dc7Wt4N+qkIY/oumvPKrxZljUwqF
         LuVQ==
X-Gm-Message-State: AOAM530pe6S9U116DtHLGLCwhKYuw2SFxTCiYQ+WQK6106znmEC8rDFW
        fmZ66To6v7nuVYQg4ibj9Hw=
X-Google-Smtp-Source: ABdhPJwPwrHN/kgtMeCVvBZbTGWh+qmRSFtqroD5tz6rMKKos9VyqUt8UyA/ufcoacKmw/+uSOTJww==
X-Received: by 2002:a17:902:b193:b0:158:c040:5cf8 with SMTP id s19-20020a170902b19300b00158c0405cf8mr24676272plr.146.1650527429609;
        Thu, 21 Apr 2022 00:50:29 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-15.three.co.id. [180.214.233.15])
        by smtp.gmail.com with ESMTPSA id o5-20020a62f905000000b0050b5b5efa47sm799738pfh.191.2022.04.21.00.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 00:50:28 -0700 (PDT)
Message-ID: <2f4c72d2-4669-4217-f322-9d4f34c3053e@gmail.com>
Date:   Thu, 21 Apr 2022 14:50:24 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 0/2] Docs: Update information at changes.rst
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
References: <cover.1650376049.git.codeagain@codeagain.dev>
 <8735i83xo1.fsf@meer.lwn.net> <20220420172731.ru7kfrdkmprybtu7@AN5Bruno>
 <878rrz30d9.fsf@meer.lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <878rrz30d9.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 04:34, Jonathan Corbet wrote:
>> Thanks, Jon! I have also been thinking whether this filename
>> ('changes.rst') is a good description of the file contents. Do you think
>> renaming it to something like 'requirements.rst' and updating its
>> references would be a good patch?
> 
> It's best not to rename things unnecessarily, especially relatively
> well-known files that a lot of people expect to find in a specific
> place.  We've done a lot of renaming over the last few years, but this
> is one I might let slide for now.
> 

Did you mean the rename will be benefical?

-- 
An old man doll... just what I always wanted! - Clara
