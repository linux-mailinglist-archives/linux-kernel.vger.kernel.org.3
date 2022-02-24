Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F344C38AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbiBXWXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiBXWXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:23:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573FF1F6379;
        Thu, 24 Feb 2022 14:22:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E891961B1D;
        Thu, 24 Feb 2022 22:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B62C340E9;
        Thu, 24 Feb 2022 22:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645741349;
        bh=UxMxEvfG8FtNiZ24bFbTag8u0+nLYjbUUydetdA6CbA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Daxs+iSjfMuGxnp8faDDRFDiHBP/NyvqTqbtoyXY3IloKURZ8+hgDbN+Rji6li356
         F7FH4q2VMz0ryZDVuBh09CsQVfyLGzc4os9xpf3peUF5+GLMrAMDQce5XTagN2y8Ws
         ItxrleLcIi1yWfoGqgK6j9IIZsDnNfpK+h88wq4I/xmROqvqGo9d3tlknWePz/h2RW
         pH2YJNMypC5YV4gvAYBYILN9wBcslk0Up4ggdFGZwT9DI6eBQGTeVm2zr+slOdRik2
         dmpojRhyKAZ8f67BS+M/6XyOBFs9AfvRJD1/3mNHFD3Yc64ETJM/jAvKxiP0/2whJ7
         5XyIXU/9IbQgw==
Date:   Thu, 24 Feb 2022 14:22:28 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Cristian Marussi <cristian.marussi@arm.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
In-Reply-To: <20220224093232.GA12053@e120937-lin>
Message-ID: <alpine.DEB.2.22.394.2202241415180.239973@ubuntu-linux-20-04-desktop>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com> <2546477f-4190-e838-3095-f47b31802445@kernel.org> <20220221213932.GA164964@EPUAKYIW015D> <7f17ab8f-429f-d2e0-8f5f-bfa2dd19cc49@kernel.org> <20220222161440.xadrgjftdyxenxgo@bogus>
 <20220222173458.GA2310133@EPUAKYIW015D> <alpine.DEB.2.22.394.2202231841190.239973@ubuntu-linux-20-04-desktop> <20220224093232.GA12053@e120937-lin>
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

On Thu, 24 Feb 2022, Cristian Marussi wrote:
> On Wed, Feb 23, 2022 at 06:51:59PM -0800, Stefano Stabellini wrote:
> > On Tue, 22 Feb 2022, Oleksii Moisieiev wrote:
> > > On Tue, Feb 22, 2022 at 04:14:40PM +0000, Sudeep Holla wrote:
> > > > On Tue, Feb 22, 2022 at 09:06:25AM +0100, Krzysztof Kozlowski wrote:
> > > > > On 21/02/2022 22:39, Oleksii Moisieiev wrote:
> > > > > > Hi Krzysztof,
> > > > > > 
> 
> Hi Stefano,
> 
> > > > > > On Mon, Feb 21, 2022 at 10:01:43PM +0100, Krzysztof Kozlowski wrote:
> > > > > >> On 21/02/2022 18:26, Oleksii Moisieiev wrote:
> > > > > >>> Introducing new parameter called scmi_devid to the device-tree bindings.
> > > > > >>> This parameter should be set for the device nodes, which has
> > > > > >>> clocks/power-domains/resets working through SCMI.
> > > > > >>> Given parameter should set the device_id, needed to set device
> > > > > >>> permissions in the Firmware. This feature will be extremely useful for
> > > > > >>> the virtualized systems, which has more that one Guests running on the
> > > > > >>> system at the same time or for the syestems, which require several
> > > > > >>> agents with different permissions. Trusted agent will use scmi_devid to
> > > > > >>> set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
> > > > > >>> for details).
> > > > > >>> Agents concept is described in Section 4.2.1 [0].
> > > > > >>>
> > > > > >>> scmi_devid in Device-tree node example:
> > > > > >>> usb@e6590000
> > > > > >>> {
> > > > > >>>     scmi_devid = <19>;
> > > > > >>>     clocks = <&scmi_clock 3>, <&scmi_clock 2>;
> > > > > >>>     resets = <&scmi_reset 10>, <&scmi_reset 9>;
> > > > > >>>     power-domains = <&scmi_power 0>;
> > > > > >>> };
> > > > > >>
> > > > > >> And how do you prevent DT overlay adding such devid to any other node
> > > > > >> thus allowing any other device to send requests with given devid?
> > > > > >>
> > > > > > Thank you for the quick response.
> > > > > > scmi_devid value will be used only by Trusted Agent when the device
> > > > > > permissions are set. Non-trusted agents, which in our case are
> > > > > > represented as Guest OS are using scmi drivers, already present in linux
> > > > > > kernel, ignores scmi_devid and uses scmi_clocks, scmi_power, scmi_reset
> > > > > > nodes to access to SCMI protocol.
> > > > > 
> > > > > Ah, ok.
> > > > > 
> > > > > > 
> > > > > >> Plus few technicalities:
> > > > > >> 1. Hyphen, not underscore in property name, so scmi-devid.
> > > > > > 
> > > > > > Thanks for the tip, I will change that in v2.
> > > > > 
> > > > > Few more thoughts:
> > > > > 1. This looks specific to ARM SCMI, so you also need vendor prefix, so
> > > > > something like:
> > > > > arm,scmi-devid
> > > > > arm,scmi-device-id
> > > > > 
> > > > 
> > > > Keeping the other discussion separate, I wanted to comment on this.
> > > > I agree with Krzysztof on having vendor specific prefix if we decide to add
> > > > this device id thing. However, I prefer not to use "arm,scmi-" here.
> > > > It can be "xen,scmi-" as we had plans to introduce some concepts in SCMI
> > > > spec that may use looks like this device-id. I would just like to avoid
> > > > conflicting with that in the future. It may happen to be same in the future
> > > > (i.e. this xen device-id matches 100% with definition of device-id we might
> > > > introduce in the spec, but I want to make assumption otherwise and leave
> > > > scope for divergence however small/little it can be). No issues even if
> > > > they converge and match 100% later in the far future.
> > > > 
> > > 
> > > xem,scmi- works for me. What do other thinks?
> >   ^ xen,scmi-
> > 
> > If this problem was Xen specific, then it would be fine to use xen,scmi-
> > As Xen developer, it solves my problem and I am fine with it.
> > 
> > However, from a device tree and SCMI point of view, it looks like this
> > problem is generic and it just happens that Xen is the first
> > implementation to encounter it.
> > 
> > Cristian wrote: "The SCMI spec does not indeed cover the discovery of
> > such devices and the related associated resources: it indeed delegates
> > such description to FDT/ACPI as of now." How is that supposed to happen
> > today with the current DT definitions, regardless of Xen? Is it a gap in
> > the current device tree binding?
> 
> What I meant is that in fact SCMI device IDs are NOT needed in the Linux
> Kernel DT, in fact also this series does not add any code using it and
> there is no code as of now in Kernel to issue BASE_SET_DEVICE_PERMISSIONS
> commands; Linux Guest OS in the above scenario is a Non-Trusted agent and
> doesn't need to know SCMI DevIDs and must NOT have access to those IDs for
> security reasons too (as Sudeep was saying): the Trusted Agent (XEN here)
> and the SCMI platform server are the only ones required to share the
> knowledge of such Device IDs (and how the related resources are grouped)
> via some HW description scheme as you are doing indeed in XEN.
> 
> So, while on one side such device IDs discovery is delegated by the spec
> to the HW description mechanisms, it seems just not needed in Kernel DT
> given the kind or role it has as an SCMI agent in this context: as said
> in fact there won't be any use as of now in Linux of such DT entries as
> of now.

I see. This is one of those "difficult" cases where the device tree
binding is needed but it is not used by the Linux kernel. (We have a few
cases like this in system device tree and the more device tree gets
adopted by other projects the more will see instances like this one.)

In that case, I think it is OK to call it "xen,scmi-" if Rob also
agrees.

After all, we are currently using in Xen a property called
"linux,pci-domain". We might as well have Linux in the future use a
property called "xen,scmi-devid" to even things out :-)
