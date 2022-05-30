Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CAE5378D8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiE3Jsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiE3Jsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:48:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52FA33EA3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:48:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso6090464wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ludios.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqhBlTO8FlWEML3KLoqwH2xh/SnFWT/HMTtY/tj0hNo=;
        b=KD65NM5+8N3n8L8P0YH142jgvHUNsDB45MCHDuSb6fislzrHq4x6TvTknvyO4ggtIi
         xQJj0yct5qQ14JKSSzgOX6uXRDN8V2qrmVcO5LRudmc2f0k0UlmewoA1HoyJEBY/kn39
         EiBbLLW49AymT1Q/kcdBFMjb60D8IWVFJCpX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqhBlTO8FlWEML3KLoqwH2xh/SnFWT/HMTtY/tj0hNo=;
        b=yC0xRDL57luuUh+yykg56In2fd/LnGHHG7fs2JYgOeN9bjir0GBoxt7WJOwNORRpi8
         ql3L8qV5NUd/NEESV8U6+1b/aD9xi2BKiTbtqVtCi0cLo8FHGTE5hBM3AVGBrs1/I+rY
         uMH8PHNrufcOVhnx2+VnjYrRjXgmWBO4wXQ8ELy83CVBVPR4g/lrSlsg1qbvXVdn0dwo
         wiNe8YAppFLKzSDfAndjsRRLsjN46V5k8FtwqtK6OZesLF60CZ9lQB3d9Ov/tGDkYOmj
         ZzhX98U4iMvJtXMhUlb53s1mq9x+BFJAsnPDXBr2b7jn7zd7VdMznw/RlfXh/remJdx9
         2EPg==
X-Gm-Message-State: AOAM533jiBDJbO9jOMBW4CU45s2Txryvstx52POCo8c0/9Az41f3QJY1
        Uuekali8ParD3RIawI0KyJI66aYluSvyNl5jCCoDMg==
X-Google-Smtp-Source: ABdhPJxmOWtsEX9T1mddsbreRg153wR2DwPObJdhOVh1Qpd+172NW496XjxbbcMluyQ9lQLLGmoxV0hT8/Gll7a0v3k=
X-Received: by 2002:a05:600c:4e94:b0:397:62ab:f88f with SMTP id
 f20-20020a05600c4e9400b0039762abf88fmr18174191wmq.63.1653904129298; Mon, 30
 May 2022 02:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAKynti+AtijnHPG-hR-zDM9eCX9HawLgB+p2C9VzS8GN-4+UsQ@mail.gmail.com>
 <YpR2IqndgsyMzN00@worktop.programming.kicks-ass.net>
In-Reply-To: <YpR2IqndgsyMzN00@worktop.programming.kicks-ass.net>
From:   Ivan Kozik <ivan@ludios.org>
Date:   Mon, 30 May 2022 09:48:22 +0000
Message-ID: <CAKynti+tTV4uxCuCJj5NG85eZVYK9wVK4pkwxDHBJypGt-Tw6w@mail.gmail.com>
Subject: Re: 5.18 missing /proc/sys/kernel/sched_autogroup_enabled?
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, nizhen@uniontech.com,
        mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 7:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
> *sigh*, I think this is yet another one of the sysctl move patches gone
> bad :/ Specifically:
>
>  c8eaf6ac76f4 ("sched: move autogroup sysctls into its own file")
>
> Does something like the below help?

Hi Peter,

Yes, your patch does fix both the missing
/proc/sys/kernel/sched_autogroup_enabled and the error when using
noautogroup.

Thank you,

Ivan
