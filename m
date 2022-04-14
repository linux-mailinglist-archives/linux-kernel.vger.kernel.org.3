Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5912E501780
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348440AbiDNPkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353130AbiDNOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:35:15 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8D8D080F;
        Thu, 14 Apr 2022 07:27:45 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w127so5529121oig.10;
        Thu, 14 Apr 2022 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ghx9VRtlfgShp3TcMoFRap3M442/0OWo2bPqHQs6UAE=;
        b=gHWaANPMU9CipERwlcyUeT+voADP3ARYJXLBWyHcz6zT8ljGHeCJfPZn/VVTKIFQUR
         cegqVuD1psvzt4afE+eIfZQzuqyBI5Cpyj3tQ7Lu565hJyi7weAFQB74/0ULE2Kkjwd9
         X6l+ocX1Pg2ao01crl1lN8vig4dvxveZYVQ7pB1uVi71L2YGeQtYMByZ3NiC8q75NBfU
         Lp/VJ6aeqbQYw51fr5WBTX5pE1GVi9AWLuHDhn4nM++C1tvhklX1sWogNz+mm/D+7v4T
         cZMrrojPmFLbFcHOn1FV2WQ+CNjxnHHl4Vsw7P9Pg2k/OMGawnAeR/AolMbSl5OiGZNA
         C6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ghx9VRtlfgShp3TcMoFRap3M442/0OWo2bPqHQs6UAE=;
        b=rQASV5XyFHUHsA4wqQupIR9c1MAqcDPuLLXQ5cExJmKnwUxQ78QqXSDX2HLvmdHgYD
         HpQ/Gp1WJIyIFNTGDgWH6rhZjuCbol/p4YdUmxvyqv8AiPeo1ru58YWD/za2kjCQhlhA
         T/IM7pA/WMbVz7cscUtN0u9Vs74Q9eWKJefFnXYfC3QIv+e15kHitzghrxH5oaova2xa
         wuo34EVgzG4vPSRAPZ4ExmIEkiz+VnRQOUmbLVzgQeaEN1VcqOgwqmBZ9yzh3+TUQPrM
         xjw9eMHNBsRu9Ppe+O1OrYrcbGk7LqUJMjHVhh5SRj99jQagT19u2xiOiwn5+Di6ULpf
         8ziA==
X-Gm-Message-State: AOAM533Rm795wS8e1DrAuE68g19/LNBHyTPoNgsFx01524bDMpZ1ATr3
        An6QCIKnNCMsvQGlbEZ8hb49aLnEc2MIPLX9mKXX4OaN
X-Google-Smtp-Source: ABdhPJzLmH7U04QAV2zWy6SAp0AkYkEt8E0dLfWvxiVGBthB4cupY68g+0MdWmbJpLAEJLLTXUUQanjh3xC913ZTe5k=
X-Received: by 2002:a05:6808:1486:b0:2f9:e821:51d9 with SMTP id
 e6-20020a056808148600b002f9e82151d9mr1484330oiw.253.1649946464573; Thu, 14
 Apr 2022 07:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <BN9PR12MB5145ECB75120FF9AC1AA4CFB8DEC9@BN9PR12MB5145.namprd12.prod.outlook.com>
 <CADnq5_OjPwzYtW99a-L6OrHz-oH0MqSNi+Me4T-x1vY8zEXLcQ@mail.gmail.com>
 <BN9PR12MB5145D81F9978B656E9BB67C78DEF9@BN9PR12MB5145.namprd12.prod.outlook.com>
 <a1203367-834f-a4d0-3478-9e16787a3b8b@amd.com>
In-Reply-To: <a1203367-834f-a4d0-3478-9e16787a3b8b@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Apr 2022 10:27:33 -0400
Message-ID: <CADnq5_MTQSZs7R+DTQWRyGqqQcff6mCb43s_7jtE8w00k+YxQg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To:     Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>,
        "Kotarac, Pavle" <Pavle.Kotarac@amd.com>,
        "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
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

On Thu, Apr 14, 2022 at 10:23 AM Rodrigo Siqueira Jordao
<rjordrigo@amd.com> wrote:
>
> Hi Alex,
>
> Do we need to apply David's patch [1] to drm-misc-next? If so, I can
> merge it there. Also, I noticed that drm-misc-next changed the dp header
> path; in that way, I had to change the original patch a little bit.
>
> 1. https://patchwork.freedesktop.org/patch/480331/?series=102035&rev=1
>

Ideally it would have gone through drm-misc, but since we are the only
ones using it at this point, I think it's ok to take through my tree.
I'll make a note about the path change when I send the PR.

Alex

> Best Regards,
> Siqueira
>
> On 2022-04-14 10:08, Zhang, Dingchen (David) wrote:
> > [AMD Official Use Only]
> >
> >
> > Thanks for clarifying, Alex.
> > ------------------------------------------------------------------------
> > *From:* Alex Deucher <alexdeucher@gmail.com>
> > *Sent:* Wednesday, April 13, 2022 10:18 AM
> > *To:* Zhang, Dingchen (David) <Dingchen.Zhang@amd.com>
> > *Cc:* Stephen Rothwell <sfr@canb.auug.org.au>; Kotarac, Pavle
> > <Pavle.Kotarac@amd.com>; Chung, ChiaHsuan (Tom)
> > <ChiaHsuan.Chung@amd.com>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; Linux Next Mailing List
> > <linux-next@vger.kernel.org>
> > *Subject:* Re: linux-next: build failure after merge of the amdgpu tree
> > The patch should be there now.
> >
> > Alex
> >
> > On Wed, Apr 13, 2022 at 10:09 AM Zhang, Dingchen (David)
> > <Dingchen.Zhang@amd.com> wrote:
> >>
> >> [AMD Official Use Only]
> >>
> >>
> >> hi Stephen,
> >>
> >> Could you please check if below patch (which has been upstreamed) is in your Linux code base?
> >>
> >> ~~~~
> >> eb2bb029bacf David Zhang         12 days ago    drm: add PSR2 support and capability definition as per eDP 1.5
> >> ~~~~~
> >>
> >> Thanks
> >> David
> >> ________________________________ From: Stephen Rothwell
> >> Sent: Tuesday, April 12, 2022 10:32 PM
> >> To: Alex Deucher
> >> Cc: Zhang, Dingchen (David); Kotarac, Pavle; Chung, ChiaHsuan (Tom); Linux Kernel Mailing List; Linux Next Mailing List
> >> Subject: linux-next: build failure after merge of the amdgpu tree
> >>
> >> Hi all,
> >>
> >> After merging the amdgpu tree, today's linux-next build (x86_64
> >> allmodconfig) failed like this:
> >>
> >> drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c: In function 'is_psr_su_specific_panel':
> >> drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:798:61: error: 'DP_PSR2_WITH_Y_COORD_ET_SUPPORTED' undeclared (first use in this function); did you mean 'DP_PSR2_WITH_Y_COORD_IS_SUPPORTED'?
> >>   798 |                 if (link->dpcd_caps.psr_info.psr_version >= DP_PSR2_WITH_Y_COORD_ET_SUPPORTED)
> >>       |                                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>       |                                                             DP_PSR2_WITH_Y_COORD_IS_SUPPORTED
> >> drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:798:61: note: each undeclared identifier is reported only once for each function it appears in
> >>
> >> Caused by commit
> >>
> >>   901029aa0017 ("drm/amd/display: implement shared PSR-SU sink validation helper")
> >>
> >> Please start including an x86_64 allmodconfig build in your local testing.
> >>
> >> I have used the amdgpu tree from next-20220412 for today.
> >>
> >> --
> >> Cheers,
> >> Stephen Rothwell
>
