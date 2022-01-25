Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7973049ADFD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450348AbiAYI1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:27:09 -0500
Received: from usmail.montage-tech.com ([12.176.92.53]:54318 "EHLO
        usmail.montage-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1450177AbiAYIYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:24:52 -0500
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 03:24:52 EST
X-MDAV-Result: clean
X-MDAV-Processed: usmail.montage-tech.com, Tue, 25 Jan 2022 00:18:24 -0800
Received: from shmail.montage-tech.com by usmail.montage-tech.com with ESMTP id md5001005969448.msg; 
        Tue, 25 Jan 2022 00:18:23 -0800
X-Spam-Processed: usmail.montage-tech.com, Tue, 25 Jan 2022 00:18:23 -0800
        (not processed: message from trusted or authenticated source)
X-MDArrival-Date: Tue, 25 Jan 2022 00:18:23 -0800
X-Return-Path: prvs=1024754431=david.dai@montage-tech.com
X-Envelope-From: david.dai@montage-tech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=montage-tech.com;
        s=MDaemon; t=1643098688; x=1643703488;
        i=david.dai@montage-tech.com; q=dns/txt; h=Date:From:To:Cc:
        Subject:Message-ID:MIME-Version:Content-Type:
        Content-Disposition; bh=YOwfpUuwTjNfCW92OafX6MvQsskvvk97bUamOD9p
        SKY=; b=TGefdGneymaKyOLjni8PX6FegYzVngJv/AqfIFAt9N7CTl+OHUggmerQ
        aZLNIFt9+lFba54im8zOhUXAfAq+2iusksA8qx7XEAem/nv4eEHkTw7tgzQ4CQho
        RdiTf1/HFis3CV0GCoVFvhWc3b3HOBu5yUTDU58vL8viyxGlqGs=
X-MDAV-Result: clean
X-MDAV-Processed: shmail.montage-tech.com, Tue, 25 Jan 2022 16:18:08 +0800
Received: from tianmu-host-sw-01 by shmail.montage-tech.com with ESMTPA id pp5001018195228.msg; 
        Tue, 25 Jan 2022 16:18:08 +0800
X-Spam-Processed: shmail.montage-tech.com, Tue, 25 Jan 2022 16:18:08 +0800
        (not processed: message from trusted or authenticated source)
Date:   Tue, 25 Jan 2022 16:14:40 +0800
From:   "david.dai" <david.dai@montage-tech.com>
To:     yi.l.liu@intel.com
Cc:     peterx@redhat.com, linux-kernel@vger.kernel.org
Subject: qemu vSVM
Message-ID: <20220125081440.GA3671060@tianmu-host-sw-01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MDCFSigsAdded: montage-tech.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi,

I want to have a try on SVA(shared virtual addressing) + pasid on QEMU based on intel IOMMU.
From my understanding, intel vIOMMU in QEMU and VFIO driver in host are ready, but VFIO
in qemu may be not.

if possible, could you tell where all patch are so that I can have a try?


Thanks,
David


