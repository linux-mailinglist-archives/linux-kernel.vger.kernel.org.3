Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338D9518441
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiECM3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbiECM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:29:39 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C452937AAD
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 05:26:06 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f83983782fso177629077b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/kdLTIP5KWv/w0AGbW53dgxr50ylE5lpuqrP/XFE1k0=;
        b=sZ1hgtTI7fxvaZ0k0uOV0GVYFCdwj7DY7WyRTiIERlNBLwVMA0aHkM9eKI80hA90uD
         TXVIUXOGNCaChIHkrDbRhvfjvJ0FLlxpCu/9Fcn4eqBj6GWfHbSOtkkgrbdVdckmuHJO
         QMdo8MDD6ZfD78z6MNJYaz4rHtJumcdPKAyidpPq6G6BV//fDOirycvGWFrXm7CGonHd
         jdt8JKOKbEldXBTe+9cfzR5GgqTyKwjsF2/aeOcX/05Xhs9WsVZW9XRZwxak4N+E2GlS
         VCEGLtHKm24ij5PYMb7kqfkjC9t8ITlg/FFNoZl2N4ZKuZ9lIWVaA4+F+58PlU6+2wEs
         L6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/kdLTIP5KWv/w0AGbW53dgxr50ylE5lpuqrP/XFE1k0=;
        b=HlTPdvHftIq0XAzHAac8sSaIJsjsB1bm2nIlMZCD68yfzerCofgAyYp2mj4n7/GAWw
         bfXypdclyct7KKO5QuTHHwBxvLNDp5DXJWuHk1Pc+s3CCh3cqJdYAQ0trzWk3L2834tw
         tuNSBCTcHoOglyAkN66FZnxORUd9vuYI35o9GnmRjUNZLX1x20CjcqO9lM4sUMVwknCV
         vSA0OLnE6UPlwQDKkXOxmIQxsQ03SbdnJdu3fLikXDPKfp2QeC8Y55nBn7QY0BVzB9pb
         X6UH2SSIv5u+CTdI08TBVAnYFQLXtf854bBn7hKkzKVuGvKiLqtrLVPfD1oUpLZ8stPD
         UgnA==
X-Gm-Message-State: AOAM531/Ur+tV25KYcytoqte6XolrdhyN2keECAESU5EYMNtuTe0jTKj
        Z+cKuRVAfWnSDU+scdprjs9/X+gOGp97ZRV1s3MjsA==
X-Google-Smtp-Source: ABdhPJy748BeoJGvdERlz6RifdnU94P5oaWHAfAf55iJWUIXN/sTYUf3fG9793RzhGeYw55AQSLOvtiy7IjggXp0lMY=
X-Received: by 2002:a0d:e5c6:0:b0:2f8:c866:7af9 with SMTP id
 o189-20020a0de5c6000000b002f8c8667af9mr15130119ywe.268.1651580765968; Tue, 03
 May 2022 05:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220412215000.897344-1-richard.gong@amd.com> <d4ba3998-34aa-86d2-bde9-bc6ae9d8d08d@molgen.mpg.de>
 <CADnq5_MgvcGPWf2gYn_3qCr+Gq1P39tvv-W-o8NhivvMpMwUBA@mail.gmail.com>
 <91e916e3-d793-b814-6cbf-abee0667f5f8@molgen.mpg.de> <94fd858d-1792-9c05-b5c6-1b028427687d@amd.com>
 <efc1dfd1-2b54-aee5-1497-4b800a468141@molgen.mpg.de> <237da02b-0ed8-6b1c-3eaf-5574aab4f13f@amd.com>
 <294555b4-2d1b-270f-6682-3a17e9df133c@molgen.mpg.de> <5adfe067-dc00-6567-e218-c5c68670cf5b@amd.com>
 <543a9e76-ca90-984b-b155-a0647cdeacff@molgen.mpg.de>
In-Reply-To: <543a9e76-ca90-984b-b155-a0647cdeacff@molgen.mpg.de>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Tue, 3 May 2022 13:25:53 +0100
Message-ID: <CAPj87rOERk-kNa6n-UdjQsDKXP9zzm8=an=FHcM+33yebW6ECw@mail.gmail.com>
Subject: Re: [PATCHv4] drm/amdgpu: disable ASPM on Intel Alder Lake based systems
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Richard Gong <richard.gong@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Xinhui Pan <xinhui.pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Alexander Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2022 at 08:08, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> Am 26.04.22 um 15:53 schrieb Gong, Richard:
> > I think so. We captured dmesg log.
>
> Then the (whole) system did *not* freeze, if you could still log in
> (maybe over network) and execute `dmesg`. Please also paste the
> amdgpu(?) error logs in the commit message.
>
> > As mentioned early we need support from Intel on how to get ASPM working
> > for VI generation on Intel Alder Lake, but we don't know where things
> > currently stand.
>
> Who is working on this, and knows?

This has gone beyond the point of a reasonable request. The amount of
detail you're demanding is completely unnecessary.
