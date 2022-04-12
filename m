Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B3B4FEAAD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiDLX0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiDLX0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:26:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF25DA49;
        Tue, 12 Apr 2022 15:42:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7419261CC1;
        Tue, 12 Apr 2022 22:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F27CC385A1;
        Tue, 12 Apr 2022 22:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649803369;
        bh=Ri1K5+TtwHPpS5n6zDN3e2bMJag7dZUmyN7b3hauG4Y=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nCOgccOse5ZjdopGQC5Sl4dka6poahbeCNHNETX+oxueCam8QBBvLUOW4VAzCgsn/
         AozZfFxOBxyHX6f0JveVxSqb4qXEyau5pFVeAboPqORMAUl4PSh/KPCXxUTHjSw1Pf
         T9IjB/6rZjTOBD1hA2uY2wggMJNd/b/lwnJfOou8KIkdxa807d5Mi6uOXW45s7cEtN
         3rVDsl0vm4GanZ5sunEjos9Ap9nmEe+Ij2IEked66/8+lniiowjnt0h5skEuyZ4Ei9
         pPQoCgUMRMLjKG8uIqGJpeNQeudRyLOV7Wa+f4sdjDgnJdubpfkoM9hAYG46imWxnB
         cpcYgsGfKpKAA==
Date:   Tue, 12 Apr 2022 15:42:47 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
cc:     Rob Herring <robh@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: xen: Add xen,scmi-devid property
 description for SCMI
In-Reply-To: <20220328085202.GA1192834@EPUAKYIW015D>
Message-ID: <alpine.DEB.2.22.394.2204121540380.3066615@ubuntu-linux-20-04-desktop>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com> <5859bb58c8caf87985deb84d7f6bfc8182bd6a59.1646639462.git.oleksii_moisieiev@epam.com> <Yie47a4lqXjVzgxI@robh.at.kernel.org> <20220316164619.GA3489934@EPUAKYIW015D> <YjIzeyNoWhVAY5HK@bogus>
 <alpine.DEB.2.22.394.2203181644560.2910984@ubuntu-linux-20-04-desktop> <YjmvFZOqAcnoBcR+@bogus> <20220322192146.GA145617@EPUAKYIW015D> <20220323105422.2t726d5wbr5h2ksl@bogus> <20220328085202.GA1192834@EPUAKYIW015D>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022, Oleksii Moisieiev wrote:
> On Wed, Mar 23, 2022 at 10:54:22AM +0000, Sudeep Holla wrote:
> > On Tue, Mar 22, 2022 at 07:21:47PM +0000, Oleksii Moisieiev wrote:
> > > Hi Sudeep,
> > > 
> > > On Tue, Mar 22, 2022 at 11:12:21AM +0000, Sudeep Holla wrote:
> > > > On Fri, Mar 18, 2022 at 04:53:20PM -0700, Stefano Stabellini wrote:
> > > > > On Wed, 16 Mar 2022, Sudeep Holla wrote:
> > > > > > On Wed, Mar 16, 2022 at 04:46:20PM +0000, Oleksii Moisieiev wrote:
> > > > > > > 
> > > > > > > > + The reason I want to keep it xen specific at the moment as we had some
> > > > > > > > plan to extended the device-id usage in the spec which hasn't progressed
> > > > > > > > a bit(I must admit that before you ask), and this addition should not be
> > > > > > > > obstruct that future development. If we align with what we define xen
> > > > > > > > specific as part of $subject work, we can always define generic binding
> > > > > > > > in the future and slowly make the other obsolete over the time.
> > > > > > > 
> > > > > > > IIUC you have some plans to provide device_id support to the device-tree
> > > > > > > bindings from your side. Maybe we can discuss some of your plans here
> > > > > > > and we can come up with the generic device-id binding?
> > > > > > > So I will have something to base on in Xen.
> > > > > > > 
> > > > > > 
> > > > > > Sorry if I wasn't clear in earlier emails. What I mentioned was that I would
> > > > > > like to reserve the generic namespace(i.e. just device-id) for generic SCMI
> > > > > > usage. Since we haven't defined it clearly in the spec, I don't want to
> > > > > > introduce the generic definition and binding now.
> > > > > > 
> > > > > > As mentioned earlier, though Xen definition and generic once may be exactly
> > > > > > same, but we won't know until then. So keep the xen usage and namespace
> > > > > > separate for now to avoid any future conflicts.
> > > > > 
> > > > > 
> > > > > Hi Sudeep,
> > > > > 
> > > > > I thought the specification already covered this device id, it simply
> > > > > delegated the description of it to Device Tree or ACPI, which is common
> > > > > behavior in ARM specs. What is missing in the SCMI spec from your point
> > > > > of view?
> > > > >
> > > > 
> > > > While you can say so, but for me it isn't to an extent that we can support
> > > > software around it. I did share my feedback with spec author but as you
> > > > know it was needed for virtualisation use-case like Xen and was rushed
> > > > into the spec. All it states is "Device identifier" identifies the device
> > > > and the enumeration is not part of the spec. It defers to DT/ACPI.
> > > > 
> > > > Since I didn't have to use that in OSPM, I hadn't given much thought/review
> > > > on that.
> > > > 
> > > > >
> > > > > Or would you like this scmi-devid Device Tree property (or similar) to
> > > > > be described in the SCMI specification itself?
> > > > >
> > > > 
> > > > Spec doesn't cover that in general but do carry some recommendations
> > > > sometimes.
> > > > 
> > > > > Typically Device Tree and ACPI descriptions are delegated to Device Tree
> > > > > and ACPI respectively. Also specification updates are typically slow
> > > > > (for good reason.) We might be waiting for a long time. It is usually
> > > > > not a matter of days.
> > > > 
> > > > I agree.
> > > > 
> > > > As I said, there were thoughts about adding device protocol to make
> > > > all the other protocols centered around the device. The idea is as below:
> > > > 
> > > > Today a device A is associated with clock domain X, reset domain Y,
> > > > voltage domain Z, perf domain P, power domain Q, ...and so on.
> > > > Especially this would get complex with lots of devices and for virtual
> > > > machines.
> > > > 
> > > > Instead let all these different operations use the device identifier A
> > > > in the above case to drive clock, reset, perf, power, voltage,...etc.
> > > 
> > > So, IIUC - the idea is to provide new device based protocol
> > > which will allow agents to control different domains by using ony device
> > > id? Does it mean that scmi drivers for agents should be also changed and there will
> > > be no back compatibility with previous versions of SCMI protocol?
> > 
> > The idea is it is discoverable and if the platform advertises new protocol,
> > then only it will be used. Otherwise we must continue to use the existing
> > and advertised protocols. Anyways I realised that we need not even consider
> > these new changes for the discussion here.
> > 
> > > If yes - we probably can add scmi-devid property for current SCMI
> > > version, such as scmi-v3,device-id (because current DEN0056D document
> > > has version 3.1) and say that this property should be
> > > used for SCMI versions, which doesn't support device protocol.
> > > What do you think about this idea?
> > 
> > The main idea we had is to re-use the generic definition of device ID
> > Linux might need for other purposes like device assignments. We would
> > like to avoid a mapping from the generic device ID Linux might need and
> > define to the one in scmi context. So as Rob mentioned, it is better to
> > define one in a generic Linux/OS context and see how we can make use of
> > that in SCMI context. We could get some recommendations added to the spec
> > if needed based on what gets added/supported in the kernel.
> > 
> > So better to start addressing or responding to Rob's comments(not sure
> > if it was this version or the previous) if you want a generic device
> > ID definition. We are not adding anything SCMI specific as that might
> > end up conflicting with the one that Linux kernel might add.
> >
> Hi Rob,
> 
> Based on what Sudeep have suggested, I think we may think about the approach
> of the Generic Linux device-id, which can be used for SCMI needs as the
> device id.
> 
> I have some ideas, how the generic device_id can be implemented.
> >From my understanding - the Generic Device Id is the unique identifier, which
> can be set for the Device node in the Device-tree. This identifier is
> already set for each node by DTC and called phandle.
> 
> I've tried setting phandle for the device-nodes, such as:
> 
> &usb0 {
>     /* .... */
> 	phandle = <0x10>;
> }
> 
> DTC seems to work properly with this constant phandle. All links works
> for usb0 and all nodes, which doesn't have constant phandle receives
> calculated phandle during device-tree compilation.
> 
> Also DTC will fail if I set 2 same phandle values in different
> device nodes. So we can rely on phandle as on the unique device id.
> 
> What do you think about using phandle to set the device_id?
> 
> The alternative way I see for now is to itroduce additional property to SCMI
> node, which includes list of the device-ids, such as:
> 
> scmi {
> 	compatible = "arm,scmi-smc";
> 	/* ... */
> 	device-ids = <&usb0 17,
> 				  &usb1 42,
> 				  ....
> 				>;
> }
> 
> Looking forward for your opinion.
> Maybe you can share some ideas about how the device-id can be
> implemented?

I don't think Sudeep and Rob meant the phandle. I think they meant
something more similar to the "xen,scmi-devid" you proposed but with a
more generic meaning.
