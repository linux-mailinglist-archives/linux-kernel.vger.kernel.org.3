Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B4A4AC1BD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382721AbiBGOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344140AbiBGOjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:39:24 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13691C0401C1;
        Mon,  7 Feb 2022 06:39:24 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k17so11317692plk.0;
        Mon, 07 Feb 2022 06:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qOF7XuZ0URB/cEi6r2JFaqatdPkNWbtv8LDsccHb8v8=;
        b=VIT9DU84F6wnBWTjPisje1T5tMIDg1MClePpER0NkNwLPu3h8vbHbOcJtkHn+nWX2I
         glyqpg1/dX84E3xetCO1d+sbkvcKwRqteVWA6VO07q809WTkEDpwTiN2QWfhS39+Kxhh
         RvLI0xe2YnxntxUG4pBeP7YjqOYRiACBUUxFQ3HPDYd3SrhFJz0ZTepbbKZLpkfu/Jks
         lqkndJ3xfApZYH+BmHR8rfP7iYR/EpX0dvrSgAtOIIMw9P9dOf2lZ2D1zRlTffdjzD17
         TVzy8Y89g9ZH8K6XFuLieClgaKuA5GMqx6gqVnLuYPSfc5zHiRjN+wmc265bEc1nCIns
         Xniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qOF7XuZ0URB/cEi6r2JFaqatdPkNWbtv8LDsccHb8v8=;
        b=aX/mww2ojSwf8a9flurVBESbHfVAaDRAtW6XMiZ/uz7K0DL7UAlmKY6IMcRAP7Byzj
         HwGbUsQkE6n9q3dnwhvYVzkyiq6r+CumOQ/rqaS5+w1qUubv+N3IzSuf4qtTvhsBFDeA
         +KkryivWeAk/b/IJrbTeEBMN9baGZFbfPw7L9p4tbhOAtNKT4EuIc2i+yl49AS1fU9q5
         anJ17Yx2mjL1MMhcQM7wruPINGgLOM5/cPsTcKo8eIDcFASvZcumukH3BlUYvO8qM/Wf
         ufCyHy5UC5JSOU4Z41QF8qfaA4JzJ+fFoBqk1dMUGedzW2QYEX8SsD7s1udemOaSEE0P
         BvNw==
X-Gm-Message-State: AOAM530+dz+8ukE190xs9sQRAdzYkQ1fXQGAaGdaIyZuLmlHlrXBQmuw
        wfyIXNXy5VWYF0dx3tSb2R8=
X-Google-Smtp-Source: ABdhPJyyBVpQ9fCO/0O2Rjq1KPTtehboO+FF8NVRGQskfkI65e+VsAO2IUAKuGYnflIfHsSkl9Rydw==
X-Received: by 2002:a17:902:e84a:: with SMTP id t10mr2430855plg.25.1644244763599;
        Mon, 07 Feb 2022 06:39:23 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id md9sm3892703pjb.6.2022.02.07.06.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 06:39:23 -0800 (PST)
Message-ID: <3cfe6cb0-67c7-bd12-0a3c-a609f5341a32@gmail.com>
Date:   Mon, 7 Feb 2022 23:39:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/4] docs: sphinx/kfigure.py: Improve conversion to PDF
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com>
 <e545803a-8f09-f0e7-4ca0-16b673ef1796@gmail.com>
 <20220114094535.5bb9ba94@coco.lan>
 <e03de287-4eef-8a68-89f3-8614db66a74b@gmail.com>
 <87bl0c7l79.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87bl0c7l79.fsf@meer.lwn.net>
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

On Sat, 15 Jan 2022 14:17:30 -0700,
Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> We are in the middle of the v5.17 merge window, and I think of this
>> series as a v5.18 material.
>> Which means it won't be merged into doc-next until v5.17-rc5 or -rc6
>> (mid March or so), unless Jon thinks otherwise.
> 
> I'd rather merge it rather sooner than that if possible; 5.18 stuff will
> start going into docs-next shortly.

Jon,

Hearing no objection since mid January, I think it is time for you to
merge this series into docs-next.

        Thanks, Akira

> 
> Thanks,
> 
> jon
