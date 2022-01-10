Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D55448982F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245154AbiAJMA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:00:26 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:38782 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245221AbiAJMAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:00:08 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id CACA692009C; Mon, 10 Jan 2022 13:00:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C4C2292009B;
        Mon, 10 Jan 2022 12:00:03 +0000 (GMT)
Date:   Mon, 10 Jan 2022 12:00:03 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     Douglas Gilbert <dgilbert@interlog.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] scsi: Set allocation length to 255 for ATA
 Information VPD page
In-Reply-To: <yq1sftzwstk.fsf@ca-mkp.ca.oracle.com>
Message-ID: <alpine.DEB.2.21.2201090342130.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk> <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk> <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com> <alpine.DEB.2.21.2201032017290.56863@angie.orcam.me.uk> <yq1tuek347m.fsf@ca-mkp.ca.oracle.com>
 <alpine.DEB.2.21.2201032324230.56863@angie.orcam.me.uk> <yq1tuej1j22.fsf@ca-mkp.ca.oracle.com> <yq1lezty169.fsf@ca-mkp.ca.oracle.com> <alpine.DEB.2.21.2201070039040.56863@angie.orcam.me.uk> <yq1sftzwstk.fsf@ca-mkp.ca.oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

> > however partitions (of the MS-DOS type) are not recognised with any of
> > the disks including one holding the root device, so the system fails
> > to mount the root filesystem and therefore does not complete booting:
> 
> My mistake. An unrelated change to the revalidate logic in the last
> patch. Fixed and pushed.

 No worries, I'm glad I helped catch it early.  This version boots 
multi-user.

> For your Mylex issue I believe the first patch in the series is all
> that's needed:
> 
> 06a471da0937 ("scsi: core: Query VPD size before getting full page")

 It is.  Thanks for sorting out this issue!

  Maciej
