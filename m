Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB9A54C673
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245460AbiFOKrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiFOKq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:46:58 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469C451585;
        Wed, 15 Jun 2022 03:46:57 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id c189so906279iof.3;
        Wed, 15 Jun 2022 03:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yTUVYFQ7BTygwQjRTAV8Sb3bsuCzr4QHgu9dQejfz7A=;
        b=EX0aHXkPD0arR3eKdZkP7M4g3NiNmnHOQPv5kl6c9bR7tLAnqE4MVinbzUEhQlHxY/
         8AQtkBPQ1tAaKij/g+uX0xIfOlSmTH0NKw9zr6+q2mlVVl4sAq571kkAfweMPExI1k0V
         6PWcVKDrhUkcz5J+8yVlfJHB5e8epjOYOHV6pvLQ0C6ao+2c/KBgQvOOk5ys720YwWqw
         LFrXPkMdMbbm75aVs9EHMrcW27iEGRovNb75ZCgP3egZeBu0w7302k4qApuBigBkoguZ
         1Mx+j+4IknJyMF2ZIwG6VEopLUGeu7zduYeQClPt8hPXYVAKSgMJnMgzuuI5KnQpGgKR
         1lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTUVYFQ7BTygwQjRTAV8Sb3bsuCzr4QHgu9dQejfz7A=;
        b=xg5M5Q2/kFRi34icR160qa31PRFM/2LjKWJKM9rxPtNV/z6OgZY3ysyfpXTwa1c4v9
         ywquCohV+6BO3X5vkBaXJcQKsrwieCeXRHkzzoQHID6Rqtkv0qIDXwwetDXK/vc2/DVk
         BESOzomOkRgSM5Ni8IsrvQHe8YElmIMXApLjTHC5nEv2kWJt7es2KTZ+zj8zNX9s6DCy
         qJu6rox+shLu74bk78newuz03QDTfFVrKfB+bDsc7v/QDUnFA8thWqc7pev6D3bBQcBf
         Th7nO64vMFCCmhNJctpSBRb6xextpaz6H/8nq5saciWrmalrJdgmr9wyGiSqNCnW0exT
         YubA==
X-Gm-Message-State: AOAM533+QYIIPCqHvXyalqFBbDj65P3si95mteKa679RZ4PObI985lYa
        E+vkSi+WH+Fjl+9mW8bWU7PrVVNWjcxqtIiEL9mHCR56TwM=
X-Google-Smtp-Source: ABdhPJyIPNIpZmcnnUJO5fJnnarWv6wNKkDx8A5k1vGMLHqVJqvNUt3tP/ca7SfwERh8u4rp6b5I6CdKKiAFBG0994k=
X-Received: by 2002:a05:6638:1690:b0:331:950f:8ea9 with SMTP id
 f16-20020a056638169000b00331950f8ea9mr5542815jat.67.1655290016748; Wed, 15
 Jun 2022 03:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220615104520.35687-1-eugene.shalygin@gmail.com>
In-Reply-To: <20220615104520.35687-1-eugene.shalygin@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 15 Jun 2022 12:46:45 +0200
Message-ID: <CAB95QAT3Ng0pR+tqKZZaaX1psO8ewrZqCcoqC4nTAM8V-q=8KA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add missing comma in board name list.
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Michael Carns <mike@carns.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error already made it into 5.19-rc1, unfortunately...
