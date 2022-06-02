Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAECA53BBC8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbiFBPoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbiFBPoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:44:21 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE932A7ABA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 08:44:21 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-f2cbceefb8so7183039fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P4l1FsyAk1RlV/u3mgwVdI7BUjKPUw4KOmo6ae9MZqQ=;
        b=XTpUyxy/cMnRWRwyHzKa/U5L3VPm0PxvRYr4BcEHyeTboJSw7UN1o5oG2iLyqZ5aaB
         fllfXZmsdhCcWZzORSfvbkRJiwK+MyaIBAh5SALO/97D/JjRNi/es1Yki0bLH9oarz0M
         stouJMkGwu8gnNWF14qvmSi3JJbUgd51iTK4V5XifHkCx26douZN4TLtfzHkK3Oe8n57
         JoYntRGky4DYl/KBqf1qltGD4YyrOfx8AhXYgVNn9KiIzc6K12WpXySu9ffml6JFX1pC
         e3Es2rfPW1CtqDexu3BamFq9JzF9MQsZHyEwRi4vXtmbKsiED3hNGu7NUMVFOyQIfMh4
         NyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P4l1FsyAk1RlV/u3mgwVdI7BUjKPUw4KOmo6ae9MZqQ=;
        b=Y4/SzcxObYJ0lo/PjXhpU8yp1vI9p0Quy07L6W2PgJ8hdoC49j8/jva6+Y25KwAGSm
         HA3QQugiWwXnzuHT0+XkFqY/C7786ck8nUxS+aBau2chUKzhES6XJ9MZWgzic1xK8wQZ
         C4M8LNy2KZmRNMHjTOcwdFQ5eMqk0chMsZmJBwISJX7TpwcWSu8qnJl3j3df2AuEzgM7
         EuF/nqzyNmpuKff4PBSBJBRcruVgm+C2bEobTn+fdexWLoDP1+qXC4FaMypqyvsGoti5
         jOU50Ti6Yt/ome1XpE7aMermHEFzbRk/gO0fzCu3fP9/oSxIACeDULwStVYVkZRq3/nW
         pUzA==
X-Gm-Message-State: AOAM531r+1yS9mcQPDFE8hvuppHjnJqGH+HbbsXvT9OCOtCRYnrVaQiG
        uLg99vko9xrzhUa+ydlXh46qYeKPRUCYc+88+KI=
X-Google-Smtp-Source: ABdhPJwBWNuwkjfuM/Dk3xLMjuvRlvgqBJO3Cukj3tw+uC8b87N4KCE8kjFaJ2nPf9/5YrzxedQa0BEj3mzUoq9NucE=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr3136696oap.253.1654184660350; Thu, 02
 Jun 2022 08:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <202205271546.oV14N2r8-lkp@intel.com> <CADnq5_NOkqRsoqELkLayNU+xArXd-4RO=_banvJpXHtSW4-YdA@mail.gmail.com>
 <CAD=4a=WRbp8w4DA2c6hE7W5A2-woRyHLvtC-GPitFwQireCeNw@mail.gmail.com>
 <20220602115046.GH2168@kadam> <CADnq5_PZBV0wAnNSLSdTc_8acaK3F6ZKDpcgwktmNaR9DKxG9Q@mail.gmail.com>
 <20220602153326.GI2168@kadam>
In-Reply-To: <20220602153326.GI2168@kadam>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 2 Jun 2022 11:44:09 -0400
Message-ID: <CADnq5_PucdB0D0o0oGUbh+CziYgNqRX+mReTpNDO-ZbsLUEFGg@mail.gmail.com>
Subject: Re: [kbuild] drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433
 amdgpu_discovery_get_vcn_info() error: buffer overflow 'adev->vcn.vcn_codec_disable_mask'
 2 <= 3
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        kbuild@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
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

On Thu, Jun 2, 2022 at 11:33 AM Dan Carpenter <dan.carpenter@oracle.com> wr=
ote:
>
> On Thu, Jun 02, 2022 at 10:24:58AM -0400, Alex Deucher wrote:
> > On Thu, Jun 2, 2022 at 7:51 AM Dan Carpenter <dan.carpenter@oracle.com>=
 wrote:
> > >
> > > On Thu, Jun 02, 2022 at 08:26:03AM +0200, Ernst Sj=C3=B6strand wrote:
> > > > Dan: I also ran Smatch which resulted in the following discussion:
> > > >
> > > > https://lists.freedesktop.org/archives/amd-gfx/2022-May/079228.html
> > >
> > > Since the bounds check is dead code which does not make sense and is =
not
> > > required, another idea would be to just delete it.
> >
> > It wouldn't be dead code if AMDGPU_MAX_VCN_INSTANCES ever increased.
>
> Or we could add a comment to the code I suppose.
>
>         /* Impossible in 2022 but this check might sense in the future */

Good idea.  I'll send out a patch.

Thanks,

Alex

>
> regards,
> dan carpenter
>
