Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEDA4DB850
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357353AbiCPTA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 15:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiCPTA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:00:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83CB16A00A;
        Wed, 16 Mar 2022 11:59:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BCA91476;
        Wed, 16 Mar 2022 11:59:11 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AC253F7F5;
        Wed, 16 Mar 2022 11:59:10 -0700 (PDT)
Date:   Wed, 16 Mar 2022 18:59:07 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: xen: Add xen,scmi-devid property
 description for SCMI
Message-ID: <YjIzeyNoWhVAY5HK@bogus>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com>
 <5859bb58c8caf87985deb84d7f6bfc8182bd6a59.1646639462.git.oleksii_moisieiev@epam.com>
 <Yie47a4lqXjVzgxI@robh.at.kernel.org>
 <20220316164619.GA3489934@EPUAKYIW015D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316164619.GA3489934@EPUAKYIW015D>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 04:46:20PM +0000, Oleksii Moisieiev wrote:
> 
> > + The reason I want to keep it xen specific at the moment as we had some
> > plan to extended the device-id usage in the spec which hasn't progressed
> > a bit(I must admit that before you ask), and this addition should not be
> > obstruct that future development. If we align with what we define xen
> > specific as part of $subject work, we can always define generic binding
> > in the future and slowly make the other obsolete over the time.
> 
> IIUC you have some plans to provide device_id support to the device-tree
> bindings from your side. Maybe we can discuss some of your plans here
> and we can come up with the generic device-id binding?
> So I will have something to base on in Xen.
> 

Sorry if I wasn't clear in earlier emails. What I mentioned was that I would
like to reserve the generic namespace(i.e. just device-id) for generic SCMI
usage. Since we haven't defined it clearly in the spec, I don't want to
introduce the generic definition and binding now.

As mentioned earlier, though Xen definition and generic once may be exactly
same, but we won't know until then. So keep the xen usage and namespace
separate for now to avoid any future conflicts.

-- 
Regards,
Sudeep
