Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598AD599D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349483AbiHSNvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349484AbiHSNvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:51:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B797FF8C6;
        Fri, 19 Aug 2022 06:51:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pm17so4671381pjb.3;
        Fri, 19 Aug 2022 06:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=pM8ZJI/a5osYIF/nQOcgseoNb81Y3Rd7dvH59J/Ahok=;
        b=oKldQBtonVmXYKT6Gffc1b8O1gvRh/MV148KWXuIGHLDyDUM2UrPtyuY7gkp5Uv794
         ESPzhNQw73D41On23DCyO6UWCzrL6LhWcWRj6PYVc9ztXQlWJkIqoLeEn7z79XqE5yd+
         UFM/1jfGNnIvW/zZ6D5QUnw2qqiYTAOBivfW4o6uyHY/YI6otWN9Eovcl7BDU25aTNsX
         ErEThCKm6SwhoH8/zhouYV66B2STCJbTRfOirwcMela9ifmucje2r6nu9VO6U3svrEN0
         sujf/kHgTUKaWJ/xbEqDHnSFnXglEkNYp8x+dpmP53Irh2YkDwk6EqvujvoM0YjeDdMv
         Wx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=pM8ZJI/a5osYIF/nQOcgseoNb81Y3Rd7dvH59J/Ahok=;
        b=lINeyqYQYgRevrAabgCgrM5dAUmeUiAz5/kv1e2CdKioB+gZmyuIxRPrUuLAxUIiL8
         jF3bbpxB3xpCh2VjqVNvaGaorijZSWOeZjUlKdzvxBQc4xKRygwoDJLXlWEg3dimmucp
         5IEOFy41GoFsNLiFB0m+e4tzsP9X+mU9+bSLWOrNcBBSRri1Ac8Hju5XlBWlACfGm++l
         99rv/D3R6GFJ2YtnKYFbrW9bXLk5SxY6IGE+ttBj/NIQ3GfIQ2uVqGgzQpnMseme3uFG
         NiL3wRtrM4XAw8oxxGI9uDIiuDOBjtkxKZKOuQr9qeSto5WmXmf6f3Vj6JkxoMvdZ+Ur
         OtnQ==
X-Gm-Message-State: ACgBeo0Fo4IWVtJ0klr1ilDMOztbHLfLASJRwyaZN3EEIkcWw8COuW7p
        pt29Yxk6o3oGfbXjSVP8E3tZFv1ZZdE=
X-Google-Smtp-Source: AA6agR6b9lkAJjwOHlokgElwsTzTkcC7O00u4ZF4TtO+t/FU/SN/FPK/ym2DWn3jfci65xmuPJprGg==
X-Received: by 2002:a17:902:da92:b0:16e:f4a4:9f93 with SMTP id j18-20020a170902da9200b0016ef4a49f93mr7408622plx.27.1660917065043;
        Fri, 19 Aug 2022 06:51:05 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b001641b2d61d4sm3239153pla.30.2022.08.19.06.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 06:51:04 -0700 (PDT)
Message-ID: <ac908c75-4046-df64-efeb-d3e3dea4da74@gmail.com>
Date:   Fri, 19 Aug 2022 22:50:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] docs/conf.py: Treat mathjax as fallback math
 renderer
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <c41cab17-afd6-bc99-56a1-e4e73b8c1ef6@gmail.com>
 <a45f1aec-a2cb-0ef2-7100-378a5130c492@gmail.com>
 <87wnb5bh67.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87wnb5bh67.fsf@meer.lwn.net>
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

On Thu, 18 Aug 2022 11:22:24 -0600, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> Currently, math expressions using the "math::" directive or
>> the ":math:" role of Sphinx need the imgmath extension for proper
>> rendering in html and epub builds.
>> imgmath requires dvipng (and latex).
>> Otherwise, "make htmldocs" will complain of missing commands.
>>
>> As a matter of fact, the mathjax extension is loaded by default since
>> Sphinx v1.8 and it is good enough for html docs without any dependency
>> on texlive packages.
>>
>> Stop loading the imgmath extension for html docs unless requirements
>> for imgmath are met.
>>
>> For epub docs, keep the same behavior of always loading imgmath.
>>
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>> Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>> ---
>> Changes sinve v1:
>>  - Acked-by from Mauro
>>
>> --
>>  Documentation/conf.py | 34 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/conf.py b/Documentation/conf.py
>> index 934727e23e0e..3ec1f845c839 100644
>> --- a/Documentation/conf.py
>> +++ b/Documentation/conf.py
>> @@ -15,6 +15,23 @@
>>  import sys
>>  import os
>>  import sphinx
>> +from subprocess import check_output
>> +
>> +# helper
>> +# ------
>> +
>> +def have_command(cmd, ver_opt, str_in_ver):
>> +    """Run ```cmd`` with ``ver_opt`` and see if ``str_in_ver`` is found
>> +    or not.
>> +    """
>> +
>> +    try:
>> +        ver_str = check_output([cmd, ver_opt]).decode('utf-8', 'ignore')
>> +        have_cmd = str_in_ver in ver_str
>> +    except:
>> +        have_cmd = False
>> +
>> +    return have_cmd
> 
> So this is adding infrastructure that isn't really mentioned in the
> changelog.
Sorry for missing it.

> 
> A more fundamental comment, though, is that I have learned (the hard
> way, repeatedly) that good things do not come from bare "except"
> statements.  They always hide bugs.  If there is an exception you're
> worried about here, please list it explicitly.
I see.  Thank you for the insightful tip.

I'm more inclined to use the simpler approach of the "which()" function
defined in sphinx/kfigure.py, which is free of try-except constructs.

Will respin this along with the fix of 2/3 in a couple of days.

        Thanks, Akira

> 
> Otherwise seems good.
> 
> Thanks,
> 
> jon
