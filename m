Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D030C4B8594
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiBPKXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:23:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiBPKXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:23:43 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79216206997
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:23:30 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b11so2884409lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgTdt/5Tmin+RrpPEv4f+OmO2PXeyvBfP6PGIN1pw00=;
        b=ZgyZzKrmMhsvCg4VMfuF0GDqGdzdbOAx4uk46L+7NyKSrkuFJ6DR2tWzprIB09t90F
         pdEfMTaqxgUhrDo328Woxo49aijQt/PH+5GrkfdtSWRvyq4re5bzLedlwmNSTfT3+kn8
         Fh2guaKG2mWyijqIWhMdIhxXS1MGbaVDkGR1LWbDV24YlHrSA0CsW/PNLugG+ufy821z
         QnY+PS1GQuurqd7ygmJgwJZvUwPTLfp5gfntzw00S2My1DCDpGjeRNJeADYNm/a4KfcS
         zikp3p85IJaJaTZz6K1bUbQMmH7pNCsZYSCy6VpzOAirR9tSzCC+0jVLrKm95rP1yGl4
         VhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgTdt/5Tmin+RrpPEv4f+OmO2PXeyvBfP6PGIN1pw00=;
        b=wLK1bdPXpx5OOo4B7YoiXtOPf92mvRUKJQqdP4xbFy57EBm3aUMnLs+LGDPzHGHd7q
         hLUsswLo42Kgb2+VGtFsst4+4em6jQ8zxe46XJXQ0ND2497/uZLCEMKDrIE/TZOPIF4Q
         UCPNiZACgk9FD1K7p4zjZAo7tN6xBglWbHaO7839JXB9qLaMqJhmufxgm+tPVENUaRsx
         njj6xJDxaqAvYQEzQUu5X+1cjUi/0O8P0K4RDaZmgDu4cOZXaZ18ZqrpP6zdHJvW8cwr
         U73dV0Pn3+biTpSlNz2cdGBcl2GAAmCDA6sV/89Y1DAMgIHMzOzl52PXYW1K13LoRxA5
         dI1Q==
X-Gm-Message-State: AOAM533Yvq4GvwQWDXallLj9Xyh7m0cabtRLAPS8dxLZspwyITSQM8te
        gfspIc80yMJH5OdJIZzyN9UM67s74wBobrIKd2Xqxw==
X-Google-Smtp-Source: ABdhPJwgnpPtxD5K4HV7oO6sxOcMCiJwgU1TdTweqVp1m3xG6mpjoIJGR/sO87EROFqrpGyf758QznqJmtiqosajuuk=
X-Received: by 2002:a05:6512:388d:b0:443:6066:2c8d with SMTP id
 n13-20020a056512388d00b0044360662c8dmr1521088lft.184.1645007008626; Wed, 16
 Feb 2022 02:23:28 -0800 (PST)
MIME-Version: 1.0
References: <20220121014039.1693208-1-kai.heng.feng@canonical.com>
 <20220125055010.1866563-1-kai.heng.feng@canonical.com> <CAPDyKFrtD28NKTyUAR-6Rt4PwYvkOuWcRhxZZWVAq4KcTNG7QQ@mail.gmail.com>
 <CAAd53p5LxZh6-jZj274g6+PeDpAPWSiwRWXL93dgOg3xpqvu8g@mail.gmail.com>
In-Reply-To: <CAAd53p5LxZh6-jZj274g6+PeDpAPWSiwRWXL93dgOg3xpqvu8g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Feb 2022 11:22:52 +0100
Message-ID: <CAPDyKFpx_H8b1KJ_yZ_3My_nxcC2e9k+wROH7hgfK3LbchQ8iQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mmc: rtsx: Use pm_runtime_{get,put}() to handle
 runtime PM
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>,
        Thomas Hebb <tommyhebb@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 at 05:21, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> On Fri, Feb 4, 2022 at 8:28 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 25 Jan 2022 at 06:50, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > >
> > > Commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM") doesn't
> > > use pm_runtime_{get,put}() helpers when it should, so the RPM refcount
> > > keeps at zero, hence its parent driver, rtsx_pci, has to do lots of
> > > weird tricks to keep it from runtime suspending.
> > >
> > > So use those helpers at right places to properly manage runtime PM.
> > >
> > > Fixes: 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
> > > Cc: Ricky WU <ricky_wu@realtek.com>
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >
> > The runtime PM reference counting for the mmc host device is managed
> > by the mmc core. Have a look at __mmc_claim_host() and
> > mmc_release_host().
> >
> > In other words, the runtime PM reference counting should not be needed
> > in the mmc host driver, unless there are some specific cases, like for
> > example during ->probe|remove().
> >
> > So perhaps it's only the changes in the ->probe|remove() functions
> > that you need to fix the problems? No?
>
> Yes you are right. Let me send a patch to remove redundant PM helpers
> from this patch.

Ohh, I didn't know that Greg already queued this up. Seems like I
don't get more than one week to review. :-)

Alright, I will look at your new patch then.

Kind regards
Uffe
