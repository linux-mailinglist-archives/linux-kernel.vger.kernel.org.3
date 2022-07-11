Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D81A570C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiGKU6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiGKU55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:57:57 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B5709B1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:57:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s21so5833472pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B1UkBhvj0NFikLgCmbMFkYS/4oL6luTzgslsYZOD2r4=;
        b=YBt4zXDTAJgAv1vQBZHdlpDLWydSofNoC3OFdIdThutUqCs5wN334PT944WhKyykTs
         dipeDOzHZu3097FYka8gceDD98zU+Of49M+5FZn1KoAnqDvcHAw43a+eByH3y1mRyEY3
         R3UC5q8QsdSqR1ZLQn8RAGePMTx7XZtydRaK1KbDDjMsp+ik6gZJAendJ+zCOb8gEJ0m
         fqHs9KR1kuf3gyvDyMzfTcbu0n7YcGcetECj7G0I3WDpgkuGGk3UW0Wi8IaHVkWvNLse
         h8O47vQSRiELcNQGUytfswjZdohrRm9tGDPifEIwgCiT7TfogpCjkKWzTd2pHJZuIcrp
         3QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B1UkBhvj0NFikLgCmbMFkYS/4oL6luTzgslsYZOD2r4=;
        b=MesKwlxd1SGElbU8wtXZpSyA9hFQbehABgia7/75wR/OaV3ffgpTgzGU8SURRvGDpR
         mEZwYeSk4YjtVpNGR6pUjGnZrOeifbKfd8ixD0eQHE1LJkqWNYdow46PxZ0D2Co9uV0v
         H23J0zE+SYoRmyFIPMsov8JYlVwzkC1uuJbG0CR/hmX1pC1o2k6GqCxH/FC5z7FWZcEO
         O/nKT7YrgML10rnkk7YFngOR01DjsDKdO75wRw+MTe+GbLToxvylL0juvnjpodTdShOe
         1sCY3oxk5bpcLjpMt9FE4J5L7cFDaZDMxNkYXAu/3lxTjAdNkgyvLHI4FiVOXXXo8tqZ
         W4pQ==
X-Gm-Message-State: AJIora9holnA+INRmfso7q8RMUpb+mP4feNTNkLph67M/4ZyIPuH0gM7
        wV5+yI0VmrukGN5CEnmagPeLsw==
X-Google-Smtp-Source: AGRyM1vVLoOymV9ZmrioVJ7NpOaz4Vr8Fsmb2up/QullxOSxQKUOj5MLoUTmbk755nC+x+3Kr+oTbg==
X-Received: by 2002:a17:90b:3811:b0:1ef:d704:24cf with SMTP id mq17-20020a17090b381100b001efd70424cfmr310336pjb.14.1657573072732;
        Mon, 11 Jul 2022 13:57:52 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b00167942e0ee9sm5191835pla.61.2022.07.11.13.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 13:57:52 -0700 (PDT)
Message-ID: <d7358d95-b187-ca7b-7337-d22dcd0ff254@kernel.dk>
Date:   Mon, 11 Jul 2022 14:57:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] trace: atomic64_read(&ioc->vtime_rate) is assigned an
 extra semicolon
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, Li kunyu <kunyu@nfschina.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
References: <20220629030013.10362-1-kunyu@nfschina.com>
 <20220711165532.10476a0b@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220711165532.10476a0b@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/22 2:55 PM, Steven Rostedt wrote:
> Jens,
> 
> Want to take this one? Or I can if you don't.

You can just include it in the trace commits, that's fine. Thanks!

-- 
Jens Axboe

