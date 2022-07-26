Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29384581726
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbiGZQSX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Jul 2022 12:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiGZQSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:18:21 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A012255A5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:18:20 -0700 (PDT)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id B17811C63C5;
        Tue, 26 Jul 2022 16:18:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 3D0AA20024;
        Tue, 26 Jul 2022 16:18:16 +0000 (UTC)
Message-ID: <1c536f8e9666725ce9f3eb97acc34d08f38d2095.camel@perches.com>
Subject: Re: [PATCH] VMCI: Update maintainers for VMCI
From:   Joe Perches <joe@perches.com>
To:     Vishnu Dasa <vdasa@vmware.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "rajeshjalisatgi@gmail.com" <rajeshjalisatgi@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Bryan Tan <bryantan@vmware.com>
Date:   Tue, 26 Jul 2022 09:18:15 -0700
In-Reply-To: <47D07B41-C327-4908-A383-683FC6C67040@vmware.com>
References: <20220725163246.38486-1-vdasa@vmware.com>
         <Yt7bfyANrfdPxdS8@kroah.com>
         <FD326388-D2BB-42B4-B217-89DB9C134866@vmware.com>
         <YuAD90UfLnf1Ojso@kroah.com>
         <47D07B41-C327-4908-A383-683FC6C67040@vmware.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: 4ogh8f9z7ycintqz6pitj7rkzrkyccbw
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 3D0AA20024
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19NAXR081PqcA4zDQC4b0ZscieEdEbqVDI=
X-HE-Tag: 1658852296-201436
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-26 at 15:55 +0000, Vishnu Dasa wrote:
> > On Jul 26, 2022, at 8:10 AM, Greg KH <gregkh@linuxfoundation.org wrote:
> > On Mon, Jul 25, 2022 at 06:29:25PM +0000, Vishnu Dasa wrote:
> > > > On Jul 25, 2022, at 11:05 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > On Mon, Jul 25, 2022 at 09:32:46AM -0700, vdasa@vmware.com wrote:
> > > > > From: Vishnu Dasa <vdasa@vmware.com>
> > > > > Remove Rajesh as a maintainer for the VMCI driver.
> > > > Why?
> > > Rajesh is no longer with VMware and won't be working on VMCI.
> > 
> > But employment does not matter for maintainership and has nothing to do
> > with it.  Maintainership follows the person, not the company, you all
> > know this.
> > 
> > So for obvious reasons, I can't take this type of change without
> > Rajesh acking it.
> 
> I understand.  After getting in touch with Rajesh, cc'ing him via his
> personal email ID.
> 
> Rajesh, could you please provide your ack if you agree with this patch to
> remove you as the maintainer for VMCI?

If being an employee of a company is a criteria for maintainership
of this subsystem, likely the subsystem entry should be:

"S:	Supported" not "S:	Maintained"

MAINTAINERS:VMWARE VMCI DRIVER
MAINTAINERS-M:  Bryan Tan <bryantan@vmware.com>
MAINTAINERS-M:  Rajesh Jalisatgi <rjalisatgi@vmware.com>
MAINTAINERS-M:  Vishnu Dasa <vdasa@vmware.com>
MAINTAINERS-R:  VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
MAINTAINERS-L:  linux-kernel@vger.kernel.org
MAINTAINERS-S:  Maintained

Likely that's true for every VMware entry.

MAINTAINERS:VMWARE BALLOON DRIVER
MAINTAINERS-M:  Nadav Amit <namit@vmware.com>
MAINTAINERS-R:  VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
MAINTAINERS-L:  linux-kernel@vger.kernel.org
MAINTAINERS-S:  Maintained
MAINTAINERS-F:  drivers/misc/vmw_balloon.c
MAINTAINERS-
MAINTAINERS:VMWARE PVRDMA DRIVER
MAINTAINERS-M:  Bryan Tan <bryantan@vmware.com>
MAINTAINERS-M:  Vishnu Dasa <vdasa@vmware.com>
MAINTAINERS-R:  VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
MAINTAINERS-L:  linux-rdma@vger.kernel.org
MAINTAINERS-S:  Maintained
MAINTAINERS-F:  drivers/infiniband/hw/vmw_pvrdma/
MAINTAINERS-
MAINTAINERS-VMware PVSCSI driver
MAINTAINERS-M:  Vishal Bhakta <vbhakta@vmware.com>
MAINTAINERS-R:  VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
MAINTAINERS-L:  linux-scsi@vger.kernel.org
MAINTAINERS-S:  Maintained
MAINTAINERS-F:  drivers/scsi/vmw_pvscsi.c
MAINTAINERS-F:  drivers/scsi/vmw_pvscsi.h
MAINTAINERS-
MAINTAINERS:VMWARE VMMOUSE SUBDRIVER
MAINTAINERS-M:  Zack Rusin <zackr@vmware.com>
MAINTAINERS-R:  VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
MAINTAINERS-R:  VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
MAINTAINERS-L:  linux-input@vger.kernel.org
MAINTAINERS-S:  Maintained
MAINTAINERS-F:  drivers/input/mouse/vmmouse.c
MAINTAINERS-F:  drivers/input/mouse/vmmouse.h
MAINTAINERS-
MAINTAINERS:VMWARE VMXNET3 ETHERNET DRIVER
MAINTAINERS-M:  Ronak Doshi <doshir@vmware.com>
MAINTAINERS-R:  VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
MAINTAINERS-L:  netdev@vger.kernel.org
MAINTAINERS-S:  Maintained
MAINTAINERS-F:  drivers/net/vmxnet3/
MAINTAINERS-

