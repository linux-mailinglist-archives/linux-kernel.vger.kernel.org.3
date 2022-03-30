Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEEF4EB9DF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbiC3FJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242783AbiC3FJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:09:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F5E109A74;
        Tue, 29 Mar 2022 22:07:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bx5so19542819pjb.3;
        Tue, 29 Mar 2022 22:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tWWVuDo0btT2/lfOVBqa8oH2n81md+EvVR8wHxl5xx4=;
        b=YuNG3uW4ShT4sdTce8FW9Pou99jKMiqr8ocFlc2GkuZysX9qw7gfg0PCS+Bu9pceyK
         c656XzzvcIa2uCkLRZHyggPgYD9j9dIgQ1mE2LJNq92eGGADXP82I9HnbEwyGnUIosRL
         FIh3tKBLbBwr8pUEArmWqCnwh1LO/03o+LBL5OFtAsWLrNvkrGH6lT8UhFtVY1ldTj0x
         wfsuGs6M541ZLGPJDIB40MMyeWZCdz/bpCtv/t2DOVxbrIoU3yk6GIjszrZfUAUhOaCy
         8OoqDrwsCqci8T4hFccUQU496UOlKU7hw0SwSU/MYFjFzgWeNddVM4oKInu3OBvb2SqF
         kfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tWWVuDo0btT2/lfOVBqa8oH2n81md+EvVR8wHxl5xx4=;
        b=xtIXqn2cwXpurYw6PVsBpkxTVajVf/F+h4BogOnqMUFMfibdsplroYJgHcsJkJn08K
         E1GGNyz8bXFiWAsZk06eHv3i+Zl1DewezsiEcNV2obGB82z2m8HR9rHHoY1SLANXT3gn
         GCMFvTYuYuKQe+qcy06+SrOFySYV2QNBUKUegqKkC868fAmcMleR975if2bH1cLZ8wR1
         4ze0bOD/IsOUZohyghk78Z4Q1uSvF34VdlztUyT7AgcqOKPmBH8x6JZHmKXHmZJ6Gt8z
         72Q06QtXlNW68+z+s0Hm7DmWQ8QtGmz9TaNABLIEFzaAaf6nsegaaDP2qivCp8y1m0vu
         Sazw==
X-Gm-Message-State: AOAM533IcetttkLMmVfISPKj7022oNj5CL09Q0vGmp6m6VVg9PmBcsZy
        i+0bC19oF1tcoGEDMXbiIno=
X-Google-Smtp-Source: ABdhPJyp9QWNhTgc5Twv6R+6yIXZ1rugcdXetn4aug9PJA/QV/6TBKRY3GmdKm7HdxmQIdDKRHnY1A==
X-Received: by 2002:a17:90b:250c:b0:1c9:8dbf:e730 with SMTP id ns12-20020a17090b250c00b001c98dbfe730mr3042455pjb.104.1648616859934;
        Tue, 29 Mar 2022 22:07:39 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-16.three.co.id. [180.214.232.16])
        by smtp.gmail.com with ESMTPSA id k137-20020a633d8f000000b0039800918b00sm13730948pga.77.2022.03.29.22.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 22:07:39 -0700 (PDT)
Message-ID: <476370b7-9325-21a3-2696-d74e326bf160@gmail.com>
Date:   Wed, 30 Mar 2022 12:07:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] docs: Add a document on how to fix a messy diffstat
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Akira Yokosawa <akiyks@gmail.com>
References: <87wngc6a7q.fsf@meer.lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87wngc6a7q.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 29/03/22 22.37, Jonathan Corbet wrote:
> +So what is to be done?  The best response when confronted with this
> +situation is to indeed to do a merge with the branch you intend your work
> +to be pulled into, but to do it privately, as if it were the source of
> +shame.  Create a new, throwaway branch and do the merge there::
> +
> +  ... vM --- vN-rc1 --- vN-rc2 --- vN-rc3 --- ... --- vN-rc7 --- vN
> +                |         |                                      |
> +                |         +-- c1 --- c2 --- ... --- cN           |
> +                |                   /               |            |
> +                +-- x1 --- x2 --- x3                +------------+-- TEMP
> +
> +The merge operation resolves all of the complications resulting from the
> +multiple beginning points, yielding a coherent result that contains only
> +the differences from the mainline branch.  Now it will be possible to
> +generate a diffstat with the desired information::
> +
> +  $ git diff -C --stat --summary linus..TEMP
> +
> +Save the output from this command, then simply delete the TEMP branch;
> +definitely do not expose it to the outside world.  Take the saved diffstat
> +output and edit it into the messy pull request, yielding a result that
> +shows what is really going on.  That request can then be sent upstream.

Looks OK.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
