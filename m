Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B305036AF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 15:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiDPNC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 09:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiDPNCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 09:02:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552DE3FBC2;
        Sat, 16 Apr 2022 06:00:19 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso9172088wml.1;
        Sat, 16 Apr 2022 06:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=XHVUz1b0D0ZF/noy7ANM+++7WGGRFc9oyw89kqgSdjE=;
        b=pahgvwHqu3mBCsoZTQUS0VrZeezjhxSrULviFF4Z6DP/WkzUOnWNVRxqVi49Wc/F5p
         n7aC1tvuXpoca3MQXAjK3yl29Y7zOoqTT8FZ+tdJvdedJiVqgeJ1fUcJtvnrSav3DXXn
         cMYZWSr5tCMYvbvI04uvOjYVBNfkToIX3Y35A7e0h01yRwjoygL4Kt5ZSkF6vWkDJtqq
         a/2ak1+iF10XYZXOlE+E7GMPc1nvxtWJ1nz43JAcpSrqerTOlEr1tV2wFJJddaWLHNX2
         PpAHmCs1sXGDYJsZki7EJGSir4SqZHeMm5q76Ck/Bg5ZmggfB98v/nMXSpnKaaGF/uET
         R+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XHVUz1b0D0ZF/noy7ANM+++7WGGRFc9oyw89kqgSdjE=;
        b=fLvoCnWI92GSaVsxJ/U//qhymPZQ2Z9U3MzIDZiZONbzSIxVj8EKERJ1iGo0/MjXo+
         b8zwJAfVcZi9fLvzomIZZdWa4Yo50v1VnWVcqpeGplYlV2sSR/YTHv3RhaKeCiLws/FV
         3TohQBZWJWVfqjgihdH9DHEa4wcijWd0Hoj7gILxseVaUi/05tXubSKHN1jgR51LvBbM
         daMZlTlBBkMYslfNTrmsTQuXdE2LyVXdVQm5KgtrpeJFS7QHWK7D+m14GF2KTJKpd7hO
         ZijwovUld7GpasOdmZ69KrIbl1OjyNs1kfLZmlh+KXQNeNhv6XIEvxMYHkbOPQu1tRXw
         wBKA==
X-Gm-Message-State: AOAM531iTFS7FSABAucBlHvuq/5hBxGboeWbqleaw7OROXcIecHuUUn0
        s7JEpESVLl0eaKt4qjAcxIc=
X-Google-Smtp-Source: ABdhPJx16Vt/FPuRxbRMNnFY/Wy6fGUSb4KuPuwz+aSvi4c9sLSD/2bBrV6IuJzISUMX0bRgFRijXw==
X-Received: by 2002:a1c:f70e:0:b0:38c:6ca9:2f8f with SMTP id v14-20020a1cf70e000000b0038c6ca92f8fmr3153245wmh.162.1650114017834;
        Sat, 16 Apr 2022 06:00:17 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:dd4a:a17a:5566:43bc? ([2a02:908:1252:fb60:dd4a:a17a:5566:43bc])
        by smtp.gmail.com with ESMTPSA id a11-20020a056000188b00b00204109f7826sm6981250wri.28.2022.04.16.06.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Apr 2022 06:00:17 -0700 (PDT)
Message-ID: <0d065fd6-3fa5-c9cb-3248-6f29b2bdcb71@gmail.com>
Date:   Sat, 16 Apr 2022 15:00:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/2] Update AMDGPU glossary and MAINTAINERS
Content-Language: en-US
To:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrealmeid@riseup.net
References: <20220415195027.305019-1-tales.aparecida@gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220415195027.305019-1-tales.aparecida@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.04.22 um 21:50 schrieb Tales Lelo da Aparecida:
> I was handling the request from [0] and then I noticed that some AMD
> developers were missing from get_maintainers output due to the lack of a
> reference to their documentation in the MAINTAINERS file.

Acked-by: Christian König <christian.koenig@amd.com>

>
> [0] https://gitlab.freedesktop.org/drm/amd/-/issues/1939#note_1309737
>
> Tales Lelo da Aparecida (2):
>    Documentation/gpu: Add entries to amdgpu glossary
>    MAINTAINERS: add docs entry to AMDGPU
>
>   Documentation/gpu/amdgpu/amdgpu-glossary.rst | 13 +++++++++++++
>   MAINTAINERS                                  |  1 +
>   2 files changed, 14 insertions(+)
>

