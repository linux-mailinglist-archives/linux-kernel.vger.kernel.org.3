Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C3C4C149E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiBWNsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbiBWNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:47:46 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB3C338BF;
        Wed, 23 Feb 2022 05:47:19 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vz16so52627140ejb.0;
        Wed, 23 Feb 2022 05:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=278A77phWIK14HSkFlCHyTxLu7wpfU9WGdsWijDHfiQ=;
        b=WqajQq39z0/YYmMf4frgaXX80SW+sE/N+MFjyfgcNgdcVst5BGLcpzeMYoOrIV8tMz
         dU5ur0vZyIJXnDP/ow1u3kGGVA7p5mKISbXZe5qP7ZXg1pREW0f8PTNcB8B613rnO9HV
         h66P+uGGxT9K9BhxsrsC/WlNe4iVXha8/ser8wIOLPpkbRKYyGib4aFs4ojUNHC76s47
         n0/3i9k3W9JuZYHFDbH8Gv8XZFbMmanI0eRXBR6NjwxaOGgfOHKV1pjmQrBwikRQWbfA
         1tpBWN8l7Ge5HE+q4l0Daq6wIzLQHyDQKHaEWe2NXNrsAkwBjYNQFjwIFdj23ajZLmaA
         jwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=278A77phWIK14HSkFlCHyTxLu7wpfU9WGdsWijDHfiQ=;
        b=trqjvVQdEcmpNDHpEv02o8+9e9jt/aKZqtbpqZza/AnsGYmBY/2tHuDIYVK4l70ick
         EFVom0URqDBbOpU+Kho++Y6rHrjZXwEykrtK05fDQ06NcDRV+UbC9/65JUDhrVWPniwX
         HZ+S1ORY9x9kMlmWSgFOr0hfPKmoLEkMKedue9yWjhuf/rSGxZJjmjxF0FAK4/QTTniK
         E58SIrZIe2Fo2rj73vaMOTzwvcY4re9FRRzr875HQzNb02rp9/pQj9xKcdGUy8Qs6dgd
         zYWGMRFHiIDTDocK6CqRFzkxnuVdBrfvRV78FqDK1TgaWPCL2EEJk0n/Bh1NJJ/fDolp
         MsNg==
X-Gm-Message-State: AOAM531h5qOf/qWO28CmD26IqJFS/VpB82XepiT5SZzKovTOQy9RvAMo
        F+axoocplK62KKG8AU0bxbdUwBx07crd/w==
X-Google-Smtp-Source: ABdhPJyVJEKSRAPXhM9DQi2bQ1NfcfU6nxF5xqJ1ZxnbzwAW9p3Sn2D3DX5b+wpk7MAiaThX1nPMag==
X-Received: by 2002:a17:906:ae97:b0:6b4:5421:e2ad with SMTP id md23-20020a170906ae9700b006b45421e2admr23466713ejb.364.1645624037815;
        Wed, 23 Feb 2022 05:47:17 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id m4sm7569353ejl.45.2022.02.23.05.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 05:47:17 -0800 (PST)
Date:   Wed, 23 Feb 2022 14:47:13 +0100
From:   Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tomasz.warniello@gmail.com
Subject: Re: [PATCH] scripts: kernel-doc: Check existence of FILE arg
Message-ID: <20220223144713.6e2284e3@fuji.fritz.box>
In-Reply-To: <1c71e5d2-f87e-6c8e-6176-e5ce42e4d41b@gmail.com>
References: <1c71e5d2-f87e-6c8e-6176-e5ce42e4d41b@gmail.com>
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

On Wed, 23 Feb 2022 15:07:30 +0900
Akira Yokosawa <akiyks@gmail.com> wrote:

> Currently, when no FILE argument is given following switches such
> as -man, -rst, and -none, kernel-doc ends up in the error of (long
> msg from perl folded):
> 
>     Use of uninitialized value $ARGV[0] in pattern match (m//)
>     at ./scripts/kernel-doc line 438.

It's a warning not an error.
