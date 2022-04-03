Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427904F0B4A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359461AbiDCQpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239665AbiDCQp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:45:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1FB3885
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:43:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n6so1353588ejc.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dfM9iFVEMlQhnqd2qRR4eBc2QvDGokUysbFV1hlfGcE=;
        b=BXa3LtkpNMBGbMAHpD5eKBfHr6zCd3rMKm5CGEfwjl6XPVdMekbtjGmoM/z2KFNWwU
         X6kHZBbg+gkpQjuXhncMf05tFL2Zht8pfNc1PAwH3NAzR44liezgut1pTsPfEhCrBSKU
         oFkoe3bpwwXebOXb15aB+IsEM5YVvnCMl0r7ql6v9scYIuW1zJfHXS7eODDXnjOWqB4w
         duVp2z6MvIBmr7cvGsGKDQib5qGpXEqCVa5HpTzNL4XzT/9Dd0TP+PWWex3WDDhqhJak
         yNXi8CMgkpf6ut3HSjQGgppv5yrf7Gvb2hLXelsEwMeoxZeEdPBFFKkLtlPAIbTzmzSw
         eOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dfM9iFVEMlQhnqd2qRR4eBc2QvDGokUysbFV1hlfGcE=;
        b=EcwfQ6vzqv/EMpUgmNMf8ulddpNfvHJWe2jLFJ5/l5xtryxwLvK3s48jMBK4ksnYKG
         IljFoA5dox4LN8ltQcRL5tCEnFHLlftmNsjIJJ/+fwudP1sLM64s37lL97uFwO5zW8Cb
         xr8cTbq8ufnyBMwhYbyJO+xDuz1djXt03PybwFWIzpdVp08pUYsCRCcu89+UT3XjHBeM
         fcKlxueWz/9zNnYb2TsolC15J8HmIlkEIxQ+9nIO4Rqoe6jYPOQFp0Zy8c8Zy+m7iDAj
         9iZilerJCy090VjRoDXOiA9IX2jd0dDkkKY8kO5iU0irPb609tgYSu8xDZ1Z9oDZuXPz
         i5Rw==
X-Gm-Message-State: AOAM533QJ5hDbT2LkcTGHnAdzRnG1yKaFVw9UU0jn32XWNR2JPwT8Jv1
        3Yl9cpDJ/r3ExK0xMRCOqFQ=
X-Google-Smtp-Source: ABdhPJyA5QVq7pKuGoqcuQoJWMTsO14n1ezBhA8QzyDvWkYZhpDpEKvagmoiwKECNaUofAQaHOfVUg==
X-Received: by 2002:a17:907:6e08:b0:6e7:f074:e41d with SMTP id sd8-20020a1709076e0800b006e7f074e41dmr1078741ejc.164.1649004208173;
        Sun, 03 Apr 2022 09:43:28 -0700 (PDT)
Received: from [192.168.0.151] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709060cc200b006d3d91e88c7sm3384228ejh.214.2022.04.03.09.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 09:43:27 -0700 (PDT)
Message-ID: <3e1dfdde-d9f3-9e16-82a6-7b5497981bdd@gmail.com>
Date:   Sun, 3 Apr 2022 18:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: r8188eu: simplify control flow
Content-Language: en-US
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <20220403155111.GA333187@euclid>
 <ed0e9f7b-9ba9-b0c8-8261-397bf793b9b9@gmail.com>
 <CAMWRUK6K77KpRkCkruL=RQcmA1opbvapyPJOA-EFpYdXxY8ujQ@mail.gmail.com>
 <4ccc9ac3-c542-cd32-0cbb-7cdabbf0dbf9@gmail.com>
 <CAMWRUK7g7BqUL1NziBfbc6Epx7G8Xos47sKAtcimDZYmG-hVgA@mail.gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <CAMWRUK7g7BqUL1NziBfbc6Epx7G8Xos47sKAtcimDZYmG-hVgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/22 18:29, Sevinj Aghayeva wrote:
> Ah, I see. You run it on an email file that contains the patch. I
> could reproduce what you saw when I ran checkpatch without any options
> on an email file. But my usual workflow is to modify a file, e.g.
> rtw_mlme.c and then run "checkpatch.pl -f rtw_mlme.c", in which case I
> cannot see the "Alignment should match" error. So it looks like if you
> do not specify -f then checkpatch.pl enables --strict option.
> 

Hi Sevinj,

I'm also not a checkpatch expert, but on my system this works without
--strict too. I applied your patch to my local tree and get:

/scripts/checkpatch.pl -f drivers/staging/r8188eu/core/rtw_mlme.c

[snip]

CHECK: Alignment should match open parenthesis
#1638: FILE: drivers/staging/r8188eu/core/rtw_mlme.c:1638:
+               if ((p->PMKIDList[i].bUsed) &&
+                               (!memcmp(p->PMKIDList[i].Bssid, bssid, 
ETH_ALEN)))

[snip]

You can also run checkpatch on the patch files (without -f).
Then it's easier to see if you introduced new issues.

regards,
Michael
