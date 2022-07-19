Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E802D579427
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiGSH3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiGSH3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:29:34 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAA731361;
        Tue, 19 Jul 2022 00:29:33 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id y8so18419010eda.3;
        Tue, 19 Jul 2022 00:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A69jVjwpcXy4XlXaFIpNcd6h86BbCjk4wfR3cQladC4=;
        b=pPqXdGz8gqqAq3CJH7ip2apePZWuQ8zqpIqmAIAdw4FLiD863HyAEIk5JaQyA4zAcK
         fs2TqGAE0IfuExCwqBEULdFfuyEgkb+yiSZt80/n9sdzJIAjBXnu8NWQlvBK+LLqk6EP
         OVrQRRMMCaUZGWHt/o2PudcOo7d6O8CzfRolmHSy0eTdX5qA8h1yvUypWjqu8YnheA7n
         wo67encMML6iPPmKMiYlsix9EQI0Ahh1LdsTM1dB2Yhhblf+C8/bNi/gkAUuuMc1jtWt
         80vTkvML0XkpTxDChcqUHnlWDiEd/C6rvxy9KBsh63JJceu/zLO+LE0r2Fzx4sw5gDTe
         slnw==
X-Gm-Message-State: AJIora+gqF7Y6QIloByEfz4e5ECVRQ/9Y5N6USN4dFz1fYuzaGemJcCl
        /xCwbMN/wvOm2ck9uZFMl3mZUw8EpaE=
X-Google-Smtp-Source: AGRyM1uyKJbAeE1LL0/xy8QCy3leak7UxnARBgApJ/NJTOapGYNNOP4BnEZboZViwWEpfLK3PnlWag==
X-Received: by 2002:a05:6402:3454:b0:43a:86c8:637 with SMTP id l20-20020a056402345400b0043a86c80637mr42068430edc.393.1658215771535;
        Tue, 19 Jul 2022 00:29:31 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7c609000000b0043ab1ad0b6bsm9996135edq.37.2022.07.19.00.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 00:29:30 -0700 (PDT)
Message-ID: <292b1e65-6ac3-80c7-1ab6-c0e750fd03f4@kernel.org>
Date:   Tue, 19 Jul 2022 09:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] kbuild: lto: documentation fixes
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Martin Liska <mliska@suse.cz>, Andi Kleen <ak@linux.intel.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <20220716093249.19326-1-bagasdotme@gmail.com>
 <CAK7LNASvOjn+abQ1196+tpvVYnj9zkPPnuc4on02aQG_YhU_dw@mail.gmail.com>
 <51c4fbf0-bee9-4326-1ef0-bf2d25bde377@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <51c4fbf0-bee9-4326-1ef0-bf2d25bde377@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 07. 22, 9:17, Bagas Sanjaya wrote:
> On 7/18/22 08:49, Masahiro Yamada wrote:
>> On Sat, Jul 16, 2022 at 6:33 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>>
>>> Here is documentation fixes for kbuild LTO feature tree [1]. Two patches
>>> fixes warnings reported by kernel test robot, the others are formatting
>>> improvements.
>>
>>
>> Please do not submit patches unrelated to the mainline.
>>
>> This series applies to the individual repository of Jiri Slaby.
>>
> 
> Seems like you missed the wording on cover letter, which said:
> 
>> Here is documentation fixes for kbuild LTO feature tree [1]
> 
> with link to the target tree, which is another way to say "The
> series is applied on top of this tree, not the mainline".

Yeah, but why to send the patches to all those people provided they have 
no idea such a tree and changes exist at all?

Anyway, applied to my tree.

thanks,
-- 
js
