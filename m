Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAC24DE4AB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 00:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbiCRXyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 19:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbiCRXyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 19:54:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A489BB83;
        Fri, 18 Mar 2022 16:53:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FCC2B825D5;
        Fri, 18 Mar 2022 23:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B264EC340ED;
        Fri, 18 Mar 2022 23:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647647601;
        bh=PJtyWgUUfrcov7AhZrLulWQ04KpL7a5ZTQ614qq1zv4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=m1XavzsEkL2EeQH/3WCdrdFfIy641+Z9JT9FrMUTQz5TJq4ImE17B4cwoOR5tfyPe
         9mmI0p28hFj4HFRs/C5LlS7WNxZShkfyqVb/BpasAkbC8tbaWclDVqFNEeaIAXkPW/
         shbz+pEisFuokPpNv6Tl4Kcn3iuS5sGTGypx6F+6svlSl1gWZx6CCsZ7BxtFi0tK/P
         isvr7IZ2+AZYBtpUmiZHa90TqWtFla7pEW4iet8CXsvSNpfyqO6wKFC7OgppYeV1uP
         57Zy42z+/5/Qk2ItPmM/6Kjy9MMT9CzVLL2c6yQCvOs9JWsMV1lhP9DVeSaCDsGj01
         feiJMq4vH1xAA==
Date:   Fri, 18 Mar 2022 16:53:20 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Sudeep Holla <sudeep.holla@arm.com>
cc:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: xen: Add xen,scmi-devid property
 description for SCMI
In-Reply-To: <YjIzeyNoWhVAY5HK@bogus>
Message-ID: <alpine.DEB.2.22.394.2203181644560.2910984@ubuntu-linux-20-04-desktop>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com> <5859bb58c8caf87985deb84d7f6bfc8182bd6a59.1646639462.git.oleksii_moisieiev@epam.com> <Yie47a4lqXjVzgxI@robh.at.kernel.org> <20220316164619.GA3489934@EPUAKYIW015D> <YjIzeyNoWhVAY5HK@bogus>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022, Sudeep Holla wrote:
> On Wed, Mar 16, 2022 at 04:46:20PM +0000, Oleksii Moisieiev wrote:
> > 
> > > + The reason I want to keep it xen specific at the moment as we had some
> > > plan to extended the device-id usage in the spec which hasn't progressed
> > > a bit(I must admit that before you ask), and this addition should not be
> > > obstruct that future development. If we align with what we define xen
> > > specific as part of $subject work, we can always define generic binding
> > > in the future and slowly make the other obsolete over the time.
> > 
> > IIUC you have some plans to provide device_id support to the device-tree
> > bindings from your side. Maybe we can discuss some of your plans here
> > and we can come up with the generic device-id binding?
> > So I will have something to base on in Xen.
> > 
> 
> Sorry if I wasn't clear in earlier emails. What I mentioned was that I would
> like to reserve the generic namespace(i.e. just device-id) for generic SCMI
> usage. Since we haven't defined it clearly in the spec, I don't want to
> introduce the generic definition and binding now.
> 
> As mentioned earlier, though Xen definition and generic once may be exactly
> same, but we won't know until then. So keep the xen usage and namespace
> separate for now to avoid any future conflicts.


Hi Sudeep,

I thought the specification already covered this device id, it simply
delegated the description of it to Device Tree or ACPI, which is common
behavior in ARM specs. What is missing in the SCMI spec from your point
of view?



Or would you like this scmi-devid Device Tree property (or similar) to
be described in the SCMI specification itself?

Typically Device Tree and ACPI descriptions are delegated to Device Tree
and ACPI respectively. Also specification updates are typically slow
(for good reason.) We might be waiting for a long time. It is usually
not a matter of days.
