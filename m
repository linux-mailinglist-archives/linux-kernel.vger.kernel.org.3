Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BF8577C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiGRHRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiGRHRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:17:51 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2131A175B1;
        Mon, 18 Jul 2022 00:17:51 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b133so6073635pfb.6;
        Mon, 18 Jul 2022 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9frmMVgDv0d10SZjPmmu2rF/sm1oZ+hwPYLgP5s6HKA=;
        b=m0haaQNtPwxpeRdvM8Ie0tqOsa+wlZEaLfySiCVn3eAS9RXg9RbpgrSTAFwlXUN0p2
         /ar8csDR291Xgl/89K6Isie7MAW57dLXQI1Kay0z1BqOh3KFSLswgCw3cLhjgNo0fxtS
         tpetAal0/Nd9LoDMObvGLjpW32urAfjrjNegMFs4AHrpte9dmTrpdssLJKRQrgVKxhrn
         RR2px06dqufZhuWwkwrI543QFnXkBYgl8KLm072TChs+D09vqHK3UCjYyLUDzrHziPPm
         q/KGFnza+JEKT2JieHrmHbmdIhrvhCpMgOKktYrJYGFlTBh1R5RMwhq5Ne7RiukT+ccL
         sjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9frmMVgDv0d10SZjPmmu2rF/sm1oZ+hwPYLgP5s6HKA=;
        b=b+JLpfXDxR0oZm6qlA49k87j/pjYZ0l6jStWO13i+RGXg4hT835EDP7NpajARNT028
         lNf3JUsPvwUNE3RrnzS6kvGTMZZAnCwH83QhdlevNzVExfRD/dMXAfHMWRR4gkzz7qsg
         yz03TyaqmB59dYVAawXeNhMjbpObwGDhkc3UdDM/EJupyBweUtMQdm4ru4OMogdgskn+
         VoJOxCPeCe4popOMrfhNpvo8PdZ1jsz3gbIY2iLqS5EyHhQIuWqSBthibkua/mxCWxPs
         kJXTAAceCFxb8Z0Ndf5/I0k6ttIy/7qlvkTHkJo+p7wq2kY+mMuJpLc7Vn7sZN1ztZhN
         AfyA==
X-Gm-Message-State: AJIora8b8E2UqhejHa1FfQ6M14/AmeXG1J5Ju6mPJBIlaUl5elt6IbDw
        9P0xF2CfphEXXFJ7mWXTwRc=
X-Google-Smtp-Source: AGRyM1tK4g3Eh7up61gxd/53rQ0egdVwkMakI4qgTIx4877xco7wSjxk9Ftw95BNeNJjQAcsms7Lzg==
X-Received: by 2002:a63:6d5:0:b0:412:ac9d:814e with SMTP id 204-20020a6306d5000000b00412ac9d814emr24481342pgg.90.1658128670613;
        Mon, 18 Jul 2022 00:17:50 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-18.three.co.id. [180.214.233.18])
        by smtp.gmail.com with ESMTPSA id g26-20020aa796ba000000b0052ab5a740aesm8398857pfk.162.2022.07.18.00.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 00:17:50 -0700 (PDT)
Message-ID: <51c4fbf0-bee9-4326-1ef0-bf2d25bde377@gmail.com>
Date:   Mon, 18 Jul 2022 14:17:44 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] kbuild: lto: documentation fixes
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Martin Liska <mliska@suse.cz>, Andi Kleen <ak@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <20220716093249.19326-1-bagasdotme@gmail.com>
 <CAK7LNASvOjn+abQ1196+tpvVYnj9zkPPnuc4on02aQG_YhU_dw@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAK7LNASvOjn+abQ1196+tpvVYnj9zkPPnuc4on02aQG_YhU_dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/22 08:49, Masahiro Yamada wrote:
> On Sat, Jul 16, 2022 at 6:33 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> Here is documentation fixes for kbuild LTO feature tree [1]. Two patches
>> fixes warnings reported by kernel test robot, the others are formatting
>> improvements.
> 
> 
> Please do not submit patches unrelated to the mainline.
> 
> This series applies to the individual repository of Jiri Slaby.
> 

Seems like you missed the wording on cover letter, which said:

> Here is documentation fixes for kbuild LTO feature tree [1]

with link to the target tree, which is another way to say "The
series is applied on top of this tree, not the mainline".

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
