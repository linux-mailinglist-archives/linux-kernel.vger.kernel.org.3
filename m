Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E903506331
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348227AbiDSEaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiDSE36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:29:58 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A2225C62;
        Mon, 18 Apr 2022 21:27:17 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bg9so22665690pgb.9;
        Mon, 18 Apr 2022 21:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FJc+cMZCsoUMr27Uj/cmPk/3F4f5j1++z7q6e9xt05U=;
        b=cz6sn5DIlYWdPNTmkDOAJSVEkFAu5kZ75g+DaU9MEcEgcBitS16eWXBAXpNp53adhw
         gYU5eM8YowGyv+jKUT+twhbWr3lDQdHqyIV1fNmt+qwNse/ui2QBBAOFJqSx6AS6FKZl
         Tsoj11G1ZbMwNAFyLEOwvEzyVdldVcaXvA8719K9mkj8ZWtF3o/KvEt9MT8Y1RKJCX+T
         81r3IkvkPDE8V/4bLF4CGz6N63Jq8WDhCqIzfp+aqD0xAdmKKNWen4RinUOg4NE7TkeD
         /wta8MHB4LPoxm71ZgWydU18HSke75ZM8Nkdsq790l3ROgTPNX5YPnF8qWb1Wcr956f3
         laUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FJc+cMZCsoUMr27Uj/cmPk/3F4f5j1++z7q6e9xt05U=;
        b=M9/osbAmMJ0ihm7Fa7k7yp0V7jGYkJ4wCzOepIkCFK7SVV6hR+PYhfqRw5Nuo2HUWL
         0owFoJeIaVeJ98p55yRTMLS4UldjShTxWzSXjmG3VUYhh/Tb7UOMQNxHk7EgKHVozBIx
         TQqI/FpJ4QUTgMEWYiv0MQ+0GUVWmP57RgwD6TGokVJMjn4jxsWGm5GE3rr5TzkPjxDH
         pPqLJDGGgMgl913sKUO8sojcP6PJaj4J7xu3SGBWFKih9xEg0+tfacNHmhnt9DGpGD2i
         fVt5uE9gptnlL8AEntmWT6hvDmC5rwuHeXGJty+jpTGDGHezDX4x+KWn01y/Np9odWL/
         cb1g==
X-Gm-Message-State: AOAM530Ciwi0gacr2p/APH6EhL4NCcseRixU13v+rdvrozFxA/MJPtKp
        evps1IYD8eVTix3hmxv0ipE=
X-Google-Smtp-Source: ABdhPJyFhCro2zMGPztsQ1kJLAqH+Wkcz+05mCG+y3045rNIkzThOFMfOXcYyx9ohBAeAH8J0pF67Q==
X-Received: by 2002:a63:e147:0:b0:39c:d177:c01f with SMTP id h7-20020a63e147000000b0039cd177c01fmr12878106pgk.81.1650342436308;
        Mon, 18 Apr 2022 21:27:16 -0700 (PDT)
Received: from [192.168.2.225] (93.179.119.173.16clouds.com. [93.179.119.173])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004fe1a045e97sm14605209pfj.118.2022.04.18.21.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 21:27:15 -0700 (PDT)
Message-ID: <fc9d5350-c4ef-8687-b041-eafcedf35aa8@gmail.com>
Date:   Tue, 19 Apr 2022 12:27:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5] docs/zh_CN: sync with original text
 Documentation/vm/page_owner.rst
Content-Language: en-US
To:     baihaowen <baihaowen@meizu.com>, yanteng si <siyanteng01@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Yanteng Si <siyanteng@loongson.cn>
References: <CAEensMz1BWx2arYAqo_g5_0w1z+m-X3nRYATmSMvZ44rb05w4Q@mail.gmail.com>
 <1650334070-7233-1-git-send-email-baihaowen@meizu.com>
 <CAEensMza-D5LhMHAmAih-s6ZkjtV+ztUXLqFqEZyjCPpJCutJw@mail.gmail.com>
 <291672f3-99ca-a894-1423-8985d1f2dbdf@meizu.com>
From:   Alex Shi <seakeel@gmail.com>
In-Reply-To: <291672f3-99ca-a894-1423-8985d1f2dbdf@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/22 11:24, baihaowen wrote:
> Yes, I have just applied another patch to original doc:
> https://lore.kernel.org/all/1650338276-13687-1-git-send-email-baihaowen@meizu.com/
> 

It's better to combine these 2 patches as a patchset. That would help a lot for review.

Thanks
Alex
