Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036934E303E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352314AbiCUSvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbiCUSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:51:40 -0400
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411CC657B2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:50:14 -0700 (PDT)
Received: from ylum.localnet (unknown [IPv6:2a01:e0a:3d9:ddd0:37f3:7f74:639b:b0a3])
        (Authenticated sender: domi.dumont@free.fr)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 95819780377;
        Mon, 21 Mar 2022 19:49:56 +0100 (CET)
From:   Dominique Dumont <dod@debian.org>
To:     Eric Valette <eric.valette@free.fr>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Reply-To: dod@debian.org
Cc:     Sasha Levin <sashal@kernel.org>, David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        1005005@bugs.debian.org, Evan Quan <evan.quan@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>
Subject: Re: Regression from 3c196f056666 ("drm/amdgpu: always reset the asic in suspend (v2)") on suspend?
Date:   Mon, 21 Mar 2022 19:49:56 +0100
Message-ID: <3873010.MHq7AAxBmi@ylum>
In-Reply-To: <61c2b2ce-d749-3723-ad27-f40e1c49d967@leemhuis.info>
References: <Ygf7KuWyc0d4HIFu@eldamar.lan> <CADnq5_MWqz7-XhOS4zfuzi3=_nKa72iYaO0BcKNcVDwEvZ+YHw@mail.gmail.com> <61c2b2ce-d749-3723-ad27-f40e1c49d967@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Monday, 21 March 2022 09:57:59 CET Thorsten Leemhuis wrote:
> Dominique/Salvatore/Eric, what's the status of this regression?
> According to the debian bug tracker the problem is solved with 5.16 and
> 5.17, but was 5.15 ever fixed?

I don't think so.

On kernel side, the commit fixing this issue is
e55a3aea418269266d84f426b3bd70794d3389c8 . 

According to the logs of [1] , this commit landed in v5.17-rc3

HTH

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git


