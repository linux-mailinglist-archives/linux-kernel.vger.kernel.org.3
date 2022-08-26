Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0985A22FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbiHZI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbiHZI2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:28:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3177D4F6E;
        Fri, 26 Aug 2022 01:28:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l3so989800plb.10;
        Fri, 26 Aug 2022 01:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Je++pFVH6dftxScgLrKrV4cRe0HZ+N3IBONYauMAvUs=;
        b=ktjrg/RO9dx6yW6/C5oYkFoptGIcUR2CniW0Do519mDjqM6uVfaw3UAe314iHZHdHs
         o74OuXcU8KIpFTiyWfHTn3vnpn7/MWpWFuJ5N4U9AarVHPjUTUbaEd//om9w4c6fC2mF
         oKZ2lpdP/oznREk7+TAOaDOA0DBbq0k/NUzJ3n0BmxJN8oOaOdn/thzW3GQEJMmLYSTg
         208tHVXF3vuOQPbZSVVbxn0z7xa5IDshFPpfwR4SOlQ74ie+4ArmzFJ8fy+phJqkGzl+
         A1NdVTR88U77mxT6ZJf/7B1TcTUd1lsw1i9Dv8xPnJw+a49o/B5MucrYpRRMMsuRT33S
         hfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Je++pFVH6dftxScgLrKrV4cRe0HZ+N3IBONYauMAvUs=;
        b=trgyaQrL67Oxpt0tbYqXpXJt02eSLC2V7yOsTTYddZ6lS7lfNqBadNi0XwBZ6AhIQn
         fI8fjHTcreAQcmq5SuWYOp25ioHu046M2JMMJjEj/gtgYuRN7X/Whue2qLeSG9akMo4h
         W57urBOWAscC6mCIfJ94BGXY+PgGaPIKtjvcWP3BAyYv4DGvTs6eNnOHF0vxHMqpmV2P
         cchm3+Gh46N3s6ry3oozZ1GJx9m1o7Q0SGFPlGV1Ow8AU3jWqOZFz5fe3vivm0ztG/fG
         Af1MhZMds0TNAT/R4S2SDvarWiQQ9OkNMkveIJQ/FWXWS+dbBtrc5UBqcGOUvrkAEiZo
         SPvA==
X-Gm-Message-State: ACgBeo3ZCVLcHMCe6OSvFAKYmVw/OJsk4SdvZy6YMRm1GalyaZX6ZGf1
        rniMuZBlcQgl1w6XdaCDrtY=
X-Google-Smtp-Source: AA6agR4YNuOgJ3oOW+shMMHi+GypTijgT6PKZiCxj/6AYkxt8JzVJfblRjSVJ98g1/R3zT0npkyBiQ==
X-Received: by 2002:a17:902:f787:b0:172:f321:2fd1 with SMTP id q7-20020a170902f78700b00172f3212fd1mr2748367pln.121.1661502491395;
        Fri, 26 Aug 2022 01:28:11 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-73.three.co.id. [223.255.225.73])
        by smtp.gmail.com with ESMTPSA id o5-20020a634e45000000b004161e62a3a5sm887364pgl.78.2022.08.26.01.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 01:28:10 -0700 (PDT)
Message-ID: <6b6e0271-2d39-bf73-8e34-31c120d4c674@gmail.com>
Date:   Fri, 26 Aug 2022 15:28:07 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] docs: Update version number from 5.x to 6.x in README.rst
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220824080836.23087-1-lukas.bulwahn@gmail.com>
 <87a67syxa0.fsf@meer.lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87a67syxa0.fsf@meer.lwn.net>
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

On 8/26/22 01:48, Jonathan Corbet wrote:
>  - applying-patches.rst should just go.  I didn't prevail last time I
>    tried to make that point, but I still don't think that we help
>    anybody by dragging 1990's instructions around now.
> 

Hi jon,

Beside what I say earlier at [1], I also think that we need to have
documentation on how to use git to obtain kernel tree and how to
update the tree, with pointers to external resources for advance
topics on git.

[1]: https://lore.kernel.org/linux-doc/YwgtoiKl5Azt7Pre@debian.me/

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
