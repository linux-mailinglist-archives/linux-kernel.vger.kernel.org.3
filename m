Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D9851B4D5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiEEAxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 20:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiEEAxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 20:53:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2B51FA7B;
        Wed,  4 May 2022 17:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4012B82A5C;
        Thu,  5 May 2022 00:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C2AC385A4;
        Thu,  5 May 2022 00:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651711810;
        bh=/xejNG+Nw+IZM6OJpM1IMjqf9IciuPJZVfl3gWmM700=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=beJyvgIH4+8xH0MbllmJI0cLfNVdFhR1gg6Ktq1LuYgXNwbn2WRqCzbVxffpO747R
         FFFHbOAAd6iM7ChNoe+SeaLgE+KJ/HmiKKeUYxQvtpaeVOPvqLj8NNVRs1/cj1s29K
         X3IA7DOJNHbJEsZtE0YrVj5LrXA76WarJLUGHIFe4Kjo3PHEQgh5EuYR9ARTOx970i
         IAC4+ev1BzCb0WoT3TJ8bEGyNQtZYYjx+P/N3kXNUGtnCMnpvQQt4TAGS4RxHdE9gw
         0+3h1odDMsY1eQvYejWU/6O3TnOGOpbfe7ysGaFumno4rSHWb4dkqpZZHsA9Uj4dnV
         UFNoiJEKURReg==
Date:   Thu, 5 May 2022 08:50:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] ARM: dts: ls1021a: remove "simple-bus" compatible
 from ifc node
Message-ID: <20220505005003.GC14615@dragon>
References: <20220322022818.9860-1-leoyang.li@nxp.com>
 <20220410072745.GN129381@dragon>
 <AS8PR04MB8946C4F390D57C34816DBFB28FFA9@AS8PR04MB8946.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8946C4F390D57C34816DBFB28FFA9@AS8PR04MB8946.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:26:22PM +0000, Leo Li wrote:
> 
> 
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: Sunday, April 10, 2022 2:28 AM
> > To: Leo Li <leoyang.li@nxp.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/6] ARM: dts: ls1021a: remove "simple-bus" compatible
> > from ifc node
> > 
> > On Mon, Mar 21, 2022 at 09:28:13PM -0500, Li Yang wrote:
> > > The binding of ifc device has been updated.  Update dts to match
> > > accordingly.
> > >
> > > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > 
> > I only received patches #1, #2, #4 and #5, while it claims there are 6 patches
> > in the series.
> 
> I used the get_maintainers.pl script to generate the recipients.  The patch #3 and #6 are for powerpc, that's probably why it missed you.  Please help to review the current patches.  If they need a rebase to the latest baseline I will resend the whole series and include you for all the patches.
> 

Applied all 4 patches you sent me, thanks!

Shawn
