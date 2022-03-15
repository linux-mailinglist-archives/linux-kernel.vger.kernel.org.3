Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21364D99C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347668AbiCOK7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239756AbiCOK5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:57:50 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D316550
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:56:38 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220315105635epoutp03f2d373797a4b42a87cf083a1dcf6e569~ciKKf2rNT1157711577epoutp03X
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:56:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220315105635epoutp03f2d373797a4b42a87cf083a1dcf6e569~ciKKf2rNT1157711577epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647341795;
        bh=nCUxDtsXKYov45Kz9G4l/FfB94J1KBRIBDaNa5YKY/I=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=cd+TBj6LFs5Tgb20A17Pa0yzKDGO5enLIzvMByuYulrSbI2AEiAY6LWZrL3PdgZ5+
         8jJRPo3Eh1eSXqb5Ma0rdEbtQmVqlRYr9BUNtfcIGTQSA9wLFO5bIOr98iftsKfSMV
         iCzb6JHN70D2Xi5+ok73HfzLjwKpTpFgvDOglH6c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220315105635epcas2p36fb2626e5c698bec138534873e73c921~ciKJ9h7Dq2114121141epcas2p3d;
        Tue, 15 Mar 2022 10:56:35 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KHr1q2GmZz4x9Pv; Tue, 15 Mar
        2022 10:56:31 +0000 (GMT)
X-AuditID: b6c32a46-bffff70000023ea8-b5-623070dfd777
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.80.16040.FD070326; Tue, 15 Mar 2022 19:56:31 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) (2) [PATCH v2] driver/nvme/host: Support duplicated nsid for
 the private ns
Reply-To: sungup.moon@samsung.com
Sender: Sungup Moon <sungup.moon@samsung.com>
From:   Sungup Moon <sungup.moon@samsung.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220315100701.GA5639@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220315105630epcms2p48f825f28577c2cd816c06c0f47bd3cc9@epcms2p4>
Date:   Tue, 15 Mar 2022 19:56:30 +0900
X-CMS-MailID: 20220315105630epcms2p48f825f28577c2cd816c06c0f47bd3cc9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTVPd+gUGSwaxbfBb/9xxjs1i5+iiT
        xaRD1xgtLu+aw2Yxf9lTdot1r9+zOLB5TGx+x+5x/t5GFo9NqzrZPDYvqffYfbOBzePzJrkA
        tqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
        yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ
        2RmdX3cwFlwRqdj0YSVrA+MJgS5GTg4JAROJe9svsHUxcnEICexglNg5by6Qw8HBKyAo8XeH
        MEiNsECsxKqrK5lAbCEBRYm/z/oYIeK6Emv+T2EGsdkEtCXunXnLBNIqIiArcWVFPchIZoGf
        jBKvW16zQezilZjR/pQFwpaW2L58K9gcTqDerrs9TBBxDYkfy3qZIWxRiZur37LD2O+PzWeE
        sEUkWu+dhaoRlHjwczdUXFLi6ckPUPF8ibbfi8D+khDoYJQ4//AI1AJziT8vr4MN5RXwleg7
        3c4KYrMIqEq8m/MMapCLxIdjq8HizALyEtvfzmEGeYxZQFNi/S59EFNCQFniyC0WiAo+iY7D
        f9lhXtwx7wnUJlWJixN62GDeXTmvgRGi1UNizYvgCYyKsxDhPAvJqlkIqxYwMq9iFEstKM5N
        Ty02KjCCR21yfu4mRnBy1HLbwTjl7Qe9Q4xMHIyHGCU4mJVEeM+80E8S4k1JrKxKLcqPLyrN
        SS0+xGgK9OREZinR5Hxges4riTc0sTQwMTMzNDcyNTBXEuf1StmQKCSQnliSmp2aWpBaBNPH
        xMEp1cA0YcG8Pz23D0Z+d3JMZWi8op86+eFfB9F7BU3ax16vaWjceGDN8TkCfx1f7t3b4vvk
        XsO17VlNk3LnlMw1vJR3uuLR7j0pyXJB39b7Jv5ax2jHfrXn6Lf2SYofNnp4mG0+ZK5i/sdi
        QfbEZ1Znj30/INhxoCCHvfK9cFp8uZuEu2h+rBq7XX9bed9eK+fQZT52nq0TipQ2Z5qmKglP
        uOOlMGvVC66/M5TWbD7+9cwDfa7DNr1JpS23H5x6szI7v2OaTe69nTM/vjq4OsgnO/nBu45g
        wxVNThtm9l9u33Ey9/lHgyt879U137R+64zf99td+esVtpULGszLr80y5O5N3nKJf/6tYh6D
        o9HTd1h1KbEUZyQaajEXFScCAN5iTXsXBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220314110545epcms2p4a227eac7c4652445050e70ee2350635d
References: <20220315100701.GA5639@lst.de> <20220315071230.GA2069@lst.de>
        <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
        <20220315095612epcms2p304482f5160ae91a120d719c88dbe368d@epcms2p3>
        <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, Mar 15, 2022 at 06:56:12PM +0900, Sungup Moon wrote:
> > I'll answer your opinion.
> > 
> > 1. ns_head leak issue
> > 
> > I don't think that is leaked ns_head. Because although all ids and nsid are same
> > through all namespaces, each namespaces are indenpendent namespace and each of that
> > should have independent data structure.
> > Duplicated nsid private namespace is different from the shared namespace even though
> > same information.
>  
> In your patch if nvme_find_ns_head returns a head for a private namespace
> with a non-uniqueue ID, that returned head already has an additional
> reference, which we'll never drop as the head variable is overriden just
> below.

Ok, I will review my patch with my team and reply your comment asap.
  
> > 2. nvme_mpath_set_disk_name issue
> > 
> > Yes, I also agree that subsystem-wide IDA is very important data. However, I
> > implemented without nvme_mpath_set_disk_name modification at the first time, it is
> > hard to decide which namespace are connected to private controller.
>  
> It is not just very important, it can't work without that.  The two
> separate IDAs can will have conflicts, so you can up with two namespaces
> with the same name without that change.
>  
> > As you know, each nvme controller start initiating at a time. So, each controller
> > structures are sequentially initiated, but each namespaces structures are initiated
> > independently because of multi-processing on cpu. So, all namespace can have different
> > instance number every boot-up time, and it makes hard to track and control the private
> > namespace on the controller or device failure.
>  
> Yes, but that is true of all Linux device enumeration.  That is why
> everyone should use table identifiers like the UUID or GUID to identify
> the namespaces.
>  
> > Anyway, the private namespace is same condition with no-multipath situation (because
> > private namespace cannot shared between controllers) so I think that the private
> > namespace should follow the naming rule with no-multipath situation.
>  
> We can't use the non-multipath cabale naming as it will cause conflicts
> in the naming.  If anything in the system supports multipathing we have
> to use subsystem based instances for the naming.
>  

Ok, I agree your opinion. My patch about nvme_mpath_set_disk_name will make confusion
of the naming in subsystem, and also find the relation-ship between controller <->
namespace using the sysfs directory structure. I'll remove that patch line and resummit
with first issue (ns_head leak issue) after review that.
