Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C07B53A630
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353360AbiFANu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353355AbiFANuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:50:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC61F6F481;
        Wed,  1 Jun 2022 06:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2262ACE1A1E;
        Wed,  1 Jun 2022 13:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A7CC385A5;
        Wed,  1 Jun 2022 13:50:48 +0000 (UTC)
Date:   Wed, 1 Jun 2022 14:50:45 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3] arm64: defconfig: Config that had RPMSG_CHAR now gets
 RPMSG_CTRL
Message-ID: <YpdutV3/jOsfPb5c@arm.com>
References: <20220405161114.1107745-1-arnaud.pouliquen@foss.st.com>
 <c497e1ef-5a62-d956-4516-87e7b53a6001@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c497e1ef-5a62-d956-4516-87e7b53a6001@foss.st.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 03:25:42PM +0200, Arnaud POULIQUEN wrote:
> Gentle reminder.
> Please notice that Mathieu replied with a "Reviewed-by".

We usually leave the defconfig updates to the SoC team. Cc'ing Arnd.

Catalin

> Thanks,
> Arnaud
> 
> On 4/5/22 18:11, Arnaud Pouliquen wrote:
> > In the commit 617d32938d1b ("rpmsg: Move the rpmsg control device
> > from rpmsg_char to rpmsg_ctrl"), we split the rpmsg_char driver in two.
> > By default give everyone who had the old driver enabled the rpmsg_ctrl
> > driver too.
> > 
> > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > ---
> > 
> > This patch is extracted from the series [1] that has been partially
> > integrated in the Linux Kernel 5.18-rc1.
> > 
> > Update vs previous version:
> > - Add missing "---" separation marker after "Signed-off-by".
> > 
> > [1]https://lore.kernel.org/lkml/15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com/T/
> > [2]https://lore.kernel.org/linux-arm-kernel/CANLsYky1_b80qPbgOaLGVYD-GEr21V6C653iGEB7VCU=GbGvAQ@mail.gmail.com/T/
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 50aa3d75ab4f..3f8906b8a2ca 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -1053,6 +1053,7 @@ CONFIG_QCOM_Q6V5_PAS=m
> >  CONFIG_QCOM_SYSMON=m
> >  CONFIG_QCOM_WCNSS_PIL=m
> >  CONFIG_RPMSG_CHAR=m
> > +CONFIG_RPMSG_CTRL=m
> >  CONFIG_RPMSG_QCOM_GLINK_RPM=y
> >  CONFIG_RPMSG_QCOM_GLINK_SMEM=m
> >  CONFIG_RPMSG_QCOM_SMD=y
