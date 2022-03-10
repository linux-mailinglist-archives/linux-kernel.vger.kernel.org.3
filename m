Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F03A4D5044
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiCJRWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244495AbiCJRVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:21:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53404198EE5;
        Thu, 10 Mar 2022 09:20:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDB20B82717;
        Thu, 10 Mar 2022 17:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BABC340E8;
        Thu, 10 Mar 2022 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646932843;
        bh=aqZ6qfSaJ4ZT3MvuYHmkAUdH5yODv/pa6W9FZCUG3jY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=XVN+3gV/pjdKqqFKUwH9gg20w19VyJManoJeniyXzKCG/8ijSP6zG6EulhfFAWNp0
         WMuECX5DL+uDY+0cgk5HMkLALQ99sUflLJaMB0XWivClUxZhKop8gcCuuf7iyzND9d
         reXmrMrmSFWZdnIzbbPJCJrSYwUHk6TqqbUP2TnXk9nQvdYb9B1e11gnyJ1DLOBEx9
         9iJ0KFAxIepQ6YjI3/L2j9A3rNwGsTMHgIR83We9evNLG/YTykrktTMylze5vA9baV
         86wWHaaEefN6xQHMXEivmld/ddBezH/d008w2/7Ql/WF8xwBolkdWbBUUdismvYVa9
         3B8NLM9eagatA==
Date:   Thu, 10 Mar 2022 09:20:42 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
cc:     Rob Herring <robh@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add vendor prefix for Xen
 hypervisor
In-Reply-To: <20220310113833.GA187897@EPUAKYIW015D>
Message-ID: <alpine.DEB.2.22.394.2203100919410.3261@ubuntu-linux-20-04-desktop>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com> <aece6fd976980131120456800de3558e1e2308a0.1646639462.git.oleksii_moisieiev@epam.com> <Yie5P/vcBz44QcPd@robh.at.kernel.org> <20220310113833.GA187897@EPUAKYIW015D>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022, Oleksii Moisieiev wrote:
> On Tue, Mar 08, 2022 at 02:14:55PM -0600, Rob Herring wrote:
> > On Mon, 07 Mar 2022 08:17:43 +0000, Oleksii Moisieiev wrote:
> > > Xen is an open source stage-1 hypervisor.
> > > 
> > > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > > ---
> > >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > 
> > As 'xen' has been missing regardless of patch 2, I fixed up the commit 
> > message and applied, thanks!
> 
> So IIUC - this patch is already applied and I don't need to add it v3?

Yes, that's right. Congratulations for your first official device tree
binding change :-)
