Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104E64C39B6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiBXXeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiBXXeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:34:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBFD27908D;
        Thu, 24 Feb 2022 15:34:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05995B824F5;
        Thu, 24 Feb 2022 23:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1D6C340E9;
        Thu, 24 Feb 2022 23:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645745642;
        bh=4DD/wKDk+EjcpsvYN4izv/QnBJgdXR2WZ16yJQTy/tc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ijQutekGcAanlrMik4fqwX5IWpy1Ee/2P62wIKyZaWwrZ4NyEmnRYh8AuuWJjlS9J
         ipuZIHZgm6lbYxBNh4NpMzDS9x2dJMx0kgjUk+UaR1JZ7Tniu3wTs3jvb/1FXBUq4v
         4S38RrqJyUg3eV+QNkkGIX20fgwRl0daJIwipvzZ2qq4kLBQ+DmS1OLKcihtbtFLWT
         ijro86aPyWJXHlLvnmVQB5O+EF+s0pV6lC+lUwqn2PfNUPC2bY3//Xb2VKC9Mtdjmt
         1AkO8xXsO+tbHQnY0gsKj8isQZLjz2YqYvcrouw1tDsV4WHqtk+R5hOrUzAqagjrJf
         /di5uJD8+dCvw==
Date:   Thu, 24 Feb 2022 15:34:01 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Stefano Stabellini <sstabellini@kernel.org>
cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
In-Reply-To: <alpine.DEB.2.22.394.2202241424110.239973@ubuntu-linux-20-04-desktop>
Message-ID: <alpine.DEB.2.22.394.2202241531111.239973@ubuntu-linux-20-04-desktop>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com> <20220222110003.GC21915@e120937-lin> <20220222160637.yn6pru4nfgwih23j@bogus> <20220222171549.GA2194063@EPUAKYIW015D> <20220224115443.fwhczfvm3cfwoim7@bogus>
 <alpine.DEB.2.22.394.2202241424110.239973@ubuntu-linux-20-04-desktop>
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

On Thu, 24 Feb 2022, Stefano Stabellini wrote:
> On Thu, 24 Feb 2022, Sudeep Holla wrote:
> > On Tue, Feb 22, 2022 at 05:15:49PM +0000, Oleksii Moisieiev wrote:
> > > Hi Sudeep,
> > > 
> > > On Tue, Feb 22, 2022 at 04:06:37PM +0000, Sudeep Holla wrote:
> > > > Hi Oleksii,
> > > > 
> > > > My initial feedback on this. And thanks Cristian for making it so easy as
> > > > you have covered most of the things in depth(which I might have not done
> > > > myself that well)
> > > > 
> > > > On Tue, Feb 22, 2022 at 11:00:03AM +0000, Cristian Marussi wrote:
> > > > > On Mon, Feb 21, 2022 at 05:26:46PM +0000, Oleksii Moisieiev wrote:
> > > > > > Introducing new parameter called scmi_devid to the device-tree bindings.
> > > > > > This parameter should be set for the device nodes, which has
> > > > > > clocks/power-domains/resets working through SCMI.
> > > > 
> > > > I prefer you had given more details on your usage model here instead of
> > > > pointing to the other Xen thread as it helps for someone without much
> > > > background on Xen or your use-case to review this.
> > > > 
> > > Let me describe the process in few words:
> > > We implemented a new feature, called SCI-mediator in Xen.
> > > The proposed implementation allows Guests to communicate with the Firmware using SCMI
> > > protocol with SMC as a transport. Other implementation are also
> > > possible, such as SCMI-Mailbox, SCPI-mailbox etc.
> > > 
> > > In this feature Xen is the Trusted Agent, which receives the following
> > > information in Xen device-tree:
> > > 1) All channels should be described, each channel defined as
> > > arm,scmi-shmem node;
> > > 2) Scmi node arm,scmi-smc with protocols description;
> > 
> > Sounds good so far.
> > 
> > > 3) scmi-devid should be set in nodes, which works through SCMI.
> > >
> > 
> > Why is this needed for Guest OS, you need not populate this if Guest OS
> > is not required to use it, right ? If it is needed just by Xen hypervisor,
> > lets talk about that and why it is bad idea to mix that with general
> > SCMI bindings.
> 
> I'll try to help Oleksii by answering here, I hope I am not off the mark
> :-)
> 
> I think Sudeep is right, scmi-devid is not needed by the guest OS.
> 
> The host device tree is a more interesting discussion. As the host
> device tree is meant to be generic and not tied to a specific version of
> Linux, it should fully describe the SCMI interface available. If the
> device tree is provided to a Trusted Agent, then it should also have the
> scmi-devid information, right?
> 
> 
> > > On start Xen inits itself as trusted agent and requests agent
> > > configuration by using BASE_DISCOVER_AGENT message. This message is sent
> > > to each configured channel to get agent_id
> > > 
> > > On Domain creation stage Xen will do the following steps:
> > > 1) Assign channel to the Guest and map channel address to the Domain
> > > address. For the Domain this address should be the same;
> > > 2) Generate arm,scmi-shmem and arm,scmi-smc nodes if needed for Guest
> > > device-tree (the device-tree which should be passed to the Guest);
> > > 3) Process devices, which are passed through to this Guest and set
> > > BASE_SET_DEVICE_PERMISSIONS for the scmi-devid, received from the
> > > device-node;
> > >
> > 
> > I am confused here. So the Xen knows which devices are assigned to each
> > Guest OS but doesn't know device ID for them, but relies on the device
> > tree node ?
> 
> Which devices go to which guest OS is a user-provided configuration. For
> instance, a user can say: "assing /amba/ethernet@ff0e0000 to dom1". This
> is normal and not related to SCMI: when a user configures a static
> partitioning system, they decide which resources belong to which domain.
> 
> So Xen is told that /amba/ethernet@ff0e0000 is supposed to go to dom1.
> Xen proceeds to map memory and interrupts corresponding to
> /amba/ethernet@ff0e0000 to dom1. So far so good. What about SCMI?
> 
> In Oleksii's design, Xen is going to assign one of the available SCMI
> channels to dom1 and restrict its permission to only
> /amba/ethernet@ff0e0000. To do that, Xen needs to know the scmi-devid of
> /amba/ethernet@ff0e0000. As far as I can tell there is nothing
> Xen-specific in this activitity, that's why I asked Oleksii to reach out
> to the upstream device tree community to improve the generic bindings
> for everyone's benefits.

Let's leave Linux and Xen aside for the moment. What are other possible
Trusted Agents? (Maybe TF-A?) How do they get the scmi-devid? It looks
like it was supposed to come from device tree but nobody got around to
adding it to the binding because it is not used by Linux?
