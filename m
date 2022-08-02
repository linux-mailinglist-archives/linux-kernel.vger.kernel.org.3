Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FFF587E82
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbiHBPCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiHBPCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:02:02 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A62B1E3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:02:01 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c20-20020a9d4814000000b0061cecd22af4so10331761otf.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=uKqb6PaUkYrBfbM6a6MGXXS4D4m12oIAPT3k08dh9BE=;
        b=gXkIQzzfDTQXvsoALPrZvmxmyhBrvsTnC6vfXHPIWyycmy2E3UYVKtGGRIhanYf6II
         ckgNlh+mqhO9LRWE64p4t/YUUzwO4jGbEHV3233fDb06SktBOVbGM0wsfeC3cvx3yA5n
         k+xChpWg6vmjEq/7cXROWy7S84ZzYvkCRjtYPOkAkgN3vhckj06FVwd/Pp4EI82YZsj4
         iwjrvUJD1aEfVIxax9Leh0WegZQpE7Prie0dx1jyXF0I6G8zCs9lhr+djQ/VY/yduH2h
         0ktfHsjz0/2wF1s0UHhRZfFC5OA9eiEhMY2gpMvZMiE+mJZ6pNC+Frah1ncE94yunhzs
         BiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=uKqb6PaUkYrBfbM6a6MGXXS4D4m12oIAPT3k08dh9BE=;
        b=6u056WCkeTZwnTcLWpOTwL4BO+0cHQtzRjiBYJDFnyO4NqqS4N2Dauu6TvtcbPktwQ
         6R1POYlwNF6TAgKKn9PTDy2KoyeFocYTIRkCgv57JNxVXrL8qdKHPj931Y/Wd6p08aup
         t9QLPWTtYxng/F5yWtTRovX8wGOEZNtXZmzrhx+Df5am8vKrT/hjX+n4Ov+c/xTrRGP6
         sdigQHjEHDtC7Yb0+OEgKCnkWwg937jndkKkaiayUxl7mArFwAWcjVJXJnVUJGZfp7ys
         uEDFUBdzdZcDnHwXqGWmVdS1FII/T6A6riEDFspCc2pE6/+O62zRETUb948p5Y6nKUhZ
         bz7Q==
X-Gm-Message-State: AJIora9pFxW21nt+blzvAo/2OEUeiCwwrpxvzTfWQRb/Q/TFATDjnCpy
        iJykjjKG70YOB1BbRDjMcRW4UXnyFMw=
X-Google-Smtp-Source: AGRyM1vrDpr5OKiG/q0avH8adnyXZc6OQGk+2OqxINidcJaLQRvnIJ0Ax6N8TMjuGWbtYgisTJLE4w==
X-Received: by 2002:a9d:784f:0:b0:61c:7817:3d8f with SMTP id c15-20020a9d784f000000b0061c78173d8fmr7707974otm.271.1659452519983;
        Tue, 02 Aug 2022 08:01:59 -0700 (PDT)
Received: from [192.168.1.108] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870149600b0010e63d0afbbsm2473054oab.55.2022.08.02.08.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 08:01:59 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <c82114b6-1003-bfb5-0550-98dcbf1a3761@lwfinger.net>
Date:   Tue, 2 Aug 2022 10:01:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: The r8188eu kernel module does not depend on the
 rtlwifi/rtl8188eufw.bin firmware file
Content-Language: en-US
To:     Grzegorz Szymaszek <gszymaszek@short.pl>, Greg KH <greg@kroah.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <YukkBu3TNODO3or9@nx64de-df6d00> <YukvnVWuhUeOgRyZ@kroah.com>
 <Yukx8KEEOhKTJ7HQ@nx64de-df6d00>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <Yukx8KEEOhKTJ7HQ@nx64de-df6d00>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/22 09:17, Grzegorz Szymaszek wrote:
> On Tue, Aug 02, 2022 at 04:07:25PM +0200, Greg KH wrote:
>> Looks like someone needs to add a line to the driver that looks like:
>> 	MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
>> […] Can you make a patch that does this?
> 
> Sure, I will prepare and send one later (hopefully today), assuming no
> one objects in the meantime. Thanks for quick response.

There will be no objections. All 8188eu-based devices need that firmware. 
Omitting the MODULE_FIRMWARE macro was simply an oversight.

Larry

