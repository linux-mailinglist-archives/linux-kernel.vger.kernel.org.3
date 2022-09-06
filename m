Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D16C5ADCF5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 03:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiIFBhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 21:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiIFBhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 21:37:16 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F86440BF3;
        Mon,  5 Sep 2022 18:37:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 123so507511pfy.2;
        Mon, 05 Sep 2022 18:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Rliz2J/fL/mT/nveVEiYF2XOZEPNoVbCQ7gKvs6TmIk=;
        b=dyZxo/QNxSEmfklK5GtIfepHhpi/gcIrEQ/36n0Xh43mPKhLod+8VsIZDA/600z5br
         CegJjhn4YMetXny/afIO+CT8u4rOROGbhISNUME6+ve55EOx/bfe/wnFcymzDWGZIgiV
         6410z3Nkmdik728SN0AoVP/B1RWscTOUCDY3Dh+M22sV8brD2Wgo/vNE3ttSlWJkQDNi
         1z/k+a+StVXzGtgBpSb8z6LmTDtgPYSz8X7Cu7VUXTydOwh/s6eTIAF2DXLMkeY8gIgE
         p6VFbzLH6F4YXYwUi1PNnvb3KQAzFzP1izcqFmHqjSHmRH6Lf/pmvxe8P8YcWb7sORd/
         R9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Rliz2J/fL/mT/nveVEiYF2XOZEPNoVbCQ7gKvs6TmIk=;
        b=0GEFIE+QjrCZ1o3uTOUAYCH0TO6SDibx+DMZBlBurtiVHEIbUJgJl+EZ+eomZxLMov
         +/Kme2CSwV5E7SsB0Ud8DJt/heViZGSp7gP+kYwQb1xt59PnFKZCt1R8iLtib63xfbhh
         WHNDuBz9WJ/taezu/Bay+V0tnbRRLEckxNln7rp7FhUdfbLzfbMMO5whm9jxxc9WSGeK
         Orz1qolPNZDAypg9hPmWUhlP6eyyNprj6YULYnF5/BkbY1godp6ZmQnZdk63K83KtDKM
         2PmIgqlPU1MAL4CDFG9CWbhr8T8UAiVc+dUNRzCm6SNpqTTpgA9GlNu0e90XYVtPfJjU
         N5mw==
X-Gm-Message-State: ACgBeo2eFezimX4Oypd62HUYvW9I7gASn4WL5gA0ugr83GcghNoCsiKh
        W3IK0QziKOkyQlJxA+M/0kk=
X-Google-Smtp-Source: AA6agR6GiPB6m9Uu6wCaPkJluTD1w4fYadPNmDx1bmbbFooklisV9LCCT66FaFzn48+loAp3mYDmdg==
X-Received: by 2002:a63:da49:0:b0:434:459:307e with SMTP id l9-20020a63da49000000b004340459307emr12360634pgj.105.1662428225949;
        Mon, 05 Sep 2022 18:37:05 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001769ee307d8sm332884pln.59.2022.09.05.18.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 18:37:05 -0700 (PDT)
Message-ID: <0131b046-a891-2fae-d2a5-6510455c3449@gmail.com>
Date:   Tue, 6 Sep 2022 08:37:00 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] drm/doc: Custom Kconfig for KUnit is no longer needed
Content-Language: en-US
To:     =?UTF-8?Q?Micha=c5=82_Winiarski?= <michal.winiarski@intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        David Gow <davidgow@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
References: <20220905184711.391022-1-michal.winiarski@intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220905184711.391022-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/22 01:47, Michał Winiarski wrote:
> References: commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")

Use Fixes: tag for bugfix patches instead.

-- 
An old man doll... just what I always wanted! - Clara
