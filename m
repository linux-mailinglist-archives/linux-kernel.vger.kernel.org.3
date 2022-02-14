Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D5F4B5D04
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiBNVhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:37:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiBNVfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:35:37 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A126555
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:35:00 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso408190pjg.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZUA5XLVzUwl5PsPpBT4GOMiYMi4Ipd6X1OagX6wrzqc=;
        b=Ri2IA/U4wrZN62NwG1Q3k8sTvxHXPtOqj+KOMSwLllDqeSg6aSU4ryXBDWs6Z8K7Qr
         Y9bR8gwyC83dLv1ouPA0/Jo5V3yQfMvvD4fSAxa5AhxfItw1mko0fhMjwGCXYkf591vr
         6Zw0ICoctwU3ZVnVTVLHebfXhWTM0NNbrHGyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZUA5XLVzUwl5PsPpBT4GOMiYMi4Ipd6X1OagX6wrzqc=;
        b=X7BIyDK3GhQzs7Nm8oTcZNsLVz1lPFSn55hOmawK6/f8eKpp7EjSoF6JNpHuGQAprC
         QjT1dTESZ7flH0Nh42IQPRbCWGP96EEYvajQu9cLLMRKyQ1TMYUuQed1FvHaqQUa3wT+
         avgsTs5g3lbJgSSUqtZBPH9DjRLAldLuKDwpDYri9DUHLgzNkErV2VrpdLxcNToqfteX
         JCR3lAUPoVXIiEUC5hwYhOWPIXnNZxR8ZWE6/yG3StiTP9MQFZAbR3+bK2CPfFrAadob
         q8+Y2xD3GFksulpTcnlooKnWzzM10Yi7mQbAZ2z6x8GN6bEMkajg6emG/hmL22aLcfG6
         dEmA==
X-Gm-Message-State: AOAM533fb3376IOUpjeWoAyPg+de0hJ5bHWy1u8gfMphTLtj8g4YPOYa
        tB9jJS+bQh7/V2BiyjUC7PAbtMuFDKu2jw==
X-Google-Smtp-Source: ABdhPJyTNUqLjr0QN/j055iQchlM/5AM3dl2qg42GOgBLXoTvD0Xm0NeQedaV23se5OBGDWW2Cmu+Q==
X-Received: by 2002:a05:6a00:2183:: with SMTP id h3mr422183pfi.12.1644867117937;
        Mon, 14 Feb 2022 11:31:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e8sm20515052pfv.168.2022.02.14.11.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:31:57 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     viro@zeniv.linux.org.uk, trix@redhat.com, ebiederm@xmission.com
Cc:     Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: cleanup comments
Date:   Mon, 14 Feb 2022 11:31:49 -0800
Message-Id: <164486710836.287496.5467210321357577186.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220211160940.2516243-1-trix@redhat.com>
References: <20220211160940.2516243-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 08:09:40 -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Remove the second 'from'.
> Replace 'backwords' with 'backwards'.
> Replace 'visibile' with 'visible'.
> 
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] exec: cleanup comments
      https://git.kernel.org/kees/c/92eec5b2f7b8

-- 
Kees Cook

