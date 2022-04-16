Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E795037AA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 18:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiDPRB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 13:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiDPRB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 13:01:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5DE4C792;
        Sat, 16 Apr 2022 09:58:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so14025899pjb.4;
        Sat, 16 Apr 2022 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cMNohu7KsNouJa1UFb+K8nUtLwDTzTI/72r42ygiURM=;
        b=Y8b4kXsAn89yhrVM/0XlFxsROV32VWFrmhPy+SPB4NP+2xDJXqt4R86dGjkRoe9U8m
         MdmH0mXzpvpipacGFAnrRsCf4QgpcP1cYnBuT9lag8JDJjsD2dlukS2RXMXDJLzuySXQ
         mB37X0txV/IsQArkVEBpXZ/0ZCXwbyNt5ahBpKOjKGBQcmBF0GAPJiQ2WBRzPwvTGoX3
         LU7TsQQj2bxorSO/0vkvdY5yB2nfZSfM1Oq24eIKtsO3W8wn3bo3jY8DmN6YpSaJuQeA
         yExE3JgRYfb29zlkViY9mCgeL769ZMdiU6+g9Y04NXlt+LY5ISCZt5cv1VWww/NctZFz
         rWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cMNohu7KsNouJa1UFb+K8nUtLwDTzTI/72r42ygiURM=;
        b=qzHBoTfEnZeSj1vNLcn+Zz+Hm0ZvnjZK8q3VHEOEHd+iLfWZYJE+SFnXC5vHE/ShQa
         +c+xYmdGnVWY5cUOY36fqtfiZqsyS3puvfpwOZ+pHap3qlvmobs1MaF/yRC9nLlZ4wfK
         0RQPXpOu0EBAcyg85EJnxvgUZxD4rL8MWE2Oz8yjg8vMNGtlG6QpdhOaTb61CStfpQkZ
         yOo+j46bSRmbQTWZt0ic3mI4krKng2ra+O/bSN7LAwKMG8a8D6AVYi0dyx6U0nDfr/Z9
         toQSwL9PKkcICJMR2+fqoiijMX7YogfMfxmT0qdJ5hqp7kwaMdKAj8vN8yeehmVXuAkj
         oCjw==
X-Gm-Message-State: AOAM533diBsvSkFSxDSwkIcfUL89JO/3S0VX6T+nucNQMR6BcAthIAVb
        x6gybP6JBK0aph2Z0Kg+Fj1YHbLosIGdWYEeycg=
X-Google-Smtp-Source: ABdhPJy7YB+IwrdQor5NjHuIZEoM/n6B3J0+rbXLoq4HAbBBdffaXFkJHbDhXcjRlqLQV7zffljEd7TTuM21G4CDAS8=
X-Received: by 2002:a17:903:1246:b0:155:c376:e5a0 with SMTP id
 u6-20020a170903124600b00155c376e5a0mr3891686plh.167.1650128332785; Sat, 16
 Apr 2022 09:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220415195027.305019-1-tales.aparecida@gmail.com>
 <20220415195027.305019-3-tales.aparecida@gmail.com> <4f4c8441-a144-6c2d-0f8b-b598905c2f3d@gmail.com>
In-Reply-To: <4f4c8441-a144-6c2d-0f8b-b598905c2f3d@gmail.com>
From:   Tales <tales.aparecida@gmail.com>
Date:   Sat, 16 Apr 2022 13:58:12 -0300
Message-ID: <CAGVoLp75WEWxk2uTz6AtomRo+5kNexqM-+aLHQe8pSp66PcHzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: add docs entry to AMDGPU
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas Sanjaya,

Em s=C3=A1b., 16 de abr. de 2022 =C3=A0s 02:47, Bagas Sanjaya
<bagasdotme@gmail.com> escreveu:
> On 4/16/22 02:50, Tales Lelo da Aparecida wrote:
> > To make sure maintainers of amdgpu drivers are aware of any changes
> >  in their documentation, add its entry to MAINTAINERS.
> >
>
> Did you mean the Documentation/gpu/amdgpu/ is maintained by dri-devel?

`Documentation/gpu/amdgpu/` should be maintained by "RADEON and AMDGPU
DRM DRIVERS" developers, which are part of the dri-devel community.

Kind regards
