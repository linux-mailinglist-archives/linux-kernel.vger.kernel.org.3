Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB8751573B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbiD2Vt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239204AbiD2Vts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:49:48 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBEE82328;
        Fri, 29 Apr 2022 14:46:28 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id c5-20020a9d75c5000000b00605ff3b9997so782155otl.0;
        Fri, 29 Apr 2022 14:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yv2yReT0/SIVJLH1HdcqGa45CaBIGoJ4UAvA1IVKGvY=;
        b=hU+FP4AEt74XdggmLJvaY/9twECN+DLOhBdmx0QIk17elWqYS65nFypQhc7tzy+KJh
         BGFmmc6VOuT1IVfkOWutSQ9beQAByQVmPYzdKSWptku/OVuKr7Kz2YqVeMiq2Q+/5sN7
         y71yEzxeTn0oA6AZcLlT1JhQt4Zxj8sQTc1kT1ms78CQKAideijfIcv/Ee/9jlw/PTqU
         hmNtCflLTyhJoedYLP3y7qgPCH+yZqkVYe4VaF35Dc8XvVLp+GituEAQlc2eeYSpnAd+
         yvKN4JEWfBNyi/ryWXl0TiGUaAYP9aP/Dy9UKFDeXk3UlEuPmXIpBfvgVhllI5lxvPZ0
         sWpA==
X-Gm-Message-State: AOAM531xNQWNvW2VVWJD37w3xD4POn+4fmzWJtUPdxYhye6c3QCOXRoO
        GjXfP5fsF8IQ1M+3szdZ2g==
X-Google-Smtp-Source: ABdhPJyMvjkpRQZaznrCZRPIPnmZU4aEnKFxIN9sw33yWBE28demRklePTNYhOnkr4eCbEsM679MGw==
X-Received: by 2002:a9d:6956:0:b0:605:fcae:3240 with SMTP id p22-20020a9d6956000000b00605fcae3240mr517923oto.280.1651268788035;
        Fri, 29 Apr 2022 14:46:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f9-20020a05680807c900b00325cda1ffabsm135511oij.42.2022.04.29.14.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:46:27 -0700 (PDT)
Received: (nullmailer pid 2942535 invoked by uid 1000);
        Fri, 29 Apr 2022 21:46:26 -0000
Date:   Fri, 29 Apr 2022 16:46:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Message-ID: <YmxcsvNculweZA/L@robh.at.kernel.org>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <20220222110003.GC21915@e120937-lin>
 <20220222160637.yn6pru4nfgwih23j@bogus>
 <20220222171549.GA2194063@EPUAKYIW015D>
 <20220224115443.fwhczfvm3cfwoim7@bogus>
 <alpine.DEB.2.22.394.2202241424110.239973@ubuntu-linux-20-04-desktop>
 <alpine.DEB.2.22.394.2202241531111.239973@ubuntu-linux-20-04-desktop>
 <YiH0KrL9LjFZnwBe@bogus>
 <alpine.DEB.2.22.394.2203041624150.3261@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2203041624150.3261@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 04:45:31PM -0800, Stefano Stabellini wrote:
> On Fri, 4 Mar 2022, Sudeep Holla wrote:
> > (sorry for the delay, had to move my email setup and some mails were
> > stuck in outbox and I missed to notice)
> > 
> > On Thu, Feb 24, 2022 at 03:34:01PM -0800, Stefano Stabellini wrote:
> > > On Thu, 24 Feb 2022, Stefano Stabellini wrote:
> > > > On Thu, 24 Feb 2022, Sudeep Holla wrote:
> > > > > On Tue, Feb 22, 2022 at 05:15:49PM +0000, Oleksii Moisieiev wrote:
> > > > > > Hi Sudeep,
> > > > > > 
> > > > > > On Tue, Feb 22, 2022 at 04:06:37PM +0000, Sudeep Holla wrote:
> > > > > > > Hi Oleksii,
> > > > > > > 
> > > > > > > My initial feedback on this. And thanks Cristian for making it so easy as
> > > > > > > you have covered most of the things in depth(which I might have not done
> > > > > > > myself that well)
> > > > > > > 
> > > > > > > On Tue, Feb 22, 2022 at 11:00:03AM +0000, Cristian Marussi wrote:
> > > > > > > > On Mon, Feb 21, 2022 at 05:26:46PM +0000, Oleksii Moisieiev wrote:
> > > > > > > > > Introducing new parameter called scmi_devid to the device-tree bindings.
> > > > > > > > > This parameter should be set for the device nodes, which has
> > > > > > > > > clocks/power-domains/resets working through SCMI.
> > > > > > > 
> > > > > > > I prefer you had given more details on your usage model here instead of
> > > > > > > pointing to the other Xen thread as it helps for someone without much
> > > > > > > background on Xen or your use-case to review this.
> > > > > > > 
> > > > > > Let me describe the process in few words:
> > > > > > We implemented a new feature, called SCI-mediator in Xen.
> > > > > > The proposed implementation allows Guests to communicate with the Firmware using SCMI
> > > > > > protocol with SMC as a transport. Other implementation are also
> > > > > > possible, such as SCMI-Mailbox, SCPI-mailbox etc.
> > > > > > 
> > > > > > In this feature Xen is the Trusted Agent, which receives the following
> > > > > > information in Xen device-tree:
> > > > > > 1) All channels should be described, each channel defined as
> > > > > > arm,scmi-shmem node;
> > > > > > 2) Scmi node arm,scmi-smc with protocols description;
> > > > > 
> > > > > Sounds good so far.
> > > > > 
> > > > > > 3) scmi-devid should be set in nodes, which works through SCMI.
> > > > > >
> > > > > 
> > > > > Why is this needed for Guest OS, you need not populate this if Guest OS
> > > > > is not required to use it, right ? If it is needed just by Xen hypervisor,
> > > > > lets talk about that and why it is bad idea to mix that with general
> > > > > SCMI bindings.
> > > > 
> > > > I'll try to help Oleksii by answering here, I hope I am not off the mark
> > > > :-)
> > > > 
> > > > I think Sudeep is right, scmi-devid is not needed by the guest OS.
> > > > 
> > > > The host device tree is a more interesting discussion. As the host
> > > > device tree is meant to be generic and not tied to a specific version of
> > > > Linux, it should fully describe the SCMI interface available. If the
> > > > device tree is provided to a Trusted Agent, then it should also have the
> > > > scmi-devid information, right?
> > > > 
> > > > 
> > > > > > On start Xen inits itself as trusted agent and requests agent
> > > > > > configuration by using BASE_DISCOVER_AGENT message. This message is sent
> > > > > > to each configured channel to get agent_id
> > > > > > 
> > > > > > On Domain creation stage Xen will do the following steps:
> > > > > > 1) Assign channel to the Guest and map channel address to the Domain
> > > > > > address. For the Domain this address should be the same;
> > > > > > 2) Generate arm,scmi-shmem and arm,scmi-smc nodes if needed for Guest
> > > > > > device-tree (the device-tree which should be passed to the Guest);
> > > > > > 3) Process devices, which are passed through to this Guest and set
> > > > > > BASE_SET_DEVICE_PERMISSIONS for the scmi-devid, received from the
> > > > > > device-node;
> > > > > >
> > > > > 
> > > > > I am confused here. So the Xen knows which devices are assigned to each
> > > > > Guest OS but doesn't know device ID for them, but relies on the device
> > > > > tree node ?
> > > > 
> > > > Which devices go to which guest OS is a user-provided configuration. For
> > > > instance, a user can say: "assing /amba/ethernet@ff0e0000 to dom1". This
> > > > is normal and not related to SCMI: when a user configures a static
> > > > partitioning system, they decide which resources belong to which domain.
> > > > 
> > > > So Xen is told that /amba/ethernet@ff0e0000 is supposed to go to dom1.
> > > > Xen proceeds to map memory and interrupts corresponding to
> > > > /amba/ethernet@ff0e0000 to dom1. So far so good. What about SCMI?
> > > > 
> > > > In Oleksii's design, Xen is going to assign one of the available SCMI
> > > > channels to dom1 and restrict its permission to only
> > > > /amba/ethernet@ff0e0000. To do that, Xen needs to know the scmi-devid of
> > > > /amba/ethernet@ff0e0000. As far as I can tell there is nothing
> > > > Xen-specific in this activitity, that's why I asked Oleksii to reach out
> > > > to the upstream device tree community to improve the generic bindings
> > > > for everyone's benefits.
> > > 
> > > Let's leave Linux and Xen aside for the moment. What are other possible
> > > Trusted Agents? (Maybe TF-A?) How do they get the scmi-devid? It looks
> > > like it was supposed to come from device tree but nobody got around to
> > > adding it to the binding because it is not used by Linux?
> > 
> > I do agree we need this info and probably device tree is the way. But what
> > I disagree here is that it needs to part of existing SCMI bindings which are
> > for the SCMI users only and not for one that may provide the interface(SCMI
> > platform/server/arbitrator/passthrough/..whatever). You can have bindings for
> > them as part of system device tree initiative and can be merged back to Linux
> > if that happens. Or we may even take the whole devicetree bindings out of
> > the Linux one day (when all the stars are aligned :) )
> 
> I would love to hear Rob's opinion on what I am about to write next on
> the topic of whether the binding should be under linux.git.
> 
> I am not sure if the policy is that only device tree bindings actively
> used by Linux are present under
> linux.git/Documentation/devicetree/bindings/. There are a tons of other
> projects using device tree and without a central point for keeping these
> bindings the specification will shatter. Given that Linux prefers to
> keep the bindings under linux.git, then the logic conclusion is that
> linux.git/Documentation/devicetree/bindings/ should also hold bindings
> not actively used by Linux right at the moment. Especially bindings that
> could be used by Linux in the future. Otherwise we risk a new binding
> being used by U-boot, Xen, Zephyr and others then Linux introduces an
> incompatible version of it. Nobody would win in that situation.

There's 0 requirement that Linux use something to be hosted in 
linux.git/Documentation/devicetree/bindings/.

If you are not comfortable with that still, submit it to dt-schema. Have 
had several u-boot properties land there recently. The only thing I 
don't want there is any class of bindings where there's 10s to 100s of 
them (e.g. device specific bindings).

The advantage with the former is you get a wider audience reviewing it 
(or more people ignoring it).

> > > After all, we are currently using in Xen a property called
> > > "linux,pci-domain". We might as well have Linux in the future use a
> > > property called "xen,scmi-devid" to even things out :-)

FYI, I tend to reject 'linux,*' properties. They have a tendency to be 
either a poor design or expand to other environments. The same applies 
all $os,* properties, but I get asked to review fewer of those. 

Rob
