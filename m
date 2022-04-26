Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE150F7FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242536AbiDZJKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346882AbiDZIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:50:52 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8878017046D;
        Tue, 26 Apr 2022 01:39:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z21so7875789pgj.1;
        Tue, 26 Apr 2022 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8hQiUxEHPoPMzr0fdipBcROtlqL5WATwPbocz4CZxMY=;
        b=oa1yQ657IWZ34HxrFzrPDPNLXqUheEVfdkQd44cPIbSRD8ymf0Ej3ty2grcBCQH5Rw
         jyOsA0zGoJXAoa3sNtD5hD/pI4RMUWZD0dlin74TWBtcly3RR1VP422N9013f+Vru1rr
         jNb6HMgZ2zIm+7niWrkPGZd3wap+poai8QNeQDLafP5e0bvUE+ODzbWnX/VaAtzXoZrg
         LrrBt3iipmzC5vUoL2WDq+TMnMfF4QK2LO9UgO057mT2JXYZgL91nFDF9u4oUFQ4Fa4A
         ydW/OAPkgx6hmZZuhA//WakOmZcSwhtO5lIQgFce5nfbWh0TDSd6HmJc0XQbfI5xaQmd
         t/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8hQiUxEHPoPMzr0fdipBcROtlqL5WATwPbocz4CZxMY=;
        b=6B7s9JUUY/xjLH0De2Ajn0cvYOolCt2wuQtAOkO1Qzko/NF5BZDjGdaWzsC5wIRke1
         GeUc71b38erCMZn1tZWkJS6RWfiGtgeVGxD9+maFNBtbZS87C3OpTSWkvZRolasoiUHP
         p5sr1Kgaw3sx2SIdtzl95o82aLW0MXUQittwlXhkFFa29x2eGluomgPg8az8ikGJP1BZ
         BEtpirtK9NiHF+dUthiZCKbv2sU0bWA0Teq1CQ3kKirOkZ2K5C8z8hKucjxVD/uZnfAx
         7GXR2zsEFF7PN9ythYK6tJCkuudPuSxegqDQJHJvm5mTRAijG/Bft3c5Y68gPPifcX+K
         1FHw==
X-Gm-Message-State: AOAM5331SJJYjIoQ8Tox/+ivjIEdWbPLC53nt9OQZlc5CEn2BRnEQf2E
        0INpYtB2B0rRf1savEqvsc8=
X-Google-Smtp-Source: ABdhPJx+aUt5+dTkkkAww5P2DvCGQ61G+vdHyEud+z2Rmek/4uoU1iic122tBEoYYRlUN9YH50QZ6Q==
X-Received: by 2002:a65:5c81:0:b0:3aa:494c:6668 with SMTP id a1-20020a655c81000000b003aa494c6668mr18865499pgt.603.1650962347722;
        Tue, 26 Apr 2022 01:39:07 -0700 (PDT)
Received: from [192.168.2.225] (93.179.119.173.16clouds.com. [93.179.119.173])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004fae885424dsm15272012pfx.72.2022.04.26.01.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 01:39:07 -0700 (PDT)
Message-ID: <043f8d6c-ecae-bbb9-922a-93422d9a21c7@gmail.com>
Date:   Tue, 26 Apr 2022 16:39:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] doc/vm/page_owner.rst: Fix table display confusion
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>, baihaowen@meizu.com
Cc:     alexs@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, siyanteng01@gmail.com,
        siyanteng@loongson.cn
References: <1650424016-7225-3-git-send-email-baihaowen@meizu.com>
 <3ce4feb9-5477-e7fb-e98c-3d6342ddc7b5@gmail.com>
From:   Alex Shi <seakeel@gmail.com>
In-Reply-To: <3ce4feb9-5477-e7fb-e98c-3d6342ddc7b5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/22 11:38, Akira Yokosawa wrote:
> This patch looks like against akpm's tree (or linux-next).
> So it is not applicable to docs-next of Jonathan's tree at the
> moment.
> 
> You need to wait until docs-next catches up akpm's tree.
> 
> Patch 1/2 should wait until the English doc is updated,
> I suppose.
> 
> By the way, I don't think the list of options need tables.
> Literal blocks should suffice.
> 
> I mean, How about the simpler changes:
> 
>>  For --sort option:
>    For --sort option::
> 
>>  For --curl option:
>    For --curl option::
> 
> Thoughts?


Hi haowen,

Don't ignore review suggestions, Akira is right here, then
you don't repeat the same issue many times:

$ g am \[PATCH\ 2_2\]\ doc_vm_page_owner.rst\:\ Fix\ table\ display\ confusion\ -\ Haowen\ Bai\ \<baihaowen@meizu.com\>\ -\ 2022-04-26\ 1507.eml 

Applying: doc/vm/page_owner.rst: Fix table display confusion

.git/rebase-apply/patch:21: indent with spaces.

        ====            ==========      ============================================

.git/rebase-apply/patch:22: indent with spaces.

        KEY             LONG            DESCRIPTION

.git/rebase-apply/patch:23: indent with spaces.

        ====            ==========      ============================================

.git/rebase-apply/patch:24: indent with spaces.

        p               pid             process ID

.git/rebase-apply/patch:25: indent with spaces.

        tg              tgid            thread group ID

warning: squelched 15 whitespace errors

warning: 20 lines add whitespace errors.

