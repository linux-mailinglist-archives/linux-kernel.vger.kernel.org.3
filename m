Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861AF4B3014
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353936AbiBKWGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:06:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345929AbiBKWGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:06:20 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06699C79
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:06:19 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id l9so4127063plg.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3eRTsM/Q7+dUjZUJKDd4/vCIs2lGaytBhPl0HjcA0As=;
        b=yVX55KcikQlRpjxWKgehbDpOXXxoWb5ZcVKU4qS2v0OUszp9Bnf7taF67mLQnhNle/
         MJWfZM1wq8CWa82iSLV9uC9iO41ZeUJOFVi4VD54NrNOHNSoOTlgUcIV46g3z5I6VBk+
         PMtT3yHOdG5KU9N5kySUHJ5KKDkGaLoy9KEEnrMhpf2boJ/icuLLBG6ggndGn+I3qJed
         hnHh8M4NIx7x93FvgW7VNyT/4kP2V05m7LY0r6Vvz7nA3Y7mumUfpaT0yeGZAcYgBdr1
         dWjHrMlJiab6UJ4qGo85VWSdhX2QSMbEF4AmvA60VhTOt5ilgiHzVQyN+ukviEscqXYj
         jB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3eRTsM/Q7+dUjZUJKDd4/vCIs2lGaytBhPl0HjcA0As=;
        b=DE8QDYBFtYYfqGKAP709RQTDnOV0wns7cxunArp8lAlgP+vEOlDKJ1VouBiFxzopE7
         tkKJS/Jj9vi5poQ9DtKOKxfx8JXSjjE3y9pvVz/m2BcdX90IPh6uQzILzm2jFkurQNsL
         rp+nTCOaVe4CDNSEKCjEEvOUiHLeKlVXoFnG6ayBP0rI1m13DPv5Nn4YJs7hfbM31ReX
         1C5DzPMc5Wfy4VoebFsKxJRr2igmuh3Ba9RJ7lObQucHhoOUvg+2neFP8j3S7pMhEhTX
         Sq7ppzvGaGaz8h7/wy79SEsezXSOzHD0INPiNij7rChR956CZVdfXu0mPiav6gRMCM7T
         Qb7A==
X-Gm-Message-State: AOAM531SBYwTpjWukXTuVHsiU44R6SOYVWRsRMEZqmu1xD2bkSDEZW0E
        GQ8etCjF8JgTmWn8atOjPFQamwybHqzUXw==
X-Google-Smtp-Source: ABdhPJwY/LaFEKcAJrEEGk71Gv7H7gIxS8Avp1t2fbewESVPSX1udtzSrdbfbjiLfm++43a2GVGDpw==
X-Received: by 2002:a17:90b:1b0e:: with SMTP id nu14mr2507972pjb.44.1644617178471;
        Fri, 11 Feb 2022 14:06:18 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q1sm5931642pjd.48.2022.02.11.14.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 14:06:17 -0800 (PST)
Message-ID: <d6e41491-44c9-33e2-13ae-ae2480b9477d@kernel.dk>
Date:   Fri, 11 Feb 2022 15:06:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] docs: block: biodoc.rst: Drop the obsolete and incorrect
 content
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Barry Song <21cnbao@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org,
        Barry Song <song.bao.hua@hisilicon.com>
References: <20220207074931.20067-1-song.bao.hua@hisilicon.com>
 <YgN8CKUoRG4TQaqt@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YgN8CKUoRG4TQaqt@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 1:32 AM, Christoph Hellwig wrote:
> I suspect it is timeto just drop that entire file.  It is so stale
> that it is actively harmful.

I'll apply this one since it's obviously correct, but yes, we
probably should just kill this file.

-- 
Jens Axboe

