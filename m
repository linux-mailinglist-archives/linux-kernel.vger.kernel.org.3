Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680F74FF8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiDMOVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiDMOVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:21:33 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAA96213C;
        Wed, 13 Apr 2022 07:19:10 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id e11so1719154vso.7;
        Wed, 13 Apr 2022 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xyykOvfztuYgfnUpaCMGYMTkW5j0hQ73NitHRL4edV8=;
        b=UiYmcEKYOKBRvcWHR3GG4EADybSbblJJ9Q4CGeCvMg1X+7K5hdDhNmW2xZKJx0LKQN
         y/0QAlhBENSlTk1C+skjKYeoCRIMqhCku+6iDVMjvpXobnXe8R0XklqN1eZygpoglwCq
         9mYwfDIhKh4CsS5Fee5/e2/OjK7kN7qIO8jD+sVjp0umzsKGcnGqON5AxNUR5xdo3G7x
         EnQB5z1MB02hjofY00BRC5i7vaQLioT/hGzDKvSpCSwnYdzGVGRjzjRgrFFvGnbYDA3Z
         BBDb55g0Qbx2g8kF4UvYDVsFf3hgCrEeFbeJ2Tla5t9I/Z3xRjyoQYmVu/zbWPUYP+dd
         jn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xyykOvfztuYgfnUpaCMGYMTkW5j0hQ73NitHRL4edV8=;
        b=m/dEz7yBphswGhpCBCPJh4563ztFx9nfTJGcCQVVMD2x7Bz95jeF0/u1qFFs+ZWKqn
         FLhgYvTJlFdNkdR3FMCYY+TIEpD5ims6LCdKPLC9hs79AVL7FS0pkMAHRpBgV3iQddaH
         wUPBOjtckrz1ewu0fD0T4jvQDsVurdwHDVs1HeJqgVLNOREn5wlCxK7jS3KBf0Vv0pL4
         DRj5YUZ1qQ2TzXEhw7B1j7x1DYrktnVhVWf2nRro5suEyVOLdKwVfyFRbLtCMfVcWQy9
         dOaculvyLwQAPxljQvjlseTCxt2hq94PvGA5saooXIwmNvIdVtdK94Aa4MtI1e42TyRT
         nVyA==
X-Gm-Message-State: AOAM531Fc88tp1MqFWagfukyCpA6sa3Mj90l1I6mHrvYqoV2W96oPg3p
        io7VJ7n7DgfJFOw526qBVeqBjW/2ZQNlmI43/XbBqV0J
X-Google-Smtp-Source: ABdhPJxZZ+1DL3K8zLu6qD3AB9+JTzypyOIzi06xkzhJTwCGpOWfQGFuYA8pPD5fJd/kSD6ru7UwPmgWfby0GzNPLxA=
X-Received: by 2002:a67:2444:0:b0:32a:1ad3:b26c with SMTP id
 k65-20020a672444000000b0032a1ad3b26cmr1137165vsk.29.1649859549818; Wed, 13
 Apr 2022 07:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <BN9PR12MB5145ECB75120FF9AC1AA4CFB8DEC9@BN9PR12MB5145.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5145ECB75120FF9AC1AA4CFB8DEC9@BN9PR12MB5145.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 13 Apr 2022 10:18:57 -0400
Message-ID: <CADnq5_OjPwzYtW99a-L6OrHz-oH0MqSNi+Me4T-x1vY8zEXLcQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To:     "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Kotarac, Pavle" <Pavle.Kotarac@amd.com>,
        "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

The patch should be there now.

Alex

On Wed, Apr 13, 2022 at 10:09 AM Zhang, Dingchen (David)
<Dingchen.Zhang@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
> hi Stephen,
>
> Could you please check if below patch (which has been upstreamed) is in your Linux code base?
>
> ~~~~
> eb2bb029bacf David Zhang         12 days ago    drm: add PSR2 support and capability definition as per eDP 1.5
> ~~~~~
>
> Thanks
> David
> ________________________________ From: Stephen Rothwell
> Sent: Tuesday, April 12, 2022 10:32 PM
> To: Alex Deucher
> Cc: Zhang, Dingchen (David); Kotarac, Pavle; Chung, ChiaHsuan (Tom); Linux Kernel Mailing List; Linux Next Mailing List
> Subject: linux-next: build failure after merge of the amdgpu tree
>
> Hi all,
>
> After merging the amdgpu tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c: In function 'is_psr_su_specific_panel':
> drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:798:61: error: 'DP_PSR2_WITH_Y_COORD_ET_SUPPORTED' undeclared (first use in this function); did you mean 'DP_PSR2_WITH_Y_COORD_IS_SUPPORTED'?
>   798 |                 if (link->dpcd_caps.psr_info.psr_version >= DP_PSR2_WITH_Y_COORD_ET_SUPPORTED)
>       |                                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                                             DP_PSR2_WITH_Y_COORD_IS_SUPPORTED
> drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:798:61: note: each undeclared identifier is reported only once for each function it appears in
>
> Caused by commit
>
>   901029aa0017 ("drm/amd/display: implement shared PSR-SU sink validation helper")
>
> Please start including an x86_64 allmodconfig build in your local testing.
>
> I have used the amdgpu tree from next-20220412 for today.
>
> --
> Cheers,
> Stephen Rothwell
