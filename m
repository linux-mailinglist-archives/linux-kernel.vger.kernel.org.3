Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23142598664
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245416AbiHROtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbiHROtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:49:47 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9556875CD0;
        Thu, 18 Aug 2022 07:49:46 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 24so1467440pgr.7;
        Thu, 18 Aug 2022 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wPb3XQDUpxdE9gEclp2HbSBEcH0O3377//QUXGa74XM=;
        b=TiRrv65fnbBroKxmHZtJIagfFET8v1QzaLF7p8X/LrqVe+hqiGBKBDcEi+IFy0utjw
         R1DXZ5jIAEcsunP49HpG/KDSM6eRdgVYIzoH1p0Eu47b+/2+ejR3msqX18wSpEsUFZkO
         sJRvVth9RrzcL5Ms6bAZV/gxYmAFEHBSpwvb+B4D5rWTG1l5Y7NshlTZ4zTeIACBDL3u
         zW34tI7IqJ0TyZzH7dsmb5WDTaK/CS37lXYlMWLBnvma8lAUb35SoktfbVNkJU0dNlnF
         y9gLbJZrPOUdDbYsWIxUqC3cirtV7bn41ejwy2fTDsqQqpfFXQBdPeZ/jGK/FYqtnQoQ
         cbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wPb3XQDUpxdE9gEclp2HbSBEcH0O3377//QUXGa74XM=;
        b=DUP8ev8wOiVRp7IcpuyMTqdwBesmyVCmHdzETitc7NManfPUjuk00T40nUDC54XGFj
         618qe7Krxm2yNunaCEj4KCsGJKAE9PwkCYpB+n5cquapJ4ZPwhzLofQ57j7Qcb03jKIf
         uqj9ScIZ47Fwr3PadHEXJ3onUdlaOztDryeBN7q5KqbQQNPZYglhrHHPiCIpud+VZn0/
         +IVLG+wCjSkQxCE85Jk6kMmVRcK50qXDPhkhwdVohFTqmMC+tn6nogU39j6rFW0WM6nR
         fk1EcFOgb5djm9Tna8/9JI/mVTOj++GFoXrzETAUQIrEwPh83ZkLO+mzmvAojhlCzcQG
         s+xA==
X-Gm-Message-State: ACgBeo0Jwqy8QuqQLhUrCim/YmwmwBt5rslfgZYu8MCcd70TqR7rbNbq
        KsvqLDBIjBrPj4BO980PwG+Gkm777jQ=
X-Google-Smtp-Source: AA6agR7TN1titVzwyCuzCLVy6hIYX8uKZ8hzg3AUeDjIk7KQcf/eiT+NQngvIbsYpKWevsObbPhJ+w==
X-Received: by 2002:aa7:8f0a:0:b0:52d:8135:64e0 with SMTP id x10-20020aa78f0a000000b0052d813564e0mr3340259pfr.0.1660834185859;
        Thu, 18 Aug 2022 07:49:45 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090a5a0900b001f3e643ebbfsm3721196pjd.0.2022.08.18.07.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 07:49:44 -0700 (PDT)
Message-ID: <63d7a132-1d6d-b771-27d7-e0049f51b445@gmail.com>
Date:   Thu, 18 Aug 2022 23:49:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/13] docs: ja_JP: remove SubmittingPatches
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        corbet@lwn.net
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <cover.1660829433.git.mchehab@kernel.org>
 <2902bc232970588d4ca59b5df0afbabb0c345d6f.1660829433.git.mchehab@kernel.org>
 <9d80455f-60aa-58b6-777d-ce1a03ed280a@gmail.com>
In-Reply-To: <9d80455f-60aa-58b6-777d-ce1a03ed280a@gmail.com>
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

On Thu, 18 Aug 2022 23:27:34 +0900, Akira Yokosawa wrote:
> Hi Mauro,
> 
> On Thu, 18 Aug 2022 15:38:49 +0200, Mauro Carvalho Chehab wrote:
>> This file is outdated as the original document was removed. So, drop
>> it too.
>>
>> Fixes: 9db370de2780 ("docs: process: remove outdated submitting-drivers.rst")
>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> 
> Yes, this is quite outdated, but a change set was merged recently during
> the v5.19 merge window [1, 2].
Uhm, it looks like you confused SubmittingPatches with submitting-drivers.rst
and are trying to remove SubmittingPatches, which should be kept...

Anyway, please don't remove it!

> 
> Please keep it and the other outdated files under ja_JP/ so that I
> can continue updating them!

I'll submit a patch removing a ref to submitting-drivers.rst in it.
I didn't notice the dangling reference as the doc is still in plain-text.

        Thanks, Akira

> 
> [1]: e29b3abcb2b6 ("docs/ja_JP/SubmittingPatches: Request summaries for commit references")
> [2]: https://lore.kernel.org/linux-doc/20220503102429.48304-1-akiyks@gmail.com/
> 
>         Thanks, Akira
> 
>> ---
[...]

