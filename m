Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7E7481393
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhL2Nf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:35:26 -0500
Received: from ofcsgdbm.dwd.de ([141.38.3.245]:40387 "EHLO ofcsgdbm.dwd.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhL2NfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:35:25 -0500
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Dec 2021 08:35:25 EST
Received: from localhost (localhost [127.0.0.1])
        by ofcsg2dn4.dwd.de (Postfix) with ESMTP id 4JPBzf5pHjz3xgm
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 13:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dwd.de; h=
        content-type:content-type:mime-version:message-id:subject
        :subject:from:from:date:date:received:received:received:received
        :received:received:received:received; s=dwd-csg20210107; t=
        1640784478; x=1641994079; bh=3lQyP9gEuAL2BkggA1WaTo0iKwmbWDEBUd/
        b6mww0Y4=; b=sAIvqIvunM01xMJsz6Vmxr7LICYiztxDyzRUUlCTUUNaAqmW44d
        kXcbRgKH9yNnC3/4Dm0Y730psVp712sfNdjfeYIEHgGVlEKX9ETC7Hbx4L046TOX
        26xbparZNpsgNMPy7aqCRd+OhbZUX/Ettd7CHYxSiaDBOf0g1nVgKd86jMwrC9wI
        DyCIgshqPbrAB1NtZQNCsmMLxQc71mZtpOZcqhcXCVBXsH8KBR6A+0OoFwY9dwmi
        SrYm3JwqnKQqTQliN7tTqFA0/D8nZuJBJ79cJm9aXohSyAEAia2ExyQbj2Q7RZQx
        nteOC59m5ASghAmezBvDYaOJGiOs1KjzWBw==
X-Virus-Scanned: by amavisd-new at csg.dwd.de
Received: from ofcsg2cteh1.dwd.de ([172.30.232.65])
        by localhost (ofcsg2dn4.dwd.de [172.30.232.27]) (amavisd-new, port 10024)
        with ESMTP id HXJeyvNEnXx9 for <linux-kernel@vger.kernel.org>;
        Wed, 29 Dec 2021 13:27:58 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 8A344C9014AE
        for <root@ofcsg2dn4.dwd.de>; Wed, 29 Dec 2021 13:27:58 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 7EFDDC9014A8
        for <root@ofcsg2dn4.dwd.de>; Wed, 29 Dec 2021 13:27:58 +0000 (UTC)
X-DDEI-TLS-USAGE: Unused
Received: from ofcsgdbm.dwd.de (unknown [172.30.232.27])
        by ofcsg2cteh1.dwd.de (Postfix) with ESMTP
        for <root@ofcsg2dn4.dwd.de>; Wed, 29 Dec 2021 13:27:58 +0000 (UTC)
Received: from ofcsgdbm.dwd.de by localhost (Postfix XFORWARD proxy);
 Wed, 29 Dec 2021 13:27:58 -0000
Received: from ofcsg2dvf2.dwd.de (ofcsg2dvf2.dwd.de [172.30.232.11])
        by ofcsg2dn4.dwd.de (Postfix) with ESMTPS id 4JPBzf3HvYz3xgm
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 13:27:58 +0000 (UTC)
Received: from ofmailhub.dwd.de (ofmailhub.dwd.de [141.38.39.196])
        by ofcsg2dvf2.dwd.de  with ESMTP id 1BTDRwa3003085-1BTDRwa4003085;
        Wed, 29 Dec 2021 13:27:58 GMT
Received: from diagnostix.dwd.de (diagnostix.dwd.de [141.38.44.45])
        by ofmailhub.dwd.de (Postfix) with ESMTP id 4EBE7E2BEB;
        Wed, 29 Dec 2021 13:27:58 +0000 (UTC)
Date:   Wed, 29 Dec 2021 13:27:58 +0000 (GMT)
From:   Holger Kiehl <Holger.Kiehl@dwd.de>
To:     linux-kernel <linux-kernel@vger.kernel.org>
cc:     Christoph Hellwig <hch@lst.de>
Subject: bpfilter: write fail messages with 5.15.x and centos 7.9.2009
Message-ID: <71e27b99-ef9c-4563-833d-e6eab5419cdb@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-FE-Policy-ID: 2:2:1:SYSTEM
X-TMASE-Version: DDEI-5.1-8.6.1018-26620.007
X-TMASE-Result: 10--1.680000-10.000000
X-TMASE-MatchedRID: JIoVbvEI+CWCrAvdroZEJm1rAlJKwOBJ3WFaxVW7M2iO7zF9OdXqVTAI
        p5pTdcgudPVq34ohx1YjGJq9K65f6a4PSwdLs3CEngIgpj8eDcDYr6U3ZlQkdsRB0bsfrpPIcSq
        bxBgG0w5ARGa+8rI13GpVk2R+DxMYddCG7Yv8ov+256cnZoV+5YrbCj3qWi1ZOItzQfqqJ9aVbI
        BWGCvRsmDM9vAi/GQVS9KA1c/c0wEJ6EK9GiR53NHoD3/vk9U/2HWzpDxX3d0GwuNnqUs/PQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-DDEI-PROCESSED-RESULT: Safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just upgraded the kernel from 5.10.x to 5.15.12 on an old Centos
7.9.2009 server. The kernel is build on a new fedora 35 system
via 'make binrpm-pkg'. With this I see the following errors:

    [  232.140766] bpfilter: Loaded bpfilter_umh pid 6327
    [  232.152144] bpfilter: write fail -32
    [  232.187175] bpfilter: Loaded bpfilter_umh pid 6330
    [  232.198540] bpfilter: write fail -32
    [  232.234604] bpfilter: Loaded bpfilter_umh pid 6332
    [  232.245916] bpfilter: write fail -32
    [  232.281883] bpfilter: Loaded bpfilter_umh pid 6337
    [  232.293222] bpfilter: write fail -32
    [  232.335798] bpfilter: Loaded bpfilter_umh pid 6380
    [  232.347157] bpfilter: write fail -32
    [  244.411821] bpfilter: Loaded bpfilter_umh pid 6712
    [  244.423216] bpfilter: write fail -32

These appear as soon as something is done via iptables (setting
something or just viewing). Is this something I need to worry
about? Under 5.10.81 I did not see these messages.

In Jul 2020 I see a similar report 'bpfilter logging write errors in
dmesg', but could not find a solution.

Any hint what I can do to fix this?

Thanks,
Holger
