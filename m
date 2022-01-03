Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB75483954
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 00:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiACX4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 18:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiACX4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 18:56:19 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4736FC061761;
        Mon,  3 Jan 2022 15:56:19 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w20so63651274wra.9;
        Mon, 03 Jan 2022 15:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1Rz8pAdirwGM9T3HIP+P00havvKoNIpSMikJMk4xuA=;
        b=l1TLyKDxIWoNP61xoNqAIsR5ZXVTRkwFIIbN39ESptPewJNODXHNlwWBtLoG9HYtEc
         XRF70sk4h8l3t/yrWjjgTHJXQLdU8V2nqfZRyWpy3IEZ95aXOxJsqRVflmBnYrO70DDI
         XC3W6dlci58vB+c7I76nY0JsjxNBVrMJUsZiwO794+uk8V+kYjOJ1vcAlXSk2mdSowJp
         DzyZPjLFVqZ9Z/CrhK9sxT7qHA6m+mrZW2KwObRkDdqF6WpLHqueV+vRIxJrYV593ZoD
         dsd4KRRWT4np5nLPe2daYgVo3jFrTOKwOFHBG3O+j3PVctfw21NhGROXErQLTye3TxjP
         FQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I1Rz8pAdirwGM9T3HIP+P00havvKoNIpSMikJMk4xuA=;
        b=SY6KsQ4+oIxVHkyivDol9F2EAAHPl5kenBWVBkcr4wVtQ9nuBEGAXBT2rkYVbJ7x/B
         X+8WB6XkGVLTPLwGdy29+BvX2jwJXzSkJIjW2ZUcCOJvx7mWgnGoipWvHtnXpKqwf7Ft
         SQfRZ8aPJ6jSb1YVRt0sk4NWjgpa9i3xxb/OpPwwWiMaEWQMlPBgKn5uZeFUM1sz5aoS
         ey37NZ1DMrdDVP3rLva42dHxCJ4OcAjZFIFInV/X775YumIucdwWpkTlwQK6noP61x4u
         dW40sncKkF9bHe4wmW34QTErxnu1/VaZthfwVkU9mYL3LXjve7NV4AR+14sJ8nPxDY8r
         QmBg==
X-Gm-Message-State: AOAM531uFMGTkyjG4a+/9cCNFzOHWiUBWuvWm7A7HblRKg08S4EV9Sfz
        eSqMY6tpgOnKYxxVB/zep4wLsRQJ1UGqJw==
X-Google-Smtp-Source: ABdhPJydApjo/eUINfLzPGnStLthDkSaE0q2Z2j8ZkMOnh33GyoFB7ZRNdQITakAoHupPo6877Yq+g==
X-Received: by 2002:a05:6000:1acb:: with SMTP id i11mr39204935wry.244.1641254177336;
        Mon, 03 Jan 2022 15:56:17 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id w21sm30996188wmi.19.2022.01.03.15.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 15:56:17 -0800 (PST)
Date:   Tue, 4 Jan 2022 00:56:13 +0100
From:   Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: transform documentation into POD
Message-ID: <20220104005613.227f0432@fuji.fritz.box>
In-Reply-To: <8735m4zdlv.fsf@meer.lwn.net>
References: <20211209225549.69010-1-tomasz.warniello@gmail.com>
        <87h7b8cfg0.fsf@meer.lwn.net>
        <0796a780-f5ee-0b6c-e7ef-544ba5f6a429@gmail.com>
        <87pmp9tcju.fsf@intel.com>
        <20220103183034.77ba8a8c@fuji.fritz.box>
        <87bl0sziva.fsf@meer.lwn.net>
        <20220103224806.2932bac2@fuji.fritz.box>
        <8735m4zdlv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jan 2022 14:57:48 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> One thread per version is good; please do not post new versions to old
> threads.  A tool like "git send-email" can be your friend here.  See
> Documentation/process/submitting-patches.rst for lots of details on how
> to submit patches.

Ok, thanks. I'll try to do it correctly this time...

> Along these lines, I appreciate that you broke up the series as I
> requested, but you overdid it a bit.  Think in terms of logical changes
> and making things easy to review, and you should be able to coalesce
> things a bit.

I'm not good at guessing what seems logical to others, especially those I
don't know much. No sarcasm here. Luckily it's not that many of them, so
hopefully they'll pass the exam overdone as they are.

> >>  - Stick with current coding conventions  
> >
> > To be honest, I need to think this over.  
> 
> Think hard; if you're unable to work with the kernel project's
> conventions, there's not a lot of point in resubmitting the patches. 

Let's finish this one together.

As for the actual code corrections, I see I put 1 tab too many in
two places in the last version. So I guess I just need to reduce them
by 1? No sarcasm again... So let me know before I've sent the next version,
if you please.

Ch, TW
