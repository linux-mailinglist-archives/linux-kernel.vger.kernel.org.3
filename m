Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D64B2CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352629AbiBKSXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:23:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352774AbiBKSXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:23:02 -0500
Received: from st43p00im-ztdg10063201.me.com (st43p00im-ztdg10063201.me.com [17.58.63.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EDDD91
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1644603200; bh=zUAj0lhGN97V60J2ev20JFwDPS1b501dbcz5ATJQAPc=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=KpM3QCkvlFy+6yREB7R2MCpHib2jyZhGefFwBanbK53cp8VPIATVeDbgcHUI6e56B
         2LmLjarNBiYQqb7tScqX3kepM9OCrMjbwYIZ9Is438TGDz63ye8nPOanjU04jYavv9
         Gcu0g5jNvHi+l5+HOUVzWYpzWSsAdKxBwiMMdgS4JhNLacqJFAy66YgXciwasgFdpQ
         FhxyWO7LRdrwcRo0JH5GXd4lMitWHKc3uxYFQkbIefSuyLsRdbU4uKLcDIkTt8Aya1
         AC3+EHSS37vyiXY/DIKGGIZUxYgzy5tYVpYEAtD3OrqoSWXEI7b+bz2GGUX8n5WhY3
         bCQKBu1QhY0CA==
Received: from gnbcxl0045.gnb.st.com (lfbn-lyo-1-306-208.w2-7.abo.wanadoo.fr [2.7.142.208])
        by st43p00im-ztdg10063201.me.com (Postfix) with ESMTPSA id 34960380D01;
        Fri, 11 Feb 2022 18:13:18 +0000 (UTC)
Date:   Fri, 11 Feb 2022 19:13:10 +0100
From:   Alain Volmat <avolmat@me.com>
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc:     patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] ARM: dts: sti: various DT fixes to avoid warnings
Message-ID: <20220211181310.GA683275@gnbcxl0045.gnb.st.com>
Mail-Followup-To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
        patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211202075105.195664-1-avolmat@me.com>
 <014f2de2-6b6c-c60e-1f5d-98a74649b8e7@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <014f2de2-6b6c-c60e-1f5d-98a74649b8e7@foss.st.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-17=5F04:2022-01-14=5F01,2022-01-17=5F04,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=766 clxscore=1011
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2202110099
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrice,

oups, sorry about that.  I send a v2 with several patches squashed
together to fix compilation issues.

Alain

On Thu, Feb 10, 2022 at 09:59:40AM +0100, Patrice CHOTARD wrote:
> Hi Alain
> 
> Pleased resubmit this series by squashing PATCH 1/4/5/6/7 together, the 
> compilation is broken and doesn't allow bisection.
> 
> The same with patches 9/11/12.
> 
> Thanks
> Patrice
> 
> On 12/2/21 08:50, Alain Volmat wrote:
> > A first serie to correct a large amount of DT warnings seen when
> > building with the W=1 option and mainly due to having several time
> > the same reg property (clock) or having unnecessary reg value.
> > 
> > The first 3 patches related to clocks require that recent serie [1] of
> > clock drivers improvements be first merged.
> > 
> > [1] https://lore.kernel.org/linux-clk/20211202072850.194314-1-avolmat@me.com/T/#t
> > 
> > Alain Volmat (12):
> >   ARM: dts: sti: ensure unique unit-address in stih407-clock
> >   ARM: dts: sti: ensure unique unit-address in stih410-clock
> >   ARM: dts: sti: ensure unique unit-address in stih418-clock
> >   ARM: dts: sti: move some nodes out of the soc section in
> >     stih407-family.dtsi
> >   ARM: dts: sti: update stih410-b2260 following stih407-family DT update
> >   ARM: dts: sti: update stih418-b2199 following stih407-family DT update
> >   ARM: dts: sti: update stihxxx-b2120 following stih407-family DT update
> >   ARM: dts: sti: remove delta node from stih410.dtsi
> >   ARM: dts: sti: move usb picophy nodes out of soc in stih410.dtsi
> >   ARM: dts: sti: move usb picophy nodes out of soc in stih418.dtsi
> >   ARM: dts: sti: move usb picophy nodes in stih410-b2120.dts
> >   ARM: dts: sti: move usb picophy nodes in stih410-b2260.dts
> > 
> >  arch/arm/boot/dts/stih407-clock.dtsi  | 101 +++++-----
> >  arch/arm/boot/dts/stih407-family.dtsi | 262 +++++++++++++-------------
> >  arch/arm/boot/dts/stih410-b2120.dts   |  16 +-
> >  arch/arm/boot/dts/stih410-b2260.dts   |  30 +--
> >  arch/arm/boot/dts/stih410-clock.dtsi  | 100 +++++-----
> >  arch/arm/boot/dts/stih410.dtsi        |  52 ++---
> >  arch/arm/boot/dts/stih418-b2199.dts   |  22 +--
> >  arch/arm/boot/dts/stih418-clock.dtsi  | 101 +++++-----
> >  arch/arm/boot/dts/stih418.dtsi        |  38 ++--
> >  arch/arm/boot/dts/stihxxx-b2120.dtsi  |  22 +--
> >  10 files changed, 351 insertions(+), 393 deletions(-)
> > 
