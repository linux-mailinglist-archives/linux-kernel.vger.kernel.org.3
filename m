Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5654E590021
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiHKPh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbiHKPhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:37:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218C998C89;
        Thu, 11 Aug 2022 08:33:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k14so14758531pfh.0;
        Thu, 11 Aug 2022 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=D5544vZ07mIqyQsDs/pSqvQEd46ChIGfK2jqr/vjGyo=;
        b=PTTvFW1c/jfRRPrPg8lAVIXAHA+WoiWJfDTFUi0yZSu8A9DEkefCAhalQq58DrD8Aj
         fSapjqPizOhPE/JNVGLYFDAHInEyJiyFxzsrNfxryoAgBUM+vdaWkJgxEd1I7NYHal67
         BFljc4NfZ0WwaVbR0JTr19Y/gIGROzjTDjUBLeAuIQ45bHtRQYGSwGAa5B5XrU4d0HTl
         bFTDFjrC+DeARMbPcgzizp8Bxj6VYHtRxAF+EdnsyrRGtRbtp0B7NhzXD4ktNZTt2XxC
         U/HJIw75I04Vu3JdpqDw8v2Lznuyaq+VsT8Lw/xXqDdTk5pJqlTuspIwj2wkul4O3Plu
         oW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=D5544vZ07mIqyQsDs/pSqvQEd46ChIGfK2jqr/vjGyo=;
        b=L6jpA5ffExN7OqW1yTg/s4FIcETSPyMFFlJ6oKJk8oeips2eks8v+QfzQONXSQwgp+
         NICEHUrPRfxnEzyQKjQEZkM973F5O7ofGdV4PworNvKDZq83rB28M7muT1sGNWTXHhCd
         F54mBPCM/JydDkdXwsoS03JUI2H8mOjy0sj1I6+pnFA4E2VmfxfVaxGejqOdVs4I7ywK
         veEc2qX+tVX3KIF1kiluLF/8cKFHq64xCFRWQ+JkAzi9unn7nqLTHcy5BhWxv9c7fK9S
         ah0DyNSQ8dN2aziSmj6CWpx8CZ30Q/dZ2eeDCIoUxae1Jn8ndO7ps4/aeuJBi6/pHUq/
         hKIg==
X-Gm-Message-State: ACgBeo08sOWOO9lziPHdSghLuIUHO8KzJ9+eZb+b1aeWTUqLUF9aLIIE
        55MrAcvrviKUqkp52qtonsCNbGA/7WU=
X-Google-Smtp-Source: AA6agR62JO81eGNTr1q8JYPEtLQ8DfJcKJ93BUFoMJc81F90nes5XxbTO94TSt6cB3IebLdQfvyO9A==
X-Received: by 2002:a05:6a00:841:b0:52f:1cfe:ebd7 with SMTP id q1-20020a056a00084100b0052f1cfeebd7mr21473038pfk.47.1660232018489;
        Thu, 11 Aug 2022 08:33:38 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id f23-20020aa79697000000b0052d4487ae7fsm4183174pfk.27.2022.08.11.08.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 08:33:37 -0700 (PDT)
Message-ID: <278e0041-a2df-d067-59eb-87b8ac178567@gmail.com>
Date:   Fri, 12 Aug 2022 00:33:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] docs: kerneldoc-preamble: Test xeCJK.sty before
 loading
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <c41cab17-afd6-bc99-56a1-e4e73b8c1ef6@gmail.com>
 <c24c2a87-70b2-5342-bcc9-de467940466e@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <c24c2a87-70b2-5342-bcc9-de467940466e@gmail.com>
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

Hi Jon,

On Mon, 8 Aug 2022 17:53:57 +0900, Akira Yokosawa wrote:
> On distros whose texlive packaging is fine-grained, texlive-xecjk
> can be installed/removed independently of other texlive packages.
> Conditionally loading xeCJK depending only on the existence of the
> "Noto Sans CJK SC" font might end up in xelatex error of
> "xeCJK.sty not found!".
> 
> Improve the situation by testing existence of xeCJK.sty before
> loading it.
> 
> This is useful on RHEL 9 and its clone distros where texlive-xecjk
> doesn't work at the moment due to a missing dependency [1].
> "make pdfdocs" for non-CJK contents should work after removing
> texlive-xecjk.
In hindsight, I think this qualifies as a stable material.
Let me append a couple of tags.

> 
> Link: [1] https://bugzilla.redhat.com/show_bug.cgi?id=2086254
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Fixes: 398f7abdcb7e ("docs: pdfdocs: Pull LaTeX preamble part out of conf.py")
Cc: stable@vger.kernel.org # v5.18+

Jon, it's up to you whether this one is destined for v6.0-rcX or
for the next merge window.  It has no dependency on patches 1/3
and 2/3.

        Thanks, Akira

