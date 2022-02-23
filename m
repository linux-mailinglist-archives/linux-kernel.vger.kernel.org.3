Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05554C150D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241350AbiBWOEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241028AbiBWOEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:04:38 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1730B12E5;
        Wed, 23 Feb 2022 06:04:10 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s1so11265129edd.13;
        Wed, 23 Feb 2022 06:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ZShNSKBQjjBrrYlgF/7HygCuwpzh3cSM7tDjKI/cvE=;
        b=Mt4HJZ0psdEOR8y6sSeRf1KohU7BbvTpy1MLf6GSUmhhrswJUdz99CNPwAyXJf30+q
         frj959wlOZJkkd3hnOLww8KUP6NzNCvR6tnQm5iLz4YX4X9e+iPLpacVgV5m4hQH4+Uv
         o2pA5NoWAVsZy2KlrPuwkOAzup9voTziHTBkUeeKrsGnHdWg4G0Od9og7dRrGSacrDsC
         lEedC7VsCDPQ/XunGewcH92pS09EqeqwEMF0VK+Z4YQh/9J6ykxgWgNQCU2q2ypnBXg/
         ha4kZj1lQINQWYGzHVFccBx1/9m72pbUmQE9sMnmlmMbTYE0NeY8wLnUQwys8ESTlsFh
         dnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ZShNSKBQjjBrrYlgF/7HygCuwpzh3cSM7tDjKI/cvE=;
        b=E83ypa3jaqtMQTkiythsGMgetdSxZ+/fq5aSxq9eryeyIavvMS+O1QdAxR/Lb98Z3q
         r+nkLdwi8gJ07G5TxMlIEyk/Q3P5okukDIqv+SY8Wqy7Z2bGIsf3aMx3PEjpDXwVI/j2
         PjaMGSFetr7Fr8duUJ2J5UEaYTmFXdSplDr9j+iKMejRSos3kh47hSqYerXKsCFECFjo
         LMgQTYD1D72tvpTbg7b9fZ3GktpJfgGBRIKFnN7SdSmgnaWFr5hr3o3dOBPr0FND1ib+
         5Q3yUXpZ6/ZjgYP/5tp9QRaPT91Ou4y4/MzhY1uTmZ8lKffbTRdkzmtf+C+UNuzZTMjf
         etbQ==
X-Gm-Message-State: AOAM532D6zycPn9V7TRoxkRe2PWUnKLvNt49rcOMLeKtqDR0yqtVWBKV
        RBRa5IQFdl4Imc9t1tFEGEs=
X-Google-Smtp-Source: ABdhPJwUXyRajX9QpauIv01zb5qAt1HYYxeVt2LJY4IEiAsVyY/vfediGpL06IHUN3UmWeH401f4lg==
X-Received: by 2002:a05:6402:4242:b0:413:1190:1a1 with SMTP id g2-20020a056402424200b00413119001a1mr13126872edb.456.1645625047779;
        Wed, 23 Feb 2022 06:04:07 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id e3sm1404846eja.77.2022.02.23.06.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:04:07 -0800 (PST)
Date:   Wed, 23 Feb 2022 15:04:03 +0100
From:   Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/11] Transform documentation into POD
Message-ID: <20220223150403.350ba3d0@fuji.fritz.box>
In-Reply-To: <1abcb226-dbfd-b3d2-5453-208af7faa0c2@gmail.com>
References: <525f3696-91f4-5a4a-c9ef-24758ccaa2bb@infradead.org>
        <ff98f455-0221-7ff0-08ed-8dea9f08694b@gmail.com>
        <939ef119-8a84-9206-bd7c-cfd215bb0200@gmail.com>
        <20220223135548.27babd85@fuji.fritz.box>
        <1abcb226-dbfd-b3d2-5453-208af7faa0c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 22:16:30 +0900
Akira Yokosawa <akiyks@gmail.com> wrote:

> When I do "man perl", I want to see a detailed explanation, and
> somewhat hard-to-parse synopsis is ok.
> 
> I'm saying that I don't like to see such a thing when I type
> "./scripts/kerneldoc -h".  I expect a hint to recall which option I
> should use.  I don't want to scroll back the terminal.
> 
> It would be nice if the verbose man page can be shown by
> "./scripts/kerneldoc -v -h" or "perldoc -F ./scripts/kerneldoc".

This is an option. But it makes things more complex. I'd rather reduce
the easy in favour of the difficult.

> >>> I don't see much point for such a non-user-facing script having nice-looking
> >>> well-structured documentation in the first place.  
> > 
> > You're touching the very essence of kernel-doc here. What and who is it for?
> > Not just the script - all of it.  
> 
> Sorry, I have no idea what I am being asked.
> Could you rephrase above for a non-native speaker of English, please?

Who is the "user"? Most of Linux users never even browse the source code.

Tomasz
