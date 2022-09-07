Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F695B07B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiIGO5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiIGO4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:56:54 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC6B9F76D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:56:48 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso10456916otv.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=R18/KkvI0bwN1Yb6uOYkzfgE4nW++3c9UPmBBYxx7CU=;
        b=QB8Ku1JNOE1BUAopdNjlcDp1puobGOzHlyUhKR6CWlFP15tejy6UAgQs1GfZwKadDs
         a0gyp3nB4XZrd9rchWz256RHIKDl9/5krwM7UNHlfD50LKybxsC9CnfE4pZPYmK+4Ts5
         t4Z9wLe8CfXRL0bSpxGpdhk2xl6jIu6MqoUrmLSWyu0NIl6qvHzY/sAigyQ4uP+A/tpi
         YRTM4RATMRutuA03smGNmntwEwWKGWyKBcL3ggj9qxpTDBXnTQs+yn3qViuHbNXWvDLV
         zE2vGQlvDUFm9ZR38UdkiSpxEla5mWnaJMNzf2L6bYPonYsiJkE2lFOtc+qR1Gr7Lcup
         w2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=R18/KkvI0bwN1Yb6uOYkzfgE4nW++3c9UPmBBYxx7CU=;
        b=DwuxRHZdv6jWS4R9GZliH36I35kQ/9xcZORrEVuTwmWTe/OYa59/ELkJ9cMd0DMLY0
         UWe4pzLfa+B6H1i70Y9OWgN+5nTrv+Md3AfAOAzMmQb/qMHhcQJYo3kG0bUrgdoxlh21
         PD/GuUsqnWiRoQRWRo2TDDJcsCsghMzyBw/iDG3PjN2dz4cmY94xAjvyv1oJtB9UFqvy
         20t103xQNxfQFle3xw5cRw5HWtEsB/AJmoO+umgtIPpuCS8DWrapevngL8DvYpN8zEau
         fplao9sB6yKJu8GjM+cTjaGVSfh1yp+TyO3ehFAmAZdmThl8IJt5gItYloJxv9Kovld4
         G+TQ==
X-Gm-Message-State: ACgBeo2uVRVRajV5VF3PphQ31KRRDs2hp2xAEMjdwZNz7SUrPFi7Ga4J
        nxCTxOucWki5McqJ2g67H4lmulFNrHVGXgP5kd4=
X-Google-Smtp-Source: AA6agR7IWbHn3lhZ/ot+C85/TxO/QN9z4ndtsTAyaJfaazgJGihOPTdsepxkn6HDUffxyIi1P+btvKVCBiP4iT8yQic=
X-Received: by 2002:a05:6830:54b:b0:636:eecb:1196 with SMTP id
 l11-20020a056830054b00b00636eecb1196mr1623273otb.123.1662562607723; Wed, 07
 Sep 2022 07:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220907112657.25150-1-yuanjilin@cdjrlc.com> <becf299e-9cf0-68bc-da31-1207e4bb71e1@arm.com>
In-Reply-To: <becf299e-9cf0-68bc-da31-1207e4bb71e1@arm.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 7 Sep 2022 10:56:36 -0400
Message-ID: <CADnq5_Ms18MHqyQVZ7UMQUCGGinzWtb5SkLubjSceOgrfJn+Ag@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix repeated words in comments
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>, airlied@linux.ie,
        daniel@ffwll.ch, isabbasso@riseup.net,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Wed, Sep 7, 2022 at 10:50 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-09-07 12:26, Jilin Yuan wrote:
> > Delete the redundant word 'we'.
>
> FWIW, to me it's not redundant because while indeed it is not correct,
> it looks exactly like the kind of typo I might make of "if we", and
> parsing it as *that* does make sense. The sentence you end up with here
> can hardly be considered an improvement since it is still ungrammatical
> nonsense.

Yes, I believe this was supposed to say "if we" rather than "we we".

Alex

>
> Robin.
>
> > Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > index 02cb3a12dd76..6d6cc4637d41 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > @@ -694,7 +694,7 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, struct amdgpu_ib *ib,
> >    * @allocated: allocated a new handle?
> >    *
> >    * Validates the handle and return the found session index or -EINVAL
> > - * we we don't have another free session index.
> > + * we don't have another free session index.
> >    */
> >   static int amdgpu_vce_validate_handle(struct amdgpu_cs_parser *p,
> >                                     uint32_t handle, uint32_t *allocated)
