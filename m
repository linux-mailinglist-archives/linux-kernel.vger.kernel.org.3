Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573E553CB39
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245017AbiFCOBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241285AbiFCOBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:01:09 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1233B3A194;
        Fri,  3 Jun 2022 07:01:07 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id l84so10478976oif.10;
        Fri, 03 Jun 2022 07:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n5xCoOmxcQUfNePekICBtm8yRcNAbJSdXliXE0/s6bo=;
        b=imGIdAMcY9YJjq7uUOuRN6k6+3/s4EhOaGAOoMwhhtqycDfNxz06BewkwuqnJFfYVf
         F6bHRN1RYtiDOiJ8sAVUdI5SUWBSCyfxAhjJJhr5sWNSRdPzefHGzT31ouGACl8khc7n
         utS30Vvhgh94GZ5GNwdLvZ/G4pDy36ARDmYweTZ3znSut+XIZ6kRwuElCL1u1jViYZhV
         DJ/XW7hAEopMtzbe2e8SZm8IqDJUwcLGaXq/uxzds0PYc2PhApBv3NHMKuA8sNuReqpM
         cfLmv7bd95fOL67FXyQzjyAN4hnrXlqwpRTdYM2K36F8vTE6Qpw9ctebvgsqaXKa1wrH
         bATQ==
X-Gm-Message-State: AOAM533fU57EpXF9SJv2IksarzZZat43BHr6sGM+yDTn+kxLvb0bLWbq
        D05O28qkpHA05E9Vs+r9hImzezX80w==
X-Google-Smtp-Source: ABdhPJzJpHGHVLwvIE2FcXcQhikQRlH/Ei4tPQaOBWYOAVeZb7ajwGmzBZFVqfh4pM1YYnKagIxgdg==
X-Received: by 2002:a05:6808:f08:b0:32c:157:ef98 with SMTP id m8-20020a0568080f0800b0032c0157ef98mr5421440oiw.140.1654264866277;
        Fri, 03 Jun 2022 07:01:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d12-20020a4ad34c000000b0040ebba81054sm3770887oos.46.2022.06.03.07.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 07:01:05 -0700 (PDT)
Received: (nullmailer pid 273368 invoked by uid 1000);
        Fri, 03 Jun 2022 14:01:04 -0000
Date:   Fri, 3 Jun 2022 09:01:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/1] dt-bindings: Add device-perms property description
Message-ID: <20220603140104.GA243231-robh@kernel.org>
References: <cover.1651749565.git.oleksii_moisieiev@epam.com>
 <20220601193956.GA234900-robh@kernel.org>
 <alpine.DEB.2.22.394.2206021818080.2783803@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2206021818080.2783803@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 06:19:00PM -0700, Stefano Stabellini wrote:
> On Wed, 1 Jun 2022, Rob Herring wrote:
> > On Thu, May 05, 2022 at 11:23:50AM +0000, Oleksii Moisieiev wrote:
> > > Introduce device-perms property which is intended to set the device
> > > permissions for the System Management interfaces.
> > > An example of this interface is SCMI (System Control and Management
> > > Interface) which controls clocks/power-domains/resets etc from the
> > > Firmware. This property sets the device_id to set the device permissions
> > > for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of [0]).
> > 
> > Is that an exhaustive list of controls? Seems like there would be a 
> > GET_DEVICE_PERMISSIONS.
> > 
> > > Device permissions management described in DEN 0056, Section 4.2.2.10 [0].
> > > Given parameter should set the device_id, needed to set device
> > > permissions in the Firmware.
> > > This property is used by trusted Agent to set permissions for the devices,
> > > passed-through to the non-trusted Agents. Trusted Agent will use device-perms to
> > > set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
> > > for details).
> > > Agents concept is described in Section 4.2.1 [0].
> > 
> > As I said on the call discussing this, this looks very similar to other 
> > proposals wanting to control or check permissions on devices handled by 
> > some provider. While the consumer of the binding is different in various 
> > proposals, that doesn't really matter from a DT perspective. DT is just 
> > describing some type of connection between nodes. So I'm looking for 
> > collaboration here with folks that have made prior proposals. To put it 
> > another way, for a new common binding like this, I want to see more than 
> > one user. 
> 
> Do you have a pointer to another similar proposal or the name of someone
> that might be interested and might be having a second use-case for this?

ST folks who were on the call... IIRC from earlier SystemDT calls, that 
Xilinx had a similar need? Here's the various proposals I found:

https://lore.kernel.org/all/20200701132523.32533-1-benjamin.gaignard@st.com/
https://lore.kernel.org/all/20190318100605.29120-1-benjamin.gaignard@st.com/
https://lore.kernel.org/all/20180227140926.22996-1-benjamin.gaignard@st.com/

The h/w in question is the ETZPC or TZPC. I would guess the SCMI 
interface was designed with this h/w in mind.

Rob
