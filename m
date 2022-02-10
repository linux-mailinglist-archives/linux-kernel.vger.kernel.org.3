Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B35B4B02E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiBJCA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:00:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiBJB7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:59:19 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C843E2B694;
        Wed,  9 Feb 2022 17:43:38 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso7094303pjg.0;
        Wed, 09 Feb 2022 17:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Cry3Wtr/RMzYLNnlssa/FegDG6Szz3AAHVIwYbF14p4=;
        b=BuwyrIlQTSYfuDOGgaCnFkGWHitNYmF2EOoFcP4H6rNyqYyuL/I+De5T49WH51elcU
         zcsrXoYrAGLEZbApNAumQoTQGxJu1EloQUA2W+AghURVpw1WsbpYmij+6PQOGpjy+aAb
         4kvUr+U4RuOWtAriGCWY8CQr0TTTY5xkMaPOULbLjdK/sUJ7Cew+bh4IvdfkgbOItcYU
         nq2WetauqN68Avk5DxTo60Qm15W3ujMuyxhPp2PqPf+uqdxH2XCpGXYDQCzTxZnYME0U
         j52q9n913KdvXUVjsGWkzOtxVv20xkKc4raZ7AybC9i2YNQw30i3ytD2mgpsYfq3oKKY
         WpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cry3Wtr/RMzYLNnlssa/FegDG6Szz3AAHVIwYbF14p4=;
        b=NDF/8HpyrPjl4pYvLHOfciyDOVhIItl5BADcHtZoqhFntKqSn2Sw3BSRAyaI859fq8
         DyARDscBfbAreMZe97MOZdatdkc4pX9o2xKOCQ+kxE9oFhy4jK04Vf8oQ4bC3a+KmHTH
         vo5L/UzSm/uxjlJja6rtNr+01aCfVqROJwJIIuFYFxOVE8f/YUCc+TblYkDQtvqURs3P
         Nh/d8M2tr5vNnYb1hhp7tqrWjFuDca/zBuFN+eK5A7WDkiB+z1cnFYAYmSsHvK75TQXr
         JA81DMDRani/7Fjg5qht2PRkrp404Hj/eS/OlDDgqB1+qvbl5jrgv/h5QbOP+bb8HLBB
         47OA==
X-Gm-Message-State: AOAM533kdHrD756mAJWJFPaRfJstu+/MTLCUs2v1hQXY9asl6WVO6FHK
        OyVgVUs0WMa0Y3cOdgBD/sk=
X-Google-Smtp-Source: ABdhPJyit4iS9692syMqC3i5QWytBR9MtfPSX9pD4s8pKYuhVTzTVNq8ikdrOFgxPyNuPu6WCSEeEg==
X-Received: by 2002:a17:90a:d343:: with SMTP id i3mr241380pjx.104.1644457418391;
        Wed, 09 Feb 2022 17:43:38 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id a3sm61728pjq.43.2022.02.09.17.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 17:43:38 -0800 (PST)
Message-ID: <e7ce363c-c154-50b7-016f-0f98bf13a0b9@gmail.com>
Date:   Thu, 10 Feb 2022 10:43:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] docs: Makefile: Add -no-shell-escape option to LATEXOPTS
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <519bd2d9-1bee-03e1-eeb4-d9883c18be0c@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <519bd2d9-1bee-03e1-eeb4-d9883c18be0c@gmail.com>
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

On Thu, 10 Feb 2022 10:26:53 +0900,
Akira Yokosawa wrote:
> By adding this option, message of "restricted \write18 enabled" from
> LaTeX can be silenced.
> 
> As there is no use of \write18 in LaTeX sources from sphinx-build, it
> is safe to add this option.

Jon,
JFYI, there is a ticket on the message at:

    https://tex.stackexchange.com/questions/76105/what-does-restricted-write18-enabled-mean-and-why-does-texlive-keep-reporting

I think David Carlisle's answer covers most of your concerns.

        Thanks, Akira 

> 
> Reported-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> ---
[...]

