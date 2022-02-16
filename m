Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7644B8858
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiBPNAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:00:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiBPNAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:00:20 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80A92A7944;
        Wed, 16 Feb 2022 05:00:08 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 10so1967584plj.1;
        Wed, 16 Feb 2022 05:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GtlxMKqaR2xxEEzyngviw8ncVL0VOxd6EYGnW9jVW90=;
        b=mXEjJXRg18kYc2KGCAPobLS9Q1bpMoeD6CsgrlgVIHli/jshJ+Dk9d39xiDMsYjnjv
         gsICekO/lFaycPX/usp1Gq9BSMGAYi3s5G8sMIdgZByBzE6Qu+nDbUMd0IuYzPWv5RUr
         5mWyQQzJKaZuiIHtkiSlT+5bv1B1LMjQiBJNMdUTjTbofI4g6qBc9AJ1kd1l/ijLTdMa
         7HNMPCYASR6DZb0grOtnsZ0v40C0kOWiKdRhK6RZmx9IxwhQCdkBBxogclakVt5GRmr+
         +uSwJ8SnoAlJ3H5yhI/KfTKqINhKO8uJLU3RD9u37Ws1AkmpYGwOdpedn5jOTdJdqWPB
         eqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GtlxMKqaR2xxEEzyngviw8ncVL0VOxd6EYGnW9jVW90=;
        b=RP4Oq97CtEMB2ugEkj8igjeZ+pnXpJZaQOSYKfPwDMf8DJhCjl+zpoFZYdahjq2qR7
         fFJ963g48CowZAY52Q9vDn7gsJOtFAqhRwFcqtfBl9TGp108Q3GG+7oB4OyCzaUhQd+A
         7ywm8vptnd2/JC8PGgvxEKyFwPxZPRpiBSzSeQjbbQuGKuqSK/x/I4yT8amWJpCB/XIO
         D6hHem3cHQzVrE6zcjedwkjCSrq+n6ft7iFpdE5z++a1ByIZq8FihPrEoccr8l/hjnKl
         ciggj2e+dQPnKB8oH/dWmiqD+x03smsC0JRLPCAzhbiCFDezKK3ytMM5ImPEJ+I3mxjL
         SMwg==
X-Gm-Message-State: AOAM531c1belmBG0LCF76dgs+ALfNr4NZ8UUXOi6xmi99tEbJ6GJl/pB
        6UpX/Dpf8INUZTtfqbweCNk=
X-Google-Smtp-Source: ABdhPJzVhpGfEL3OJTGG3vrQ4kd0ITp5Xl4JkvSl1wigsfy7nzUIydE7P4ZuWMB87RuSKOBkV6W9nQ==
X-Received: by 2002:a17:90b:250f:b0:1b8:f257:c39 with SMTP id ns15-20020a17090b250f00b001b8f2570c39mr1582977pjb.135.1645016408406;
        Wed, 16 Feb 2022 05:00:08 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q2sm20691432pjj.32.2022.02.16.05.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 05:00:07 -0800 (PST)
Message-ID: <d0ce2c79-4e4d-9373-3ab6-e1e355224559@gmail.com>
Date:   Wed, 16 Feb 2022 22:00:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/5] docs: pdfdocs: Improve LaTeX preamble (TOC, CJK
 fonts)
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
 <87zgmr66cn.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87zgmr66cn.fsf@meer.lwn.net>
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

On Tue, 15 Feb 2022 16:46:32 -0700,
Jonathan Corbet wrote:

> I've applied the set, thanks.
> 
> I do notice that Documentation/conf.py is getting large and
> unapproachable.

Yes, I was having the same impression.

>                  At some future point, it might be nice to pull all of
> the latex stuff out into a separate file where it won't scare people who
> stumble into it by accident.

I have an idea to accomplish this.

Will prepare a follow-up patch once you push the docs-next branch with this
set applied.

        Thanks, Akira

> 
> Thanks,
> 
> jon
