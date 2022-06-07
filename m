Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AA753FF05
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243561AbiFGMjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiFGMjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:39:40 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E1B1E0;
        Tue,  7 Jun 2022 05:39:36 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e656032735so23039955fac.0;
        Tue, 07 Jun 2022 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HiYTeaH2Ytvy9J3xHvGT5KfgL81gOulpVWevU/JIGjQ=;
        b=Pa+E2AI+vhzby88jLf87j+HCaBZNNBmAxlyecZ1p+WVUqS/UlmKhq0yL6alWbBO6P3
         SuLQP30pwhVd2MzPhZRtiS0A5i01/zQOgUqza4LvIGv1ouf1YnWjL0V7Zkyw+cDSyh3E
         NEBT9iEUH058arGgfX67qm5pTiLIL79GTpV+qxWko3VtrgYblbdtpriu1/0SDu6x3LPG
         l5fCXojmDNm6B1EFK9SXBLrKV/6/e0zXGlvjtqeOlxJgvAVhCMJIhYX2TUKhxsO1uIvr
         YXCnDa2iBcFb1MdLIdbVwV3N+NO9qdrHvNgW9WSCSHEuDVbAjUwj/OXXlxNVXF5JnYPI
         aW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HiYTeaH2Ytvy9J3xHvGT5KfgL81gOulpVWevU/JIGjQ=;
        b=ba0BZaX9fgAltmnSe6D3hTKPo/gHgfN/Ai6HyWOmRDCgSxunbQWkVbwOA6BHVhSlWi
         KCSjd6I3fwwCXF5ZqqcWfgCgXLlpJ9HtQ9jaRMqANfAWVF17Zw48sNTbd3ZqG0Yw/UeO
         F172nnich6DuWY0folvYecD5AzHQflsWoFhy7j9yDyMsl4MVYtLVZITKQ5UCHZoEvQta
         u+FapaVP70BRQo+aHvfmgK3cbJEzE2oyTP6O5UI2T4u5MSgPIeFOUwzJUQEim9/SSxep
         +2+aNEMllNRr9W5Sxu/07nH9qVxuFFkmsd0NoZrI1YpMJRqxN5NdffOUNAamDBitkcG0
         gSkw==
X-Gm-Message-State: AOAM530S6EHu/tfu8TtJG/iyGPR4HwPFOyrXnUoP/PYUj5uX2vOJZSEU
        HpRv5PRmXgimbPKfi0+UtR4=
X-Google-Smtp-Source: ABdhPJyDzD0MEf/liZAcbSAJnd3NBluQuapP26Cwm4kXdWHdOYC1Dn5nWZetS+yLUXOjPVYFqZrilg==
X-Received: by 2002:a05:6870:6005:b0:e6:515c:da5a with SMTP id t5-20020a056870600500b000e6515cda5amr16559042oaa.183.1654605576010;
        Tue, 07 Jun 2022 05:39:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v10-20020a056870424a00b000f317901b29sm8273081oac.4.2022.06.07.05.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 05:39:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a015840d-1457-f874-c7a5-b7c91e639fd6@roeck-us.net>
Date:   Tue, 7 Jun 2022 05:39:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: linux-next: build warnings after merge of the hwmon-staging tree
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <20220607142301.3eb8a53c@canb.auug.org.au>
 <Yp8bz4Yo45Bq4VfR@debian.me>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Yp8bz4Yo45Bq4VfR@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 02:35, Bagas Sanjaya wrote:
> On Tue, Jun 07, 2022 at 02:23:01PM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the hwmon-staging tree, today's linux-next build (htmldocs)
>> produced these warnings:
>>
>> Documentation/hwmon/lm90.rst:493: WARNING: Bullet list ends without a blank line; unexpected unindent.
>> Documentation/hwmon/lm90.rst:494: WARNING: Bullet list ends without a blank line; unexpected unindent.
>>
>> Introduced by commit
>>
>>    7dd47c2603aa ("hwmon: (lm90) Support MAX1617 and LM84")
>>
> 
> Hi Stephen,
> 
> These warnings above doesn't appear when doing htmldocs build using
> Sphinx installed from pip on my system.
> 

That is possibly because I already fixed it up (in one place a '-'
instead of '*' had slipped in).

Guenter
