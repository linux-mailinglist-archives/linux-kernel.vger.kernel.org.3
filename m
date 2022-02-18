Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579F14BAFB3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiBRC3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:29:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiBRC3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:29:52 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01602DFD1;
        Thu, 17 Feb 2022 18:29:36 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w3so12946003edu.8;
        Thu, 17 Feb 2022 18:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PA6wGAdTHPmyGZljT+mifKX5DS7xiHYB6o4PnSOjpVQ=;
        b=WE3WDUo6y+En976FRMvW6izqgNtFgN4c/aUxq+dvj0BqlpGQB/3HTaVpRovqPuUeGD
         f4J6izQFuXnwst+5KFDk76Hm/7cfB0U6EM4wVktizwbegVUjPWEEH2WUfPWeNL664z9S
         nrFjhWt+Fjq4Maeu5XGEkSw8agvK6Zc+ljOO/nZHE/A9TtRY1wiPlt4z6yiXZwpGfqNy
         IAcp1oxixOKM13iFC7zNqMUZay7weUaNq2GtYO6i50qfI+6oCrkEtP9JXKbCbj9HqxDX
         TnljBzjI7rcsbhGmpxSq6cuUAakI8c4qHEyYhHs3ZpQkiZbSMcqJTcz61ntueBB6nJOt
         yCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PA6wGAdTHPmyGZljT+mifKX5DS7xiHYB6o4PnSOjpVQ=;
        b=SHyoMHX3TpRyIHqFdCJJibZGxMbn8XS5qDgowj/QgHzF/JQSRVY7vPwKQvGfzfMmhu
         bZmFW4bpSPei4n0SvOqC2037foz00cxvYyb4EwEt9zO+7RpvqGpffrDgNioL+5/nUwMS
         OouVDmr1zdaNvHrCyRxOD91E4TQ2YBnAYKXOdg4v/g58puxbYXuaArQKFCWLo0Zh02fW
         BGxU7avXpkJ2JKSqjeCaYjcijAdVM8LLXq9qIjA8stDP8B7sWMzM51vCQ2SBq+HG7uU2
         fkxZcznu9mrMe84CUOUW5Urki78VejYYhYjonWgr9LDk8+hfRxI2exIPSYk5eYL/LoYB
         dcgQ==
X-Gm-Message-State: AOAM531VjFlE3c9jq1F+W8SbufHnwZiGTHXduL40MliTUtyKDsZFXMVW
        EWbE0j3KQgbmtrok1HLVtcemcm8TGaE=
X-Google-Smtp-Source: ABdhPJzgIBFhyfyVwILs0/wXMK3m2CNw+6Pd8I+1/fHk6e0Yf0PFDxOo+JoCieBTJOzP8uFj2qPnZg==
X-Received: by 2002:a50:d0dc:0:b0:410:dc9a:4065 with SMTP id g28-20020a50d0dc000000b00410dc9a4065mr5666645edf.346.1645151375447;
        Thu, 17 Feb 2022 18:29:35 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id eg42sm2132627edb.79.2022.02.17.18.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 18:29:35 -0800 (PST)
Date:   Fri, 18 Feb 2022 03:29:30 +0100
From:   Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] scripts: kernel-doc: Major kernel-doc rework
Message-ID: <20220218032930.5230ee1e@fuji.fritz.box>
In-Reply-To: <87bkz51l2g.fsf@meer.lwn.net>
References: <20220205233945.7a4d22d8@fuji.fritz.box>
        <8735ki2x62.fsf@meer.lwn.net>
        <20220217163247.03e37c9b@fuji.fritz.box>
        <87bkz51l2g.fsf@meer.lwn.net>
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

On Thu, 17 Feb 2022 10:04:23 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> This is the kernel community you're talking about - saying that it
> prefers any language (except possibly C) is asking for big-time trouble
> :)

It should be written in C then.

> Markus's work was here:
> 
>   https://lore.kernel.org/lkml/1485287564-24205-1-git-send-email-markus.heiser@darmarit.de/
> 
> At the time, we were just trying to get the RST transition done, and
> swapping out the kernel-doc script seemed like a major distraction that
> we didn't need, so this never got looked at as seriously as I would have
> liked.

Thanks. Interesting.

I should have mentioned getting rid of the parser states in my release
announcement.
